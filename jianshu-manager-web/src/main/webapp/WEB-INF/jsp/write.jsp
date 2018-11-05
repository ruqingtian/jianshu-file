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
            // var nextEle=$("#"+id+"").nextSibling();
            // console.log(nextEle.className);
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
                    $("#collectionName").append("<hr/>");


                },
                dataType:"json"
            });
        }

        console.log("waimian");
        //获取文章的内容
        $('.articleName').live('click',function () {

          var aId=this.id;
            console.log(this.id);



            $.ajax({
                type:"POST",
                url:"/write/content",
                data:{id:aId},
                success:function (data) {
                    var ue = UE.getEditor('container');
                    ue.setContent(data.content);
                    $("#articleTitle").val(data.title);
                    $("#articleId").val(data.id);

                },
                dataType:"json"
            });


        });
        //单击新建文集
        function saveCollection() {


           document.getElementById('newCollectionName').style.display="";
            $("#newCollName").val("请输入文集名...");
           // console.log(1111111111);
        }
        //新建文集button
        function updateDisplay() {
            document.getElementById('newCollectionName').style.display="none";
            console.log(4444444);
        }
        //新建文集中    文集名重置
        function newCollNameReset() {
            $("#newCollName").val("");
        }
        //新建文集中  提交
        function submitCollectionName() {
            var userId=$("#userId").val();
            var collectionName=$("#newCollName").val();
            console.log(22222);

            $.ajax({
                type:"POST",
                url:"/save/collection",
                data:{userId:userId,collectionName:collectionName},
                success:function (data) {
                    console.log(55555555);
                    location.reload(true);

                },
                dataType:"json"
            });
        }



    </script>
</head>`
<body>
<h1>${nickName}</h1><br/>
<div>

    文章集：<a href="javascript:void(0)" onclick="saveCollection()">新建文集</a> <br/>
    <div id="newCollectionName" style="display:none">
            <input id="userId" type="hidden" value="${userId}">
            <input  type='text' onclick="newCollNameReset()"  id='newCollName'/>
            <input type='button' onclick="submitCollectionName()" value='提交' />
            <input id='newCollectionNameButton' onclick='updateDisplay()'  type='button' value='取消' />

    </div>
    <c:forEach items="${collectionList}" var="collection">
        <input type="button" name="collectionName"  value=${collection.name} id=${collection.id}  onclick="getCollection(${collection.id})"/>
       <%--<span style="display: none">--%>
        <%--<input type="button" value="修改">--%>
        <%--<input type="button" value="删除">--%>
        <%--</span>--%>
        <br/>

    </c:forEach>
</div>
<hr/>
<div id="collectionName">

</div>

<div>
    <script type="text/javascript">
        var ue=UE.getEditor("container");
    </script>
    <div >
        <form action="/write/saveArticle" method="post">
        标题：<input style="width: 90%" type="text" name="title" value="无标题文章" id="articleTitle"/>

        <input type="hidden" id="articleId" name="articleId"  />
        <script type="text/plain" id="container" name="content" >
            这里是初始化内容


        </script>


        <input type="submit" value="提交">
        </form>
    </div>

</div>
</body>
</html>
