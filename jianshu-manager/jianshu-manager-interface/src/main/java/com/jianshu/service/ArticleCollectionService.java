package com.jianshu.service;

import com.jianshu.pojo.Article_collection;

import java.util.List;

public interface ArticleCollectionService {
    //根据userId 查询所有
    public List<Article_collection> selectArticleCollectionByUserId(int userId);

}
