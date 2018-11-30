package com.jianshu.service.impl;

import com.fasterxml.jackson.databind.annotation.JsonAppend;
import com.jianshu.mapper.*;
import com.jianshu.otherpojo.MoreArticle;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.Article_review;
import com.jianshu.pojo.Dynamic;
import com.jianshu.pojo.User;
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
    public void updateArticleById(int id, String title, String content) {
        Date updateTime=new Date();
        Map<String ,Object> map=new HashMap<>();
        map.put("id",id );
        map.put("title",title );
        map.put("content",content );
        map.put("updateTime",updateTime );
        map.put("status",1);
        mapper.updataArticleById(map);
        //插入动态
        Article article = mapper.selectArticleById(id);
        Dynamic dynamic=new Dynamic();
        dynamic.setUserId(article.getUserId());
        dynamic.setArticleId(id);
        dynamic.setContent("发表了文章");
        dynamic.setCreateTime(new Date());
        dynamicMapper.insertArticleMyself(dynamic);
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
        PageBean<Article> pageBean=new PageBean<>();
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
        for(int i=0;i<articles.size();i++){
            User user = userMapper.selectUserById(articles.get(i).getUserId());
            if(articles.get(i).getContent().length()>5) {
                articles.get(i).setContent(articles.get(i).getContent().substring(0,5)+"...");
            }else{
                articles.get(i).setContent(articles.get(i).getContent());
            }

            articles.get(i).setUserName(user.getNickName());
        }
        pageBean.setShowList(articles);

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
            list.add(moreArticle);
        }
        return list;
    }

    @Override
    public MoreArticle saveMoreArticle(int articleId) {
        MoreArticle moreArticle=new MoreArticle();
        Article article = selectArticleById(articleId);
        BeanUtils.copyProperties(article, moreArticle);
        int count = concernMapper.selectCountRead(articleId);
        int likeNums = concernMapper.selectCountLike(articleId);
        moreArticle.setReadNums(count);
        moreArticle.setLikeNums(likeNums);
        return moreArticle;
    }

    @Override
    public List<MoreArticle> dynamicMessage(int userId) {
        List<Dynamic> dynamics = dynamicMapper.selectDynamicByUserId(userId);
        List<MoreArticle> list=new ArrayList<>();
        User user = userMapper.selectUserById(userId);
        for(Dynamic dynamic:dynamics){
            if("喜欢了文章".equals(dynamic.getContent())){
                MoreArticle article=new MoreArticle();
                Article article1 = mapper.selectArticleById(dynamic.getArticleId());
                BeanUtils.copyProperties(article1,article );
                if(article1.getContent().length()>30) {
                    article.setContent(article1.getContent().substring(0,30)+"...");
                }

                User user1 = userMapper.selectUserById(article1.getUserId());
                article.setUserName(user1.getNickName());
                article.setImg(user.getImg());
                article.setNickName(user.getNickName());
                article.setDynamicContent(dynamic.getContent());
                article.setDynamicDate(changeDate(dynamic.getCreateTime()));
                article.setReadNums(concernMapper.selectCountRead(article.getId()));
                article.setLikeNums(concernMapper.selectCountLike(article.getId()));
                list.add(article);
            }
        }
        return list;
    }

    //时间格式修改
    public String changeDate(Date date){
        SimpleDateFormat format=new SimpleDateFormat("yyyy.MM.dd HH:mm ");
        String time = format.format(date);
        return time;
    }
}
