package com.jianshu.service.impl;

import com.jianshu.mapper.ConcernMapper;
import com.jianshu.pojo.Concern;
import com.jianshu.service.ConcernService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ConcernServiceImpl implements ConcernService {
    @Autowired
    private ConcernMapper mapper;

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
    }

    @Override
    public Concern selectConcern(int userId, int concernId) {
        return  mapper.selectConcern(userId,concernId );

    }

    @Override
    public void deleteConcern(int userId, int concernId) {
        mapper.deleteConcern(userId,concernId );

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
    }

    @Override
    public Concern selectConcernByUserIdANdLikeArticleId(int userId, int likeArticleId) {
        return mapper.selectConcernByUserIdAndLikeArticleId(userId,likeArticleId );
    }

    @Override
    public void deleteConcernByUserIdANdLikeArticleId(int userId, int likeArticleId) {
        mapper.deleteLike(userId,likeArticleId );
    }

    @Override
    public int selectCountLike(int likeArticleId) {
        return mapper.selectCountLike(likeArticleId);
    }
}
