local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
local ads = require "ads"

_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
	OIHDisplay = self.view
	ads.hide()
	OverlayInstructionsImage4 = display.newImage("InstructionsHard.png",0,0)
	OverlayInstructionsImage4.anchorX = 0
	OverlayInstructionsImage4.anchorY = 0
	OverlayInstructionsImage4.width = _W
	OverlayInstructionsImage4.height = _H
	OIHDisplay:insert(OverlayInstructionsImage4)
	TouchRectangleOIH = display.newRect(_W*0.85,_H*0.9,_W*0.1,_H*0.08)
	TouchRectangleOIH.anchorX = 0
	TouchRectangleOIH.anchorY = 0
	TouchRectangleOIH.isVisible = false
	TouchRectangleOIH.isHitTestable = true
	OIHDisplay:insert(TouchRectangleOIH)
	TouchRectangleOIH2 = display.newRect(_W*0.05,_H*0.89,_W*0.1,_H*0.08)
	TouchRectangleOIH2.anchorX = 0
	TouchRectangleOIH2.anchorY = 0
	TouchRectangleOIH2.isVisible = false
	TouchRectangleOIH2.isHitTestable = true
	OIHDisplay:insert(TouchRectangleOIH2)
	TouchRectangleOIH:addEventListener("touch",function()
		local optionsOIH =
		{
		    effect = "slideDown",
		    time = 800,
		    params = {
		    	FinishedDemonstration = true
			}
		}
		composer.gotoScene("DifficultySelection",optionsOIH)
	end)
	TouchRectangleOIH2:addEventListener("touch",function()
		local optionsOIH2 =
		{
		    effect = "crossFade",
		    time = 800
		}
		composer.gotoScene("OverlayInstructions3",optionsOIH2)
	end)
end
function scene:show( event )
end
function scene:hide( event )
    composer.removeScene("OverlayInstructions4")
end

function scene:destroy( event )

   
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene