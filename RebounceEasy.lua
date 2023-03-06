local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
	print("Rebounce")
	timer1 = timer.performWithDelay(100,function()composer.gotoScene("Easy","fade")end,1)
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
        timer.cancel(timer1)
        composer.removeScene("RebounceEasy")
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