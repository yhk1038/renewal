$(document).ready(function () {
    $('.bookmark-btn').click(function (e) {
        var ground_thumbnail = $(this).closest('.thumbnail');
        ground_thumbnail.toggleClass('bookmark-active');
        e.stopPropagation();
    });

    $.each($('.posts-wrapper:not(.wide) .thumbnail'), function (i, tbn) {
        var thumbnail = $(tbn);
        var h = thumbnail.find('img').height();
        var top = -1.0 * h + 120;
        console.log(top);
        thumbnail.find('.caption').css('top', top);
    });
});