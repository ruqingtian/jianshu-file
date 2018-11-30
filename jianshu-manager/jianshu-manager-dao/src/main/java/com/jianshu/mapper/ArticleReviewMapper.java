package com.jianshu.mapper;

import com.jianshu.pojo.Article_review;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleReviewMapper {
    //添加评论
    public void insertReview(Article_review review);
    //根据文章的id 查询所有评论
    public List<Article_review> selectListByArticleId(int articleId);
    //根据id 删除评论
    public void deleteReviewById(int id);
    //根据int userId, int articleId, String content 查询评论id
    public int selectIdByUserIdAndArticleIdAndContent(@Param("userId") int userId,@Param("articleId") int articleId, @Param("content")String content);
    //根据id 查询评论
    public Article_review selectReviewById(int id);
    //根据文章id 删除所有的评论
    public void deleteRiviewByArticleId(int articleId);
    //根据文章的id  查询id 集合
    public List<Integer> selectIdByArticleId(int articleId);

}
