<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2019/1/11
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style=";border: 1px solid gold;">
    <script type="text/javascript">
        var ue=UE.getEditor("container");
    </script>
    <div >

        标题：<input style="width: 90%" type="text" name="title" value="无标题文章" id="articleTitle"/><br/>
        封面图片：<img src="/" id="titleImg" width="130px" height="90px"><input id="fileImg" accept="image/*" type="file" onchange="imgChange(this)" value="上传"/>

        <input type="hidden" id="articleId" name="articleId" value="-100"   />
        <script type="text/plain" id="container" name="content" >
            这里是初始化内容
        </script>
        <input type="button" onclick="submitArticle()" value="提交">

    </div>

</div>
</body>
</html>
