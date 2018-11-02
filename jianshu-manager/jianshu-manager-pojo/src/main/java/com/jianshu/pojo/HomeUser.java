package com.jianshu.pojo;

import java.io.Serializable;

public class HomeUser implements Serializable {
    private int id ;
    private String img;
    private String nickName;
    private double sumNums;
    private int likeNums;

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

    public double getSumNums() {
        return sumNums;
    }

    public void setSumNums(double sumNums) {
        this.sumNums = sumNums;
    }

    public int getLikeNums() {
        return likeNums;
    }

    public void setLikeNums(int likeNums) {
        this.likeNums = likeNums;
    }
}
