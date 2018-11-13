<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/9
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript " src="/js/jquery.cookie.js"></script>
    <style type="text/css">
        .content{
            width: 80%;
            text-align: center;
        }
    </style>
    <title>文章详情</title>
</head>
<body>
<jsp:include page="top.jsp"/>
<div class="content" style="position:relative; margin-left:10px; margin-top:50px;">
    <h2>${article.title}</h2><br/>
    <p><img  class="smallImg" src="${user1.img}"/>${user1.nickName}<input type="button" value="+关注" style="font-size: 15px; background: #6ce26c"/></p>
    <p style="font-size: 15px">${article.showTime} 字数 ${article.number} 阅读 ${article.readNums} 评论 0 喜欢 ${article.likeNums}</p>
</div>
<div class="content">
<img src="${article.image}"/>
</div>
<div class="content">
    ${article.content}
</div>
</body>
</html>
