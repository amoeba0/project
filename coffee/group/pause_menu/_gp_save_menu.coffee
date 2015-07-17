class gpSaveMenu extends appGroup
    constructor: () ->
        super
        @dialog = new baseDialog()
        @addChild(@dialog)

        @ok_button = new saveOkButton()
        @addChild(@ok_button)
        @ok_text = new saveOkText()
        @addChild(@ok_text)

        @save_message = new messageText('保存しました。', 157, 262)
        @addChild(@save_message)