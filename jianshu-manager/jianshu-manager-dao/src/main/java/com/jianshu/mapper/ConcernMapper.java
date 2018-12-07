package com.jianshu.mapper;

import com.jianshu.pojo.Concern;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConcernMapper {
    //查询该用户关注的 id   集合
    public List<Integer> selectListByUserId(int userId);
    //添加关注
    public void insertConcern(Concern concern);
//    查询关注
    public Concern selectConcern(@Param("userId") int userId,@Param("concernId") int concernId);
    //删除关注
    public void deleteConcern(@Param("userId") int userId,@Param("concernId") int concernId);
    //查看粉丝
    public List<Integer> selectListByConcernId(int concernId);

    //阅读
    public void insertReadArticleId(Concern concern);
    //阅读查询次数
    public int selectCountRead(@Param("readArticleId") int readArticleId);
    //查询user阅读是否存在
    public Concern selectConcernByUserId(@Param("userId") int userId,@Param("readArticleId")int readArticleId);

    //添加喜欢
    public void insertLikeArticleId(Concern concern);
    //删除喜欢
    public void deleteLike(@Param("userId")int userId,@Param("likeArticleId")int likeArticleId);
    //查询喜欢的数量
    public int selectCountLike(@Param("likeArticleId")int likeArticleId);
    //查询喜欢是否存在
    public Concern selectConcernByUserIdAndLikeArticleId(@Param("userId")int userId,@Param("likeArticleId")int likeArticleId);
    //根据userId 查询所有喜欢的文章Id
    public List<Integer> selectLikeArticleIdByUserId(@Param("userId")int userId);

    //根据文章的id 删除所有
    public void deleteConcernBylikeArticleId(int likeArticleId);


}
