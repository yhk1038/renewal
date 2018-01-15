$(document).ready(function () {
    bind_reset()
});


// Rebind bundle

function bind_reset() {

    // bind list ..

    bind_href_click_redirect() // .href 클릭하면 이동
}

function bind_href_click_redirect() {
    $('.href').unbind().click(function () {
        if ($(this).data('window_open')){
            window.open($(this).data('href'));
        } else {
            window.location = $(this).data('href');
        }
    });
}