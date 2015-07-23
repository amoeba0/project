class appHtml extends Entity
    constructor: (width, height) ->
        super
        @_element = document.createElement('div')
        @width = width
        @height = height