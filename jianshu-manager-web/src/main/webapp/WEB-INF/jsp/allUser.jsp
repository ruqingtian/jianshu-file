<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/14
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/js/concern.js"></script>
    <link rel="stylesheet" href="/css/page.css" type="text/css"/>
    <title>推荐作者-简书</title>

    <style type="text/css">



    </style>
    <script type="text/javascript">
        $(function () {
            var currentPage=1;
            getUser(currentPage);
        });
        function getMoreUser(obj) {
           var currentPage=parseInt($(obj).attr('name'));
           var max=$("#getMoreUserDiv").attr('name');
           if(currentPage!=max){
               getUser(currentPage+1);
               $(obj).attr('name',currentPage+1);
           }
        }
        function getUser(currentPage) {
            $.ajax({
                type:"GET",
                url:"/user/getAll",
                data:{"currentPage":currentPage},
                success:function (data) {
                    console.log(data);

                    for(var i=0;i<data.showList.length;i++){
                        $("#getMoreUserDiv").attr("name",data.totalPage);
                        if(data.showList[i].concernStatus==0){
                            var str="+关注";
                        }else{
                            var str="已关注";
                        }
                        if(data.showList[i].desc!=null){
                            var desc= data.showList[i].desc
                        }else{
                            var desc="该用户暂时没有设置个性签名";
                        }
                        var content="<div><a href='/user/myPage?userId="+data.showList[i].id+"' ><img class='smallImg' src="+data.showList[i].img+"/> "+data.showList[i].nickName+"</a><input class='yesAndNoConcern' name="+data.showList[i].id+" type='button' value="+str+">" +
                            " <p>"+desc+"</p> " +
                            "最近更新 <br/>" +
                            "</div>";
                        $("#content").append(content);
                        for(var j=0;j<data.showList[i].articleTitle.length;j++){
                            var title="<p><a href='/article/With?id="+data.showList[i].articleTitle[j].id+"'>"+data.showList[i].articleTitle[j].title+"</a></p>";
                            $("#content").append(title);
                        }
                        if(data.showList[i].articleTitle.length==0){
                            $("#content").append("该用户还没有文章");
                        }



                    }
                },
                dataType:"json"
            })
        }
    </script>
</head>
<body>
<jsp:include page="top.jsp"/>
<div class="content all">
    推荐作者
</div>
<div class="content all" id="content">

</div>
<div class="all" id="getMoreUserDiv">
    <input style="font-size: 30px" type="button" name=1 id="getMoreUser" onclick="getMoreUser(this)" value="加载更多"/>
</div>
</body>
</html>
