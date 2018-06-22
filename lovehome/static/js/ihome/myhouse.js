$(document).ready(function(){
    $.get('/user/status/', function (data) {
        if (data.user.ID_CARD){
            $(".auth-warn").hide();
            $('#houses-list').show();
        }else{
            $(".auth-warn").show();
            $('#houses-list').hide();
        }
    });
    $.get('/house/house_msg/', function (data) {
        for (var i = 0; i < data.length; i++){
            $('#houses-list').append($('<li>').append($('<a>').attr('href','/house/detail/?house_id='+data[i].id).append($('<div>').attr('class', 'house-title').append($('<h3>').text('房屋ID:'+data[i].id+'--'+data[i].title))).append($('<div>').attr('class', 'house-content').append($('<img>').attr('src', data[i].image).css('height',80)).append('<div>').attr('class', 'house-text').append($('<ul>').append($('<li>').text('位于:'+ data[i].area)).append($('<li>').text('价格：￥'+data[i].price+'/晚')).append($('<li>').text('发布时间:'+data[i].create_time))))))
        }
    })
});
