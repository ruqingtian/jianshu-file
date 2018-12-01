package com.jianshu.service;

import com.jianshu.otherpojo.MoreArticle;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ArticleService {
    //根据collectionId 获取List
    public List<Article> selectArticleByCollectionId(int collectionId);

    //根据id 获取文章
    public Article selectArticleById(int id);

    //根据文章id 修改文章
    public void updateArticleById(int id, String title, String content);
    //新建文章
    public void saveArticle(int userId,int collectionId);
    //根据id删除文章
    public void deleteArticle(int id);
//    查询所有的文章
    public List<Article> selectAllArticle();
//    分页查询文章
    public PageBean selectPageArticle(int currentPage,int index,int currentCount);

    //根据userId 获取文章集合
    public List<MoreArticle> getAllByUserId(int userId);
    //封装MoreArticle
    public MoreArticle saveMoreArticle(int articleId);

    //动态消息 封装MoreArticle
    public List dynamicMessage(int userId,int cookieId);
}
