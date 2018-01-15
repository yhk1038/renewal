$(document).ready(function () {
    exec_slick();

    // var screen_width = window.screen.width;
    // $(window).resize(function () {
    //     var screen_width_before = screen_width;
    //     screen_width = window.screen.width;
    //     console.log('resized!', [screen_width_before, screen_width]);
    //
    //     if (responsive_changed(screen_width_before, screen_width)){
    //         exec_slick();
    //     }
    // });

    $.each($('.posts-wrapper:not(.wide) .thumbnail'), function (i, tbn) {
        var thumbnail = $(tbn);
        var h = thumbnail.find('img').height();
        var top = -1.0 * h + 120;
        // console.log(top);
        thumbnail.find('.caption').css('top', top);
    });
});


function exec_slick() {

    // var responsive = responsive_slick();
    // var toShow = responsive[0], toScroll = responsive[1];
    // console.log('exec!', [toShow, toScroll]);

    $('.slick-items').slick({
        autoplay : false,

        speed : 300,

        infinite: false,

        arrows: true,

        slidesToShow:   6,

        slidesToScroll: 3,

        fade: false,

        responsive: [
            {
                breakpoint: 992,
                settings: {
                    slidesToShow: 4,
                    slidesToScroll: 2
                }
            },
            {
                breakpoint: 767,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 2
                }
            }
            // You can unslick at a given breakpoint now by adding:
            // settings: "unslick"
            // instead of a settings object
        ]
    });
}

function responsive_slick() {
    return (window.screen.width > 767) ? [6, 3] : [2, 2]
}

function responsive_changed(before, now) {
    return (
        (before !== now) && ((before >= 768 && now <= 767) || (before <= 767 && now >= 768))
    )
}
