local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
local ads = require "ads"

_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
    ads.hide()
    groupDS = self.view
    local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
    dbDS = sqlite.open( path ) 
    function doesDBFileExists(sFileAndPath)
    
    local bResults = false
  
    -- io.open opens a file at filePath. returns nil if no file found
    local file = io.open( sFileAndPath, "r" )
    
    if file then   -- YES FILE OPENed -->
        io.close( file )
        bResults = true
    else           -- FILE - NOT - OPENed -->
        bResults = false
    end
    
    return bResults
end
local path2 = system.pathForFile( "NotANewApp.sqlite", system.DocumentsDirectory )
if doesDBFileExists( path2 ) == true then 
            print ("doesDBFileExists ->> true")
 else
        timer.performWithDelay(200,function() composer.gotoScene("OverlayInstructions","fromBottom",800) end,1)       
end
        
    BackgroundDS = display.newRect(0,0,_W,_H)
    BackgroundDS.anchorX = 0
    BackgroundDS.anchorY = 0
    BackgroundDS:setFillColor(0,108/255,232/255)
    groupDS:insert(BackgroundDS)

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
    
	Tile1 = display.newImage("Tile1.png")
    Tile1.anchorX = 0
    Tile1.anchorY = 0
    Tile1.x = 0
    Tile1.y = _H*0.2
    Tile1.width = _W*0.5
    Tile1.height = _W*0.5
    Tile1:addEventListener("touch",function()
        print("Went")
        composer.gotoScene("Easy","fade")
    end)
    groupDS:insert(Tile1)
    Tile2 = display.newImage("Tile2.png")
    Tile2.anchorX = 0
    Tile2.anchorY = 0
    Tile2.x = _W*0.5
    Tile2.y = _H*0.2
    Tile2.width = _W*0.5
    Tile2.height = _W*0.5
    Tile2:addEventListener("touch",function()
        print("Went")
        composer.gotoScene("Medium","fade")
    end)
    groupDS:insert(Tile2)
    Tile3 = display.newImage("Tile3.png")
    Tile3.anchorX = 0
    Tile3.anchorY = 0
    Tile3.x = 0
    Tile3.y = _H*0.2 + _W*0.5
    Tile3.width = _W*0.5
    Tile3.height = _W*0.5
    Tile3:addEventListener("touch",function()
        print("Went")
        composer.gotoScene("Hard","fade")
    end)
    groupDS:insert(Tile3)
    Tile4 = display.newImage("BackTile.png")
    Tile4.anchorX = 0
    Tile4.anchorY = 0
    Tile4.x = _W*0.5
    Tile4.y = _H*0.2 + _W*0.5
    Tile4.width = _W*0.5
    Tile4.height = _W*0.5
    Tile4:addEventListener("touch",function()
        print("Went")
        composer.gotoScene("MainMenu",{effect = "fade", params = {Execute = false}})
    end)
    groupDS:insert(Tile4)
    TitleDS = display.newText("游戏形式",_W*0.18,_H*0.05,"HappyZcool",120)
    TitleDS.anchorX = 0
    TitleDS.anchorY = 0
    groupDS:insert(TitleDS)
    InstructionsButton = display.newImage("InstructionsCheck.png",_W*0.44,_H*0.78)
    InstructionsButton.anchorX = 0
    InstructionsButton.anchorY = 0
    InstructionsButton:scale(0.15,0.15)
    InstructionsButton:addEventListener("touch",function() 
        composer.gotoScene("OverlayInstructions","fromBottom",800)
    end)
    groupDS:insert(InstructionsButton)
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
       Tile1:removeEventListener("touch",function()
            print("Went")
            composer.gotoScene("Easy","fade")
        end)
       Tile2:removeEventListener("touch",function()
            print("Went")
            composer.gotoScene("Medium","fade")
        end)
       Tile3:removeEventListener("touch",function()
            print("Went")
            composer.gotoScene("Hard","fade")
        end)
       Tile4:removeEventListener("touch",function()
            print("Went")
            composer.gotoScene("MainMenu","fade")
        end)
        InstructionsButton:removeEventListener("touch",function() 
            composer.gotoScene("OverlayInstructions","fromBottom",800)
        end)
    elseif ( phase == "did" ) then

    end
    composer.removeScene("DifficultySelection")
end

function scene:destroy( event )

    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene