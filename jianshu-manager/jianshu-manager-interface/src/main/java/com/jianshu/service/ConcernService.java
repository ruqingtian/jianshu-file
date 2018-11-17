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
    //添加阅读
    public void insertRead(int userId,int readArticleId);
    //查询user是否阅读
    public Concern selectRead(int userId,int readArticleId);
    //查询阅读的数量
    public int selectCountRead(int readArticleId);

    //添加喜欢
    public void insertLikeArticleId(int userId,int likeArticleId);
    //查询是否喜欢
    public Concern selectConcernByUserIdANdLikeArticleId(int userId,int likeArticleId);
    //删除喜欢
    public void deleteConcernByUserIdANdLikeArticleId(int userId,int likeArticleId);
    //查询喜欢个数
    public int selectCountLike(int likeArticleId);
}
