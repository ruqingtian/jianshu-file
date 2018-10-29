package com.jianshu.mapper;

import com.jianshu.pojo.User;

/*
* 操作用户的接口
* */
public interface UserMapper {
    //添加一个用户
    int insert(User user);


    //根据id 修改用户
    int update(User user);
    
    //根据id 获取用户
    User select(int id);

}
