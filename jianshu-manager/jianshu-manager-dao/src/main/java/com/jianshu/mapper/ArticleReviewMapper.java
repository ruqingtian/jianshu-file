package com.jianshu.mapper;

import com.jianshu.pojo.Article_review;

import java.util.List;

public interface ArticleReviewMapper {
    //添加评论
    public void insertReview(Article_review review);
    //根据文章的id 查询所有评论
    public List<Article_review> selectListByArticleId(int articleId);
    //根据id 删除评论
    public void deleteReviewById(int id);
}
