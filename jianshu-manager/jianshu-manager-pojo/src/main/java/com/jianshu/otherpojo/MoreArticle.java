package com.jianshu.otherpojo;

import com.jianshu.pojo.Article;

import java.io.Serializable;

public class MoreArticle  extends Article implements Serializable  {
    private int readNums;

    public int getReadNums() {
        return readNums;
    }

    public void setReadNums(int readNums) {
        this.readNums = readNums;
    }
}
