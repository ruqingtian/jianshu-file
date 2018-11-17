package com.jianshu.pojo;

import java.io.Serializable;
import java.util.Date;

public class Concern implements Serializable {
    private int userId;
    private int concernId;
    private Date createTime;
    private int likeArticleId;
    private int readArticleId;

    public int getLikeArticleId() {
        return likeArticleId;
    }

    public void setLikeArticleId(int likeArticleId) {
        this.likeArticleId = likeArticleId;
    }

    public int getReadArticleId() {
        return readArticleId;
    }

    public void setReadArticleId(int readArticleId) {
        this.readArticleId = readArticleId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getConcernId() {
        return concernId;
    }

    public void setConcernId(int concernId) {
        this.concernId = concernId;
    }
}
