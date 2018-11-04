package com.jianshu.service;

import com.jianshu.pojo.Article;

import java.util.List;

public interface ArticleService {
    //根据collectionId 获取List
    public List<Article> selectArticleByCollectionId(int collectionId);

    //根据id 获取文章
    public Article selectArticleById(int id);
}
