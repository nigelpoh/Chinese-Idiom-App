local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
local ads = require "ads"

_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
	ads.hide()
	OIIDisplay = self.view
    local path = system.pathForFile( "NotANewApp.sqlite", system.DocumentsDirectory )
    OICheck = sqlite.open(path)
	OverlayInstructionsImage1 = display.newImage("InstructionsIntro.png",0,0)
	OverlayInstructionsImage1.anchorX = 0
	OverlayInstructionsImage1.anchorY = 0
	OverlayInstructionsImage1.width = _W
	OverlayInstructionsImage1.height = _H
	OIIDisplay:insert(OverlayInstructionsImage1)
	TouchRectangleOII = display.newRect(_W*0.85,_H*0.9,_W*0.1,_H*0.08)
	TouchRectangleOII.anchorX = 0
	TouchRectangleOII.anchorY = 0
	TouchRectangleOII.isVisible = false
	TouchRectangleOII.isHitTestable = true
	OIIDisplay:insert(TouchRectangleOII)
	TouchRectangleOII:addEventListener("touch",function()
		local optionsOII =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions2",optionsOII)
	end)
	OverlayInstructionsImageBubble = display.newImage("InstructionsBubble.png",_W*0.6,_H*0.72)
	OverlayInstructionsImageBubble.anchorX = 0
	OverlayInstructionsImageBubble.anchorY = 0
	OverlayInstructionsImageBubble:scale(0.5,0.5)
	OverlayInstructionsImageBubble.alpha = 0.5
	OIIDisplay:insert(OverlayInstructionsImageBubble)
end
function scene:show( event )
end
function scene:hide( event )
    composer.removeScene("OverlayInstructions")
end

function scene:destroy( event )

   
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene