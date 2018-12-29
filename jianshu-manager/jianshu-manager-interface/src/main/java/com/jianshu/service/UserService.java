package com.jianshu.service;

import com.jianshu.otherpojo.JianshuResult;
import com.jianshu.otherpojo.MyPageUser;
import com.jianshu.otherpojo.PageBean;
import com.jianshu.pojo.HomeUser;
import com.jianshu.pojo.User;

import java.util.List;

public interface UserService {
    //创建用户
    public void  saveUser(String nickName,String userName,String pwd,String phone);

    //检验数据
    public JianshuResult checkName(String param,Integer type);

    //根据用户名查密码
    public User selectPwdByUserName(String userName);

    //根据id 查询用户
    public User selectUserById(int id);

    //查询所有用户
    public List<HomeUser> selectHomeUser();
    //分页查询用户
    public PageBean selectPageUser(int currentPage,int index, int currentCount,int cookieId);
    //修改用户
    public void updateUser(User user);
    //封装MyPageUser
    public MyPageUser saveMyPageUser(int id);
    //模糊查询分页
    public PageBean<MyPageUser> selectLikeNickName(int currentPage,int index,String nickName,int currentCount);
    //查询全部的用户进行封装 并分页
    public PageBean<MyPageUser> selectAllUserAndPageBean(int currentPage,int currentCount,int userId);
}
