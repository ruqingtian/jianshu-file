<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/13
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>

    <title>用户设置</title>
    <style type="text/css">
        .content{
            position:relative; margin-left:10px; margin-top:50px;
            width: 100%;
            height: 100%;
            left: 35%;

        }
        .touxiang{
            height: 40px;
        }

    </style>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="content">
    <form action="/user/update" method="post" enctype="multipart/form-data">
        <table>
            <input type="hidden" name="id" value="${user.id}">
        <tr>
            <td><img class="touxiang" src="${user.img}"/> </td>
            <td><input name="image"  type="file"/>更换头像</td>
        </tr>
        <tr>
            <td>昵称</td>
            <td><input name="nickName" type="text" value="${user.nickName}"></td>
        </tr>
        <tr>
            <td>性别</td>
            <td>
                <c:choose>
                    <c:when test="${user.sex==1}">
                        <script type="text/javascript">
                            $(function () {
                                $("#nv").removeAttr("checked");
                                $("#nan").attr({checked:"checked"});
                                $("#baomi").removeAttr("checked");
                            })

                        </script>
                    </c:when>
                    <c:when test="${user.sex==0}">
                        <script type="text/javascript">
                            $(function () {
                                $("#nan").removeAttr("checked");
                                $("#nv").attr({checked: "checked"});
                                $("#baomi").removeAttr("checked");
                            })


                        </script>
                    </c:when>
                    <c:when test="${user.sex==2}">
                        <script type="text/javascript">
                            $(function () {
                                $("#nan").removeAttr("checked");
                                $("#nv").removeAttr("checked");
                                $("#baomi").attr({checked: "checked"});
                            })
                        </script>
                    </c:when>
                </c:choose>
                <input id="nv"  type="radio" value="0" name="sex">女</input>
                <input id="nan"  type="radio" value="1" name="sex">男</input>
                <input id="baomi"  type="radio" value="2" name="sex">保密</input>

            </td>
        </tr>
        <tr>
            <td>个人简介</td>
            <td><textarea name="userDesc" rows="5" cols="20">${user.userDesc}</textarea></td>
        </tr>
        <tr>
            <td>电子邮件</td>
            <td><input name="mail" type="text" value="${user.mail}"/></td>
        </tr>
        <tr>
            <td>手机</td>
            <td><input name="phone" type="text" value="${user.phone}"/></td>
        </tr>
        <tr>
            <td>个人网站</td>
            <td><input name="web" type="text" value="${user.web}"/></td>
        </tr>
            <tr>
                <td ><input type="submit" value="保存"></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
