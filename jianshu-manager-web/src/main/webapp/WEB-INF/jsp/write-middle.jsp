<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2019/1/11
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="border: 1px solid blue;">
    <p id="newSaveArticle"  style="display:none">文章:<a id="UserId+${user.id}"   href="javascript:void(0)" onclick="saveArticle(this)">新建文章</a></p>
    <div  id="collectionName"></div>
</div>
</body>
</html>
