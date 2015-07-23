class systemHtml extends appHtml
    constructor: (width, height) ->
        super width, height
        @class = []
        @text = ''
    setHtml: ()->
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        @_element.innerHTML = '<div class="'+tmp_cls+'">'+@text+'</div>'