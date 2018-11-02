<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/10/31
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.6.4.js"></script>
    <title>写文章</title>
    <script type="text/javascript">
        $(function () {
            alert("123");
        });
        function getCollection() {
            alert("1231");
            $.ajax({
                type:"GET",
                url:"/write/article",
                data:{id:1},
                success:function (data) {
                    alert(data);
                },
                dataType:"json"
            });
        }
    </script>
</head>
<body>
<h1>${nickName}</h1><br/>
<div>

    文章集：<a href="">新建文集</a> <br/>

    <c:forEach items="${collectionList}" var="collection">
        <input type="button"  value=${collection.name} id="${collection.id}"  onclick="getCollection()"/>  <br/>
    </c:forEach>




</div>
<hr/>
<div id="collectionName">

    文章：<a href="">新建文章</a><br/>
    <c:if test="${not empty articleList}">
    <c:forEach items="${articleList}" var="article">
        ${article.title}
        <c:choose>
            <c:when test="${article.status==1}">
                （已发布）
            </c:when>
            <c:otherwise>
                （未发布）
            </c:otherwise>
        </c:choose> <br/>
    </c:forEach>
    </c:if>

</div>
</body>
</html>
