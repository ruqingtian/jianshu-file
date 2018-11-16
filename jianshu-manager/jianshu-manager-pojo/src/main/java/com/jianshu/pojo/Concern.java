package com.jianshu.pojo;

import java.io.Serializable;

public class Concern implements Serializable {
    private int userId;
    private int concernId;

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
