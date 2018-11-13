package com.jianshu.service.impl;

import com.jianshu.mapper.UserMapper;
import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.PageBean;
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


    @Override
    public void saveUser(String nickName, String userName, String pwd, int sex, String phone, String mail,String img) {

        User user=new User();


        user.setNickName(nickName);
        user.setUserName(userName);
        user.setPwd(pwd);
        user.setSex(sex);
        user.setPhone(phone);
        user.setMail(mail);
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
    //登入验证
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
            homeUser.setLikeNums((users.get(i).getFansNums()));
            list.add(homeUser);
        }
        return list;
    }

    @Override
    public PageBean selectPageUser(int currentPage,int index, int currentCount) {
        PageBean<User> pageBean=new PageBean<>();
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
        for(int i=0;i<users.size();i++){
            users.get(i).setImg("../.."+ users.get(i).getImg());
        }
        pageBean.setShowList(users);
        return pageBean;
    }

    @Override
    public void updateUser(User user) {
        User user1 = mapper.selectUserById(user.getId());
        user.setUpdateTime(new Date());
        if("".equals(user.getImg())){
            user.setImg(user1.getImg());
        }
        mapper.updateUser(user);
    }
}
