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
    <title>注册用户</title>
    <style type="text/css">
        div{
            width: 100%;
            text-align: center;
            position: relative;
            height: 109px;

            margin:0 auto;
        }
    </style>

    <script type="text/javascript">
       // /* $(function () {
       //     alert("12d")
       //  });*/
        function checkName() {
            var input=document.getElementById("userName");
            var spanNode=document.getElementById("userId");

            $.ajax({
                type:"POST",
                url:"/user/check",
                data:{
                    name:$("#userName").val(),
                    type:1
                },

                success:function (data) {
                    if(data.status==200){
                        spanNode.innerHTML="正确".fontcolor("green");
                    }else{
                        spanNode.innerHTML=data.msg.fontcolor("red");
                    }
                },
                dataType: "json"
            });
        }
        function checkPwd() {
            var inputNode=document.getElementById("pwd");
            var spanNode=document.getElementById("userPwd");
            var content=inputNode.value;
            var reg=/^[a-z0-9]{6,18}$/i;
            if(reg.test(content)){
                spanNode.innerHTML="正确".fontcolor("green");
            }else{
                spanNode.innerHTML="错误".fontcolor("red");
            }

        }
        function checkPwd2() {
            var inputNode=document.getElementById("pwd");
            var password=inputNode.value;
            var inputNode2=document.getElementById("pwd2");
            var password2=inputNode2.value;
            var spanNode = document.getElementById("userPwd2");


            if (password!=""&password == password2) {
                spanNode.innerHTML = "正确".fontcolor("green");
            } else {
                spanNode.innerHTML = "错误".fontcolor("red");
            }
        }
        function checkPhone() {
            console.log(21);
            var inputNode=document.getElementById("phone");
            var content=inputNode.value;
            var spanNode=document.getElementById("userPhone");
            var reg=/^\d{11}$/;
            if(reg.test(content)){
                spanNode.innerHTML = "正确".fontcolor("green");
            } else {
                spanNode.innerHTML = "错误".fontcolor("red");
            }
        }
        function checkAll() {
            var flag=true;
            console.log(111);
            console.log($("#userId").html());
            console.log($("#userPwd").html());
            console.log($("#userPwd2").html());
            console.log($("#ususerPhone").html());


            console.log($("#userId").html());
            if(document.getElementById("userId").innerHTML!=="<font color=\"green\">正确</font>"){
                flag=false;
            }
            if(document.getElementById("userPwd").innerHTML!=="<font color=\"green\">正确</font>"){
                flag=false;
            }
            if(document.getElementById("userPwd2").innerHTML!=="<font color=\"green\">正确</font>"){
                flag=false;
            }
            if(document.getElementById("userPhone").innerHTML!=="<font color=\"green\">正确</font>"){
                flag=false;
            }
            console.log("flag="+flag);
            alert(flag);
            return flag;
        }
    </script>
</head>
<body>
<a class="logo" href="/"><img src="../../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png" ></a>
<div >
    <h3 class="title">
        <div>
            <a href="/login">登录</a>
            <b>·</b>
            <a href="/register">注册</a>
        </div>
    </h3>
<form action="/user/save" class="new_user" id="userRegFrom" method="post" enctype="multipart/form-data" onsubmit="return true"/>
        昵称：<input type="text" name="nickName"><br/>
        头像：<input type="file" name="img" /><br/>
        用户名：<input type="text" name="userName" id="userName" onblur="checkName()"><span id="userId"></span><br>
        设置密码：<input type="password" name="pwd" id="pwd" onblur="checkPwd()"><span id="userPwd"></span><br>
        确认密码：<input type="password" name="pwd2" id="pwd2" onblur="checkPwd2()"><span id="userPwd2"></span><br/>
        手机号：<input type="text" name="phone" id="phone" onkeyup="checkPhone()"><span id="userPhone"></span><br>



    <input  type="submit" value="提交" onclick="return checkAll()"/>
</form>
</div>
</body>
</html>
