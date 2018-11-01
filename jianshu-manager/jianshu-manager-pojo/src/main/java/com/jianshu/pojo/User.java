package com.jianshu.pojo;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
    private int id;
    private String img;
    private String nickName;
    private String userName;
    private String pwd;
    private String sex;
    private String phone;
    private String mail;
    private String userDesc;
    private int fansNums;
    private int concernNums;
    private Date createTime;
    private Date updateTime;

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName==null?null:nickName.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName==null?null:userName.trim();
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd==null?null:pwd.trim();;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone==null?null:phone.trim();
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail==null?null:mail.trim();
    }

    public String getUserDesc() {
        return userDesc;
    }

    public void setUserDesc(String userDesc) {
        this.userDesc = userDesc==null?null:userDesc.trim();
    }

    public int getFansNums() {
        return fansNums;
    }

    public void setFansNums(int fansNums) {
        this.fansNums = fansNums;
    }

    public int getConcernNums() {
        return concernNums;
    }

    public void setConcernNums(int concernNums) {
        this.concernNums = concernNums;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
