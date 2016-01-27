class pauseSaveConfirmLayer extends appDomLayer
    constructor:()->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new saveConfirmDiscription()
        @addChild(@discription)
        @ok_button = new saveConfirmOkButtonHtml()
        @addChild(@ok_button)
        @cancel_button = new saveConfirmCancelButtonHtml()
        @addChild(@cancel_button)

class pauseSaveLayer extends appDomLayer
    constructor: () ->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new saveEndDiscription()
        @addChild(@discription)
        @ok_button = new saveOkButtonHtml()
        @addChild(@ok_button)

class pauseTitleConfirmLayer extends appDomLayer
    constructor:()->
        super
        @addChild(@modal)
        @dialog = new saveDialogHtml()
        @addChild(@dialog)
        @discription = new titleConfirmDiscription()
        @addChild(@discription)
        @ok_button = new titleConfirmOkButtonHtml()
        @addChild(@ok_button)
        @cancel_button = new titleConfirmCancelButtonHtml()
        @addChild(@cancel_button)