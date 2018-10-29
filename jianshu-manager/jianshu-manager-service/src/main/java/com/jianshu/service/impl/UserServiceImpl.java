package com.jianshu.service.impl;

import com.jianshu.mapper.UserMapper;
import com.jianshu.pojo.User;
import com.jianshu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;


    @Override
    public void saveUser(String nickName, String userName, String pwd, String sex, String phone, String mail) {
        User user=new User();


        user.setNickName(nickName);
        user.setUserName(userName);
        user.setPwd(pwd);
        user.setSex(sex);
        user.setPhone(phone);
        user.setMail(mail);
        //补全信息
        user.setCreateTime(new Date());
        user.setUpdateTime(new Date());


        mapper.insert(user);
    }
}
