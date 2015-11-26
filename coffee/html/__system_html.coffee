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
        tmp_cls = ''
        for val in @class
            tmp_cls += val + ' '
        if @is_button is true
            tmp_cls += 'image-button'
        @_element.innerHTML = '<img src="images/html/'+@image_name+'.png" class="'+tmp_cls+'"></img>'
    changeNotButton:()->
        @is_button = false
        @setImageHtml()
    changeIsButton:()->
        @is_button = true
        @setImageHtml()
    addDomClass:(cls, isImg = false)->
        if (@class.indexOf(cls) == -1)
            @class.push(cls)
            @_setHtml(isImg)
    removeDomClass:(cls, isImg = false)->
        for val, key in @class
            if val is cls
                @class.splice(key, 1)
        @_setHtml(isImg)
    _setHtml:(isImg = false)->
        if isImg is true
            @setImageHtml()
        else
            @setHtml()