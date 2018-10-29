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
    <title>添加用户</title>
</head>
<body>
<form class="new_user" action="/user/save" method="post"   >
        昵称：<input type="text" name="nickName"><br/>

        用户名：<input type="text" name="userName"><br>
        密  码：<input type="password" name="pwd"><br>
        性别：<<input type="text" name="sex" ><br>


        手机号：<input type="text" name="phone"><br>
        邮  箱：<input type="text" name="mail"><br>


    <input type="submit" value="提交">
</form>
</body>
</html>
