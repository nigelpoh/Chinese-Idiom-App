local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
local ads = require "ads"

_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
	ads.hide()
	OIEDisplay = self.view
	OverlayInstructionsImage2 = display.newImage("InstructionsEasy.png",0,0)
	OverlayInstructionsImage2.anchorX = 0
	OverlayInstructionsImage2.anchorY = 0
	OverlayInstructionsImage2.width = _W
	OverlayInstructionsImage2.height = _H
	OIEDisplay:insert(OverlayInstructionsImage2)
	TouchRectangleOIE = display.newRect(_W*0.85,_H*0.9,_W*0.1,_H*0.08)
	TouchRectangleOIE.anchorX = 0
	TouchRectangleOIE.anchorY = 0
	TouchRectangleOIE.isVisible = false
	TouchRectangleOIE.isHitTestable = true
	OIEDisplay:insert(TouchRectangleOIE)
	TouchRectangleOIE2 = display.newRect(_W*0.05,_H*0.89,_W*0.1,_H*0.08)
	TouchRectangleOIE2.anchorX = 0
	TouchRectangleOIE2.anchorY = 0
	TouchRectangleOIE2.isVisible = false
	TouchRectangleOIE2.isHitTestable = true
	OIEDisplay:insert(TouchRectangleOIE2)
	TouchRectangleOIE:addEventListener("touch",function()
		local optionsOIE =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions3",optionsOIE)
	end)
	TouchRectangleOIE2:addEventListener("touch",function()
		local optionsOIE2 =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions",optionsOIE2)
	end)
end
function scene:show( event )
end
function scene:hide( event )
	composer.removeScene("OverlayInstructions2")
end
function scene:destroy( event )  
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene