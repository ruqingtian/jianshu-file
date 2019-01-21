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
            position:relative;
            width: 100%;
            height: 100%;
            left: 35%;

        }
        .touxiang{
            height: 100px;
            width: 100px;
        }
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }


    </style>
    <script type="text/javascript">
        function imgChange(obj) {
            var file=document.getElementById("touxiangImg");
            var imgUrl=window.URL.createObjectURL(file.files[0]);
            console.log(imgUrl);
            $(".touxiang").attr("src",imgUrl);
        }
        function regexPhone(obj) {
            var phone=$(obj).val();
            console.log(phone.length);
            if(phone.length!=11){
                document.getElementById("regexPhone").innerText="手机号只能11位";
            }else{
                var reg=/\d{11}/;

                if(reg.test(phone)){
                    document.getElementById("regexPhone").innerText="";
                }else{
                    document.getElementById("regexPhone").innerText="手机号只能是数字";
                }
            }
        }
        function checkAll() {
            var  val=$("#regexPhone").text();
            var flag=false;
            if(val==""){
                flag=true;
            }
            return flag;
        }
    </script>
</head>
<body>
<div style="">
<jsp:include page="top.jsp"></jsp:include></div>
<div class="content" style="padding-top: 100px">
    <form action="/user/update" method="post" enctype="multipart/form-data">
        <table style="border-spacing: 15px">
            <input type="hidden" name="id" value="${user.id}">
        <tr>
            <td><img class="touxiang" id="changeImg" src="${user.img}"/> </td>
            <td><a style="font-size: 25px" href="javascript:;" class="file">更换头像<input name="image" id="touxiangImg" onchange="imgChange(this)"  type="file"/></a></td>
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
            <td><input name="phone" type="text" value="${user.phone}" onblur="regexPhone(this)"/><span style="color: red" id="regexPhone"></span></td>
        </tr>
        <tr>
            <td>个人网站</td>
            <td><input name="web" type="text" value="${user.web}"/></td>
        </tr>
            <tr>
                <td  colspan="2"><input style="font-size: 20px; width: 100px;border-radius: 18px;margin-left:40%;background-color: #6ce26c" type="submit" value="保存" onclick="return checkAll()" ></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
