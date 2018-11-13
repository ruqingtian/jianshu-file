package com.jianshu.controller;

import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.Article_collection;
import com.jianshu.pojo.User;
import com.jianshu.service.ArticleCollectionService;
import com.jianshu.service.ArticleService;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    public String write(Model model,HttpServletRequest request,HttpServletResponse response){

        //注入ArticleCollectionserviceid
        //用户
        Cookie[] cookies = request.getCookies();
        String userId="";
        User user=new User();
        if(cookies!=null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("USERID")) {
                    userId = cookie.getValue();
                    cookie.setMaxAge(24*60*60);
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        if(!"".equals(userId)){
            user = userService.selectUserById(Integer.parseInt(userId));
            model.addAttribute("user",user );
            List<Article_collection> collections = collectionService.selectArticleCollectionByUserId(user.getId());
            model.addAttribute("collectionList", collections);

        }else{
            return "login";
        }




        return "/write";
    }

    //主页
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(Model model, HttpServletRequest request, HttpServletResponse response){
      /*  List<HomeUser> list = service.selectHomeUser();
        model.addAttribute("homeUserList", list);*/
        int currentPage=1;
        int currentCount=2;
        int index=(currentPage-1)*currentCount;
        PageBean pageBean = userService.selectPageUser(currentPage, index, currentCount);
        model.addAttribute("pageBean", pageBean);
        List<Article> articleList = articleService.selectAllArticle();
        model.addAttribute("articleList",articleList );
        Cookie[] cookies = request.getCookies();
        String userId="";
        User user=new User();
        if(cookies!=null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("USERID")) {
                    userId = cookie.getValue();
                    cookie.setMaxAge(24*60*60);
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        if(!"".equals(userId)){
            user = userService.selectUserById(Integer.parseInt(userId));

        }
        model.addAttribute("user",user);
        return "index";
    }
    //文章详情
    @RequestMapping(value = "/article/With",method = RequestMethod.GET)
    public String articleWith(Integer id,Model model,HttpServletResponse response,HttpServletRequest request){
        articleService.readNumsAddOne(id);
        Article article = articleService.selectArticleById(id);
        User user = userService.selectUserById(article.getUserId());
        model.addAttribute("article",article );
        model.addAttribute("user1",user );
        Cookie[] cookies = request.getCookies();
        String userId="";
        User user1=new User();
        if(cookies!=null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("USERID")) {
                    userId = cookie.getValue();
                    cookie.setMaxAge(24*60*60);
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        if(!"".equals(userId)){
            user1 = userService.selectUserById(Integer.parseInt(userId));

        }
        model.addAttribute("user",user1);

        return "article";
    }

    //跳转页面个人设置
    @RequestMapping(value ="/user/setting",method = RequestMethod.GET)
    public String userSetting(Integer id,Model model){
        User user = userService.selectUserById(id);
        model.addAttribute("user",user );

        return "userSetting";
    }
}
