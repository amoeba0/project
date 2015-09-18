class systemHtml extends appHtml
    constructor: (width, height) ->
        super width, height
        @class = []
        @text = ''
        @is_button = true
    setHtml: ()->
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        @_element.innerHTML = '<div class="'+tmp_cls+'">'+@text+'</div>'
    setImageHtml:()->
        tmp_class = ''
        if @is_button is true
            tmp_class = 'image-button'
        @_element.innerHTML = '<img src="images/html/'+@image_name+'.png" class="'+tmp_class+'"></img>'
    changeNotButton:()->
        @is_button = false
        @setImageHtml()
    changeIsButton:()->
        @is_button = true
        @setImageHtml()