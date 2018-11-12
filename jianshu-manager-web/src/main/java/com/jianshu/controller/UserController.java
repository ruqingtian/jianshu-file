package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;
import com.jianshu.service.UserService;

import com.jianshu.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    @Autowired
    private UserService service;

    @Value("${USER_CURRENT_COUNT}")
    private Integer USER_CURRENT_COUNT;
    //注册用户
    @RequestMapping(value="/user/save",method= RequestMethod.POST)
    @ResponseBody
    public JianshuResult dosave(String nickName, String userName, String pwd, String sex, String phone, String mail, MultipartFile img, HttpServletRequest request){

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

        service.saveUser(nickName,userName,pwd,sex,phone,mail,imgPath);
        return JianshuResult.ok();
    }




    //检验
    @RequestMapping(value = "/user/check",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult checkData(@RequestParam String name,@RequestParam Integer type){
        JianshuResult jianshuResult = service.checkName(name, type);
        return jianshuResult;
    }

    //登入
    @RequestMapping(value = "/user/login",method = RequestMethod.POST)
    @ResponseBody
    public JianshuResult login(String userName,String pwd){
        User user = service.selectPwdByUserName(userName);
        if(user==null||!user.getPwd().equals(pwd)){
            return  JianshuResult.build(400,"用户名或者密码错误" );
        }

            return JianshuResult.ok(user);

    }

    //分页查询用户
    @RequestMapping(value = "/index/userPage",method = RequestMethod.GET)
    @ResponseBody
    public PageBean page(Integer currentPage){

        int index=(currentPage-1)*USER_CURRENT_COUNT;
        PageBean pageBean = service.selectPageUser(currentPage, index, USER_CURRENT_COUNT);
        return pageBean;

    }
}
