class pauseSaveLayer extends appDomLayer
    constructor: () ->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @ok_button = new saveOkButtonHtml()
        @addChild(@ok_button)