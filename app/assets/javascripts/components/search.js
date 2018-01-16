$(document).ready(function () {
    $('#searchModal').on('show.bs.modal', function (e) {
        $('html').addClass('full');

    }).on('hidden.bs.modal', function (e) {
        $('html').removeClass('full');

    }).on('shown.bs.modal', function (e) {
        header_fix();
        $('#searchModalLabel').find('input').focus();

    });


    $('#searchCategoryZone li a span').click(function (e) {
        $('#searchCategoryZone li').removeClass('active');
        $(this).closest('li').addClass('active');
        e.stopPropagation();
        return false;
    });


    $('#searchModalLabel').find('.input-group-addon').click(function (e) {
        $('#searchModal').modal('hide');
        $('html').removeClass('full');
    });

});


function header_fix() {
    var fixed_header = $('#searchModal').find('.modal-header');
    $('#searchModal.in').unbind().scroll(function (e) {
        var top = $(this).scrollTop();
        fixed_header.css('top', top);
    });
}
