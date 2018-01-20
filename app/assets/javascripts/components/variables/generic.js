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


function parse_sec(secs, format) {
    var hr  = Math.floor(secs / 3600);
    var min = Math.floor((secs - (hr * 3600))/60);
    var sec = Math.floor(secs - (hr * 3600) -  (min * 60));

    if (hr < 10)  { hr  = "0" + hr; }
    if (min < 10) { min = "0" + min; }
    if (sec < 10) { sec = "0" + sec; }
    if (!hr)      { hr  = "00"; }

    if (format !== null) {
        var formatted_time = format.replace('hh', hr);
        formatted_time = formatted_time.replace('h', hr*1+""); // check for single hour formatting
        formatted_time = formatted_time.replace('mm', min);
        formatted_time = formatted_time.replace('m', min*1+""); // check for single minute formatting
        formatted_time = formatted_time.replace('ss', sec);
        formatted_time = formatted_time.replace('s', sec*1+""); // check for single second formatting
        return formatted_time;
    } else {
        return parseInt(hr) === 0 ? [min,sec].join(':') : [hr,min,sec].join(':');
    }
}