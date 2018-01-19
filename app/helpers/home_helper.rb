module HomeHelper

    def carousel_text(text_arr)
        pref, text, suff = '', '', ''
        pref = text_arr[0] unless text_arr[0]&.length&.zero?
        text = text_arr[1] unless text_arr[1]&.length&.zero?
        suff = text_arr[2] unless text_arr[2]&.length&.zero?

        pref = '' if text.length == 0
        suff, pref = '','' unless text.match('  ').nil?
        [pref, text, suff].join.html_safe
    end
end
