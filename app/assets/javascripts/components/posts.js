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
    var post_id = ground_thumbnail.data('id');
    var user_id = ground_thumbnail.data('user_id');
    var data = {user_id: user_id, post_id: post_id};

    var classList = ground_thumbnail[0].className.split(' ');
    var method = (classList.indexOf(res+'-active') === -1) ? 'create' : 'destroy';
    // console.log(method);
    request(res, method, 0, data);

    ground_thumbnail.toggleClass(res+'-active');
    if ($(el).children()){
        $(el).children().toggleClass('zmdi-'+icon).toggleClass('zmdi-'+icon+'-outline').toggleClass('c-'+color);
    }
}