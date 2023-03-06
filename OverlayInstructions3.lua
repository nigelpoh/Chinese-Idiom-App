local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
local ads = require "ads"

_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
	OIMDisplay = self.view
	ads.hide()
	OverlayInstructionsImage3 = display.newImage("InstructionsMedium.png",0,0)
	OverlayInstructionsImage3.anchorX = 0
	OverlayInstructionsImage3.anchorY = 0
	OverlayInstructionsImage3.width = _W
	OverlayInstructionsImage3.height = _H
	OIMDisplay:insert(OverlayInstructionsImage3)
	TouchRectangleOIM = display.newRect(_W*0.85,_H*0.9,_W*0.1,_H*0.08)
	TouchRectangleOIM.anchorX = 0
	TouchRectangleOIM.anchorY = 0
	TouchRectangleOIM.isVisible = false
	TouchRectangleOIM.isHitTestable = true
	OIMDisplay:insert(TouchRectangleOIM)
	TouchRectangleOIM2 = display.newRect(_W*0.05,_H*0.89,_W*0.1,_H*0.08)
	TouchRectangleOIM2.anchorX = 0
	TouchRectangleOIM2.anchorY = 0
	TouchRectangleOIM2.isVisible = false
	TouchRectangleOIM2.isHitTestable = true
	OIMDisplay:insert(TouchRectangleOIM2)
	TouchRectangleOIM:addEventListener("touch",function()
		local optionsOIM =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions4",optionsOIM)
	end)
	TouchRectangleOIM2:addEventListener("touch",function()
		local optionsOIM2 =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions2",optionsOIM2)
	end)
end
function scene:show( event )
end
function scene:hide( event )
    composer.removeScene("OverlayInstructions3")
end

function scene:destroy( event )

   
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene