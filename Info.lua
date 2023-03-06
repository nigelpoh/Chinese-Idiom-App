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
    InfoGroup = self.view
    BackgroundEmpty = display.newImageRect("EmptyBackground.png",_W,_H)
    BackgroundEmpty.anchorX = 0
    BackgroundEmpty.anchorY = 0
    InfoGroup:insert(BackgroundEmpty)
    InfoTitle = display.newText("鸣谢",_W*0.33,_H*0.05,"HappyZcool",120)
    InfoTitle.anchorX = 0
    InfoTitle.anchorY = 0
    InfoGroup:insert(InfoTitle)
    KnowledgeProviderTitle = display.newText("德明政府中学–提供资源",_W*0.5,_H*0.23,"HappyZcool",55)
    KnowledgeProviderTitle.anchorX = 0.5
    KnowledgeProviderTitle.anchorY = 0.5
    InfoGroup:insert(KnowledgeProviderTitle)
    KnowledgeProvider1 = display.newText("符校长",_W*0.5,_H*0.30,"HappyZcool",45)
    KnowledgeProvider1.anchorX = 0.5
    KnowledgeProvider1.anchorY = 0.5
    KnowledgeProvider1:setFillColor(0.8,0.8,0.8)
    InfoGroup:insert(KnowledgeProvider1)
    KnowledgeProvider2 = display.newText("吴老师",_W*0.5,_H*0.34,"HappyZcool",45)
    KnowledgeProvider2.anchorX = 0.5
    KnowledgeProvider2.anchorY = 0.5
    KnowledgeProvider2:setFillColor(0.8,0.8,0.8)
    InfoGroup:insert(KnowledgeProvider2)
    KnowledgeProvider3 = display.newText("江老师",_W*0.5,_H*0.38,"HappyZcool",45)
    KnowledgeProvider3.anchorX = 0.5
    KnowledgeProvider3.anchorY = 0.5
    KnowledgeProvider3:setFillColor(0.8,0.8,0.8)
    InfoGroup:insert(KnowledgeProvider3)
    CodingTitle = display.newText("Green Infinity–程序设计",_W*0.5,_H*0.45,"HappyZcool",55)
    CodingTitle.anchorX = 0.5
    CodingTitle.anchorY = 0.5
    InfoGroup:insert(CodingTitle)
    Coding1 = display.newText("傅俊恺",_W*0.5,_H*0.52,"HappyZcool",45)
    Coding1.anchorX = 0.5
    Coding1.anchorY = 0.5
    Coding1:setFillColor(0.8,0.8,0.8)
    InfoGroup:insert(Coding1)
    GraphicsTitle = display.newText("图片",_W*0.5,_H*0.59,"HappyZcool",55)
    GraphicsTitle.anchorX = 0.5
    GraphicsTitle.anchorY = 0.5
    InfoGroup:insert(GraphicsTitle)
    Graphics1 = display.newText("freepik.com",_W*0.5,_H*0.66,"HappyZcool",45)
    Graphics1.anchorX = 0.5
    Graphics1.anchorY = 0.5
    Graphics1:setFillColor(0.8,0.8,0.8)
    InfoGroup:insert(Graphics1)
    DHSLogo = display.newImage("DHS.png",_W*0.3,_H*0.76)
    DHSLogo.anchorX = 0.5
    DHSLogo.anchorY = 0.5
    DHSLogo:scale(0.4,0.4)
    InfoGroup:insert(DHSLogo)
    GILogo = display.newImage("GreenInfinityLogo.png",_W*0.7,_H*0.76)
    GILogo.anchorX = 0.5
    GILogo.anchorY = 0.5
    GILogo:scale(0.09,0.09)
    InfoGroup:insert(GILogo)

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
    
    local function InfoGoMM( event )
        composer.gotoScene("MainMenu",{effect = "fade", params = {Execute = false}})
    end
    local BackInfo = widget.newButton(
        {
            defaultFile = "Transparent.png",
            left = _W*0.7,
            top = _H*0.82,
            width = _W*0.15,
            height = _W*0.15*(_W/_H),
            font = "HappyZcool",
            fontSize = 60,
            onEvent = InfoGoMM
        }
    )
    --BackInfo:scale(0.2,0.2)
    BackInfo.anchorX = 0.5
    BackInfo.anchorY = 0
    BackInfo.x = _W*0.7
    BackInfo.y = _H*0.82
    InfoGroup:insert(BackInfo)
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
        composer.removeScene("Info")
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