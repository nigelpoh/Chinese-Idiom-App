local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
print("------------------Start of Scene---------------------")
WrongIndexBefore = 0
rScoreBefore = 0
LockDownEasy = false
local groupEasy = self.view
local GameOverEasy = false
LaserSound = audio.loadSound( "laser.wav" )
local beamGroup = display.newGroup()
local t = os.date( '*t' )
StorageSeconds = t.sec
MaxLimit = 243
local function castRay( startX, startY, endX, endY )
        local beam1 = display.newLine( beamGroup, startX, startY, endX, endY )
        beam1.strokeWidth = 15 ; 
        beam1:setStrokeColor( 1, 0, 0, 1 ) ; 
        beam1.blendMode = "add" ; 
        beam1:toBack()
        transition.to( beamGroup, { time=800, delay=400, alpha=0, onComplete=resetBeams } )
end
math.randomseed( os.time() )
local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end
Sequence = {}
local path2 = system.pathForFile("Levels.sqlite",system.ResourceDirectory)
db2 = sqlite.open(path2)
local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
db = sqlite.open( path )   
local tablesetup = [[CREATE TABLE IF NOT EXISTS UserRecordsEasy (id INTEGER PRIMARY KEY, Sequence INTEGER, Score INTEGER DEFAULT 0, Time FLOAT DEFAULT 15, Highscore INTEGER DEFAULT 0);]]
db:exec( tablesetup )
local SequenceSetUp = [[CREATE TABLE IF NOT EXISTS SequenceEasy (id INTEGER PRIMARY KEY, SequenceNumber INTEGER);]]
db:exec( SequenceSetUp )
function ChangeEasy()
    local sql1 = [[DELETE FROM SequenceEasy]]
    db:exec(sql1)
    local sql = [[CREATE TABLE IF NOT EXISTS SequenceEasy (id INTEGER PRIMARY KEY, SequenceNumber INTEGER);]]
    db:exec( sql )
    for k = 1,MaxLimit do
        local sql = [[INSERT INTO SequenceEasy(SequenceNumber) VALUES(']]..Sequence[k]..[[')]]
        db:exec(sql)
    end
    print("Here")
    local sql = [[UPDATE UserRecordsEasy SET Sequence = 1 WHERE id = 1]]
    db:exec(sql)
end
for i in db:nrows("SELECT Sequence AS row2 FROM UserRecordsEasy WHERE id = 1") do
    for j in db:nrows("SELECT COUNT(id) AS row FROM SequenceEasy") do
    if(i.row2 == j.row) then
        for k = 1,MaxLimit do
            table.insert(Sequence,k)
        end
        shuffleTable(Sequence)
        print(table.concat(Sequence," ,"))
        ChangeEasy()
    elseif (i.row2 < j.row) then
        
end
end
end
for i in db:nrows("SELECT COUNT(id) AS row2 FROM UserRecordsEasy") do
for j in db:nrows("SELECT COUNT(id) AS row FROM SequenceEasy") do
    print("X")
    if(j.row == 0 and i.row2 == 0) then
        local sql = [[INSERT INTO UserRecordsEasy(Sequence) VALUES(1)]]
        db:exec(sql)
        for k = 1,MaxLimit do
            table.insert(Sequence,k)
        end
        print(table.concat(Sequence))
        shuffleTable(Sequence)
        for k = 1,MaxLimit do
            print(Sequence[k])
            local sql = [[INSERT INTO SequenceEasy(SequenceNumber) VALUES(']]..Sequence[k]..[[')]]
            db:exec(sql)
        end
    end
end
end
arrayEasy = {"Correct1","Correct2","Correct3","Wrong"}
shuffleTable(arrayEasy)
local Wrong = table.indexOf( arrayEasy, "Wrong" )
BackgroundEasy = display.newImageRect("Background.png",_W,_H)
BackgroundEasy.x = 0
    BackgroundEasy.y = 0
    BackgroundEasy.anchorX = 0
    BackgroundEasy.anchorY = 0
    groupEasy:insert(BackgroundEasy)
    ScoreEasy = display.newImage("ScoreBoardEasy.png",_W*0.25,_H*0.0001)
    ScoreEasy.anchorX = 0
    ScoreEasy.anchorY = 0
    ScoreEasy:scale(0.62,0.62)
    groupEasy:insert(ScoreEasy)
    turretEasy = display.newImage("turret.png",_W*0.22,_H*0.26)
    turretEasy.anchorX = 0
    turretEasy.anchorY = 0 
    turretEasy:scale(0.5,0.5)
    turretEasy:rotate(135)
    groupEasy:insert(turretEasy)
    for i in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
            PointsEasy = display.newText(i.Score,_W*0.52,_H*0.125,"HappyZcool",100)
            PointsEasy.anchorX = 0.5
            PointsEasy.anchorY = 0.5
            groupEasy:insert(PointsEasy)
    end
    for j in db:nrows("SELECT Sequence AS row FROM UserRecordsEasy") do
        jjEasy = j.row
    end
    for i in db:nrows("SELECT SequenceNumber AS row FROM SequenceEasy WHERE id = "..jjEasy) do
        print(i.row)
        for z in db2:nrows("SELECT * FROM Easy WHERE ID = "..i.row) do  
            print("Wrong: "..tostring(Wrong))
            Word1Easy = display.newText(z[arrayEasy[1]],_W*0.02,_H*0.47,_W*0.1,_H,native.systemFont,40)
            Word1Easy.anchorX = 0
            Word1Easy.anchorY = 0
            groupEasy:insert(Word1Easy)
            Word2Easy = display.newText(z[arrayEasy[2]],_W*0.87,_H*0.47,_W*0.1,_H,native.systemFont,40)
            Word2Easy.anchorX = 0
            Word2Easy.anchorY = 0
            groupEasy:insert(Word2Easy)
            Word3Easy = display.newText(z[arrayEasy[3]],_W*0.45,_H*0.22,native.systemFont,40)
            Word3Easy.anchorX = 0
            Word3Easy.anchorY = 0
            groupEasy:insert(Word3Easy)
            Word4Easy = display.newText(z[arrayEasy[4]],_W*0.45,_H*0.73,native.systemFont,40)
            Word4Easy.anchorX = 0
            Word4Easy.anchorY = 0
            groupEasy:insert(Word4Easy)
        end
    end
    for k in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
        local optionsTurret =
            {
                width = 64,
                height = 64,
                numFrames = 10,
                sheetContentWidth = 640,  
                sheetContentHeight = 64  
            }
        local LaserBeamTurretEasyImagesheet = graphics.newImageSheet( "LaserBeamTurret.png", optionsTurret )
        local sequenceDataTurret=
            {
                name="LaserBeamTurret",
                start=1,
                count=10,
                time=k.Time*1000,
                loopCount = 1,   
                loopDirection = "forward"    
            }
        LaserBeamTurretEasy = display.newSprite( LaserBeamTurretEasyImagesheet, sequenceDataTurret)
        LaserBeamTurretEasy.anchorX = 0.5
        LaserBeamTurretEasy.anchorY = 0.5
        LaserBeamTurretEasy.x = _W*0.195
        LaserBeamTurretEasy.y = _H*0.295
        LaserBeamTurretEasy:scale(1,1)
        LaserBeamTurretEasy:play()
        groupEasy:insert(LaserBeamTurretEasy)
    end
    local function SwipeTouchEventEasyGameOver(event)
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        local phase = event.phase
            if "began" == phase then
            elseif "moved" == phase then
            elseif "ended" == phase or "cancelled" == phase then
                local sql = [[UPDATE UserRecordsEasy SET Score = 0 WHERE id = 1]]
                db:exec(sql)
                if event.xStart > event.x and swipeLengthX > 50 then 
                    print("Swiped Left")
                    Runtime:removeEventListener("touch",SwipeTouchEventEasyGameOver)
                    transition.to(CharacterOverlayEasy,{x = _W*0.1,time = 300,onComplete = function()
                        composer.gotoScene("RebounceEasy2")
                     end})
                elseif event.xStart < event.x and swipeLengthX > 50 then 
                    print( "Swiped Right" )
                    Runtime:removeEventListener("touch",SwipeTouchEventEasyGameOver)
                    for u in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
                        if(u.Highscore < u.Score) then
                            local sql = [[UPDATE UserRecordsEasy SET Highscore = ]]..u.Score..[[ WHERE id = 1]]
                            db:exec(sql)
                        end
                    end
                        transition.to(CharacterOverlayEasy,{x = _W*0.7,time = 300,onComplete = function()
                            composer.gotoScene("RebounceEasy")
                        end})
                    end
                end
            end
            function GameOverEasySequenceSeq()
                Runtime:addEventListener("touch",SwipeTouchEventEasyGameOver)
                GameOverEasy = true
                LockDownEasy = true
                audio.stop()
                audio.dispose()
                OverlayBackgroundGameOver = display.newImage("BackgroundGameOver.png",0,0)
                OverlayBackgroundGameOver.anchorX = 0
                OverlayBackgroundGameOver.anchorY = 0
                OverlayBackgroundGameOver.width = _W
                OverlayBackgroundGameOver.height = _H
                OverlayBackgroundGameOver.alpha = 0
                groupEasy:insert(OverlayBackgroundGameOver)
                transition.to(OverlayBackgroundGameOver,{alpha=1,time = 1000})                    
                for n in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
                if(n.Highscore < n.Score) then
                    local HighScoreEasy = display.newText( "个人纪录： "..tostring(n.Score).."(破纪录！）",_W*0.5,_H*0.18,"HappyZcool",50)
                    HighScoreEasy.anchorX = 0.5
                    HighScoreEasy.anchorY = 0.5
                    HighScoreEasy.alpha = 0
                    HighScoreEasy:setFillColor(0,36/255,115/255)
                    groupEasy:insert(HighScoreEasy)
                    transition.to(HighScoreEasy,{alpha=1,time = 1000})
                else
                    local HighScoreEasy = display.newText( "个人纪录： "..tostring(n.Highscore),_W*0.5,_H*0.18,"HappyZcool",50)
                    HighScoreEasy.anchorX = 0.5
                    HighScoreEasy.anchorY = 0.5
                    HighScoreEasy.alpha = 0
                    HighScoreEasy:setFillColor(0,36/255,115/255)
                    groupEasy:insert(HighScoreEasy)
                    transition.to(HighScoreEasy,{alpha=1,time = 1000})
                end
                local optionsCOE =
                {
                    width = 195,
                    height = 135,
                    numFrames = 8,
                    sheetContentWidth = 1560,  
                    sheetContentHeight = 135  
                }
                local CharacterOverlayEasyImagesheet = graphics.newImageSheet( "Character.png", optionsCOE )
                local sequenceDataCOE=
                {
                    name="CharacterOverlay",
                    start=1,
                    count=8,
                    time=1000,
                    loopCount = 0,   
                    loopDirection = "forward"    
                }
                CharacterOverlayEasy = display.newSprite( CharacterOverlayEasyImagesheet, sequenceDataCOE)
                CharacterOverlayEasy.anchorX = 0
                CharacterOverlayEasy.anchorY = 0
                CharacterOverlayEasy.x = _W*0.37
                CharacterOverlayEasy.y = _H*0.47
                CharacterOverlayEasy.alpha = 0
                CharacterOverlayEasy:scale(1,1)
                CharacterOverlayEasy:play()
                groupEasy:insert(CharacterOverlayEasy)
                transition.to(CharacterOverlayEasy,{alpha = 1,time = 1000})
            end
        end
            function GameOverEasySequence() 
                print("Timer123 Triggered")
                transition.to(CharacterLostEasy,{alpha = 0,time = 600,onComplete=GameOverEasySequenceSeq})
            end
    function GameOverEasySequenceEnd()
        for n in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
            audioLaserEasy = audio.play(LaserSound)
            LaserBeamTurretEasy.alpha = 0
            CharacterLostEasy = display.newImage("FinalCharacter.png",_W*0.36,_H*0.45)
            CharacterLostEasy.anchorX = 0
            CharacterLostEasy.anchorY = 0
            CharacterLostEasy.alpha = 0
            groupEasy:insert(CharacterLostEasy)
            castRay(_W*0.17,_H*0.285,_W*0.48,_H*0.48)
            CharacterEasy:pause()
            CharacterEasy:setSequence(1)
            transition.dissolve(CharacterEasy,CharacterLostEasy,1000,300)
            Timer1Easy = timer.performWithDelay(1000,LostEasyGO,1) 
    end
    end
    function LostEasyGO()
        if(Timer1Easy ~= nil) then
            timer.cancel(Timer1Easy)
        end
        if(Timer2Easy ~= nil) then
            timer.cancel(Timer2Easy)
        end
        audio.stop()
        GameOverEasySequenceSeq()
    end
    local startTime = system.getTimer()  
    local seconds = 0
    for n in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
        TimeCalculationEasy = n.Time*1000
        Timer2Easy = timer.performWithDelay(TimeCalculationEasy,GameOverEasySequenceEnd,1)
    end  
    local optionsCE =
    {
        width = 195,
        height = 135,
        numFrames = 8,
        sheetContentWidth = 1560,  
        sheetContentHeight = 135  
    }
    local CharacterEasyImagesheet = graphics.newImageSheet( "Character.png", optionsCE )
    local sequenceDataCE=
    {
        name="Character",
        start=1,
        count=8,
        time=1000,
        loopCount = 0,   
        loopDirection = "forward"    
    }
    CharacterEasy = display.newSprite( CharacterEasyImagesheet, sequenceDataCE)
    CharacterEasy.anchorX = 0
    CharacterEasy.anchorY = 0
    CharacterEasy.x = _W*0.36
    CharacterEasy.y = _H*0.45
    CharacterEasy:scale(1,1)
    CharacterEasy:play()
    groupEasy:insert(CharacterEasy)
    function SWTEECheck(WrongIndex)
        print("Transiting")
        for i in db:nrows("SELECT * FROM UserRecordsEasy WHERE id = 1") do
            if(WrongIndex == Wrong and WrongIndex ~= WrongIndexBefore and rScoreBefore == 0) then
                local rScore = i.Score + 1
                local sql = [[UPDATE UserRecordsEasy SET Score = ]]..rScore..[[ WHERE id = 1]]
                db:exec(sql)
                if(i.Time > 10.6) then
                    local h = i.Time - 0.7
                    local sql = [[UPDATE UserRecordsEasy SET Time = ]]..h..[[ WHERE id = 1]]
                    db:exec(sql)
               end
               local l = i.Sequence + 1
               print("Sequence A: "..l..", "..WrongIndex.." = "..WrongIndexBefore)
                local sql = [[UPDATE UserRecordsEasy SET Sequence = ]]..l..[[ WHERE id = 1]]
                db:exec(sql)
                if(WrongIndex == 1) then
                transition.to(CharacterEasy,{time = 300, x = _W*0.15,onComplete = function() 
                    CharacterEasy.isVisible = false
                    composer.gotoScene( "RebounceEasy" )
                end})
            elseif(WrongIndex == 2) then
                transition.to(CharacterEasy,{time = 300, x = _W*0.75,onComplete = function()
                    CharacterEasy.isVisible = false
                    composer.gotoScene( "RebounceEasy" )
                end})
            elseif(WrongIndex == 3) then
                transition.to(CharacterEasy,{time = 300, y = _H*0.25,onComplete = function() 
                    CharacterEasy.isVisible = false
                    composer.gotoScene( "RebounceEasy" )
                end})
            elseif(WrongIndex == 4) then
                transition.to(CharacterEasy,{time = 300, y = _H*0.65,onComplete = function() 
                    CharacterEasy.isVisible = false
                    composer.gotoScene( "RebounceEasy" )
                end})
            end
            elseif(WrongIndex == 1 and WrongIndex ~= Wrong) then
                transition.to(CharacterEasy,{time = 300, x = _W*0.15,onComplete = function() 
                    CharacterEasy.isVisible = false
                    print("Transt1")
                    LostEasyGO()
                end})
            elseif(WrongIndex == 2 and WrongIndex ~= Wrong) then
                transition.to(CharacterEasy,{time = 300, x = _W*0.75,onComplete = function()
                    CharacterEasy.isVisible = false
                    print("Transt2")
                    LostEasyGO()
                end})
            elseif(WrongIndex == 3 and WrongIndex ~= Wrong) then
                transition.to(CharacterEasy,{time = 300, y = _H*0.25,onComplete = function() 
                    CharacterEasy.isVisible = false
                    print("Transt3")
                    LostEasyGO()
                end})
            elseif(WrongIndex == 4 and WrongIndex ~= Wrong) then
                transition.to(CharacterEasy,{time = 300, y = _H*0.65,onComplete = function() 
                    CharacterEasy.isVisible = false
                    print("Transt4")
                    LostEasyGO()
                end})
            end
        end
        WrongIndexBefore = WrongIndex
        rScoreBefore = rScore
    end
    function SwipeTouchEventEasy(event)
        print("Touched")  
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        print("X:"..swipeLengthX)
        print("Y:"..swipeLengthY)
        local phase = event.phase
        if "ended" == phase or "cancelled" == phase then
            if(swipeLengthX > swipeLengthY) then
            if event.xStart > event.x and swipeLengthX > 100 and LockDownEasy == false then 
                print("Swiped Left")
                print("X:"..swipeLengthX)
                SWTEECheck(1)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
            elseif event.xStart < event.x and swipeLengthX > 100 and LockDownEasy == false  then 
                print( "Swiped Right" )
                print("X:"..swipeLengthX)
                SWTEECheck(2)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
            end
        end
        elseif(swipeLengthX<swipeLengthY)then
            if event.yStart > event.y and swipeLengthY > 100 and LockDownEasy == false then
                print("Swiped Up")
                print("Y:"..swipeLengthY)
                SWTEECheck(3)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
            elseif event.yStart < event.y and swipeLengthY > 100 and LockDownEasy == false then
                print("Swiped Down")
                print("Y:"..swipeLengthY)
                SWTEECheck(4)
                Runtime:removeEventListener("touch",SwipeTouchEvent)
            end 
        end
    end
    groupEasy:insert(beamGroup)
    Runtime:addEventListener("touch",SwipeTouchEventEasy)
    print("--------------------End of Scene-------------------")
end
function scene:show( event )
end
function scene:hide( event )
    audio.stop()
    if(Timer1Easy ~= nil) then
            timer.cancel(Timer1Easy)
        end
        if(Timer2Easy ~= nil) then
            timer.cancel(Timer2Easy)
        end
    composer.removeScene("Easy")
end

function scene:destroy( event )

   
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene