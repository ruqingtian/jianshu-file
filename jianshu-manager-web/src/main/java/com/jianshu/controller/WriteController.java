package com.jianshu.controller;

import com.jianshu.pojo.Article;
import com.jianshu.pojo.Article_collection;
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
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class WriteController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private UserService userService;
    @Autowired
    private ArticleCollectionService collectionService;

    @RequestMapping(value = "/write/article",method = RequestMethod.GET)
    public String write( int id, Model model){
        int userId=1;
        int b=id;
        //用户
        User user = userService.selectUserById(userId);
        model.addAttribute("nickName",user.getNickName() );
        //文章集
        List<Article_collection> collections = collectionService.selectArticleCollectionByUserId(userId);
        model.addAttribute("collectionList", collections);

        List<Article> articles = articleService.selectArticleByCollectionId(id);
        model.addAttribute("articleList", articles);
        return "write";
    }
}
