$(document).scroll(function(e){
    if (_layout_.navbar_transparent){
        if ($(window).scrollTop() >= 400){
            $('#header').removeClass('transparent');
        } else {
            $('#header').addClass('transparent');
        }
    }
});