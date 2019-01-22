window.onload=function () {

    $.ajax({
        type: "GET",
        url: "/index/userPage",
        data: {currentPage: 1},
        success: function (data) {
            indexShowUser(data);
        },
        dataType: "json"
    });
    $("a[name='1']").addClass("currentPage");
    $.ajax({
        type:"GET",
        url:"/index/articlePage",
        data:{currentPage:1},
        success:function (data) {
            readMoreArticle(data);

        } ,
        dataType:"json"
    });
};
function readMoreArticle(data) {
    console.log(data);
    for(var i=0;i<data.showList.length;i++){
        var count=
            "<div class='articleDiv' style='height: 150px;width: 100%;margin-top:30px'>" +
            "   <div class='articleShow' style='width: 500px;height:107px;float:left;'>" +
            "       <p style='width: 440px;margin-top:-2px;margin-bottom:3px;line-height:27px;font-weight:700;font-size: 22px;' ><a href='/article/With?id="+data.showList[i].id+"' target='_blank'><strong>"+data.showList[i].title+"</strong></a></p>" +
            "       <span style='margin:0px;width: 460px;font-size:13px;line-height:24px;color:#999'>"+data.showList[i].content+"</span> " +
            "       <p style='margin: 5px 0px;width: 460px;font-size:13px;line-height:24px;color:#999'>"+data.showList[i].userName+"  评论 "+data.showList[i].reviewNums+" 喜欢"+data.showList[i].likeNums+"</p>" +
            "   </div>" +
            "   <div >" +
            "       <img class='articleImg ' src="+data.showList[i].image+" style='width:150px;height:107px'/>" +
            "   </div>" +
            "</div><div style='clear:none'></div>";

        $("#articleShow").append(count);

    }
}
function jumpPage(obj) {
    var currentPage=$(obj).attr('name');

    $(".currentPage").removeClass("currentPage");
    $(obj).addClass("currentPage");
    $.ajax({
        type:"GET",
        url:"/index/userPage",
        data:{currentPage:currentPage},
        success:function (data) {
            indexShowUser(data);
        },
        dataType:"json"
    })
}
function beforePage() {
    var currentPage=$(".currentPage").attr("name")-1;

    if(currentPage!=0){
        $(".currentPage").removeClass("currentPage");

        $("a[name="+currentPage+''+"]").addClass("currentPage");
        $.ajax({
            type:"GET",
            url:"/index/userPage",
            data:{currentPage:currentPage},
            success:function (data) {
                indexShowUser(data);
            },
            dataType:"json"
        })
    }
}
// 首页显示推荐作者公共
function indexShowUser(data) {
    console.log(data);
    $("#pageUser").html("");
    for(var i=0;i<data.showList.length;i++){
        if(data.showList[i].sumNums>1000){
            var sumNums=(data.showList[i].sumNums/1000).toFixed(1);
            sumNums=sumNums+" k字";
            console.log(sumNums);
        }else{
            var sumNums=data.showList[i].sumNums;
            sumNums=sumNums+"字";
        }
        var userId=data.showList[i].id;
        var str="<input style='margin-left:100px;font-size: 19px' class='yesAndNoConcern' name="+userId+" type='button' value=+关注>";
        if(data.showList[i].status==1){
            str="<input style='margin-left:100px;font-size: 19px' class='yesAndNoConcern' name="+userId+" type='button' value=已关注>";
        }else if(data.showList[i].status==3){
            str="";
        }
        var count="<div style='margin-top:20px;width: 350px'>" +
            "           <div style='float:left;width: 50px;'><a  href='/user/myPage?userId="+userId+"'  target='_blank' > " +
                "           <img  class='smallImg' src="+data.showList[i].img+"/>  </a>" +
            "           </div> " +
            "           <div style='width:300px;'><a style='font-size: 17px' href='/user/myPage?userId="+userId+"'  target='_blank'>"+data.showList[i].nickName+" </a>"+str+"<br/>" +
                "      <span style='color: #646464'>     写了"+sumNums+"  "+data.showList[i].likeNums+" 喜欢</span>" +
            "           </div>" +
            "      </div>" +
            "        <div style='clear:none'></div>";
        $("#pageUser").append(count);
    }
}
function nextPage() {
    var currentPage=$(".currentPage").attr("name");
    currentPage=parseInt(currentPage)+1;

    var totalPageStr=$("a[name=changeAll]").attr('id');
    var totalPage=parseInt(totalPageStr)+1;



    if(currentPage!=totalPage) {
        $(".currentPage").removeClass("currentPage");

        $("a[name=" + currentPage + '' + "]").addClass("currentPage");
        $.ajax({
            type: "GET",
            url: "/index/userPage",
            data: {currentPage: currentPage},
            success: function (data) {
                indexShowUser(data);
            },
            dataType: "json"
        })
    }
}
function changePage(obj) {
    var totalCount=$(obj).attr('id');
    console.log(totalCount);
    var currentPage=parseInt(Math.random()*totalCount)+1;
    console.log(currentPage);

    $(".currentPage").removeClass("currentPage");

    $("a[name=" + currentPage + '' + "]").addClass("currentPage");
    $.ajax({
        type: "GET",
        url: "/index/userPage",
        data: {currentPage: currentPage},
        success: function (data) {
            indexShowUser(data);
        },
        dataType: "json"
    })
}
function showMoreArticle(obj) {
    var name=$(obj).attr('name');
    name=parseInt(name)+1;

    $.ajax({
        type:"GET",
        url:"/index/articlePage",
        data:{currentPage:name},
        success:function (data) {
            readMoreArticle(data);
            $(obj).attr('name',name);
            if(data.totalPage==name){
                document.getElementById('showMore').disabled=true;


            }

        } ,
        dataType:"json"
    });
}
$(".yesAndNoConcern").live('mouseenter',function () {
    var count=$(this).attr("value");
    console.log(count);
    if(count=="已关注"){
        $(this).attr("value","取消关注");
    }
});
$(".yesAndNoConcern").live('mouseleave',function () {
    var count=$(this).attr("value");
    if(count=="取消关注"){
        $(this).attr("value","已关注");
    }
});
$(".yesAndNoConcern ").live('click',function () {
    var userId=$(this).attr('name');
    console.log(userId);
    var node=$(this);
    $.ajax({
        type:"GET",
        url:"/user/concern",
        data:{"userId":userId},
        success:function (data) {

            if(data.data=="关注成功"){
                node.attr("value","已关注");

            }
            if(data.data=="删除成功"){
                node.attr("value","+关注");
            }
            if(data.msg=="请先登录"){
                location.href="/login";
            }

        },
        dataType:"json"
    })

});
function getAllUser() {
    window.open('/allUser');
}