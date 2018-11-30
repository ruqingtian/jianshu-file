package com.jianshu.otherpojo;

import com.jianshu.pojo.Article;

import java.io.Serializable;

public class MoreArticle  extends Article implements Serializable  {
    private int readNums;
    private int likeNums;//喜欢该文章在数量

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
