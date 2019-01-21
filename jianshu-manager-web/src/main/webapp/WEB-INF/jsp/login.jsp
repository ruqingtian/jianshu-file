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

    <script type="text/javascript" src="/js/jquery-1.6.4.js"></script>
    <link rel="stylesheet" href="/css/registerAndLogin.css">
    <title>登录</title>
    <style type="text/css">
        div{
            width: 100%;
            text-align: center;
            position: relative;
            height: 109px;
            margin:0 auto;

            border:10px;
        }
        span{
            font-size: 15px;
            color: red;
        }

    </style>
    <script type="text/javascript">
        $(function () {
            $(".now").removeClass("now");
            $("#login").addClass("now");
        })
        function regexUserName(obj) {
            var userName=$(obj).val();
            console.log(userName);
            if(userName.trim()==""){
                $("#userNameSpan").html("用户名不能为空");
            }else{
                $("#userNameSpan").html("");
            }
        }
        function regexPassWord(obj) {
            var passWord=$(obj).val();
            if(passWord.trim()==""){
                $("#passWordSpan").html("密码不能为空");
            }else{
                $("#passWordSpan").html("");
            }
        }
        function onSubmit() {

            var userName= $("#userName").val();
            var pwd= $("#passWord").val();
            if(userName.trim()==""){
                $("#userNameSpan").html("用户名不能为空");
            }else if(pwd.trim()==""){
                $("#passWordSpan").html("密码不能为空");
            }else {
                $.ajax({
                    type: "POST",
                    url: "/user/login",
                    data: {"userName": userName, "pwd": pwd},
                    success: function (data) {
                      console.log(data);
                        if(data.status==400){
                            alert(data.msg);
                        }else if(data.status==200){
                            window.location.href=document.referrer;

                        }
                    },
                    dataType: "json"
                })
            }
        }
    </script>
</head>

<body style="background-color:  #f0f0f0">
<div class="overAll">
    <div class="logo" style="margin-left: -15px">
        <a href="/"><img class="logoImg" src="../../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png"></a>
    </div>
    <div class="backBorder" style="height: 350px;margin-top: 0px">
        <div >
            <h3 class="title">
                <div style="height: 40px" >
                    <a class="title" id="login" href="/login">登录</a>
                    <b>&nbsp;· &nbsp;</b>
                    <a class="title" id="register" href="/register">注册</a>
                </div>
            </h3>
            <div class="content" >
                <form class="new_user">
                    <table>
                        <tr>
                            <td>用户名：</td>
                            <td> <input onkeyup="regexUserName(this)" class="input" id="userName" type="text" name="userName" placeholder="请输入用户名"></td>
                            <td><span id="userNameSpan"></span>
                        </tr>

                        <tr>
                            <td>密码：</td>
                            <td><input onkeyup="regexPassWord(this)" class="input" id="passWord" type="password" name="pwd" placeholder="请输入密码"></td>
                            <td>  <span
                                    id="passWordSpan"></span></td>
                        </tr>

                        <tr>
                            <td align="center" colspan="3"> <input class="input" style="background-color: #6ce26c;margin-top: 20px" type="button"
                                        onclick="onSubmit()" value="登陆"></td>

                        </tr>

                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
