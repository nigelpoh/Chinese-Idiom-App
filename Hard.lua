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
LockDownHard = false
OTSBoolEasy = false
local groupHard = self.view
local groupBackingHard = display.newGroup()
local GameOverHard = false
LaserSound = audio.loadSound( "laser.wav" )
local beamGroup = display.newGroup()
local t = os.date( '*t' )
StorageSeconds = t.sec
local function castRay( startX, startY, endX, endY )
    if GameOverHard == false then
        local beam1 = display.newLine( beamGroup, startX, startY, endX, endY )
        beam1.strokeWidth = 15 ; 
        beam1:setStrokeColor( 1, 0, 0, 1 ) ; 
        beam1.blendMode = "add" ; 
        beam1:toBack()
        transition.to( beamGroup, { time=800, delay=400, alpha=0, onComplete=resetBeams } )
    end
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
local tablesetup = [[CREATE TABLE IF NOT EXISTS UserRecordsHard (id INTEGER PRIMARY KEY, Sequence INTEGER, Score INTEGER DEFAULT 0, Time FLOAT DEFAULT 15, Highscore INTEGER DEFAULT 0);]]
db:exec( tablesetup )
local SequenceSetUp = [[CREATE TABLE IF NOT EXISTS SequenceHard (id INTEGER PRIMARY KEY, SequenceNumber INTEGER);]]
db:exec( SequenceSetUp )
function ChangeHard()
    local sql1 = [[DELETE FROM SequenceHard]]
    db:exec(sql1)
    local sql = [[CREATE TABLE IF NOT EXISTS SequenceHard (id INTEGER PRIMARY KEY, SequenceNumber INTEGER);]]
    db:exec( sql )
    for k = 1,10 do
        local sql = [[INSERT INTO SequenceHard(SequenceNumber) VALUES(']]..Sequence[k]..[[')]]
        db:exec(sql)
    end
    print("Here")
    local sql = [[UPDATE UserRecordsHard SET Sequence = 1 WHERE id = 1]]
    db:exec(sql)
end
for i in db:nrows("SELECT Sequence AS row2 FROM UserRecordsHard WHERE id = 1") do
    for j in db:nrows("SELECT COUNT(id) AS row FROM SequenceHard") do
    if(i.row2 == j.row) then
        for k = 1,10 do
            table.insert(Sequence,k)
        end
        shuffleTable(Sequence)
        print(table.concat(Sequence," ,"))
        ChangeHard()
    elseif (i.row2 < j.row) then
        
end
end
end
for i in db:nrows("SELECT COUNT(id) AS row2 FROM UserRecordsHard") do
for j in db:nrows("SELECT COUNT(id) AS row FROM SequenceHard") do
    print("X")
    if(j.row == 0 and i.row2 == 0) then
        local sql = [[INSERT INTO UserRecordsHard(Sequence) VALUES(1)]]
        db:exec(sql)
        for k = 1,10 do
            table.insert(Sequence,k)
        end
        print(table.concat(Sequence))
        shuffleTable(Sequence)
        for k = 1,10 do
            print(Sequence[k])
            local sql = [[INSERT INTO SequenceHard(SequenceNumber) VALUES(']]..Sequence[k]..[[')]]
            db:exec(sql)
        end
    end
end
end
arrayHard = {"Correct1","Correct2","Correct3","Wrong"}
shuffleTable(arrayHard)
local Wrong = table.indexOf( arrayHard, "Wrong" )
BackgroundHard = display.newImageRect("Background.png",_W,_H)
BackgroundHard.x = 0
    BackgroundHard.y = 0
    BackgroundHard.anchorX = 0
    BackgroundHard.anchorY = 0
    groupBackingHard:insert(BackgroundHard)
    groupHard:insert(BackgroundHard)
    ScoreHard = display.newImage("ScoreBoardHard.png",_W*0.25,_H*0.0001)
    ScoreHard.anchorX = 0
    ScoreHard.anchorY = 0
    groupBackingHard:insert(ScoreHard)
    ScoreHard:scale(0.62,0.62)
    groupHard:insert(ScoreHard)
    turretHard = display.newImage("turret.png",_W*0.22,_H*0.26)
    turretHard.anchorX = 0
    turretHard.anchorY = 0 
    turretHard:scale(0.5,0.5)
    turretHard:rotate(135)
    groupBackingHard:insert(turretHard)
    groupHard:insert(turretHard)
    for i in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
            PointsHard = display.newText(i.Score,_W*0.52,_H*0.125,"HappyZcool",100)
            PointsHard.anchorX = 0.5
            PointsHard.anchorY = 0.5
            groupHard:insert(PointsHard)
    end
    for j in db:nrows("SELECT Sequence AS row FROM UserRecordsHard") do
        jj = j.row
    end
    for i in db:nrows("SELECT SequenceNumber AS row FROM SequenceHard WHERE id = "..jj) do
        print(i.row)
        for z in db2:nrows("SELECT * FROM Hard WHERE ID = "..i.row) do  
            print("Wrong: "..tostring(Wrong))
            Word1Hard = display.newText(z[arrayHard[1]],_W*0.02,_H*0.41,_W*0.1,_H,native.systemFont,40)
            Word1Hard.anchorX = 0
            Word1Hard.anchorY = 0
            groupBackingHard:insert(Word1Hard)
            groupHard:insert(Word1Hard)
            Word2Hard = display.newText(z[arrayHard[2]],_W*0.87,_H*0.41,_W*0.1,_H,native.systemFont,40)
            Word2Hard.anchorX = 0
            Word2Hard.anchorY = 0
            groupBackingHard:insert(Word2Hard)
            groupHard:insert(Word2Hard)
            Word3Hard = display.newText(z[arrayHard[3]],_W*0.37,_H*0.22,native.systemFont,40)
            Word3Hard.anchorX = 0
            Word3Hard.anchorY = 0
            groupBackingHard:insert(Word3Hard)
            groupHard:insert(Word3Hard)
            Word4Hard = display.newText(z[arrayHard[4]],_W*0.37,_H*0.73,native.systemFont,40)
            Word4Hard.anchorX = 0
            Word4Hard.anchorY = 0
            groupBackingHard:insert(Word4Hard)
            groupHard:insert(Word4Hard)
            optionsQuestionHard = {
            text = "找出不"..z.Category.."的成语。",
            x = _W*0.05,
            y = _H*0.8,
            width = _W*0.9,
            height = _H*0.3,
            font = native.systemFont,
            fontSize = 30,
            align = "center"
        }
            QuestionHard = display.newText(optionsQuestionHard)
            QuestionHard.anchorX = 0
            QuestionHard.anchorY = 0
            groupBackingHard:insert(QuestionHard)
            groupHard:insert(QuestionHard)
        end
    end
    for k in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
        local optionsTurret =
            {
                width = 64,
                height = 64,
                numFrames = 10,
                sheetContentWidth = 640,  
                sheetContentHeight = 64  
            }
        local LaserBeamTurretHardImagesheet = graphics.newImageSheet( "LaserBeamTurret.png", optionsTurret )
        local sequenceDataTurret=
            {
                name="LaserBeamTurret",
                start=1,
                count=10,
                time=k.Time*1000,
                loopCount = 1,   
                loopDirection = "forward"    
            }
        LaserBeamTurretHard = display.newSprite( LaserBeamTurretHardImagesheet, sequenceDataTurret)
        LaserBeamTurretHard.anchorX = 0.5
        LaserBeamTurretHard.anchorY = 0.5
        LaserBeamTurretHard.x = _W*0.195
        LaserBeamTurretHard.y = _H*0.295
        LaserBeamTurretHard:scale(1,1)
        LaserBeamTurretHard:play()
        groupBackingHard:insert(LaserBeamTurretHard)
        groupHard:insert(LaserBeamTurretHard)
    end
   function GameOverHardSequenceSeq()
        Runtime:addEventListener("touch",SwipeTouchEventHardGameOver)
        GameOverHard = true
        LockDownHard = true
        OverlayBackgroundGameOver = display.newImage("BackgroundGameOver.png",0,0)
        OverlayBackgroundGameOver.anchorX = 0
        OverlayBackgroundGameOver.anchorY = 0
        OverlayBackgroundGameOver.width = _W
        OverlayBackgroundGameOver.height = _H
        OverlayBackgroundGameOver.alpha = 0
        groupHard:insert(OverlayBackgroundGameOver)
        transition.to(OverlayBackgroundGameOver,{alpha=1,time = 1000})                    
        for n in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
            if(n.Highscore < n.Score) then
                local HighScoreHard = display.newText( "个人纪录： "..tostring(n.Score).."(破纪录！）",_W*0.5,_H*0.18,"HappyZcool",50)
                HighScoreHard.anchorX = 0.5
                HighScoreHard.anchorY = 0.5
                HighScoreHard.alpha = 0
                HighScoreHard:setFillColor(0,36/255,115/255)
                groupHard:insert(HighScoreHard)
                transition.to(HighScoreHard,{alpha=1,time = 1000})
            else
                local HighScoreHard = display.newText( "个人纪录： "..tostring(n.Highscore),_W*0.5,_H*0.18,"HappyZcool",50)
                HighScoreHard.anchorX = 0.5
                HighScoreHard.anchorY = 0.5
                HighScoreHard.alpha = 0
                HighScoreHard:setFillColor(0,36/255,115/255)
                groupHard:insert(HighScoreHard)
                transition.to(HighScoreHard,{alpha=1,time = 1000})
            end
            local optionsCOE =
            {
                width = 195,
                height = 135,
                numFrames = 8,
                sheetContentWidth = 1560,  
                sheetContentHeight = 135  
            }
            local CharacterOverlayHardImagesheet = graphics.newImageSheet( "Character.png", optionsCOE )
            local sequenceDataCOE=
            {
                name="CharacterOverlay",
                start=1,
                count=8,
                time=1000,
                loopCount = 0,   
                loopDirection = "forward"    
            }
            CharacterOverlayHard = display.newSprite( CharacterOverlayHardImagesheet, sequenceDataCOE)
            CharacterOverlayHard.anchorX = 0
            CharacterOverlayHard.anchorY = 0
            CharacterOverlayHard.x = _W*0.37
            CharacterOverlayHard.y = _H*0.47
            CharacterOverlayHard.alpha = 0
            CharacterOverlayHard:scale(1,1)
            CharacterOverlayHard:play()
            groupHard:insert(CharacterOverlayHard)
            transition.to(CharacterOverlayHard,{alpha = 1,time = 1000})
        end
    end
    function GameOverHardSequence() 
        print("Timer123 Triggered")
        transition.to(CharacterLostHard,{alpha = 0,time = 600,onComplete=GameOverHardSequenceSeq})
    end
    function GameOverHardSequenceEnd()
      if(OTSBoolEasy == false) then
            audioLaserHard = audio.play(LaserSound)
            LaserBeamTurretHard.alpha = 0
            CharacterLostHard = display.newImage("FinalCharacter.png",_W*0.36,_H*0.45)
            CharacterLostHard.anchorX = 0
            CharacterLostHard.anchorY = 0
            CharacterLostHard.alpha = 0
            groupHard:insert(CharacterLostHard)                
            castRay(_W*0.17,_H*0.285,_W*0.48,_H*0.48)
            CharacterHard:pause()
            CharacterHard:setSequence(1)
            transition.dissolve(CharacterHard,CharacterLostHard,1000,300) 
            Timer1Hard = timer.performWithDelay(1000,LostHardGO,1)
        end
    end
    function LostHardGO()
        if(Timer1Hard ~= nil) then
            timer.cancel(Timer1Hard)
        end
        if(Timer2Hard ~= nil) then
            timer.cancel(Timer2Hard)
        end
        audio.stop()
        OTSBoolEasy = true
        Runtime:removeEventListener("touch",SwipeTouchEventHard)
        GameOverHardSequenceSeq()
    end
    for n in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
        TimeCalculation = n.Time*1000
        print("TimeCalculation: "..TimeCalculation)
        Timer2Hard = timer.performWithDelay(TimeCalculation,GameOverHardSequenceEnd,1)
    end
    local optionsCE =
    {
        width = 195,
        height = 135,
        numFrames = 8,
        sheetContentWidth = 1560,  
        sheetContentHeight = 135  
    }
    local CharacterHardImagesheet = graphics.newImageSheet( "Character.png", optionsCE )
    local sequenceDataCE=
    {
        name="Character",
        start=1,
        count=8,
        time=1000,
        loopCount = 0,   
        loopDirection = "forward"    
    }
    CharacterHard = display.newSprite( CharacterHardImagesheet, sequenceDataCE)
    CharacterHard.anchorX = 0
    CharacterHard.anchorY = 0
    CharacterHard.x = _W*0.36
    CharacterHard.y = _H*0.45
    CharacterHard:scale(1,1)
    CharacterHard:play()
    groupHard:insert(CharacterHard)
    function SWTEEDCheck(WrongIndex)
        print("Transiting")
        for i in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
            if(WrongIndex == Wrong and WrongIndex ~= WrongIndexBefore and rScoreBefore == 0) then
                local rScore = i.Score + 1
                local sql = [[UPDATE UserRecordsHard SET Score = ]]..rScore..[[ WHERE id = 1]]
                db:exec(sql)
                if(i.Time > 10.6) then
                    local h = i.Time - 0.7
                    local sql = [[UPDATE UserRecordsHard SET Time = ]]..h..[[ WHERE id = 1]]
                    db:exec(sql)
               end
               local l = i.Sequence + 1
               print("Sequence A: "..l..", "..WrongIndex.." = "..WrongIndexBefore)
                local sql = [[UPDATE UserRecordsHard SET Sequence = ]]..l..[[ WHERE id = 1]]
                db:exec(sql)
                if(WrongIndex == 1) then
                transition.to(CharacterHard,{time = 300, x = _W*0.15,onComplete = function() 
                    CharacterHard.isVisible = false
                    composer.gotoScene( "RebounceHard" )
                end})
            elseif(WrongIndex == 2) then
                transition.to(CharacterHard,{time = 300, x = _W*0.75,onComplete = function()
                    CharacterHard.isVisible = false
                    composer.gotoScene( "RebounceHard" )
                end})
            elseif(WrongIndex == 3) then
                transition.to(CharacterHard,{time = 300, y = _H*0.25,onComplete = function() 
                    CharacterHard.isVisible = false
                    composer.gotoScene( "RebounceHard" )
                end})
            elseif(WrongIndex == 4) then
                transition.to(CharacterHard,{time = 300, y = _H*0.65,onComplete = function() 
                    CharacterHard.isVisible = false
                    composer.gotoScene( "RebounceHard" )
                end})
            end
            elseif(WrongIndex == 1 and WrongIndex ~= Wrong) then
                transition.to(CharacterHard,{time = 300, x = _W*0.15,onComplete = function() 
                    CharacterHard.isVisible = false
                    print("Transt1")
                    LostHardGO()
                end})
            elseif(WrongIndex == 2 and WrongIndex ~= Wrong) then
                transition.to(CharacterHard,{time = 300, x = _W*0.75,onComplete = function()
                    CharacterHard.isVisible = false
                    print("Transt2")
                    LostHardGO()
                end})
            elseif(WrongIndex == 3 and WrongIndex ~= Wrong) then
                transition.to(CharacterHard,{time = 300, y = _H*0.25,onComplete = function() 
                    CharacterHard.isVisible = false
                    print("Transt3")
                    LostHardGO()
                end})
            elseif(WrongIndex == 4 and WrongIndex ~= Wrong) then
                transition.to(CharacterHard,{time = 300, y = _H*0.65,onComplete = function() 
                    CharacterHard.isVisible = false
                    print("Transt4")
                    LostHardGO()
                end})
            end
        end
        WrongIndexBefore = WrongIndex
        rScoreBefore = rScore
    end
    function SwipeTouchEventHardGameOver(event)
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        local phase = event.phase
            if "began" == phase then
            elseif "moved" == phase then
            elseif "ended" == phase or "cancelled" == phase then
                local sql = [[UPDATE UserRecordsHard SET Score = 0 WHERE id = 1]]
                db:exec(sql)
                local sql2 = [[UPDATE UserRecordsHard SET SequenceWithinSequence = 1 WHERE id = 1]]
                db:exec(sql2)
                if event.xStart > event.x and swipeLengthX > 50 then 
                    print("Swiped Left")
                    Runtime:removeEventListener("touch",SwipeTouchEventHardGameOver)
                    transition.to(CharacterOverlayHard,{x = _W*0.1,time = 300,onComplete = function()
                        composer.gotoScene("RebounceHard2")
                     end})
                elseif event.xStart < event.x and swipeLengthX > 50 then 
                    print( "Swiped Right" )
                    Runtime:removeEventListener("touch",SwipeTouchEventHardGameOver)
                    for u in db:nrows("SELECT * FROM UserRecordsHard WHERE id = 1") do
                        if(u.Highscore < u.Score) then
                            local sql = [[UPDATE UserRecordsHard SET Highscore = ]]..u.Score..[[ WHERE id = 1]]
                            db:exec(sql)
                        end
                    end
                        transition.to(CharacterOverlayHard,{x = _W*0.7,time = 300,onComplete = function()
                            composer.gotoScene("RebounceHard")
                        end})
                    end
                end
            end
    function SwipeTouchEventHard(event)
        print("Touched")  
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        local phase = event.phase
        if "ended" == phase or "cancelled" == phase then
            if(swipeLengthX > swipeLengthY) then
            if event.xStart > event.x and swipeLengthX > 100 and LockDownHard == false then 
                print("Swiped Left")
                print("X:"..swipeLengthX)
                SWTEEDCheck(1)
            elseif event.xStart < event.x and swipeLengthX > 100 and LockDownHard == false  then 
                print( "Swiped Right" )
                print("X:"..swipeLengthX)
                SWTEEDCheck(2)
            end
        end
        elseif(swipeLengthX<swipeLengthY)then
            if event.yStart > event.y and swipeLengthY > 100 and LockDownHard == false then
                print("Swiped Up")
                print("Y:"..swipeLengthY)
                SWTEEDCheck(3)
            elseif event.yStart < event.y and swipeLengthY > 100 and LockDownHard == false then
                print("Swiped Down")
                print("Y:"..swipeLengthY)
                SWTEEDCheck(4)
            end 
        end
    end
    groupHard:insert(beamGroup)
    Runtime:addEventListener("touch",SwipeTouchEventHard)
    
     print("--------------------End of Scene-------------------")
end
function scene:show( event )
end
function scene:hide( event )
    if(Timer1Hard ~= nil) then
        timer.cancel(Timer1Hard)
    end
    if(Timer2Hard ~= nil) then
        timer.cancel(Timer2Hard)
    end
    composer.removeScene("Hard")
end
function scene:destroy( event )
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene