package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.ReviewMore;
import com.jianshu.service.ArticleReviewService;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.lang.model.type.ErrorType;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class ReviewController {
    @Autowired
    private ArticleReviewService reviewService;

    //添加评论
    @RequestMapping(value = "/article/addreview",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult addReview(Integer articleId,String content,HttpServletRequest request,HttpServletResponse response){
        int userId = getCookieUserId(request, response);
        reviewService.insertReview(userId,articleId ,content );
        return JianshuResult.ok();
    }
    //显示评论
    @RequestMapping(value = "/article/showReview",method = RequestMethod.GET)
    @ResponseBody
    public List<ReviewMore> showReview(Integer articleId){
        List<ReviewMore> reviewMores = reviewService.showListByArticleId(articleId);
        return reviewMores;
    }
    //判断是否是自己的评论
    @RequestMapping(value = "/review/yesOrNo",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult isreview(Integer id,HttpServletRequest request,HttpServletResponse response){
        int cookieUserId = getCookieUserId(request, response);
        if(cookieUserId==id){
            return JianshuResult.ok("本人评论");
        }
        return JianshuResult.ok("非本人评论");
    }
    //删除自己的评论
    @RequestMapping(value = "/review/delete",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult deleteReview(Integer reviewId){
        reviewService.deleteReviewById(reviewId);
        return JianshuResult.ok();
    }



    //获取登录的用户id
    public int getCookieUserId(HttpServletRequest request, HttpServletResponse response){
        Cookie[] cookies = request.getCookies();
        String userId="-10";
        if(cookies!=null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("USERID")) {
                    userId = cookie.getValue();
                    cookie.setMaxAge(24*60*60);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        return Integer.parseInt(userId);
    }
}
