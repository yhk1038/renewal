
$('.toggleTgModal').click(function () {
    var tg_id = $(this).data('tg_id');
    var info = JSON.parse($('.tg_info[data-tg_id="'+tg_id+'"]').text());
    var themes_info = JSON.parse($('.tg_themes_info[data-tg_id="'+tg_id+'"]').text());

    $('#tgModalLabel').text(info.title);

    var themes_dom = '';
    $.each(themes_info, function (i, theme_info) {
        themes_dom += '<p onclick="window.location = ">'+theme_info.title+'</p>';
    });
    $('#tgModalBody').html(themes_dom)
});