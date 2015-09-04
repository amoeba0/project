class pauseItemUseLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemUseDialogHtml()
        @close_button = new itemUseDialogCloseButton()
        @addChild(@modal)
        @addChild(@dialog)
        @addChild(@close_button)