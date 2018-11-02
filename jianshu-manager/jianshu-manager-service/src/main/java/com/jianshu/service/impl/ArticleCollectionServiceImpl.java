package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleCollectionMapper;
import com.jianshu.pojo.Article_collection;
import com.jianshu.service.ArticleCollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleCollectionServiceImpl implements ArticleCollectionService {
    @Autowired
    private ArticleCollectionMapper mapper;

    //根据用户的id 查询所有的文章集
    @Override
    public List<Article_collection> selectArticleCollectionByUserId(int userId) {
        //注入mapper
        return mapper.selectUserIdByArticleCollection(userId);


    }
}
