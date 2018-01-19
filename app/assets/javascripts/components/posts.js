$(document).ready(function () {
    /*
     *      Post action : bookmark, like, follow
     */
    var posts_wrapper   = $('.posts-wrapper:not(.preview)');
    var bookmark_btn    = posts_wrapper.find('.bookmark-btn');
    var like_btn        = posts_wrapper.find('.like-btn');
    var follow_btn      = posts_wrapper.find('.follow-btn');

    bookmark_btn.click(function (e) {
        toggle_action(this, 'bookmark', 'star', 'amber');
        e.stopPropagation();
        return false;
    });

    like_btn.click(function (e) {
        toggle_action(this, 'like', 'favorite', 'red');
        e.stopPropagation();
        return false;
    });

    follow_btn.click(function (e) {
        toggle_action(this, 'subscribe', 0, 0);
        e.stopPropagation();
        return false;
    });


    /*
     *      댓글 펼쳐 보기
     */
    $('#comment_omit_btn').click(function (e) {
        var scroll = $(document).scrollTop();
        $(this).toggle();
        $('#disqus_thread').slideToggle();
        e.stopPropagation();
        document.body.scrollTop = scroll;
        return false;
    });


    /*
     *      _form active preview
     */
    var form    = $('.post-container').find('form');
    var runtime = $('#post_runtime');
    var title   = $('#post_title');

    var preview_wrapper = $('.posts-wrapper.preview');
    var runtime_preview = preview_wrapper.find('.runtime-badge');
    var title_preview   = preview_wrapper.find('.caption').find('h4');

    runtime.keyup(function (e) {
        var value = $(this).val();
        runtime_preview.text(value);
    });

    title.keyup(function (e) {
        var value = $(this).val();
        title_preview.text(value);
    });
});


function toggle_action(el, res, icon, color) {
    var ground_thumbnail = $(el).closest('.thumbnail-post');
    var data = res === 'subscribe' ? subscribe_datas(el) : action_datas(el);

    var classList = ground_thumbnail[0].className.split(' ');
    var method = (classList.indexOf(res+'-active') === -1) ? 'create' : 'destroy';
    // console.log(method);
    request(res, method, 0, data);

    color               = color === 0 ? '' : 'c-'+color;
    var icon_active     = icon === 0 ? '' : 'zmdi-'+icon;
    var icon_deactive   = icon === 0 ? '' : 'zmdi-'+icon+'-outline';
    ground_thumbnail.toggleClass(res+'-active');
    if ($(el).children()){
        $(el).children().toggleClass(icon_active).toggleClass(icon_deactive).toggleClass(color);
    }
}

function action_datas(el) {
    var ground_thumbnail = $(el).closest('.thumbnail-post');
    var post_id = ground_thumbnail.data('id');
    var user_id = ground_thumbnail.data('user_id');
    return {user_id: user_id, post_id: post_id}
}

function subscribe_datas(el) {
    var ground_thumbnail = $(el).closest('.thumbnail-post');
    var user_id = ground_thumbnail.data('user_id');
    var author_id = ground_thumbnail.data('author_id');
    return {user_id: user_id, target_id: author_id}
}