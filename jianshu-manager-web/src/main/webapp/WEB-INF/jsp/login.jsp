<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/10/30
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>登入</title>
    <style type="text/css">
        div{
            width: 100%;
            text-align: center;
            position: relative;
            height: 109px;
            margin:0 auto;

            border:10px;
        }

    </style>
</head>

<body>
<a class="logo" href="/"><img src="../../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png" ></a>
<div >
    <h3 class="title">
        <div>
            <a href="/login">登入</a>
            <b>·</b>
            <a href="/register">注册</a>
        </div>
    </h3>
    <form  class="new_user" action="/user/login" method="post"   >
        <tr>
        用户名：<input type="text" name="userName"><br>
        </tr>
        <tr>
        密  码：<input type="password" name="pwd"><br>
        </tr>
        <tr>
        <input type="submit" value="提交">
        </tr>
    </form>
</div>
</body>
</html>
