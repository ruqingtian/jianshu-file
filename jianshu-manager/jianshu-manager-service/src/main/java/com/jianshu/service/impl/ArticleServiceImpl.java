package com.jianshu.service.impl;

import com.fasterxml.jackson.databind.annotation.JsonAppend;
import com.github.pagehelper.Page;
import com.jianshu.mapper.*;
import com.jianshu.otherpojo.MoreArticle;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.*;
import com.jianshu.service.ArticleService;
import com.jianshu.service.ConcernService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper mapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ConcernMapper concernMapper;
    @Autowired
    private DynamicMapper dynamicMapper;
    @Autowired
    private ArticleReviewMapper reviewMapper;

    @Override
    public List<Article> selectArticleByCollectionId(int collectionId) {
        return mapper.selectArticleByCollectionId(collectionId);
    }

    @Override
    public Article selectArticleById(int id) {

        Article article = mapper.selectArticleById(id);
        article.setNumber(article.getContent().length());

        article.setShowTime( changeDate(article.getUpdateTime()));

        return article;
    }

    @Override
    public void updateArticleById(int id, String title, String content,int status) {
        Date updateTime=new Date();
        Map<String ,Object> map=new HashMap<>();
        map.put("id",id );
        map.put("title",title );
        map.put("content",content );
        map.put("updateTime",updateTime );
        map.put("status",status);
        Article article1 = mapper.selectArticleById(id);
        mapper.updataArticleById(map);
        //插入动态
        if(article1.getStatus()==0&&status==1) {
            Article article = mapper.selectArticleById(id);
            Dynamic dynamic = new Dynamic();
            dynamic.setUserId(article.getUserId());
            dynamic.setArticleId(id);
            dynamic.setContent("发表了文章");
            dynamic.setCreateTime(new Date());
            dynamicMapper.insertArticleMyself(dynamic);
        }
    }

    @Override
    public void saveArticle(int userId, int collectionId) {

        //补全属性
        Map<String,Object> map=new HashMap<>();
        map.put("userId",userId );
        map.put("collectionId",collectionId );
        map.put("title","无标题文章" );
        map.put("content","这是初始化内容" );
        map.put("createTime",new Date() );
        map.put("updateTime",new Date() );
        mapper.saveArticle(map);

    }

    @Override
    public void deleteArticle(int id) {
        List<Integer> integers = reviewMapper.selectIdByArticleId(id);
        for(Integer integer:integers){
            dynamicMapper.deleteDynamicByReviewId(integer);
        }
        mapper.deleteArticle(id);
        reviewMapper.deleteRiviewByArticleId(id);
        concernMapper.deleteConcernBylikeArticleId(id);
        dynamicMapper.deleteArticleMyself(id ,"发表了文章" );
        dynamicMapper.deleteArticleMyself(id ,"喜欢了文章" );

    }

    @Override
    public List<Article> selectAllArticle() {
        List<Article> articleList = mapper.selectAllArticle();
        for(int i=0;i<articleList.size();i++){
            User user = userMapper.selectUserById(articleList.get(i).getUserId());
            if(articleList.get(i).getContent().length()>5) {
                articleList.get(i).setContent(articleList.get(i).getContent().substring(0, 5) + "...");
            }else{
                articleList.get(i).setContent(articleList.get(i).getContent());
            }
            articleList.get(i).setUserName(user.getNickName());
        }
        return articleList;
    }

    @Override
    public PageBean selectPageArticle(int currentPage, int index, int currentCount) {
        PageBean<MoreArticle> pageBean=new PageBean<>();
        //设置当前页
        pageBean.setCurrentPage(currentPage);
        //设置当前显示条数
        pageBean.setCurrentCount(currentCount);
        //设置总条数
        int totalCount=mapper.selectCountArticle();
        pageBean.setTotalCount(totalCount);
        //设置总页数
        int totalPage=(int)Math.ceil(1.0*totalCount/currentCount);
        pageBean.setTotalPage(totalPage);
        //设置每页显示数据
        List<Article> articles=mapper.selectPageArticle(index,currentCount );
        List<MoreArticle> list=new ArrayList<>();
        for(int i=0;i<articles.size();i++){
            MoreArticle moreArticle=new MoreArticle();
            BeanUtils.copyProperties(articles.get(i),moreArticle );
            User user = userMapper.selectUserById(articles.get(i).getUserId());
            moreArticle.setUserName(user.getNickName());
            moreArticle.setReviewNums(reviewMapper.selectListByArticleId(moreArticle.getId()).size());
            moreArticle.setLikeNums(concernMapper.selectCountLike(moreArticle.getId()));
            list.add(moreArticle);
        }
        pageBean.setShowList(list);

        return pageBean;
    }


    @Override
    public List<MoreArticle> getAllByUserId(int userId) {
        List<Article> articles = mapper.selectListByUserId(userId);
        List<MoreArticle> list=new ArrayList<>();
        SimpleDateFormat format=new SimpleDateFormat("MM.dd HH:mm ");
        for(Article article:articles){
            MoreArticle moreArticle=new MoreArticle();
            article.setShowTime(format.format(article.getUpdateTime()));
            BeanUtils.copyProperties(article,moreArticle );
            moreArticle.setLikeNums(concernMapper.selectCountLike(moreArticle.getId()));

            moreArticle.setReviewNums(reviewMapper.selectListByArticleId(article.getId()).size());

            list.add(moreArticle);
        }
        return list;
    }

    @Override
    public MoreArticle saveMoreArticle(int articleId) {
        MoreArticle moreArticle=new MoreArticle();
        Article article = selectArticleById(articleId);
        BeanUtils.copyProperties(article, moreArticle);

        int likeNums = concernMapper.selectCountLike(articleId);

        moreArticle.setReviewNums(reviewMapper.selectListByArticleId(articleId).size());
        moreArticle.setLikeNums(likeNums);
        return moreArticle;
    }

    @Override
    public List dynamicMessage(int userId,int cookieId) {
        List<Dynamic> dynamics = dynamicMapper.selectDynamicByUserId(userId);
        List list=new ArrayList<>();
        User user = userMapper.selectUserById(userId);
        for(Dynamic dynamic:dynamics){
            if(!"关注了作者".equals(dynamic.getContent())) {
                MoreArticle article = new MoreArticle();
                if (dynamic.getArticleId() != 0) {
                    Article article1 = mapper.selectArticleById(dynamic.getArticleId());
                        BeanUtils.copyProperties(article1, article);

                        User user1 = userMapper.selectUserById(article1.getUserId());
                        article.setUserName(user1.getNickName());
                        article.setReviewNums(reviewMapper.selectListByArticleId(article1.getId()).size());

                }
                if (dynamic.getReviewId() != 0) {
                    article.setReviewContent(reviewMapper.selectReviewById(dynamic.getReviewId()).getContent());
                }
                article.setImg(user.getImg());
                article.setNickName(user.getNickName());

                article.setDynamicContent(dynamic.getContent());
                article.setDynamicDate(changeDate(dynamic.getCreateTime()));

                article.setLikeNums(concernMapper.selectCountLike(article.getId()));
                article.setWorkerId(cookieId);
                list.add(article);
            }else{
                MyPageUser myPageUser=new MyPageUser();
                User user1 = userMapper.selectUserById(dynamic.getConcernId());
                myPageUser.setId(user1.getId());
                myPageUser.setUserId(userId);
                myPageUser.setImg(user1.getImg());
                myPageUser.setNickName(user1.getNickName());
                myPageUser.setConcernNums(concernMapper.selectListByConcernId(user1.getId()).size());

                List<Article> articles = mapper.selectListByUserId(user1.getId());
                int sum=0;
                int likeNums=0;
                for(Article article:articles){
                   sum+= article.getContent().length();
                   likeNums+=concernMapper.selectCountLike(article.getId());
                }
                myPageUser.setCount(sum);
                myPageUser.setLikeNums(likeNums);
                myPageUser.setDesc(user1.getUserDesc());
                Concern concern = concernMapper.selectConcern(cookieId, user1.getId());
                if(concern!=null){
                    myPageUser.setConcernStatus(1);
                }else{
                    myPageUser.setConcernStatus(0);
                }
                myPageUser.setUserImg(user.getImg());
                myPageUser.setUserName(user.getNickName());
                myPageUser.setDynamicContent(dynamic.getContent());
                myPageUser.setDynamicDate(changeDate(dynamic.getCreateTime()));
                list.add(myPageUser);
            }

        }
        return list;
    }

    @Override
    public PageBean<MoreArticle> likeTitileLimit(String title,int currentPage, int index, int currentCount) {
        title="%"+title+"%";
        PageBean<MoreArticle> pageBean=new PageBean<>();
        List<Article> articles = mapper.selectListByTitleOrContent(title, index, currentCount);
        List<MoreArticle> list=new ArrayList<>();
        for(Article article:articles){
            MoreArticle moreArticle=new MoreArticle();
            if (article.getContent().length() > 200) {
                article.setContent(article.getContent().substring(0, 200) + "...");
            }

            BeanUtils.copyProperties(article,moreArticle );
            moreArticle.setDynamicDate(changeDate(article.getCreateTime()));
            User user = userMapper.selectUserById(article.getUserId());
            moreArticle.setImg(user.getImg());
            moreArticle.setNickName(user.getNickName());
            moreArticle.setReadNums(concernMapper.selectCountRead(article.getId()));
            moreArticle.setReviewNums(reviewMapper.selectListByArticleId(article.getId()).size());
            moreArticle.setLikeNums(concernMapper.selectCountLike(article.getId()));
            list.add(moreArticle);

        }
        pageBean.setCurrentPage(currentPage);
        pageBean.setCurrentCount(currentCount);
        pageBean.setTotalCount(mapper.selectCountLikeTitleOrContent(title));
        pageBean.setTotalPage((int)Math.ceil(1.0*(pageBean.getTotalCount())/currentCount));
        pageBean.setShowList(list);

        return pageBean;
    }

    @Override
    public List<MoreArticle> getAllLikeArticle(int userId) {
        List<Integer> integers = concernMapper.selectLikeArticleIdByUserId(userId);
        List<MoreArticle> list=new ArrayList<>();
        for(Integer s:integers){
            Article article = mapper.selectArticleById(s);

            MoreArticle moreArticle=new MoreArticle();
            BeanUtils.copyProperties(article,moreArticle );
            User user = userMapper.selectUserById(article.getUserId());
            moreArticle.setDynamicDate(changeDate(article.getCreateTime()));
            moreArticle.setImg(user.getImg());
            moreArticle.setNickName(user.getNickName());
            moreArticle.setWorkerId(userId);
            moreArticle.setReadNums(mapper.selectReadNums(article.getId()));
            moreArticle.setReviewNums(reviewMapper.selectIdByArticleId(article.getId()).size());
            moreArticle.setLikeNums(concernMapper.selectCountLike(article.getId()));
            list.add(moreArticle);
        }
        return list;
    }

    @Override
    public int selectReadNums(int articleId) {
        return mapper.selectReadNums(articleId);
    }

    @Override
    public void updateReadNums(int articleId) {
        int nums = mapper.selectReadNums(articleId);
        mapper.updateReadNums(articleId,nums+1 );

    }


    //时间格式修改
    public String changeDate(Date date){
        SimpleDateFormat format=new SimpleDateFormat("yyyy.MM.dd HH:mm ");
        String time = format.format(date);
        return time;
    }
}
