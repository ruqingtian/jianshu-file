package com.jianshu.service;

import com.jianshu.pojo.Concern;

import java.util.List;

public interface ConcernService {
    //查询该用户关注的 id   集合
    public List<Integer> selectListByUserId(int userId);
    //添加关注
    public void insertConcern(int userId,int concernId);
    //查询关注
    public Concern selectConcern(int userId, int concernId);
    //删除关注
    public void deleteConcern(int userId,int concernId);
    //查看改用户的粉丝 id 集合
    public List<Integer> selectListByConcernId(int concernId);
}
