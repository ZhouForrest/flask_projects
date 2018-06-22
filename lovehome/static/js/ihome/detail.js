function hrefBack() {
    history.go(-1);
}

function decodeQuery(){
    var search = decodeURI(document.location.search);
    return search.replace(/(^\?)/, '').split('&').reduce(function(result, item){
        values = item.split('=');
        result[values[0]] = values[1];
        return result;
    }, {});
}

$(document).ready(function(){
    var id = location.search.split('=')[1];
    $.get('/house/house_detail/'+id+'/', function (data) {
        var detail_html = template('house_detail_template', {'detail':data});
        $('.swiper-container').html(detail_html);
        var house_msg_html = template('house_detail_msg', {'house_msg': data});
        $('.detail-header').html(house_msg_html);
        var mySwiper = new Swiper ('.swiper-container', {
        loop: true,
        autoplay: 2000,
        autoplayDisableOnInteraction: false,
        pagination: '.swiper-pagination',
        paginationType: 'fraction'
    });
    $(".book-house").show();
    });

});