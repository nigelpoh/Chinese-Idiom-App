local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
    groupMainMenu = self.view
    local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
    dbMainMenu = sqlite.open( path )   
    local sql = [[UPDATE UserRecordsMedium SET Score = 0 WHERE id = 1]]
    dbMainMenu:exec(sql)
    local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
    dbMainMenu:exec(sql)
    local sql = [[UPDATE UserRecordsEasy SET Score = 0 WHERE id = 1]]
    dbMainMenu:exec(sql)
	Background = display.newImageRect("Background.png",_W,_H)
	Background.x = 0
	Background.y = 0
	Background.anchorX = 0
	Background.anchorY = 0
    groupMainMenu:insert(Background) 
	Title = display.newText("成语天王",_W*0.5,_H*0.03,"HappyZcool",110)
	Title.anchorX = 0.5
	Title.anchorY = 0
    groupMainMenu:insert(Title)
    SwipeReminder = display.newText("请轻扫频幕",_W*0.5,_H*0.14,"HappyZcool",50)
    SwipeReminder.anchorX = 0.5
    SwipeReminder.anchorY = 0
    SwipeReminder:setFillColor(1,174/255,0)
    groupMainMenu:insert(SwipeReminder)
    Play = display.newImage("play.png")
    Play.x = _W*0.45
    Play.y = _H*0.2
    Play:scale(0.15,0.15)
    Play.anchorX = 0
    Play.anchorY = 0
    groupMainMenu:insert(Play)
    Settings = display.newImage("settings.png")
    Settings.x = _W*0.45
    Settings.y = _H*0.73
    Settings:scale(0.15,0.15)
    Settings.anchorX = 0
    Settings.anchorY = 0
    groupMainMenu:insert(Settings)
    Book = display.newImage("book.png")
    Book.x = _W*0.87
    Book.y = _H*0.47
    Book:scale(0.15,0.15)
    Book.anchorX = 0
    Book.anchorY = 0
    groupMainMenu:insert(Book)
    Info = display.newImage("info.png")
    Info.x = _W*0.02
    Info.y = _H*0.47
    Info:scale(0.15,0.15)
    Info.anchorX = 0
    Info.anchorY = 0
    groupMainMenu:insert(Info)
    local optionsC =
    {
        width = 195,
        height = 135,
        numFrames = 8,
        sheetContentWidth = 1560,  
        sheetContentHeight = 135  
    }
    local CharacterImageSheet = graphics.newImageSheet( "Character.png", optionsC )
    local sequenceDataC =
    {
        name="Character",
        start=1,
        count=8,
        time=1000,
        loopCount = 0,   
        loopDirection = "forward"    
    }
    local Character = display.newSprite( CharacterImageSheet, sequenceDataC)
    Character.anchorX = 0
    Character.anchorY = 0
    Character.x = _W*0.36
    Character.y = _H*0.45
    Character:scale(1,1)
    Character:play()
    groupMainMenu:insert(Character)
    local function SwipeTouchEvent(event)
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        if(swipeLengthX > swipeLengthY) then
        local phase = event.phase
        if "began" == phase then
            return true
        elseif "moved" == phase then
        elseif "ended" == phase or "cancelled" == phase then
            if event.xStart > event.x and swipeLengthX > 100 then 
                print("Swiped Left")
                print("X:"..swipeLengthX)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
                transition.to(Character,{time = 300, x = _W*0.15,onComplete = function() 
                    Character.isVisible = false
                    composer.gotoScene("Info","fade")
                    end})
            elseif event.xStart < event.x and swipeLengthX > 100 then 
                print( "Swiped Right" )
                 print("X:"..swipeLengthX)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
                transition.to(Character,{time = 300, x = _W*0.75,onComplete = function() 
                    Character.isVisible = false
                    composer.gotoScene("Dictionary","fade")
                    end})
            end
        end
        elseif(swipeLengthX<swipeLengthY)then
            if event.yStart > event.y and swipeLengthY > 100 then
                print("Swiped Up")
                 print("Y:"..swipeLengthY)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
                transition.to(Character,{time = 300, y = _H*0.25,onComplete = function() 
                    Character.isVisible = false
                    composer.gotoScene("RebounceEasy3","fade")
                    end})
            elseif event.yStart < event.y and swipeLengthY > 100 then
                print("Swiped Down")
                print("Y:"..swipeLengthY)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
                transition.to(Character,{time = 300, y = _H*0.65,onComplete = function() 
                    Character.isVisible = false
                    composer.gotoScene("Settings","fade")
                    end})
            end 
        end
    end
    Runtime:addEventListener("touch",SwipeTouchEvent)
    function GetRidOfSwipeInstrLis()
        Runtime:removeEventListener("touch", RemoveSwipeInstr)
    end
    function RemoveSwipeInstr()
        display.remove(SwipeInstr)
        GetRidOfSwipeInstrLis()
    end
    if(event.params.Execute == true) then
        SwipeInstr = display.newImage("SwipeToSelect.png",_W*0.5,_H*0.5)
        SwipeInstr.anchorX = 0.5
        SwipeInstr.anchorY = 0.5
        groupMainMenu:insert(SwipeInstr)
        Runtime:addEventListener("touch", RemoveSwipeInstr)
        SwipeInstr:scale(0.3,0.3)
    end
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
    print("------------------HIDDEN--------------------")
    composer.removeScene("MainMenu")
    if ( phase == "will" ) then
     
    elseif ( phase == "did" ) then
    
    end
    composer.removeScene("MainMenu")
end

function scene:destroy( event )

    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene