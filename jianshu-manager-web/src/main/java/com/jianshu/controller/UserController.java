package com.jianshu.controller;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.pojo.HomeUser;
import com.jianshu.service.UserService;

import com.jianshu.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.PrintWriter;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService service;

    //注册用户
    @RequestMapping(value="/user/save",method= RequestMethod.POST)
    @ResponseBody
    public JianshuResult dosave(String nickName,String userName,String pwd,String sex,String phone,String mail,String img){


        service.saveUser(nickName,userName,pwd,sex,phone,mail,img);
        return JianshuResult.ok();
    }

    //主页显示全部用户
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(Model model){
        List<HomeUser> list = service.selectHomeUser();
        model.addAttribute("homeUserList", list);
        return "index";
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
        String s = service.selectPwdByUserName(userName);
        if(s==null||!s.equals(pwd)){
            return  JianshuResult.build(400,"用户名或者密码错误" );
        }

            return JianshuResult.ok("登入成功");



    }
}
