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
    <script type="text/javascript" src="/js/jquery-1.6.4.js"></script>
    <link rel="stylesheet" href="/css/registerAndLogin.css">
    <title>注册用户</title>
    <style type="text/css">

    </style>

    <script type="text/javascript">
        // /* $(function () {
        //     alert("12d")
        //  });*/
        $(function () {
            $(".now").removeClass("now");
            $("#register").addClass("now");
        })

        function checkName() {
            var input = document.getElementById("userName");
            var spanNode = document.getElementById("userId");

            $.ajax({
                type: "POST",
                url: "/user/check",
                data: {
                    name: $("#userName").val(),
                    type: 1
                },

                success: function (data) {
                    if (data.status == 200) {
                        spanNode.innerHTML = "正确".fontcolor("green");
                    } else {
                        spanNode.innerHTML = data.msg.fontcolor("red");
                    }
                },
                dataType: "json"
            });
        }

        function checkPwd() {
            var inputNode = document.getElementById("pwd");
            var spanNode = document.getElementById("userPwd");
            var content = inputNode.value;
            var reg = /^[a-z0-9]{6,18}$/i;
            if (reg.test(content)) {
                spanNode.innerHTML = "正确".fontcolor("green");
            } else {
                spanNode.innerHTML = "错误".fontcolor("red");
            }

        }

        function checkPwd2() {
            var inputNode = document.getElementById("pwd");
            var password = inputNode.value;
            var inputNode2 = document.getElementById("pwd2");
            var password2 = inputNode2.value;
            var spanNode = document.getElementById("userPwd2");


            if (password != "" & password == password2) {
                spanNode.innerHTML = "正确".fontcolor("green");
            } else {
                spanNode.innerHTML = "错误".fontcolor("red");
            }
        }

        function checkPhone() {
            console.log(21);
            var inputNode = document.getElementById("phone");
            var content = inputNode.value;
            var spanNode = document.getElementById("userPhone");
            var reg = /^\d{11}$/;
            if (reg.test(content)) {
                spanNode.innerHTML = "正确".fontcolor("green");
            } else {
                spanNode.innerHTML = "错误".fontcolor("red");
            }
        }

        function checkAll() {
            var flag = true;
            console.log(111);
            console.log($("#userId").html());
            console.log($("#userPwd").html());
            console.log($("#userPwd2").html());
            console.log($("#ususerPhone").html());


            console.log($("#userId").html());
            if (document.getElementById("userId").innerHTML !== "<font color=\"green\">正确</font>") {
                flag = false;
            }
            if (document.getElementById("userPwd").innerHTML !== "<font color=\"green\">正确</font>") {
                flag = false;
            }
            if (document.getElementById("userPwd2").innerHTML !== "<font color=\"green\">正确</font>") {
                flag = false;
            }
            if (document.getElementById("userPhone").innerHTML !== "<font color=\"green\">正确</font>") {
                flag = false;
            }
            console.log("flag=" + flag);

            return flag;
        }
    </script>
</head>
<body style="background-color:  #f0f0f0">
<div class="overAll">
    <div class="logo">
        <a href="/"><img class="logoImg" src="../../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png"></a>
    </div>
    <div class="backBorder">
        <div>
            <h3 class="title">
                <div>
                    <a class="title" href="/login">登录</a>
                    <b>&nbsp;·&nbsp; </b>
                    <a id="register" class="title" href="/register">注册</a>
                </div>
            </h3>
            <div class="content" >
                <form action="/user/save" class="new_user" id="userRegFrom" method="post" enctype="multipart/form-data"
                      onsubmit="return true"/>
                <input class="input" type="text" name="nickName" placeholder="你的昵称"><br/>
                <input class="input" type="text" name="userName" id="userName" placeholder="请输入用户名"
                       onblur="checkName()"><span
                    id="userId"></span><br>
                <input class="input" type="password" name="pwd" id="pwd" onblur="checkPwd()" placeholder="请输入密码"><span
                    id="userPwd"></span><br>
                <input class="input" type="password" name="pwd2" id="pwd2" onblur="checkPwd2()"
                       placeholder="请确认密码"><span
                    id="userPwd2"></span><br/>
                <input class="input" type="text" name="phone" id="phone" placeholder="请输入手机号"
                       onkeyup="checkPhone()"><span
                    id="userPhone"></span><br>


                <input class="input" style="background-color: #6ce26c;margin-top: 20px" type="submit" value="注册"
                       onclick="return checkAll()"/>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
