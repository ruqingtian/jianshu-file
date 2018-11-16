package com.jianshu.service.impl;

import com.jianshu.mapper.ConcernMapper;
import com.jianshu.pojo.Concern;
import com.jianshu.service.ConcernService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        mapper.insertConcern(userId,concernId );
    }

    @Override
    public Concern selectConcern(int userId, int concernId) {
        return  mapper.selectConcern(userId,concernId );

    }

    @Override
    public void deleteConcern(int userId, int concernId) {
        mapper.deleteConcern(userId,concernId );

    }
}
