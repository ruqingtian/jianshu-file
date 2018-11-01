<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/10/28
  Time: 18:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>简书-创作你的创作</title>

    <style type="text/css">
       .top{
            width: 100%;
            height: 50px;
            font-size: 20px;
          z-index:999;
           position: fixed;
            top: 0;
            lsft:0;
           background-color: antiquewhite;

        }
        .content{
            position:relative; margin-left:10px; margin-top:50px;
        }
        img{
            height: 40px;
        }


    </style>

</head>



<body>
<div class="top">
    <nav >
    <a class="logo" href="/"><img src="../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png" /></a>
    <a class="first" href="/" >首页</a> <a href="/" >下载app</a><input type="text"> <input type="button" value="搜索">

    <!--右上角 -->

    <a  class="btn" href="/login">登入</a>
    <a class="btn"href="/register">注册</a>
    <a class="btn" href="/write">写文章</a>
    </nav>
</div>
<div class="content">
    推荐作者：<br/>
    <c:forEach items="${homeUserList}" var="homeUser">

         <img src='${homeUser.img}'/>  ${homeUser.nickName}: 写了${homeUser.sumNums} ${homeUser.likeNums} 喜欢      <a href="/">关注</a><br/>
    </c:forEach>
</div>

</body>
</html>
