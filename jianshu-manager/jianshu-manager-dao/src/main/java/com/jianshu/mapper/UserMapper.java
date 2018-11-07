package com.jianshu.mapper;

import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/*
* 操作用户的接口
* */
public interface UserMapper {
    //添加一个用户
    int insert(User user);
    //查询所有的用户
    List<User> selectAllUser();
    //根据用户名查询
    String selectByUserName(String userName);

    //分页查询主页显示用户
    List<User> selectPageUser(@Param("index") int index,@Param("currentCount") int currentCount);
    //查询总条数
    int selectTotalCount();


    //根据id 修改用户
    int update(User user);
    
    //根据id 查询用户
    User selectUserById(int id);

}
