<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2019/1/11
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="border: 1px solid red;">

    <a href="javascript:void(0)" onclick="saveCollection()">+新建文集</a> <br/>
    <div id="newCollectionName" style="display:none">
        <input id="userId" type="hidden" value="${user.id}">
        <input  type='text' onclick="newCollNameReset()"  id='newCollName'/>
        <input type='button' onclick="submitCollectionName()" value='提交' />
        <input id='newCollectionNameButton' onclick='updateDisplay()'  type='button' value='取消' />

    </div>
    <c:forEach items="${collectionList}" var="collection">
        <input type="button" name=${collection.id} value=${collection.name}   onclick="getCollection(this)"/>
        <span  id=${collection.id} style="display:none">
        <input type="button" onclick="updateCollectionName(this)" value="修改"/>
           <input type="text" style="display:none" onblur="updateName(this)"/>
        <input type="button" onclick="deleteCollection(this)" value="删除">
        </span>
        <br/>

    </c:forEach>
</div>
</body>
</html>
