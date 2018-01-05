
$(document).ready(function () {
    var opacity_scroll_weight = 500;
    var liftup_scroll_weight = 3;
    var liftup, opacity, currentScroll;

    $(window).scroll(function(){
        currentScroll = $(window).scrollTop();
        opacity = currentScroll / opacity_scroll_weight;
        liftup  = currentScroll / liftup_scroll_weight;

        if (opacity >= 0){
            $('.carousel-caption').css('opacity', opacity);
            $('.carousel-inner').css('top', 60 - liftup);
        }
    });
});
