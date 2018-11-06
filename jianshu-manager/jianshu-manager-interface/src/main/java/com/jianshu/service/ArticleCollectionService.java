package com.jianshu.service;

import com.jianshu.pojo.Article_collection;

import java.util.List;

public interface ArticleCollectionService {
    //根据userId 查询所有
    public List<Article_collection> selectArticleCollectionByUserId(int userId);
    //新建文集
    public void insertCollection(int userId,String collectionName);
    //修改文集名称
    public void updateCollectionName(int id,String collectionName);
    //根据id删除文集
    public void deleteCollectionById(int id);


}
