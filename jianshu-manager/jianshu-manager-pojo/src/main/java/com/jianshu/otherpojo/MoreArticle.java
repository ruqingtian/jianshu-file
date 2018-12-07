package com.jianshu.otherpojo;

import com.jianshu.pojo.Article;

import java.io.Serializable;

public class MoreArticle  extends Article implements Serializable  {
    private int readNums;
    private int likeNums;//喜欢该文章在数量
    private int reviewNums;//评论的数量
    private String img;//头像
    private String nickName;//昵称
    private String dynamicContent;//动态信息的内容
    private String reviewContent;//动态 评论内容
    private String dynamicDate;//动态评论时间
    private int workerId;//使用者id

    public int getWorkerId() {
        return workerId;
    }

    public void setWorkerId(int workerId) {
        this.workerId = workerId;
    }

    public int getReviewNums() {
        return reviewNums;
    }

    public void setReviewNums(int reviewNums) {
        this.reviewNums = reviewNums;
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

    public String getDynamicContent() {
        return dynamicContent;
    }

    public void setDynamicContent(String dynamicContent) {
        this.dynamicContent = dynamicContent;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public String getDynamicDate() {
        return dynamicDate;
    }

    public void setDynamicDate(String dynamicDate) {
        this.dynamicDate = dynamicDate;
    }

    public int getLikeNums() {
        return likeNums;
    }

    public void setLikeNums(int likeNums) {
        this.likeNums = likeNums;
    }

    public int getReadNums() {
        return readNums;
    }

    public void setReadNums(int readNums) {
        this.readNums = readNums;
    }
}
