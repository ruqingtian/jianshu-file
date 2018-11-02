package com.jianshu.controller;

import com.jianshu.pojo.Article;
import com.jianshu.pojo.Article_collection;
import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;
import com.jianshu.service.ArticleCollectionService;
import com.jianshu.service.ArticleService;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class JumpPageController {
    @Autowired
    private UserService userService;
    @Autowired
    private ArticleCollectionService collectionService;
    @Autowired
    private ArticleService articleService;


    //转到注册页面
    @RequestMapping("/register")
    public String register(){
        return "register";
    }
    //跳转登入页面
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    //跳转写文章的页面
    @RequestMapping(value = "/write",method = RequestMethod.GET)
    public String write(Model model){
        //模拟登入
        int userId=1;

        //注入ArticleCollectionserviceid
        //用户
        User user = userService.selectUserById(userId);
        model.addAttribute("nickName",user.getNickName() );
        //文章集
        List<Article_collection> collections = collectionService.selectArticleCollectionByUserId(userId);
        model.addAttribute("collectionList", collections);



        return "write";
    }
}
