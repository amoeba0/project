class pauseRecordLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new recordDialogHtml()
        @close_button = new recordDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)