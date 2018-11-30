package com.jianshu.service.impl;

import com.jianshu.mapper.ConcernMapper;
import com.jianshu.mapper.DynamicMapper;
import com.jianshu.pojo.Concern;
import com.jianshu.pojo.Dynamic;
import com.jianshu.service.ConcernService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ConcernServiceImpl implements ConcernService {
    @Autowired
    private ConcernMapper mapper;
    @Autowired
    private DynamicMapper dynamicMapper;

    @Override
    public List<Integer> selectListByUserId(int userId) {
        List<Integer> list = mapper.selectListByUserId(userId);

        return list;
    }

    @Override
    public void insertConcern(int userId, int concernId) {
        Concern concern=new Concern();
        concern.setConcernId(concernId);
        concern.setUserId(userId);
        concern.setCreateTime(new Date());
        mapper.insertConcern(concern);
        //插入动态
        Dynamic dynamic=new Dynamic();
        dynamic.setUserId(userId);
        dynamic.setConcernId(concernId);
        dynamic.setContent("关注了作者");
        dynamic.setCreateTime(new Date());
        dynamicMapper.insertConcernId(dynamic);
    }

    @Override
    public Concern selectConcern(int userId, int concernId) {
        return  mapper.selectConcern(userId,concernId );

    }

    @Override
    public void deleteConcern(int userId, int concernId) {
        mapper.deleteConcern(userId,concernId );
        dynamicMapper.deleteConcernId(userId,concernId,"关注了作者" );

    }

    @Override
    public List<Integer> selectListByConcernId(int concernId) {

        return mapper.selectListByConcernId(concernId);
    }

    @Override
    public void insertRead(int userId, int readArticleId) {
        Concern concern=new Concern();
        concern.setUserId(userId);
        concern.setReadArticleId(readArticleId);
        concern.setCreateTime(new Date());
        mapper.insertReadArticleId(concern);
    }

    @Override
    public Concern selectRead(int userId, int readArticleId) {
        return mapper.selectConcernByUserId(userId,readArticleId );
    }

    @Override
    public int selectCountRead(int readArticleId) {
        return mapper.selectCountRead(readArticleId);
    }

    @Override
    public void insertLikeArticleId(int userId, int likeArticleId) {
        Concern concern=new Concern();
        concern.setUserId(userId);
        concern.setLikeArticleId(likeArticleId);
        concern.setCreateTime(new Date());
        mapper.insertLikeArticleId(concern);
        //插入动态
        Dynamic dynamic=new Dynamic();
        dynamic.setUserId(userId);
        dynamic.setArticleId(likeArticleId);
        dynamic.setContent("喜欢了文章");
        dynamic.setCreateTime(new Date());
        dynamicMapper.insertArticleId(dynamic);
    }

    @Override
    public Concern selectConcernByUserIdANdLikeArticleId(int userId, int likeArticleId) {
        return mapper.selectConcernByUserIdAndLikeArticleId(userId,likeArticleId );
    }

    @Override
    public void deleteConcernByUserIdANdLikeArticleId(int userId, int likeArticleId) {
        mapper.deleteLike(userId,likeArticleId );
        dynamicMapper.deleteArticleId(userId,likeArticleId,"喜欢了文章" );
    }

    @Override
    public int selectCountLike(int likeArticleId) {
        return mapper.selectCountLike(likeArticleId);
    }
}
