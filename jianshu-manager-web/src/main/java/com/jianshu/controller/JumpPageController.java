package com.jianshu.controller;

import com.jianshu.otherpojo.MoreArticle;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.Article_collection;
import com.jianshu.pojo.Concern;
import com.jianshu.pojo.User;
import com.jianshu.service.ArticleCollectionService;
import com.jianshu.service.ArticleService;
import com.jianshu.service.ConcernService;
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
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
public class JumpPageController {
    @Autowired
    private UserService userService;
    @Autowired
    private ArticleCollectionService collectionService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private ConcernService concernService;

    //转到注册页面
    @RequestMapping("/register")
    public String register(){
        return "register";
    }
    //跳转登录页面
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    //跳转写文章的页面
    @RequestMapping(value = "/write",method = RequestMethod.GET)
    public String write(Model model, HttpServletRequest request, HttpServletResponse response) {

        //注入ArticleCollectionserviceid
        //用户

        User user = new User();
        int userId = getCookieUserId(request, response);
        if(userId!=-10) {
            user = userService.selectUserById(userId);
            model.addAttribute("user", user);
            List<Article_collection> collections = collectionService.selectArticleCollectionByUserId(user.getId());
            model.addAttribute("collectionList", collections);
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

        return "index";
    }
    //文章详情
    @RequestMapping(value = "/article/With",method = RequestMethod.GET)
    public String articleWith(Integer id,Model model,HttpServletResponse response,HttpServletRequest request){

        int cookieId = getCookieUserId(request, response);
        if(cookieId!=-10){
            Concern concern = concernService.selectRead(cookieId, id);
            if(concern==null){
                concernService.insertRead(cookieId,id );
            }
        }

        MoreArticle article = articleService.saveMoreArticle(id);
        MyPageUser myPageUser = userService.saveMyPageUser(article.getUserId());
        model.addAttribute("article",article );
        model.addAttribute("user",myPageUser );

        return "article";
    }

    //跳转页面个人设置
    @RequestMapping(value ="/user/setting",method = RequestMethod.GET)
    public String userSetting(Model model,HttpServletRequest request,HttpServletResponse response){
        int userId = getCookieUserId(request, response);
        User user = userService.selectUserById(userId);
        model.addAttribute("user",user );

        return "userSetting";
    }
    //跳转我的主页
    @RequestMapping(value = "/user/myPage",method = RequestMethod.GET)
    public String myPage(Integer userId,Model model,HttpServletRequest request,HttpServletResponse response){

            MyPageUser myPageUser = userService.saveMyPageUser(userId);
            List<Integer> integers = concernService.selectListByUserId(userId);
            myPageUser.setConcernNums(integers.size());
            model.addAttribute("user", myPageUser);


        int cookieId = getCookieUserId(request, response);
        if(cookieId!=userId){
            model.addAttribute("status","不是本人主页" );
        }
        return "myPage";
    }
    //跳转搜索页面
    @RequestMapping(value = "search",method = RequestMethod.GET)
    public String searchJsp(String content,Model model) throws Exception {
       content=new String(content.getBytes("iso-8859-1"),"UTF-8");
        model.addAttribute("content",content );
        return "search";
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
