package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.Concern;
import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;
import com.jianshu.service.ConcernService;
import com.jianshu.service.UserService;

import com.jianshu.util.JsonUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.tags.form.SelectTag;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ConcernService concernService;

    @Value("${USER_CURRENT_COUNT}")
    private Integer USER_CURRENT_COUNT;
    @Value("${SEARCH_USER_COUNT}")
    private Integer SEARCH_USER_COUNT;
    @Value("${ALLUSER_CURRENT_COUNT}")
    private Integer ALLUSER_CURRENT_COUNT;
    //注册用户
    @RequestMapping(value="/user/save",method= RequestMethod.POST)

    public String dosave(String nickName, String userName, String pwd, String phone,  HttpServletRequest request,HttpServletResponse response){

        userService.saveUser(nickName,userName,pwd,phone);
        login(userName,pwd , response);
        return "redirect:/";

    }




    //检验
    @RequestMapping(value = "/user/check",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult checkData(@RequestParam String name,@RequestParam Integer type){
        JianshuResult jianshuResult = userService.checkName(name, type);
        return jianshuResult;
    }

    //登录
    @RequestMapping(value = "/user/login",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult login(String userName, String pwd, HttpServletResponse response){
        User user = userService.selectPwdByUserName(userName);
        if(user==null||!user.getPwd().equals(pwd)){
            return  JianshuResult.build(400,"用户名或者密码错误" );
        }
        Cookie cookie=new Cookie("USERID",""+user.getId());
        cookie.setPath("/");
        cookie.setMaxAge(60*60*24);
        response.addCookie(cookie);

            return JianshuResult.ok(user);

    }

    //分页查询用户
    @RequestMapping(value = "/index/userPage",method = RequestMethod.GET)
    @ResponseBody
    public PageBean page(Integer currentPage,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        int index=(currentPage-1)*USER_CURRENT_COUNT;
        PageBean pageBean = userService.selectPageUser(currentPage, index, USER_CURRENT_COUNT,cookieId);
        return pageBean;

    }
    //修改所有信息
    @RequestMapping(value = "/user/update",method = RequestMethod.POST)
    public String update(Integer id,MultipartFile image,String nickName,Integer sex,String userDesc,String mail,String phone ,String web ,Model model,HttpServletRequest request){
        User user=new User();
        String imgPath = workImg(image, request);
        user.setId(id);
        user.setImg(imgPath);
        user.setNickName(nickName);
        user.setSex(sex);
        user.setUserDesc(userDesc);
        user.setMail(mail);
        user.setPhone(phone);
        user.setWeb(web);
        userService.updateUser(user);
        User user1 = userService.selectUserById(user.getId());
        model.addAttribute("user",user1);

        return "redirect:setting";

    }

    //判断用户是否登录
    @RequestMapping(value = "/user/isUserLogin",method = RequestMethod.GET)
    @ResponseBody
    public User isUserLogin(HttpServletRequest request, HttpServletResponse response){
        Cookie[] cookies = request.getCookies();
        String userId="";
        User user=new User();
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
        if(!"".equals(userId)){
            user = userService.selectUserById(Integer.parseInt(userId));

        }
      return user;
    }
    //退出登录
    @RequestMapping(value = "/user/exitUser",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult exitUser(HttpServletResponse response,HttpServletRequest request){
        Cookie cookie=new Cookie("USERID",""+1);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        return JianshuResult.ok();
    }

    //判断是否关注
    @RequestMapping(value = "/user/judgeConcern",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult judgeConcern(Integer userId,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        Concern concern = concernService.selectConcern(cookieId, userId);
        if(concern!=null){
            return JianshuResult.ok("已关注");
        }
        return  JianshuResult.ok("未关注");
    }
    //添加关注
    @RequestMapping(value = "/user/concern",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult saveAndDeleteConcern(Integer userId,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        if(cookieId == -10){
            return JianshuResult.build(400,"请先登录" );
        }
        Concern concern = concernService.selectConcern(cookieId, userId);
        if(concern==null) {
            concernService.insertConcern(cookieId, userId);
            return JianshuResult.ok("关注成功");
        }else{
            concernService.deleteConcern(cookieId,userId );
        }
        return JianshuResult.ok("删除成功");
    }

    //查询关注
    @RequestMapping(value = "/user/concernUser",method = RequestMethod.GET)
    @ResponseBody
    public List<MyPageUser> getConcernUser(Integer userId){
        List<MyPageUser> list=new ArrayList<>();
        List<Integer> integers = concernService.selectListByUserId(userId);
        for(Integer id:integers){
            MyPageUser myPageUser = userService.saveMyPageUser(id.intValue());
            myPageUser.setConcernStatus(1);
            list.add(myPageUser);

        }
        return list;
    }
    //查询粉丝
    @RequestMapping(value = "/user/fansUser",method = RequestMethod.GET)
    @ResponseBody
    public List<MyPageUser> getFansUser(Integer concernId){
        List<MyPageUser> list=new ArrayList<>();
        List<Integer> integers = concernService.selectListByConcernId(concernId);
        for(Integer id:integers){
            MyPageUser myPageUser = userService.saveMyPageUser(id);
            Concern concern = concernService.selectConcern(concernId, id);
            if(concern!=null){
                myPageUser.setConcernStatus(1);
            }else{
                myPageUser.setConcernStatus(0);
            }
            list.add(myPageUser);
        }
        return list;
    }
    //取消关注
    @RequestMapping(value = "/user/deleteConcern",method = RequestMethod.GET)
    @ResponseBody
    public JianshuResult deleteConcern(Integer userId,HttpServletRequest request,HttpServletResponse response){
        int cookieId = getCookieUserId(request, response);
        concernService.deleteConcern(cookieId,userId );
        return JianshuResult.ok();

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
    //搜索用户
    @RequestMapping(value ="/search/user",method = RequestMethod.POST)
    @ResponseBody
    public PageBean<MyPageUser> selectSearchUser(String nickName,Integer currentPage){
        int index=(currentPage-1)*SEARCH_USER_COUNT;
        PageBean<MyPageUser> pageBean = userService.selectLikeNickName(currentPage, index, nickName, SEARCH_USER_COUNT);
        return pageBean;
    }

    @RequestMapping(value = "/user/getAll",method = RequestMethod.GET)
    @ResponseBody
    public PageBean<MyPageUser> selectAllUser(Integer currentPage,HttpServletRequest request,HttpServletResponse response){
        int cookieUserId = getCookieUserId(request, response);
        PageBean<MyPageUser> pageBean = userService.selectAllUserAndPageBean(currentPage, ALLUSER_CURRENT_COUNT, cookieUserId);
        return  pageBean;
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
