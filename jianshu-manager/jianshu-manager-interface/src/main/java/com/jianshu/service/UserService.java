package com.jianshu.service;

import com.jianshu.pojo.User;

public interface UserService {
    //创建用户
    public void  saveUser(String nickName,String userName,String pwd,String sex,String phone,String mail);
    //修改用户
//    public void updateUser(User user);
}
