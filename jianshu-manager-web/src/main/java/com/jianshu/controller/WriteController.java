package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.MoreArticle;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Article;
import com.jianshu.pojo.Concern;
import com.jianshu.service.ArticleCollectionService;
import com.jianshu.service.ArticleService;
import com.jianshu.service.ConcernService;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.UUID;

@Controller
public class WriteController {
    @Autowired
    private ArticleService articleService;
    @Autowired
    private UserService userService;
    @Autowired
    private ArticleCollectionService collectionService;
    @Autowired
    private ConcernService concernService;

    @Value("${ARTICLE_CURRENT_COUNT}")
    private Integer ARTICLE_CURRENT_COUNT;
    @Value("${SEARCH_ARTICLE_COUNT}")
    private Integer SEARCH_ARTICLE_COUNT;

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
    public Article saveArticle( String title,  Integer articleId, String content,Integer status,HttpServletRequest request)  {

        if(articleId!=-100) {

            articleService.updateArticleById(articleId, title, content,status);
            Article article = articleService.selectArticleById(articleId);

            return article;
        }
        return null;
    }

    @RequestMapping(value = "/save/collection",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult saveCollection(@RequestParam Integer userId,@RequestParam String collectionName){
        collectionService.insertCollection(userId,collectionName );
        return JianshuResult.ok() ;
    }

    @RequestMapping(value = "/update/collectionName",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult updateCollectionName(@RequestParam String newName,@RequestParam Integer articleId){
        collectionService.updateCollectionName(articleId,newName );

        return JianshuResult.ok();
    }

    @RequestMapping(value = "/delete/collection",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult deleteCollection(Integer id){
        collectionService.deleteCollectionById(id);
        return JianshuResult.ok();
    }

    @RequestMapping(value ="/save/article",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult saveArticle(@RequestParam Integer userId,@RequestParam Integer collectionId){
        articleService.saveArticle(userId,collectionId );
        return JianshuResult.ok();
    }

    @RequestMapping(value = "/delete/article",method =RequestMethod.GET)
    @ResponseBody
    public JianshuResult deleteArticle(Integer id){
        articleService.deleteArticle(id);
        return JianshuResult.ok();
    }

    @RequestMapping(value = "/index/articlePage",method = RequestMethod.GET)
    @ResponseBody
    public PageBean<Article> selectArticlePage(Integer currentPage){
        int index=(currentPage-1)*ARTICLE_CURRENT_COUNT;
        PageBean pageBean = articleService.selectPageArticle(currentPage, index, ARTICLE_CURRENT_COUNT);
        return  pageBean;

    }

    @RequestMapping(value = "/article/userArticle",method = RequestMethod.GET)
    @ResponseBody
    public List<MoreArticle> getAllByUserId(int userId){
        List<MoreArticle> list = articleService.getAllByUserId(userId);
        return list;
    }

    @RequestMapping(value = "/article/like",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult yesAndNoLike(Integer articleId,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        int likeNums = concernService.selectCountLike(articleId);
        if(cookieId==-10){
            return JianshuResult.build(400,"请先登录" );
        }
        Concern concern = concernService.selectConcernByUserIdANdLikeArticleId(cookieId, articleId);
        if(concern==null){
            concernService.insertLikeArticleId(cookieId,articleId );

            return JianshuResult.ok(likeNums+1);

        }else{
            concernService.deleteConcernByUserIdANdLikeArticleId(cookieId,articleId );
        }
        return JianshuResult.ok(likeNums-1);
    }

    @RequestMapping(value = "/article/dynamic",method = RequestMethod.GET)
    @ResponseBody
    public List<MoreArticle> getDynamic(Integer userId,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        List list = articleService.dynamicMessage(userId,cookieId);
        return list;
    }

    @RequestMapping(value = "/search/article",method = RequestMethod.POST)
    @ResponseBody
    public PageBean<MoreArticle> searchArticle(String content,int currentPage)  {

        int index=(currentPage-1)*SEARCH_ARTICLE_COUNT;
        PageBean<MoreArticle> pageBean = articleService.likeTitileLimit(content, currentPage, index, SEARCH_ARTICLE_COUNT);
        return pageBean;
    }

    @RequestMapping(value = "/article/showLike",method =  RequestMethod.GET)
    @ResponseBody
    public List<MoreArticle> showLikeArticle(Integer userId){
        List<MoreArticle> allLikeArticle = articleService.getAllLikeArticle(userId);
        return allLikeArticle;
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
    //处理图片的路径
    public  String workImg(MultipartFile img,HttpServletRequest request){
        String filePath="";
        String uuid="";
        String suffix="";
        //判断文件是否为空
        if(!img.isEmpty()){
            //文件保存路径
            try {
                uuid= UUID.randomUUID().toString().replace("-","" );
                //取后缀
                String imgName=img.getOriginalFilename();
                suffix =imgName.substring(imgName.lastIndexOf(".") );

                filePath=request.getSession().getServletContext().getRealPath("/")+"upload/"+uuid+suffix;
                //转存文件
                img.transferTo(new File(filePath));
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        String imgPath="/upload/"+uuid+suffix;
        return imgPath;
    }
}
