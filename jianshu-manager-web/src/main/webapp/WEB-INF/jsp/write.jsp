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
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
    <title>写文章</title>
    <script type="text/javascript">
        // $(function () {
        //     alert("123");
        // });
        // 获取文章标题
        function getCollection(id) {

           var id=id;
            $("#collectionName").html("");
            // console.log(id);
            $.ajax({
                type:"GET",
                url:"/write/article",
                data:{id:id},
                success:function (data) {

                    console.log(data);
                    var str="文章:<a href=''+>新建文章</a>";
                    $("#collectionName").html(str);
                    for(var i=0;i<data.length;i++){
                        console.log(data[i].status);
                        var sta="未发布";
                        if(data[i].status===1){
                            sta="已发布";
                        }
                     var   content="<br/><input id="+data[i].id+" type='button' class='articleName' value="+data[i].title+" />("+sta+")";
                        $("#collectionName").append(content);
                    }
                    $("#collectionName").append("<hr/>")

                },
                dataType:"json"
            });
        }

        console.log("waimian");
        //获取文章的内容
        $('.articleName').live('click',function () {
            alert(123);
          var aId=this.id;
            console.log(this.id);



            $.ajax({
                type:"POST",
                url:"/write/content",
                data:{id:aId},
                success:function (data) {
                    $("#container textarea:only-child" ).innerHTML=data.content;

                },
                dataType:"json"
            });


        });


    </script>
</head>
<body>
<h1>${nickName}</h1><br/>
<div>

    文章集：<a href="">新建文集</a> <br/>

    <c:forEach items="${collectionList}" var="collection">
        <input type="button" name="collectionName"  value=${collection.name} id=${collection.id}  onclick="getCollection(${collection.id})"/>  <br/>
    </c:forEach>
</div>
<hr/>
<div id="collectionName">

</div>

<div>
    <script type="text/javascript">
        var ue=UE.getEditor("container");
    </script>
    <form action="">
        标题：<input type="text" value="无标题文章" id="articleTitle"/>
        <input type="text" name="userNumber"  value="1"/>
    <textarea id="container" name="container" rows="10" cols="50" >


    </textarea>
        <input type="submit" value="提交">
    </form>

</div>
</body>
</html>
