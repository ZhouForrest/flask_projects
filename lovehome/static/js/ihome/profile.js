function showSuccessMsg() {
    $('.popup_con').fadeIn('fast', function() {
        setTimeout(function(){
            $('.popup_con').fadeOut('fast',function(){}); 
        },1000) 
    });
}

function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(document).ready(function () {
    $("#user-name").focus(function(){
        $(".error-msg").hide();
    });
    $('#form-avatar').submit(function(){
    $(this).ajaxSubmit({
        url:'/app/profile/',
        type:'PATCH',
        dataType:'json',
        success:function (data) {
            if(data.code == 200){
                $('#user-avatar').attr('src',  data.avatar);
            }
        }
    });
    return false;
    });
    $('#form-name').submit(function () {
        var name = $('#user-name').val();
        $.ajax({
            url:'/app/proname/',
            dataType:'json',
            type:'PATCH',
            data:{'name': name},
            success:function (data) {
                if (data.code == 4001){
                    $('.error-msg span').html(data.msg);
                    $('.error-msg').show()
                };
                if (data == 200){
                    $('#user-name').val('').focus();
                }
            }
        });
        return false;
    })
});
