$(document).scroll(function(e){
    if ($(window).scrollTop() >= 400){
        $('#header').removeClass('transparent');
    } else {
        $('#header').addClass('transparent');
    }
});