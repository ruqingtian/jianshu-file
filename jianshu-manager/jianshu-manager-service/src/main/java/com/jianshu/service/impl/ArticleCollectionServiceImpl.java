package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleCollectionMapper;
import com.jianshu.pojo.Article_collection;
import com.jianshu.service.ArticleCollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    //新建文集
    @Override
    public void insertCollection(int userId, String collectionName) {
        //补全信息
        Date crrateTime=new Date();
        Map<String,Object> map=new HashMap<>();
        map.put("name",collectionName );
        map.put("userId",userId );
        map.put("createTime",crrateTime );
        map.put("updateTime",crrateTime );
        mapper.insertColection(map);
    }

    @Override
    public void updateCollectionName(int id, String collectionName) {
        Date updateTime=new Date();
        Map<String,Object> map=new HashMap<>();
        map.put("id",id );
        map.put("name",collectionName );
        map.put("updateTime",updateTime );
        mapper.updateCollectionName(map);
    }

    @Override
    public void deleteCollectionById(int id) {
        mapper.deleteCollectionById(id);
    }
}
