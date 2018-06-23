//模态框居中的控制
function centerModals(){
    $('.modal').each(function(i){   //遍历每一个模态框
        var $clone = $(this).clone().css('display', 'block').appendTo('body');    
        var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
        top = top > 0 ? top : 0;
        $clone.remove();
        $(this).find('.modal-content').css("margin-top", top-30);  //修正原先已经有的30个像素
    });
}
function hrefBack() {
    history.go(-1);
}
function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(document).ready(function(){
    $('.modal').on('show.bs.modal', centerModals);      //当模态框出现的时候
    $(window).on('resize', centerModals);

    $.get('/house/user_lorders/', function (data) {
        var order_tmp = template('lorder_list_tmp', {'orders': data.orders});
        $('.orders-list').html(order_tmp);
        $(".order-accept").on("click", function(){
        var orderId = $(this).parents("li").attr("order-id");
        $(".modal-accept").attr("order-id", orderId);
        $('.modal-accept').on('click', function () {
            $.post('/house/user_lorders/', {'house_id': orderId, 'token': 'accept'}, function (data) {
                if (data == 200){
                    location.href = '/house/lorders/'
                }
            });
        })
    });
    $(".order-reject").on("click", function(){
        var orderId = $(this).parents("li").attr("order-id");
        $(".modal-reject").attr("order-id", orderId);
        $('.modal-reject').on('click', function () {
            var comment = $('#reject-reason').val();
            alert($('#reject-reason').val());
            $.post('/house/user_lorders/', {'comment': comment, 'house_id': orderId}, function (data) {
                location.href = '/house/lorders/'
            })
        })
    });

    })
});