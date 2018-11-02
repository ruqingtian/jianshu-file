package com.jianshu.otherpojo;

import java.io.Serializable;

public class JianshuResult implements Serializable{
        // 响应业务状态
        private Integer status;

        // 响应消息
        private String msg;

        // 响应中的数据
        private Object data;

        //构建其他状态的JianshuResult对象
        public static JianshuResult build(Integer status, String msg, Object data) {
            return new JianshuResult(status, msg, data);
        }

        public static JianshuResult ok(Object data) {
            return new JianshuResult(data);
        }

        public static JianshuResult ok() {
            return new JianshuResult(null);
        }

        public JianshuResult() {

        }

        public static JianshuResult build(Integer status, String msg) {
            return new JianshuResult(status, msg, null);
        }

        public JianshuResult(Integer status, String msg, Object data) {
            this.status = status;
            this.msg = msg;
            this.data = data;
        }

        public JianshuResult(Object data) {
            this.status = 200;
            this.msg = "OK";
            this.data = data;
        }

        public Integer getStatus() {
            return status;
        }

        public void setStatus(Integer status) {
            this.status = status;
        }

        public String getMsg() {
            return msg;
        }

        public void setMsg(String msg) {
            this.msg = msg;
        }

        public Object getData() {
            return data;
        }

        public void setData(Object data) {
            this.data = data;
        }

    }

