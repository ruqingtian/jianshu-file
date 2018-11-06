package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleMapper;
import com.jianshu.pojo.Article;
import com.jianshu.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper mapper;

    @Override
    public List<Article> selectArticleByCollectionId(int collectionId) {
        return mapper.selectArticleByCollectionId(collectionId);
    }

    @Override
    public Article selectArticleById(int id) {
        return mapper.selectArticleById(id);
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
}
