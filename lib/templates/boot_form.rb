module BootForm
    attr_accessor :obj, :res, :attr, :options,
                  :grid, :required, :disabled, :value,
                  :id, :name, :label_text, :placeholder,
                  :classes, :style, :fg_class, :btn_class, :grid_class

    def grid_input(type, res, attr, arg)
        set_vars type, res, attr, arg
        html = ''

        case type
        when 'crawler'
            html += crawler_format

        when 'text'
            html += text_format

        when 'select'
            html += select_format

        end

        html.html_safe
    end

    def grid_submit(value, arg)
        grid    = arg[:grid] ? arg[:grid] : {left: 'col-sm-offset-2', right: 'col-sm-10'}

        classes     = arg[:class]
        fg_class    = classes[:fg] ? classes[:fg] : ''
        grid_class  = classes[:grid] ? classes[:grid] : ''
        btn_class   = classes[:btn] ? classes[:btn] : ''
        style       = arg[:style]

        html    = "\n"+
            "<div class=\"form-group #{fg_class}\">\n"+
            "   <div class=\"#{grid[:left]} #{grid[:right]} #{grid_class}\">\n"+
            "       <button type=\"submit\" style=\"#{style}\" class=\"#{btn_class}\" onclick=\"if (!allow_disabled_data()){return false}\">#{value}</button>\n"+
            "   </div>\n"+
            "</div>\n"

        html.html_safe
    end

    private
    def set_vars(type, res, attr, arg)
        @obj     = res
        @res     = res.class.to_s.underscore
        @attr    = attr.to_s.underscore
        @options = arg[:options]
        @classes = arg[:class]
        @style   = arg[:style]

        @grid        = @options[:grid]      ? @options[:grid] : {left: 'col-sm-2', right: 'col-sm-10'}
        @required    = @options[:required]  ? 'required' : 'optional'
        @disabled    = @options[:disabled]  ? 'disabled' : false

        @id = "#{@res}_#{@attr}"
        @name, @value = '', ''
        if type == 'crawler'
            @value   = '실행'
        else
            @name    = "#{@res}[#{@attr}]"
            @value   = @options[:value]     || (eval("obj&.#{@attr}") || '')
        end

        if type == 'crawler'
            @fg_class    = @classes[:fg] ? @classes[:fg] : ''
            @grid_class  = @classes[:grid] ? @classes[:grid] : ''
            @btn_class   = @classes[:btn] ? @classes[:btn] : ''
        end

        @label_text  = @options[:label_text] || @attr
        @label_text  = '<b>'+@label_text+'</b>' unless @disabled
        @placeholder = @options[:placeholder] ? options[:placeholder] : "#{@attr} of #{@res}"
    end

    def crawler_format
        sample = grid[:right].split('-')
        offset = ['col', sample[1], 'offset', (12 - sample.last.to_i)].join('-')
        ''+
            "<div class=\"form-group\">\n"+
            "   <label for=\"#{id}\" class=\"#{grid[:left]} control-label\">#{label_text.capitalize}</label>\n\n"+
            "   <div class=\"#{grid[:right]}\">\n"+
            "       <div class=\"fg-line #{disabled if disabled}\">\n"+
            "           <input type=\"text\" class=\"form-control input-sm string #{required} #{'form-disabled' if disabled}\" name=\"#{name}\" id=\"#{id}\" placeholder=\"#{placeholder}\" autocomplete=\"off\" value=\"\" #{required if options[:required]} #{disabled if disabled}>\n"+
            "       </div>\n"+
            "   </div>\n\n"+
            "</div>\n"+
            "\n"+
            "<div class=\"form-group #{fg_class}\">\n"+
            "   <div class=\"#{offset} #{grid[:right]} #{grid_class}\">\n"+
            "       <a style=\"#{style}\" class=\"crawlBtn #{btn_class}\">#{value}</a>\n"+
            "   </div>\n"+
            "</div>\n"
    end

    def text_format
        ''+
            "<div class=\"form-group\">\n"+
            "   <label for=\"#{id}\" class=\"#{grid[:left]} control-label\">#{label_text.capitalize}</label>\n\n"+
            "   <div class=\"#{grid[:right]}\">\n"+
            "       <div class=\"fg-line #{disabled if disabled}\">\n"+
            "           <input type=\"text\" class=\"form-control input-sm string #{required} #{'form-disabled' if disabled}\" name=\"#{name}\" id=\"#{id}\" placeholder=\"#{placeholder}\" autocomplete=\"off\" value=\"#{value}\" #{required if options[:required]} #{disabled if disabled}>\n"+
            "       </div>\n"+
            "   </div>\n\n"+
            "</div>\n"
    end

    def select_format
        ''+
            "<div class=\"form-group\">\n"+
            "   <label for=\"#{id}\" class=\"#{grid[:left]} control-label\">#{label_text.capitalize}</label>\n\n"+
            "   <div class=\"#{grid[:right]}\">\n"+
            "       <div class=\"fg-line\">\n"+
            "           <div class=\"select\">\n\n"+
            "               <select #{required if options[:required]} class=\"form-control #{'form-disabled' if disabled}\" name=\"#{name}\" id=\"#{id}\" #{disabled if disabled}>\n" + options_format + "</select>\n\n"+
            "           </div>\n"+
            "       </div>\n"+
            "   </div>\n"+
            "</div>\n"
    end

    def options_format
        if disabled
            default_text = eval("#{attr.gsub('_id','').camelcase}.find(#{value}).title")
            "<option value=\"#{value}\">#{default_text}</option>\n"
        else
            objs = eval("#{attr.gsub('_id','').camelcase}.all.reverse")
            "<option>Select an Option</option>\n" + objs.map{|op| "<option value=\"#{op.id}\" #{'selected' if op.id == value.to_i}>#{op.title}</option>\n"}.join
        end
    end
end
