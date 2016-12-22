class pauseHelpLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new menuDialogHtml()
        @close_button = new helpDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)
        @type = 0
        @nowPage = 0
        @txts = {
            0:{
                'title':'test'
                'text' :[
                    'test'
                ]
            },
            1:{
                'title':'たいとる'
                'text' :[
                    'ないよう'
                ]
            },
            2:{
                'title':'たいとるに'
                'text' :[
                    'ふがふが',
                    'ほげほげ'
                ]
            }
        }
    setHelp:(type)->
        @type = type
        @text = new helpDiscription(@txts[type]['text'][0])
        @title = new helpTitle(@txts[type]['title'])
        @addChild(@text)
        @addChild(@title)
        @ok_btn = new helpOkButtonHtml()
        @next_btn = new helpNextButtonHtml()
        if @txts[type]['text'].length is 1
            @addChild(@ok_btn)
        else
            @addChild(@next_btn)
            page = @setPageText()
            @page_num = new pageNum(page)
            @addChild(@page_num)
    goNext:()->
        @nowPage++
        @text.setText(@txts[@type]['text'][@nowPage])
        page = @setPageText()
        @page_num.setText(page)
        if @txts[@type]['text'].length - 1 <= @nowPage
            @removeChild(@next_btn)
            @addChild(@ok_btn)
    setPageText:()->
        page = @nowPage + 1
        all = @txts[@type]['text'].length
        return page + '／' + all + 'ページ'

