package com.jianshu.otherpojo;

import com.jianshu.pojo.Article;

import java.io.Serializable;
import java.util.List;

public class MyPageUser implements Serializable {
    private int id;
    private String img;
    private String nickName;
    private int concernNums;
    private int fansNums;
    private int articleNums;
    private int count;//总字数
    private int likeNums;
    private String desc;//个人简介
    private int concernStatus;//1已关注
    private String userImg;
    private String userName;
    private String dynamicContent;
    private String dynamicDate;
    public List<Article> articleTitle;

    public List<Article> getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(List<Article> articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getDynamicContent() {
        return dynamicContent;
    }

    public void setDynamicContent(String dynamicContent) {
        this.dynamicContent = dynamicContent;
    }

    public String getDynamicDate() {
        return dynamicDate;
    }

    public void setDynamicDate(String dynamicDate) {
        this.dynamicDate = dynamicDate;
    }

    public String getUserImg() {
        return userImg;
    }

    public void setUserImg(String userImg) {
        this.userImg = userImg;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getConcernStatus() {
        return concernStatus;
    }

    public void setConcernStatus(int concernStatus) {
        this.concernStatus = concernStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public int getConcernNums() {
        return concernNums;
    }

    public void setConcernNums(int concernNums) {
        this.concernNums = concernNums;
    }

    public int getFansNums() {
        return fansNums;
    }

    public void setFansNums(int fansNums) {
        this.fansNums = fansNums;
    }

    public int getArticleNums() {
        return articleNums;
    }

    public void setArticleNums(int articleNums) {
        this.articleNums = articleNums;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getLikeNums() {
        return likeNums;
    }

    public void setLikeNums(int likeNums) {
        this.likeNums = likeNums;
    }
}
