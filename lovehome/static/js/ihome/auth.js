function showSuccessMsg() {
    $('.popup_con').fadeIn('fast', function() {
        setTimeout(function(){
            $('.popup_con').fadeOut('fast',function(){}); 
        },1000) 
    });
}
$(document).ready(function () {
    // $.get('/app/auth/', function (user) {
    //     alert(user)
    //     if (code == 200){
    //         if (!user.ID_NAME || !user.ID_CARD){
    //             $('#btn-success').show()
    //         }
    //     }
    // });
    $('#form-auth').submit(function () {
        var id_card = $('#id-card').val();
        var id_name = $('#real-name').val();
        alert(id_name);
        alert(id_card);
        $.ajax({
            url:'/app/auth/',
            type:'POST',
            data:{'id_name': id_name, 'id_card': id_card},
            success:function (data) {
                if (data == 200){
                    $('.btn-success').hide();
                }
                if (data.code == 5001){
                    $('.error-msg span').html(data.msg)
                }
                if (data.code == 5002){
                    $('.error-msg span').text(data,msg)
                }
            }
        });
        return false;
    })
})

