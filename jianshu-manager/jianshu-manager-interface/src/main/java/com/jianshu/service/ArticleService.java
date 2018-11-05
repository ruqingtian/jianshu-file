package com.jianshu.service;

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
}
