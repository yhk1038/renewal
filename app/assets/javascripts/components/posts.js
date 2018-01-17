$(document).ready(function () {
    $('.bookmark-btn').click(function (e) {
        toggle_action(this, 'bookmark', 'star', 'amber');
        e.stopPropagation();
        return false;
    });

    $('.like-btn').click(function (e) {
        toggle_action(this, 'like', 'favorite', 'red');
        e.stopPropagation();
        return false;
    });

    $('.follow-btn').click(function (e) {
        toggle_action(this, 'subscribe', 0, 0);
        e.stopPropagation();
        return false;
    });


    $('#comment_omit_btn').click(function (e) {
        var scroll = $(document).scrollTop();
        $(this).toggle();
        $('#disqus_thread').slideToggle();
        e.stopPropagation();
        document.body.scrollTop = scroll;
        return false;
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