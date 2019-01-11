<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2019/1/11
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="/js/write.js"></script>
    <link rel="stylesheet" href="/css/write.css">
    <title>Title</title>
</head>
<frameset rows="15%,20%*">
    <frame src="/WEB-INF/jsp/write-left.jsp"/>
    <frame src="/WEB-INF/jsp/write-middle.jsp">
    <frame src="/WEB-INF/jsp/write-right.jsp">
</frameset>
</html>
