package com.jianshu.controller;

import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {

    @Autowired
    private UserService service;

    @RequestMapping(value="/user/save",method= RequestMethod.POST)
    public String dosave(String nickName,String userName,String pwd,String sex,String phone,String mail){
            service.saveUser(nickName,userName ,pwd ,sex ,phone ,mail );
        return "ok";
    }
}
