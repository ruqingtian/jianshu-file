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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        SimpleDateFormat format=new SimpleDateFormat("yyyy.MM.dd HH:mm ");
        article.setShowTime(format.format(article.getUpdateTime()));

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
            articleList.get(i).setContent(articleList.get(i).getContent().substring(0,5)+"...");
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
            articles.get(i).setContent(articles.get(i).getContent().substring(0,5)+"...");
            articles.get(i).setUserName(user.getNickName());
        }
        pageBean.setShowList(articles);

        return pageBean;
    }


    @Override
    public List<Article> getAllByUserId(int userId) {
        List<Article> articles = mapper.selectListByUserId(userId);
        SimpleDateFormat format=new SimpleDateFormat("MM.dd HH:mm ");
        for(Article article:articles){
            article.setShowTime(format.format(article.getUpdateTime()));
        }
        return articles;
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
}
