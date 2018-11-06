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
    <style type="text/css">
        .spanShow{
            display:inline !important;
        }
        .textNewName{
            display:inline !important;
        }
    </style>
    <script type="text/javascript">

        // $(function () {
        //     alert("123");
        // });
        // 获取文章标题
        function getCollection(obj) {

           var id=obj.name;

           var spanId=id;

            $("#collectionName").html("");

            $(".spanShow").removeClass("spanShow");
            $(".textNewName").removeClass("textNewName");

            $("#"+spanId+"").addClass("spanShow");

            $.ajax({
                type:"GET",
                url:"/write/article",
                data:{id:id},
                success:function (data) {


                    var str="文章:<a href=''+>新建文章</a>";
                    $("#collectionName").html(str);
                    for(var i=0;i<data.length;i++){

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


        //获取文章的内容
        $('.articleName').live('click',function () {

          var aId=this.id;

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

        }
        //新建文集button
        function updateDisplay() {
            document.getElementById('newCollectionName').style.display="none";

        }
        //新建文集中    文集名重置
        function newCollNameReset() {
            $("#newCollName").val("");
        }
        //新建文集中  提交
        function submitCollectionName() {
            var userId=$("#userId").val();
            var collectionName=$("#newCollName").val();


            $.ajax({
                type:"POST",
                url:"/save/collection",
                data:{userId:userId,collectionName:collectionName},
                success:function (data) {

                    location.reload(true);

                },
                dataType:"json"
            });
        }
         //修改collectionName
        function updateCollectionName(obj) {
            var id=$(obj).parent().attr('id');

            $(obj).next().addClass("textNewName");

        }

        //失去焦点上传新name
        function updateName(obj) {
            var collectionName=$(obj).val();

            var id=$(obj).parent().attr('id');


            $.ajax({
                type:"POST",
                url:"/update/collectionName",
                data:{articleId:id,newName:collectionName},
                success:function (data) {
                    location.reload(true);
                },
                dataType:"json"
            })

        }
        //删除文集的单击事件
        function deleteCollection(obj) {
            var id=$(obj).parent().attr("id");
            console.log(id);
            $.ajax({
                type:"GET",
                url:"/delete/collection",
                data:{id:id},
                success:function (data) {
                    console.log("delete");
                    location.reload(true);
                },
                dataType:"json"
            })
        }
        //提交文章
        function submitArticle() {
            var title=$("#articleTitle").val();
            var id=$("#articleId").val();
            var ue = UE.getEditor('container');
            var content=ue.getContent();
            console.log(title);
            console.log(id);
            console.log(content);
            $.ajax({
                type:"POST",
                url:"/write/saveArticle",
                data:{articleId:id,title:title,content:content},
                success:function (data) {
                    console.log("成功返回");
                    alert("发布成功");
                },
                dataType:"json"

            })
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
        <input type="button" name=${collection.id} value=${collection.name}   onclick="getCollection(this)"/>
       <span  id=${collection.id} style="display:none">
        <input type="button" onclick="updateCollectionName(this)" value="修改"/>
           <input type="text" style="display:none" onblur="updateName(this)"/>
        <input type="button" onclick="deleteCollection(this)" value="删除">
        </span>
        <br/>

    </c:forEach>
</div>
<div id="collectionName">

</div>

<div>
    <script type="text/javascript">
        var ue=UE.getEditor("container");
    </script>
    <div >

        标题：<input style="width: 90%" type="text" name="title" value="无标题文章" id="articleTitle"/>

        <input type="hidden" id="articleId" name="articleId"  />
        <script type="text/plain" id="container" name="content" >
            这里是初始化内容
        </script>
        <input type="button" onclick="submitArticle()" value="提交">

    </div>

</div>
</body>
</html>
