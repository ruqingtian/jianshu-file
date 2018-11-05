package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.pojo.Article;
import com.jianshu.service.ArticleCollectionService;
import com.jianshu.service.ArticleService;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    @ResponseBody
    public List<Article> write(Integer id){
        int userId=1;


        List<Article> articles = articleService.selectArticleByCollectionId(id);

        return articles;
    }

    @RequestMapping(value = "/write/content",method = RequestMethod.POST)
    @ResponseBody
    public Article content(@RequestParam Integer id){
        int articleId=id;
        return articleService.selectArticleById(articleId);
    }

    @RequestMapping(value = "/write/saveArticle",method = RequestMethod.POST)
    @ResponseBody
    public String saveArticle(@RequestParam String title,  @RequestParam Integer articleId, @RequestParam String content)  {

        content=content.substring(3,content.length()-4 );
        articleService.updateArticleById(articleId, title, content);

       return "OK";
    }

    @RequestMapping(value = "/save/collection",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult saveCollection(@RequestParam Integer userId,@RequestParam String collectionName){
        collectionService.insertCollection(userId,collectionName );
        return JianshuResult.ok();
    }
}
