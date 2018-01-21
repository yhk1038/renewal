
$(document).ready(function () {

    $('.toggleTgModal').click(function () {
        var tg_id = $(this).data('tg_id');
        var info = JSON.parse($('.tg_info[data-tg_id="'+tg_id+'"]').text());
        var themes_info = JSON.parse($('.tg_themes_info[data-tg_id="'+tg_id+'"]').text());

        $('#tgModalLabel').text(info.title);

        var themes_dom = '';
        $.each(themes_info, function (i, theme_info) {
            themes_dom += '<p onclick="window.location = ">'+theme_info.title+'</p>';
        });
        $('#tgModalBody').html(themes_dom);
    });


    /*
     *      _form active preview
     */
    var form    = $('.theme-container').find('form');
    var bg_img  = form.find('#theme_background_img');
    var title   = form.find('#theme_title');
    var theme_group = form.find('#theme_theme_group_id');

    bg_img.keyup(function (e) {
        var value = $(this).val();
        var preview_dom = $('.themes-wrapper.preview').find('iframe').contents();
        preview_dom.find('.carousel .item.active').find('img')[0].src = value;
        preview_dom.find('.imgbody')[0].style.backgroundImage = 'url('+value+')';
    });

    title.keyup(function (e) {
        var value = $(this).val();
        var preview_dom = $('.themes-wrapper.preview').find('iframe').contents();
        var title_preview = preview_dom.find('.carousel-info-title').find('a');
        title_preview.text(value);
    });

    $()
});


function allow_disabled_data() {
    var form    = $('.container').find('form');
    var disables = form.find('.form-disabled');
    if (confirm('저장하시겠습니까?')){
        disables.removeAttr('disabled');
        return true;
    } else {
        return false;
    }
}
