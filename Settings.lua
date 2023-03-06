local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
-- Load Corona 'ads' library 
local ads = require "ads"
_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
    ads.hide()
    ContactGroup = self.view
    BackgroundEmptyContact = display.newImage("EmptyBackground.png")
    BackgroundEmptyContact.anchorX = 0
    BackgroundEmptyContact.anchorY = 0 
    ContactGroup:insert(BackgroundEmptyContact)

    -- ads network
    local adType = "banner"
    local int = 30
    local adX
    local adY
  

    adNetwork = "admob"
    adType = "banner" -- interstitial
    int = 30
    local adX, adY = display.screenOriginX, _H - display.screenOriginY
    
    ads:setCurrentProvider(adNetwork)

    
    ads.show( adType, { x=adX, y=adY, interval = int, testMode = false } )
    NeedHelp = display.newText("需要帮助？",_W*0.5,_H*0.23,"HappyZcool",100)
    NeedHelp.anchorX = 0.5
    NeedHelp.anchorY = 0
    ContactGroup:insert(NeedHelp)
    InfoNeedHelp = display.newText("请联络我们！",_W*0.5,_H*0.31,"HappyZcool",60)
    InfoNeedHelp.anchorX = 0.5
    InfoNeedHelp.anchorY = 0
    InfoNeedHelp:setFillColor(0.9,0.9,0.9)
    ContactGroup:insert(InfoNeedHelp)
    local optionsC =
    {
        width = 195,
        height = 135,
        numFrames = 8,
        sheetContentWidth = 1560,  
        sheetContentHeight = 135  
    }
    local CharacterSettingsImageSheet = graphics.newImageSheet( "Character.png", optionsC )
    local sequenceDataC =
    {
        name="CharacterSettings",
        start=1,
        count=8,
        time=1000,
        loopCount = 0,   
        loopDirection = "forward"    
    }
    local CharacterSettings = display.newSprite( CharacterSettingsImageSheet, sequenceDataC)
    CharacterSettings.anchorX = 0
    CharacterSettings.anchorY = 0
    CharacterSettings.x = _W*0.36
    CharacterSettings.y = _H*0.45
    CharacterSettings:scale(1,1)
    CharacterSettings:play()
    ContactGroup:insert(CharacterSettings)
    function handleButtonEventSettingsSet()
        local optionsSet =
            {
                to = "green.infinity.88@gmail.com",
                subject = "Inquiry: 成语天王"
            }
        native.showPopup( "mail", optionsSet )
    end
    optionsCUB = {
        shape = "roundedRect",
        width = _W*0.45,
        height = _H*0.1,
        cornerRadius = 10,
        onPress = handleButtonEventSettingsSet,
        fillColor = { default={ 0, 32/255, 128/255 ,1 }, over={ 0, 32/255, 110/255 ,1 } },
        font = "HappyZcool",
        fontSize = 60,
        labelColor = {default = {0.8,0.8,0.8}}
    }
    local ContactUsButton = widget.newButton(optionsCUB)
    ContactUsButton.x = _W*0.5
    ContactUsButton.y = _H*0.62 
    ContactUsButton.anchorX = 0.5
    ContactUsButton.anchorY = 0
    ContactUsButton:setLabel( "联络我们!" )
    ContactGroup:insert(ContactUsButton)
    local function InfoGoMMCG( event )
        composer.gotoScene("MainMenu",{effect = "fade", params = {Execute = false}})
    end
    local BackInfoCG = widget.newButton(
        {
            defaultFile = "Transparent.png",
            left = _W*0.5,
            top = _H*0.77,
            width = _W*0.15,
            height = _W*0.15*(_W/_H),
            font = "HappyZcool",
            fontSize = 60,
            onEvent = InfoGoMMCG
        }
    )
    --BackInfoCG:scale(0.2,0.2)
    BackInfoCG.anchorX = 0.5
    BackInfoCG.anchorY = 0
    BackInfoCG.x = _W*0.5
    BackInfoCG.y = _H*0.77
    ContactGroup:insert(BackInfoCG)
end
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      
    elseif ( phase == "did" ) then
      
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
     
    elseif ( phase == "did" ) then

    end
end

function scene:destroy( event )

    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene