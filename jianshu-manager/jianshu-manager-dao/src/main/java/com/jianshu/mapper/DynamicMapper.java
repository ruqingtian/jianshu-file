package com.jianshu.mapper;

import com.jianshu.pojo.Dynamic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DynamicMapper {
    //添加动态 关注用户
    public void insertConcernId(Dynamic dynamic);
    //删除关注
    public void deleteConcernId(@Param("userId") int userId, @Param("concernId") int concernId,@Param("content") String content);

    //喜欢文章的动态
    public void insertArticleId(Dynamic dynamic);
    //删除喜欢文章的动态
    public void deleteArticleId(@Param("userId") int userId, @Param("articleId") int articleId,@Param("content") String content);

    //发表文章的动态
    public void insertArticleMyself(Dynamic dynamic);
    //删除文章的动态
    public void deleteArticleMyself( @Param("articleId") int articleId,@Param("content") String content);

    //评论文章的动态
    public void  insertReviewId(Dynamic dynamic);
    //删除评论文章的动态
    public void  deleteReviewId(@Param("userId") int userId, @Param("reviewId") int reviewId,@Param("content") String content);

    //根据文章id 删除
    public void deleteDynamicByReviewId(int reviewId);

    //根据userId 查询所有的动态信息
    public List<Dynamic> selectDynamicByUserId(@Param(value = "userId") int userId);
}
