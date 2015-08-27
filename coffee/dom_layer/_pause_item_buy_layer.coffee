class pauseItemBuyLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new itemBuyDialogHtml()
        @close_button = new itemBuyDialogCloseButton()
        @addChild(@dialog)
        @addChild(@close_button)