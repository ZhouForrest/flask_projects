function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(document).ready(function(){
    // $('.popup_con').fadeIn('fast');
    // $('.popup_con').fadeOut('fast');
    $.get('/house/area_msg/', function (data) {
        for (var i =0; i < data.length; i++){
            $('#area-id').append($('<option>').text(data[i].name).val(data[i].id))
        }
    });
    $.get('/house/facility_msg/', function (data) {
        for (var i = 0; i < data.length; i++){
            $('.house-facility-list').append($('<li>').append($('<div>').attr('class', 'checkbox')).append($('<label>').append($('<input>').attr({'type': 'checkbox', 'name': 'facility', 'value': data[i].id})).append($('<span>').text(data[i].name))))
        }
    });
    $('#form-house-info').submit(function () {
        $.post('/house/newhouse/', $(this).serialize(), function(data){
            if (data.code == 200){
                $('#form-house-info').hide();
                $('#from-house-img').show();
                $('#house-id').val(data.house_id)
            }
        });
        return false;
    });
    $('#from-house-img').submit(function () {
        $(this).ajaxSubmit({
            url:'/house/newhouse/',
            type:'PATCH',
            dataType:'json',
            success:function (data) {
                if (data.code == 200){
                    $('#my_house_img').attr('src', data.house_img).css({'height':50, 'width':50});
                }
            }
        });
        return false;
    })

});

