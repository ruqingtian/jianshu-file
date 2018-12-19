package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleMapper;
import com.jianshu.mapper.ConcernMapper;
import com.jianshu.mapper.UserMapper;
import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.Concern;
import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;
import com.jianshu.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;
    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private ConcernMapper concernMapper;


    @Override
    public void saveUser(String nickName, String userName, String pwd, String phone,String img) {

        User user=new User();


        user.setNickName(nickName);
        user.setUserName(userName);
        user.setPwd(pwd);
        user.setPhone(phone);
        user.setSex(2);
        user.setImg(img);
        //补全信息
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());


        mapper.insert(user);
    }
    //检验数据
    @Override
    public JianshuResult checkName(String param,Integer type) {
        if(type==1){//userName

            // 正则表达式规则
            String reg="[a-z0-9]{4,18}";
            // 编译正则表达式
            Pattern pattern = Pattern.compile(reg);
            // 忽略大小写的写法
            // Pattern pat = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
            Matcher matcher = pattern.matcher(param);
            if(!matcher.find()){
                return JianshuResult.build(202, "4~18位");
            }

        }else{
            return JianshuResult.build(400,"非法的参数") ;
        }
        //3.调用mapper的查询方法 获取数据
        User user = mapper.selectByUserName(param);
        //4.如果查询到了数据   --数据不可以用   false
        if(user!=null){
            return JianshuResult.build(202, "用户名存在");
        }
        return JianshuResult.ok(true);
    }
    //登录验证
    @Override
    public User selectPwdByUserName(String userName) {
        return mapper.selectByUserName(userName);
    }

    //根据id查询用户
    @Override
    public User selectUserById(int id) {
        return mapper.selectUserById(id);
    }

    //显示主页的作者信息
    @Override
    public List<HomeUser> selectHomeUser() {
        List<User> users = mapper.selectAllUser();
        List<HomeUser> list=new ArrayList<>();
        for(int i=0;i<users.size();i++){
            HomeUser homeUser=new HomeUser();
            User user=users.get(i);
            homeUser.setId(users.get(i).getId());
            homeUser.setImg(users.get(i).getImg());

            homeUser.setNickName(users.get(i).getNickName());
            homeUser.setLikeNums((concernMapper.selectListByConcernId(i).size()));
            list.add(homeUser);
        }
        return list;
    }

    @Override
    public PageBean selectPageUser(int currentPage,int index, int currentCount,int cookieId) {
        PageBean<HomeUser> pageBean=new PageBean<>();
        //设置当前页
        pageBean.setCurrentPage(currentPage);
        //设置当前显示条数
        pageBean.setCurrentCount(currentCount);
        //设置总条数
        int totalCount= mapper.selectTotalCount();
        pageBean.setTotalCount(totalCount);
        //设置总页数
        int totalPage=(int)Math.ceil(1.0*totalCount/currentCount);
        pageBean.setTotalPage(totalPage);
        //设置每页显示数据
        List<User> users = mapper.selectPageUser(index, currentCount);
        List<HomeUser> list=new ArrayList<>();
        for(int i=0;i<users.size();i++){
            HomeUser homeUser=new HomeUser();
            if(cookieId==-10){
                homeUser.setStatus(0);
            }else{
                Concern concern = concernMapper.selectConcern(cookieId, users.get(i).getId());
                if(concern!=null){
                    homeUser.setStatus(1);
                }else{
                    homeUser.setStatus(0);
                }
            }
            homeUser.setId(users.get(i).getId());
            homeUser.setImg("../.."+users.get(i).getImg());
            homeUser.setNickName(users.get(i).getNickName());

            List<Article> articles = articleMapper.selectListByUserId(users.get(i).getId());
            int count=0;//记录总字数
            int a=0;//记录总喜欢数量
            for(Article article:articles){
                count+=article.getContent().length();
                a+=concernMapper.selectCountLike(article.getId());
            }
            homeUser.setSumNums(count);
            homeUser.setLikeNums(a);
            list.add(homeUser);

        }
        pageBean.setShowList(list);
        return pageBean;
    }

    @Override
    public void updateUser(User user) {
        User user1 = mapper.selectUserById(user.getId());
        user.setUpdateTime(new Date());
        if("/upload/".equals(user.getImg())){
            user.setImg(user1.getImg());
        }
        mapper.updateUser(user);
    }

    @Override
    public MyPageUser saveMyPageUser(int id) {
        MyPageUser myPageUser=new MyPageUser();
        User user = mapper.selectUserById(id);
        List<Article> articles = articleMapper.selectListByUserId(id);
        List<Integer> integers = concernMapper.selectListByUserId(id);
        myPageUser.setId(user.getId());
        myPageUser.setImg(user.getImg());
        myPageUser.setNickName(user.getNickName());
        myPageUser.setFansNums(concernMapper.selectListByConcernId(id).size());
        myPageUser.setConcernNums(integers.size());
        myPageUser.setArticleNums(articles.size());
        int count=0;//记录字数
        int a=0;//记录喜欢的个数
        for(Article article:articles){
            count+=article.getContent().length();
            a+=concernMapper.selectCountLike(article.getId());

        }
        myPageUser.setCount(count);
        myPageUser.setLikeNums(a);
       ;
        return myPageUser;
    }

    @Override
    public PageBean<MyPageUser> selectLikeNickName(int currentPage,int index, String nickName, int currentCount) {
        PageBean<MyPageUser> pageBean=new PageBean<>();
        List<User> users = mapper.selectLikeNickName(nickName, index, currentCount);
        List<MyPageUser> list=new ArrayList<>();

        for(User user:users){
            MyPageUser myPageUser=new MyPageUser();
            myPageUser.setId(user.getId());
            myPageUser.setImg(user.getImg());
            myPageUser.setNickName(user.getNickName());
            myPageUser.setConcernNums(concernMapper.selectListByUserId(user.getId()).size());
            myPageUser.setFansNums(concernMapper.selectListByConcernId(user.getId()).size());
            List<Article> articles = articleMapper.selectListByUserId(user.getId());
            myPageUser.setArticleNums(articles.size());
            int sum=0,like=0;
            for(Article article:articles){
                sum+=article.getContent().length();
                like+=concernMapper.selectCountLike(article.getId());
            }
            myPageUser.setCount(sum);
            myPageUser.setLikeNums(like);
           list.add(myPageUser);
        }
        pageBean.setShowList(list);
        pageBean.setCurrentCount(currentCount);
        pageBean.setCurrentPage(currentPage);
        pageBean.setTotalCount(mapper.selectCountLikeNickName(nickName));
        pageBean.setTotalPage((int)Math.ceil(1.0*(pageBean.getTotalCount())/currentCount));


        return pageBean;
    }

    @Override
    public PageBean<MyPageUser> selectAllUserAndPageBean(int currentPage,int currentCount,int userId) {
        PageBean<MyPageUser> pageBean=new PageBean<>();
        int index=(currentPage-1)*currentCount;
        List<User> users = mapper.selectPageUser(index,currentCount );
        List<MyPageUser> list=new ArrayList<>();

        for(User user:users){
            MyPageUser myPageUser=new MyPageUser();
            myPageUser.setId(user.getId());
            myPageUser.setImg(user.getImg());
            myPageUser.setNickName(user.getNickName());
            myPageUser.setDesc(user.getUserDesc());
            Concern concern = concernMapper.selectConcern(userId, user.getId());
            if(concern!=null){
                myPageUser.setConcernStatus(1);
            }else{
                myPageUser.setConcernStatus(0);
            }

            List<Article> articles = articleMapper.selectListByUserId(user.getId());
            if(articles.size()>3){
                articles=articles.subList(0,3 );
            }
            myPageUser.setArticleTitle(articles);
            list.add(myPageUser);
        }
        pageBean.setCurrentPage(currentPage);
        pageBean.setCurrentCount(currentCount);
        pageBean.setTotalCount(mapper.selectAllUser().size());
        pageBean.setTotalPage((int)Math.ceil(1.0*(pageBean.getTotalCount())/currentCount));
        pageBean.setShowList(list);
        return pageBean;
    }
}
