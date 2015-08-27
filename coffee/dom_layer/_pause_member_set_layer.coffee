class pauseMemberSetLayer extends appDomLayer
    constructor: () ->
        super
        @dialog = new memberSetDialogHtml()
        @close_button = new memberSetDialogCloseButton()
        @addChild(@dialog)
        @addChild(@close_button)