package com.jianshu.service;


import com.jianshu.otherpojo.ReviewMore;

import java.util.List;

public interface ArticleReviewService {
    //添加评论
    public void insertReview(int userId,int articleId,String content);
    //根据文章ID 查询所有的评论
    public List<ReviewMore> showListByArticleId(int articleId);
    //根据id 删除评论
    public void deleteReviewById(int id);
}
