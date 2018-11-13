package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleMapper;
import com.jianshu.mapper.UserMapper;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.User;
import com.jianshu.service.ArticleService;
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
        mapper.deleteArticle(id);
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
    public void readNumsAddOne(int id) {
        Article article = mapper.selectArticleById(id);
        int readNums=article.getReadNums()+1;
        mapper.readNumsAddOne(id,readNums );
    }
}
