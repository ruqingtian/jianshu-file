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
    <title>登入</title>
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
                            var expires=1*24*60*60*1000;
                            var date=new Date(new Date()+expires);
                            console.log(date);
                            console.log(data.data.nickName);
                            document.cookie="USERID="+data.data.id+";expires="+date.toUTCString();
                            window.location.href=document.referrer;

                        }
                    },
                    dataType: "json"
                })
            }
        }
    </script>
</head>

<body>
<a class="logo" href="/"><img src="../../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png" ></a>
<div >
    <h3 class="title">
        <div>
            <a href="/login">登入</a>
            <b>·</b>
            <a href="/register">注册</a>
        </div>
    </h3>
    <form  class="new_user"  >
        <tr>
        用户名：<input id="userName" type="text" name="userName"><span id="userNameSpan"></span><br>
        </tr>
        <tr>
        密  码：<input id="passWord" type="password" name="pwd"><span id="passWordSpan"></span><br>
        </tr>
        <tr>
        <input type="button" onclick="onSubmit()" value="提交">
        </tr>
    </form>
</div>
</body>
</html>
