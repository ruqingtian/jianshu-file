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
    <script type="text/javascript" src="/js/commonjs.js"></script>

    <link rel="stylesheet" href="/css/write.css">

    <title>写文章</title>
    <style type="text/css">

    </style>
    <script type="text/javascript">
        $(function () {
            $(".articleCollection")[0].click();

            $.ajax({
                type:"GET",
                url:"/user/isUserLogin",
                success:function (data) {
                    if(data.userName==null){
                        location.href="/login";
                    }
                },
                dataType:"json"
            })
        });
        // 获取文章标题
        function getCollection(obj) {

            $(".chooseCollection").removeClass("chooseCollection");
            $(obj).addClass("chooseCollection");
            var id=$(obj).attr("name");



            var spanId=id;

            $("#collectionName").attr('name',id);

            $(".spanShow").removeClass("spanShow");


            $("#"+spanId+"").addClass("spanShow");

            $.ajax({
                type:"GET",
                url:"/write/article",
                data:{id:id},
                success:function (data) {

                    articleForeach(data);


                },
                dataType:"json"
            });
        }
        $('.articleCollection').live('mouseenter',function () {
            $(this).addClass("chooseCollectionMouse");
        });
        $('.articleCollection').live('mouseleave',function () {
            $(this).removeClass("chooseCollectionMouse");
        });

        //获取文章的内容
        $('.articleDiv').live('click',function () {
            $(".chooseArticle").removeClass("chooseArticle");
            $(this).addClass("chooseArticle");
            var aId = this.id;
            articlewith(aId)
        });
        $('.articleDiv').live('mouseenter',function () {
            $(this).addClass("chooseMouse");
        });
        $('.articleDiv').live('mouseleave',function () {
            $(this).removeClass("chooseMouse");
        });
        function articlewith(aId) {

            $(".deleteArticleShow").removeClass("deleteArticleShow");
            $("#deleteArticle"+aId+"").addClass("deleteArticleShow");

            $.ajax({
                type: "POST",
                url: "/write/content",
                data: {id: aId},
                success: function (data) {

                    var ue = UE.getEditor('container');
                    ue.setContent(data.content);
                    $("#articleTitle").val(data.title);
                    $("#articleId").attr("value", data.id);
                    $("#titleImg").attr("src", data.image);
                    $("#articleStatus").attr("value",data.status);

                },
                dataType: "json"
            });
        }
        //单击新建文集
        function saveCollection() {


            document.getElementById('newCollectionName').style.display="";


        }
        //新建文集button
        function updateDisplay() {
            document.getElementById('newCollectionName').style.display="none";

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

            $(obj).next().next().addClass(" textNewName");
            //自动获取焦点
            $(".textNewName").focus();


        }

        //失去焦点上传新name
        function updateName(obj) {

            var collectionName=$(obj).val();

            if(collectionName.trim()!="") {
                console.log(collectionName);
                var id = $(obj).parent().attr('id');


                $.ajax({
                    type: "POST",
                    url: "/update/collectionName",
                    data: {articleId: id, newName: collectionName},
                    success: function (data) {
                        location.reload(true);
                    },
                    dataType: "json"
                });

            }
            $(".textNewName").removeClass("textNewName");


        }
        //删除文集的单击事件
        function deleteCollection(obj) {
            var id=$(obj).parent().attr("id");

            if(confirm("确认是否删除此文集的所有文章")) {
                $.ajax({
                    type: "GET",
                    url: "/delete/collection",
                    data: {id: id},
                    success: function (data) {

                        location.reload(true);
                    },
                    dataType: "json"
                })
            }
        }
        //提交文章
        function submitArticle() {
            var title=$("#articleTitle").val();
            var id=$("#articleId").attr("value");
            var status=1;
            if(id==-100){
                alert("请选择你要修改的文章");
            }
            var ue = UE.getEditor('container');
            var content=ue.getContent();
            var formData=new FormData();
            formData.append('titleImg',$("#fileImg")[0].files[0]);
            formData.append('articleId',id);
            formData.append('title',title);
            formData.append('content',content);
            formData.append('status',status);

            $.ajax({
                type:"POST",
                url:"/write/saveArticle",
                data:formData,
                async: false,
                contentType: false,
                processData: false,
                success:function (data) {
                    var str=data.title;
                    $("#"+id+"").val(str);
                    if(str.length>4){
                        str=str.substring(0,4)+"...";
                    }
                    var node=$(".chooseArticle a").html("<Strong>"+str+"</strong>");
                    $(".chooseArticle span").html("（已发布）");
                    $("#"+id+"").val(data.title);

                    alert("发布成功");

                },
                dataType:"json"

            })
        }
        //新建文章
        function saveArticle(obj) {

            var userId=$(obj).attr('id');

            userId=parseInt(userId.substring(6,userId.length));

            var collectionId=$("#collectionName").attr("name");


            $.ajax({
                type:"POST",
                url:"/save/article",
                data:{userId:userId,collectionId:collectionId},

                success:function (data) {
                    $.ajax({
                        async:false,
                        type:"GET",
                        url:"/write/article",
                        data:{id:collectionId},
                        dataType:"json",
                        success:function (data) {

                            articleForeach(data);
                        }

                    })
                },
                dataType:"json"

            })
        }

        //删除文章的单击事件
        $(".deleteArticle").live('click',function () {
            var articleId=$(this).attr("id");
            articleId=articleId.substring(13);

            var collectionId=$(this).attr('name');

            if(confirm("确认删除文章")) {
                $.ajax({
                    type: "GET",
                    url: "/delete/article",
                    data: {id: articleId},
                    success: function (data) {

                        $.ajax({
                            async: false,
                            type: "GET",
                            url: "/write/article",
                            data: {id: collectionId},
                            dataType: "json",
                            success: function (data) {

                                articleForeach(data);
                            }

                        })
                    },
                    dataType: "json"
                })
            }
        });

        //文章显示
        function articleForeach(data) {
            $("#collectionName").html("");
            document.getElementById('newSaveArticle').style.display="";
            for(var i=0;i<data.length;i++){

                var sta="未发布";
                if(data[i].status===1){
                    sta="已发布";
                }
                if(data[i].title.length>5){
                    var title=data[i].title.substring(0,5)+"...";
                }else{
                    var title=data[i].title;
                }
                var   content="<div id='"+data[i].id+"' class='articleDiv' style='border: 1px solid #646464;padding-left: 10%;height: 60px'>" +
                    "<a style='color: black;font-size: 20px;line-height: 60px' href='javascript:void(0)'  class='articleName'  ><strong>"+title+"</strong></a>" +
                    "<span style='font-size: 20px'>("+sta+")</span>" +
                    "<input class='deleteArticle' id='deleteArticle"+data[i].id+"' name="+data[i].collectionId+" style='display:none;' type='button' value='删除'/>" +
                    "</div>";



                $("#collectionName").append(content);
            }

        }
        //图片回显
        function imgChange(obj) {
            var file=document.getElementById("fileImg");
            var imgUrl=window.URL.createObjectURL(file.files[0]);

            $("#titleImg").attr("src",imgUrl);
        }


//输入文章弹起保存
        var ue=UE.getEditor("container");
        ue.addListener("keyup",function () {



            setTimeout(function () {

                document.getElementById("onKeyUpsaveArticle").innerText="保存中...";
                var title=$("#articleTitle").val();
                var id=$("#articleId").attr("value");
                var status=$("#articleStatus").attr("value");
                if(id==-100){
                    alert("请选择你要修改的文章");
                }
                var ue = UE.getEditor('container');
                var content=ue.getContent();
                var formData=new FormData();
                formData.append('titleImg',$("#fileImg")[0].files[0]);
                formData.append('articleId',id);
                formData.append('title',title);
                formData.append('content',content);
                formData.append('status',status);

                $.ajax({
                    type:"POST",
                    url:"/write/saveArticle",
                    data:formData,
                    async: false,
                    contentType: false,
                    processData: false,
                    success:function (data) {

                        var str=data.title;
                        $("#"+id+"").val(str);
                        if(str.length>4){
                            str=str.substring(0,4)+"...";
                        }
                       var node=$(".chooseArticle a").html("<Strong>"+str+"</strong>");

                        document.getElementById("onKeyUpsaveArticle").innerText="已保存";


                    },
                    dataType:"json"

                })


            },2000)
        })


    </script>

</head>
<body>

<div style="overflow-y: auto;width: 200px;float: left;height: 100%;background-color:#404040 ">
    <div style="width: 80%;height: 60px;border: 1px solid #ec7259;border-radius: 40px;text-align: center;margin-left: 10%;margin-top: 50px">
        <a href="/" style="color: #ec7259;border-radius: 15px;font-size: 15px;line-height: 60px">返回首页</a>
    </div>
    <div style="margin-left: 10%;margin-top: 40px;margin-bottom: 20px">
        <a style="color:white;font-size: 25px" href="javascript:void(0)" onclick="saveCollection()"><strong>+新建文集</strong></a>
    </div>
    <div id="newCollectionName" style="display:none">
        <div style="width: 80%;margin-left: 10%;margin-top: -10px;">
            <input id="userId" type="hidden" value="${user.id}">
            <input style="height: 40px;background-color: #646464;color: #cccccc"  type='text'  placeholder="请输入文集名"  id='newCollName'/>
        </div>
        <div style="margin-left: 10%;width: 60%">
            <div style="border: 1px solid #42c02e;border-radius: 40px;width: 60px;height: 30px;text-align: center;float:left;margin-top: 5px">
                <a  href="javascript:void(0)" style="color: #42c02e;line-height: 30px"  onclick="submitCollectionName()" >提交</a>
            </div>
            <div style="float: right;margin-top: 5px">
                <a  href="javascript:void(0)" style="color: white;line-height: 30px" id='newCollectionNameButton' onclick='updateDisplay()'   >取消</a>
            </div>
            <div style="clear: both"></div>
        </div>

    </div>
    <c:forEach items="${collectionList}" var="collection">
        <div  class="articleCollection" style="width: 100%;height: auto;" name=${collection.id}   onclick="getCollection(this)"   >
            <div style="margin-left: 10%" onblur="displayUpdateInput(this)"  >
                <a href="javascript:void(0)" style="color: white;line-height: 50px;font-size: 16px"  >${collection.name}</a>
           <span  id=${collection.id} style="display:none">
                <input type="button" onclick="updateCollectionName(this)" value="修改"/>
               <input type="button" onclick="deleteCollection(this)" value="删除"/>

               <input  type="text" class="textOldName "   onblur="updateName(this)"/>

            </span>
            </div>
        </div>

    </c:forEach>
</div>
<div style="overflow-y: auto;width: 300px;float: left;height: 100%;">
    <div style="padding-left: 10%">
        <p id="newSaveArticle"  style="display:none"><a style="color: black;font-size: 25px" id="UserId+${user.id}"   href="javascript:void(0)" onclick="saveArticle(this)">+新建文章</a></p>
    </div>
    <div style=""  id="collectionName"></div>
</div>
<div style="float: right;height: 100%;width: 800px">

    <div  style="overflow-y: auto;height: 100%"  >

       <div style="padding-left: 10%">
           <input style="width: 100%;border: none;font-size: 30px;color: #646464" type="text" name="title" value="无标题文章" id="articleTitle"/>
       </div>

       <div style="border: 3px solid #646464">
           <div style="float: left">封面图片：<img src="/" id="titleImg" width="130px" height="90px"></div>
           <div style="float: left">
               <a style="margin-top: 60px" class="file">添加封面<input  class="file" id="fileImg" accept="image/*" type="file" onchange="imgChange(this)" /></a>
           </div>
           <div style="float: right;padding-top: 10px">
               <div onclick="submitArticle()" style="padding-top: 7px;margin-right:5px;padding-left:40px;height: 40px;width: 100px;border: 1px solid #42c02e;border-radius: 40px;color: #42c02e">
                   <a href="javascript:void(0)" style="font-size: 25px;color: #42c02e;" type="button"  >发布</a></div>
               <div style="padding-left: 35px"><span id="onKeyUpsaveArticle" style="color: #646464;font-size: 20px">已保存</span></div>
        <input type="hidden" id="articleId" name="articleId" value="-100"   />
               <input type="hidden" id="articleStatus"  value="0"   />
           </div>
           <div style="clear:both"></div>
       </div>
        <script  class="fuwenben" type="text/plain" id="container" name="content" >
            这里是初始化内容
        </script>


    </div>

</div>
</body>
</html>
