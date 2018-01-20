$(document).ready(function (e) {
    var crawlBtn = $('.crawlBtn');
    crawlBtn.click(function () {
        crawler_request($('#post_crawling_target').val());
        $('#post_crawling_target_after').hide();
    });
});

function crawler_request(url) {
    var url = normalize_url(url);
    var provider = url.split('/')[2].split('.')[1];
    var target_url = url;
    $.ajax({
        url: '/home/crawler',
        method: 'post',
        data: {
            authenticity_token: _form_auth_,
            target: {
                provider: provider,
                url: target_url
            }
        }
    }).done(function (data) {
        console.log(data);
        var provider = data.provider;
        var info = data.detail;

        var form = $('.post-container').find('form');
        var form_title      = form.find('#post_title'),
            form_bg_img     = form.find('#post_thumbnail_img'),
            form_video_url  = form.find('#post_video_url');
        var preview_dom = $('.posts-wrapper.preview');

        if (provider === 'youtube'){
            var title       = info.title,
                image       = info.image,
                video_url   = info.video_secure_url;

        } else if (provider === 'facebook'){
            var title       = info.title,
                image       = info.image,
                video_url   = info.url;
        } else if (provider === 'naver'){
            var title       = info.title,
                image       = info.image,
                video_url   = info.video_url,
                playtime    = info.video_play_time;

            var runtime = parse_sec(playtime, null);
            $('#post_runtime').val(runtime);
            preview_dom.find('.runtime-badge').text(runtime);
        }

        // form inputs
        form_title.val(title);
        form_bg_img.val(image);
        form_video_url.val(video_url);

        // previews
        preview_dom.find('.caption').find('h4').text(title);
        $.each(preview_dom.find('.thumbnail').find('img'), function (i, el) {
            $(el)[0].src = image;
        });
        $.each(preview_dom.find('.tbn-img'), function (i, el) {
            $(el)[0].style.backgroundImage = 'url('+image+')';
        });

        compute_thumbnail();
        $('#post_crawling_target_after').show();
        compute_thumbnail();
    });
}

function normalize_url(url) {
    var provider = url.split('/')[2];
    if (provider === 'youtu.be'){
        var host = 'https://www.youtube.com/watch';
        var source = 'v='+url.split('/')[url.split('/').length - 1].split('?')[0];
        var params = [source, 'feature='+provider, url.split('/')[url.split('/').length - 1].split('?')[1]].join('&');
        url = [host, params].join('?');
    }
    console.log(url);
    return url
}