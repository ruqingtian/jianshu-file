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
                node.removeClass("yesOrNoConcernStyle");

            }
            if(data.data=="删除成功"){
                node.addClass("yesOrNoConcernStyle");
                node.attr("value","+关注");
            }
            if(data.msg=="请先登录"){
                location.href="/login";
            }

        },
        dataType:"json"
    })

})
