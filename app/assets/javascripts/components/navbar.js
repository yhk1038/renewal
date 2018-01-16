$(document).scroll(function(e){
    if (_layout_.navbar_transparent){
        if ($(window).scrollTop() >= 400){
            $('#header').removeClass('transparent');
        } else {
            $('#header').addClass('transparent');
        }
    }
});




var lastScrollTop = 0;
$(window).scroll(function(e){
    var st = $(this).scrollTop();
    if (st > lastScrollTop){
        downScroll();
    } else {
        upScroll();
    }
    lastScrollTop = st;
});


function downScroll() {
    $('#tag-line-header').addClass('show')
}

function upScroll() {
    $('#tag-line-header').removeClass('show')
}
