package com.jianshu.otherpojo;

import java.io.Serializable;

public class MyPageUser implements Serializable {
    private int id;
    private String img;
    private String nickName;
    private int concernNums;
    private int fansNums;
    private int articleNums;
    private int count;
    private int likeNums;
    private int concernStatus;

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
