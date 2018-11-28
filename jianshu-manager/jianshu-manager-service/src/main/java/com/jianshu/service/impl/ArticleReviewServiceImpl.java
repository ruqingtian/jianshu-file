package com.jianshu.service.impl;

import com.jianshu.mapper.ArticleReviewMapper;
import com.jianshu.mapper.UserMapper;
import com.jianshu.otherpojo.ReviewMore;
import com.jianshu.pojo.Article_review;
import com.jianshu.pojo.User;
import com.jianshu.service.ArticleReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ArticleReviewServiceImpl implements ArticleReviewService {
    @Autowired
    private ArticleReviewMapper articleReviewMapper;
    @Autowired
    private UserMapper userMapper;
    @Override
    public void insertReview(int userId, int articleId, String content) {
        Article_review review=new Article_review();
        review.setArticleId(articleId);
        review.setContent(content);
        review.setUserId(userId);
        review.setCreateTime(new Date());
        review.setUpdateTime(new Date());
        articleReviewMapper.insertReview(review);

    }

    @Override
    public List<ReviewMore> showListByArticleId(int articleId) {
        List<ReviewMore> list=new ArrayList<>();
        List<Article_review> reviewList = articleReviewMapper.selectListByArticleId(articleId);
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM.dd HH:mm ");
        for(Article_review review:reviewList){
            ReviewMore reviewMore=new ReviewMore();
            User user = userMapper.selectUserById(review.getUserId());
            reviewMore.setUserId(review.getUserId());
            reviewMore.setContent(review.getContent());
            reviewMore.setDate(format.format(review.getCreateTime()));
            reviewMore.setUserName(user.getNickName());
            reviewMore.setReviewId(review.getId());
            reviewMore.setImg(user.getImg());
            list.add(reviewMore);
        }
        return list;
    }

    @Override
    public void deleteReviewById(int id) {
        articleReviewMapper.deleteReviewById(id);
    }


}
