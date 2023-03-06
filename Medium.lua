local composer = require( "composer" )
local widget = require( "widget" )
local sqlite = require("sqlite3")
local scene = composer.newScene()
_W = display.viewableContentWidth
_H = display.viewableContentHeight
function scene:create( event )
local groupMedium = self.view
SmallestTimeMedium = 30
AlreadySetTo1 = nil
WrongIndexBeforeMedium = 0
rScoreBeforeMed = 0
CorrectMedium = 0
CorrettaMedio = {}
LockDownMedium = false
arrayMedium = {}
WrongBool = nil
SentenceMed = ""
FirstHalfMed = ""
SecondHalfMed = ""
RepetitionMed = nil
RepetitionPair = {}
local GameOverMedium = false
LaserSound = audio.loadSound( "laser.wav" )
local beamGroup = display.newGroup()
local t = os.date( '*t' )
StorageSeconds = t.sec
local function castRay( startX, startY, endX, endY )
    local beam1 = display.newLine( beamGroup, startX, startY, endX, endY )
    beam1.strokeWidth = 15 ; 
    beam1:setStrokeColor( 1, 0, 0, 1 ) ; 
    beam1.blendMode = "add" ; 
    beam1:toBack()
    transition.to( beamGroup, { time=800, delay=400, alpha=0, onComplete=resetBeams } )
end
math.randomseed( os.time() )
local path2 = system.pathForFile("Levels.sqlite",system.ResourceDirectory)
db2Medium = sqlite.open(path2)
local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
dbMedium = sqlite.open( path )   
local tablesetup = [[CREATE TABLE IF NOT EXISTS UserRecordsMedium (id INTEGER PRIMARY KEY, Sequence INTEGER, Score INTEGER DEFAULT 0, Time FLOAT DEFAULT 40.0, Highscore INTEGER DEFAULT 0,SequenceWithinSequence DEFAULT 1);]]
dbMedium:exec( tablesetup )
local SequenceSetUp = [[CREATE TABLE IF NOT EXISTS SequenceMedium (id INTEGER PRIMARY KEY, SequenceNumber INTEGER, SequenceBoolean TEXT);]]
dbMedium:exec( SequenceSetUp )
if event.type == "applicationExit" then
    local sql = [[UPDATE UserRecordsMedium SET Score = 0 WHERE id = 1]]
    dbMedium:exec(sql)
    local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
    dbMedium = sqlite.open( path ) 
end
function UpdateTableMedium()
    print("AXX")
    dbMedium:close()
    local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
    dbMedium = sqlite.open( path )   
end
for i in db2Medium:nrows("SELECT COUNT(*) AS x FROM Medium") do
    MaxLimitMed = i.x
end
function string:split( inSplitPattern, outResults )

   if not outResults then
      outResults = {}
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( self, theStart ) )
   return outResults
end
function InputCheck()
    for i in dbMedium:nrows("SELECT Sequence FROM UserRecordsMedium WHERE id = 1") do
        for j in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
            for k in db2Medium:nrows("SELECT * FROM Medium WHERE id = "..j.SequenceNumber) do
                SplitStringMed = {}
                RepetitionPair = {}
                if(WrongBool == "false") then
                    SplitStringMed[1] = k.Correct1.." Correct1"
                    SplitStringMed[2] = k.Correct2.." Correct2"
                    SplitStringMed[3] = k.Correct3.." Correct3"
                    SplitStringMed[4] = k.Correct4.." Correct4"
                    for i = 1,#SplitStringMed do
                        for j = 1,#SplitStringMed do
                            local xyz = string.gsub(SplitStringMed[i],"%a","")
                            xyz = string.gsub(xyz,"%d","")
                            xyz = string.gsub(xyz," ","")
                            if(table.indexOf(SplitStringMed,xyz.." Correct"..j) ~= nil) then
                                iasd = #RepetitionPair + 1
                                RepetitionPair[iasd] = {}
                                RepetitionPair[iasd][1] = "Correct"..table.indexOf(SplitStringMed,xyz.." Correct"..j)
                                local mxz = SplitStringMed[i]:split(" ")
                                RepetitionPair[iasd][2] = mxz[2]
                            end
                        end
                    end
                elseif(WrongBool == "true") then
                    if(k.Indices == 1) then
                        SplitStringMed[1] = k.Wrong.." Wrong"
                        SplitStringMed[2] = k.Correct2.." Correct2"
                        SplitStringMed[3] = k.Correct3.." Correct3"
                        SplitStringMed[4] = k.Correct4.." Correct4"
                    elseif(k.Indices == 2) then
                        SplitStringMed[1] = k.Correct1.." Correct1"
                        SplitStringMed[2] = k.Wrong.." Wrong"
                        SplitStringMed[3] = k.Correct3.." Correct3"
                        SplitStringMed[4] = k.Correct4.." Correct4"
                    elseif(k.Indices == 3) then
                        SplitStringMed[1] = k.Correct1.." Correct1"
                        SplitStringMed[2] = k.Correct2.." Correct2"
                        SplitStringMed[3] = k.Wrong.." Wrong"
                        SplitStringMed[4] = k.Correct4.." Correct4"
                    elseif(k.Indices == 4) then
                        SplitStringMed[1] = k.Correct1.." Correct1"
                        SplitStringMed[2] = k.Correct2.." Correct2"
                        SplitStringMed[3] = k.Correct3.." Correct3"
                        SplitStringMed[4] = k.Wrong.." Wrong"
                    end
                    for i = 1,#SplitStringMed do
                        for j = 1,#SplitStringMed do
                            local xyz = string.gsub(SplitStringMed[i],"%a","")
                            xyz = string.gsub(xyz,"%d","")
                            xyz = string.gsub(xyz," ","")
                            mxz = SplitStringMed[i]:split(" ")
                            if(mxz[2] == "Wrong") then
                            else
                                CheckBoolMedSSM = false
                                for i = 1,#RepetitionPair do
                                    if(table.indexOf(RepetitionPair[i],mxz[2]) ~= nil) then
                                        CheckBoolMedSSM = true
                                    end
                                end
                                if(table.indexOf(SplitStringMed,xyz.." Wrong") ~= nil and  "Wrong" ~= mxz[2] and CheckBoolMedSSM == false) then
                                    iasd = #RepetitionPair + 1
                                    RepetitionPair[iasd] = {}
                                    RepetitionPair[iasd][1] = "Wrong"
                                    RepetitionPair[iasd][2] = mxz[2]
                                end
                                if(table.indexOf(SplitStringMed,xyz.." Correct"..j) ~= nil and "Correct"..table.indexOf(SplitStringMed,xyz.." Correct"..j) ~= mxz[2] and CheckBoolMedSSM == false) then
                                    iasd = #RepetitionPair + 1
                                    RepetitionPair[iasd] = {}
                                    if(table.indexOf(SplitStringMed,xyz.." Correct"..j) ~= nil) then
                                        RepetitionPair[iasd][1] = "Correct"..table.indexOf(SplitStringMed,xyz.." Correct"..j)
                                        RepetitionPair[iasd][2] = mxz[2]
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
function InputCheck2(WrongIndexIC2)
    if(RepetitionPair[1] ~= nil) then
        print("Crossing")
        print(RepetitionPair[1][1] ~= RepetitionPair[1][2])
        print(RepetitionPair[1][1])
        print(RepetitionPair[1][2])
        local Count = 0
        for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
            for j in dbMedium:nrows("SELECT * FROM SequenceMedium WHERE id = "..i.Sequence) do
                for z in db2Medium:nrows("SELECT * FROM Medium WHERE id = "..j.SequenceNumber) do
                    for l in string.gmatch(z.Idiom,z[RepetitionPair[1][1]]) do
                        Count = Count + 1
                    end
                end
            end
        end
        print("Count: "..Count)
        if(Count >= 2) then
            print("Table of RP: "..table.concat(RepetitionPair[1]))
            for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                for j = 1,#RepetitionPair do
                    for k = 1,#RepetitionPair[j] do  
                        print("RepetitionPair[j][k]: "..tostring(RepetitionPair[j][k]))
                        print("arrayMedium[i.SequenceWithinSequence]: "..tostring(arrayMedium[WrongIndexIC2]))
                        print("RepetitionPair[j][k] ~= arrayMedium[i.SequenceWithinSequence]: "..tostring(RepetitionPair[j][k]).." ~= "..tostring(arrayMedium[WrongIndexIC2]))
                        print("--------ALERT--------")
                        print(RepetitionPair[j][k] == arrayMedium[i.SequenceWithinSequence])
                        if(RepetitionPair[j][k] ~= arrayMedium[WrongIndexIC2]) then
                            print("Trying to Pass")
                            if(AlreadySetTo1 == false) then
                                print("Been Here")
                                RepetitionMed = 0
                                if(WrongBool == "true") then
                                    CorrectMedium = table.indexOf(arrayMedium,array2Medium[i.SequenceWithinSequence])
                                elseif(WrongBool == "false") then
                                    local xzy = SplitStringMed[i.SequenceWithinSequence]:split(" ")
                                    CorrectMedium = table.indexOf(arrayMedium,xzy[i.SequenceWithinSequence])
                                end
                            end
                        elseif(RepetitionPair[j][k] == arrayMedium[WrongIndexIC2]) then
                            print("Was Here")
                            RepetitionMed = 1
                            CorrectMedium = "Non Utilizzare Corretta Medio Inglese"
                            CorrettaMedio = RepetitionPair
                            AlreadySetTo1 = true
                        end
                    end
                end        
            end
        elseif(Count < 2) then
            RepetitionMed = 0
            for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                if(WrongBool == "true") then
                    print("i.SequenceWithinSequence: "..i.SequenceWithinSequence)
                    print("array2Medium[i.SequenceWithinSequence]: "..print(array2Medium[i.SequenceWithinSequence]))
                    CorrectMedium = table.indexOf(arrayMedium,array2Medium[i.SequenceWithinSequence])
            elseif(WrongBool == "false") then
                print("IS it here?")
                print("i.SequenceWithinSequence: "..i.SequenceWithinSequence)
                for m in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                    local xzy = SplitStringMed[m.SequenceWithinSequence]:split(" ")
                    print("xzy[i.SequenceWithinSequence]: "..xzy[2])
                    CorrectMedium = table.indexOf(arrayMedium,xzy[2])
                end
                end
            end
        end
    elseif(RepetitionPair[1] == nil) then
        RepetitionMed = 0
        for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
            if(WrongBool == "true") then
                print("array2Medium[i.SequenceWithinSequence]: "..tostring(array2Medium[i.SequenceWithinSequence]))
                CorrectMedium = table.indexOf(arrayMedium,array2Medium[i.SequenceWithinSequence])
            elseif(WrongBool == "false") then
                print("Or here?")
                for m in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                    local xzy = SplitStringMed[m.SequenceWithinSequence]:split(" ")
                    print("xzy[i.SequenceWithinSequence]: "..xzy[2])
                    CorrectMedium = table.indexOf(arrayMedium,xzy[2])
                end
            end
        end
    end
end
function SplitSentenceMedium(Sentence)
    for i in dbMedium:nrows("SELECT Sequence FROM UserRecordsMedium WHERE id = 1") do
        for j in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
            for k in db2Medium:nrows("SELECT Idiom FROM Medium WHERE id = "..j.SequenceNumber) do
                for l in db2Medium:nrows("SELECT Sentence FROM Medium WHERE id = "..j.SequenceNumber) do
                    SentenceMed = l.Sentence
                    local TableSentenceMed = SentenceMed:split(k.Idiom)
                    FirstHalfMed = TableSentenceMed[1]
                    SecondHalfMed = TableSentenceMed[2]
                    print("FirstHalfMed: "..FirstHalfMed.."\n SecondHalfMed: "..SecondHalfMed)
                    return FirstHalfMed,SecondHalfMed
                end
            end
        end
    end
end
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
function ChangeMedium()
    local sql1 = [[DELETE FROM SequenceMedium]]
    dbMedium:exec(sql1)
    local sql = [[CREATE TABLE IF NOT EXISTS SequenceMedium (id INTEGER PRIMARY KEY, SequenceNumber INTEGER);]]
    dbMedium:exec( sql )
    for k = 1,MaxLimitMed do
        local ChooseMed = {true,false}
        shuffleTable(ChooseMed)
        local chosenMed = ChooseMed[1]
        local sql = [[INSERT INTO SequenceMedium(SequenceNumber,SequenceBoolean) VALUES(']]..Sequence[k]..[[',']]..tostring(chosenMed)..[[')]]
        dbMedium:exec(sql)
    end
    print("Here")
    local sql = [[UPDATE UserRecordsMedium SET Sequence = 1 WHERE id = 1]]
    dbMedium:exec(sql)
end
for i in dbMedium:nrows("SELECT Sequence AS row2 FROM UserRecordsMedium WHERE id = 1") do
    for j in dbMedium:nrows("SELECT COUNT(id) AS row FROM SequenceMedium") do
        print("i.row2 == j.row: "..i.row2.." == "..j.row)
        if(i.row2 == j.row) then
            for k = 1,MaxLimitMed do
                table.insert(Sequence,k)
            end
            shuffleTable(Sequence)
            print(table.concat(Sequence," ,"))
            ChangeMedium()
        elseif (i.row2 < j.row) then
            
        end
    end
end
function RowAddition()
        local sql2 = [[INSERT INTO UserRecordsMedium(Sequence) VALUES(1)]]
        dbMedium:exec(sql2)
        for k = 1,MaxLimitMed do
            table.insert(Sequence,k)
        end
        print(table.concat(Sequence))
        shuffleTable(Sequence)
        for k = 1,MaxLimitMed do
            local ChooseMed = {true,false}
            shuffleTable(ChooseMed)
            local chosenMed = ChooseMed[1]
            local sql = [[INSERT INTO SequenceMedium(SequenceNumber,SequenceBoolean) VALUES(']]..Sequence[k]..[[',']]..tostring(chosenMed)..[[')]]
            dbMedium:exec(sql)
        end
    end
for i in dbMedium:nrows("SELECT COUNT(id) AS row2 FROM UserRecordsMedium") do
for j in dbMedium:nrows("SELECT COUNT(id) AS row FROM SequenceMedium") do
    print("j.row: "..j.row.." i.row2: "..i.row2)
    if(j.row == 0 and i.row2 == 0) then
       RowAddition() 
    end
    if(j.row == nil and i.row2 == nil) then
       RowAddition() 
    end
end
end
for j in dbMedium:nrows("SELECT Sequence FROM UserRecordsMedium WHERE id = 1") do
    print("Seq: "..j.Sequence)
    for i in dbMedium:nrows("SELECT SequenceBoolean FROM SequenceMedium WHERE id = "..j.Sequence) do
        WrongBool = i.SequenceBoolean
        InputCheck()
        print("Split: "..table.concat(SplitStringMed,", "))
        print("WrongBool: "..WrongBool)
    end
end
if(WrongBool == "false") then
    arrayMedium = {"Correct1","Correct2","Correct3","Correct4"}
    shuffleTable(arrayMedium)
    print("arrayMedium: "..table.concat(arrayMedium,", "))
elseif(WrongBool == "true") then
    arrayMedium = {"Correct1","Correct2","Correct3","Correct4","Wrong"}
    array2Medium = {"Correct1","Correct2","Correct3","Correct4"}
    for j in dbMedium:nrows("SELECT Sequence FROM UserRecordsMedium WHERE id = 1") do
        print(table.concat(j,", "))
        print("J: "..j.Sequence)
        for mx in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id ="..j.Sequence) do
            for ix in db2Medium:nrows("SELECT Indices AS b FROM Medium WHERE id = "..mx.SequenceNumber) do 
                local string2 = "Correct"..ix.b
                table.remove(arrayMedium,table.indexOf(arrayMedium,string2))
                table.remove(array2Medium,table.indexOf(array2Medium,string2))
                shuffleTable(arrayMedium)
                print("Table 1: "..table.concat( arrayMedium, ", "))
                print("Table 2: "..table.concat(array2Medium,", "))
            end
        end
    end
    print("arrayMedium: "..table.concat(arrayMedium,", "))
end
BackgroundMedium = display.newImageRect("BackgroundMedium.png",_W,_H)
BackgroundMedium.x = 0
    BackgroundMedium.y = 0
    BackgroundMedium.anchorX = 0
    BackgroundMedium.anchorY = 0
    groupMedium:insert(BackgroundMedium)
    ScoreMedium = display.newImage("ScoreBoardMedium.png",_W*0.25,_H*0.0001)
    ScoreMedium.anchorX = 0
    ScoreMedium.anchorY = 0
    ScoreMedium:scale(0.62,0.62)
    groupMedium:insert(ScoreMedium)
    turretMedium = display.newImage("turret.png",_W*0.22,_H*0.26)
    turretMedium.anchorX = 0
    turretMedium.anchorY = 0 
    turretMedium:scale(0.5,0.5)
    turretMedium:rotate(135)
    groupMedium:insert(turretMedium)
    for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
            PointsMedium = display.newText(i.Score,_W*0.52,_H*0.125,"HappyZcool",100)
            PointsMedium.anchorX = 0.5
            PointsMedium.anchorY = 0.5
            groupMedium:insert(PointsMedium)
    end
    print("Went through")
    for j in dbMedium:nrows("SELECT Sequence AS row FROM UserRecordsMedium") do
        print("Went through again")
        jjMed = j.row
        print("jjMed")
        print("jjMed: "..jjMed)
        for i in dbMedium:nrows("SELECT SequenceNumber AS row FROM SequenceMedium WHERE id = "..jjMed) do
            for z in db2Medium:nrows("SELECT * FROM Medium WHERE id = "..i.row) do    
                print("z[arrayMedium[1]]: "..tostring(z[arrayMedium[1]]).."\nz[arrayMedium[2]]: "..tostring(z[arrayMedium[2]]).."\nz[arrayMedium[3]]: "..tostring(z[arrayMedium[3]]).."\nz[arrayMedium[4]]: "..tostring(z[arrayMedium[4]]))
                Word1Medium = display.newText(z[arrayMedium[1]],_W*0.02,_H*0.47,native.systemFont,40)
                Word1Medium.anchorX = 0
                Word1Medium.anchorY = 0
                groupMedium:insert(Word1Medium)
                Word2Medium = display.newText(z[arrayMedium[2]],_W*0.87,_H*0.47,native.systemFont,40)
                Word2Medium.anchorX = 0
                Word2Medium.anchorY = 0
                groupMedium:insert(Word2Medium)
                Word3Medium = display.newText(z[arrayMedium[3]],_W*0.45,_H*0.22,native.systemFont,40)
                Word3Medium.anchorX = 0
                Word3Medium.anchorY = 0
                groupMedium:insert(Word3Medium)
                Word4Medium = display.newText(z[arrayMedium[4]],_W*0.45,_H*0.73,native.systemFont,40)
                Word4Medium.anchorX = 0
                Word4Medium.anchorY = 0
                groupMedium:insert(Word4Medium)
                for j in dbMedium:nrows("SELECT Sequence AS row FROM UserRecordsMedium") do
            print("Went through again")
            jjMed = j.row
            print("jjMed")
            print("jjMed: "..jjMed)
            local SentenceDisplayGroup = display.newGroup()
                    local ReturnVal1SSMMed,ReturnVal2SSMMed = SplitSentenceMedium()
                    FirstHalfSentenceMed = ReturnVal1SSMMed
                    if(WrongBool == "false") then
                        IdiomMidMed = {}
                        for i = 1,4 do
                            IdiomMidMed[i] = "�"
                        end
                    elseif(WrongBool == "true") then
                        IdiomMidMed = {}
                        for k in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                            for l in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..k.Sequence) do
                                for j in db2Medium:nrows("SELECT Indices FROM Medium WHERE id = "..l.SequenceNumber) do
                                    for i = 1,4 do
                                        if(i == j.Indices) then
                                            if(j.Indices == 1) then
                                                for m in db2Medium:nrows("SELECT Correct1 FROM Medium WHERE id = "..l.SequenceNumber) do
                                                    print("A: "..table.maxn(IdiomMidMed))
                                                    local maxnIndex = table.maxn(IdiomMidMed)+1
                                                    IdiomMidMed[maxnIndex] = m.Correct1
                                                end
                                            elseif(j.Indices == 2) then
                                                for m in db2Medium:nrows("SELECT Correct2 FROM Medium WHERE id = "..l.SequenceNumber) do
                                                    print("A: "..table.maxn(IdiomMidMed))
                                                    local maxnIndex = table.maxn(IdiomMidMed)+1
                                                    IdiomMidMed[maxnIndex] = m.Correct2
                                                end
                                            elseif(j.Indices == 3) then
                                                for m in db2Medium:nrows("SELECT Correct3 FROM Medium WHERE id = "..l.SequenceNumber) do
                                                    print("A: "..table.maxn(IdiomMidMed))
                                                    local maxnIndex = table.maxn(IdiomMidMed)+1
                                                    IdiomMidMed[maxnIndex] = m.Correct3
                                                end
                                            elseif(j.Indices == 4) then
                                                for m in db2Medium:nrows("SELECT Correct4 FROM Medium WHERE id = "..l.SequenceNumber) do
                                                    print("A: "..table.maxn(IdiomMidMed))
                                                    local maxnIndex = table.maxn(IdiomMidMed)+1
                                                    IdiomMidMed[maxnIndex] = m.Correct4
                                                end
                                            end
                                        elseif(i ~= j.Indices) then
                                            print("A: "..table.maxn(IdiomMidMed))
                                            local maxnIndex = table.maxn(IdiomMidMed)+1
                                            IdiomMidMed[maxnIndex] = "�"
                                        end
                                    end
                                end
                            end
                        end
                    end
                    SecondHalfSentenceMed = ReturnVal2SSMMed
                end
            end
        end
    end
    function UpdateSentenceMedium()
        if(DisplayingTextMed ~= nil) then
            display.remove(DisplayingTextMed)
        end
        print("Table: "..table.concat(IdiomMidMed))
        optionsDisplayingTextMed = {
            text = tostring(FirstHalfSentenceMed)..tostring(IdiomMidMed[1])..tostring(IdiomMidMed[2])..tostring(IdiomMidMed[3])..tostring(IdiomMidMed[4])..tostring(SecondHalfSentenceMed),
            x = _W*0.05,
            y = _H*0.8,
            width = _W*0.9,
            height = _H*0.19,
            font = native.systemFont,
            fontSize = 25,
            align = "center"
        }
        DisplayingTextMed = display.newText(optionsDisplayingTextMed)
        DisplayingTextMed.anchorX = 0
        DisplayingTextMed.anchorY = 0
        DisplayingTextMed:setFillColor(0.8, 0.9, 0.8)
        groupMedium:insert(DisplayingTextMed)
    end
    UpdateSentenceMedium()
    for k in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
        local optionsTurret =
            {
                width = 64,
                height = 64,
                numFrames = 10,
                sheetContentWidth = 640,  
                sheetContentHeight = 64  
            }
        local LaserBeamTurretMediumImagesheet = graphics.newImageSheet( "LaserBeamTurret.png", optionsTurret )
        local sequenceDataTurret=
            {
                name="LaserBeamTurret",
                start=1,
                count=10,
                time=k.Time*1000,
                loopCount = 1,   
                loopDirection = "forward"    
            }
        LaserBeamTurretMedium = display.newSprite( LaserBeamTurretMediumImagesheet, sequenceDataTurret)
        LaserBeamTurretMedium.anchorX = 0.5
        LaserBeamTurretMedium.anchorY = 0.5
        LaserBeamTurretMedium.x = _W*0.195
        LaserBeamTurretMedium.y = _H*0.295
        LaserBeamTurretMedium:scale(1,1)
        LaserBeamTurretMedium:play()
        groupMedium:insert(LaserBeamTurretMedium)
    end
    local function SwipeTouchEventMediumGameOver(event)
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        local phase = event.phase
            if "began" == phase then
            elseif "moved" == phase then
            elseif "ended" == phase or "cancelled" == phase then
                local sql = [[UPDATE UserRecordsMedium SET Score = 0 WHERE id = 1]]
                dbMedium:exec(sql)
                local sql2 = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                dbMedium:exec(sql2)
                if event.xStart > event.x and swipeLengthX > 50 then 
                    print("Swiped Left")
                    Runtime:removeEventListener("touch",SwipeTouchEventMediumGameOver)
                    transition.to(CharacterOverlayMedium,{x = _W*0.1,time = 300,onComplete = function()
                        composer.gotoScene("RebounceMedium2")
                     end})
                elseif event.xStart < event.x and swipeLengthX > 50 then 
                    print( "Swiped Right" )
                    Runtime:removeEventListener("touch",SwipeTouchEventMediumGameOver)
                    for u in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                        if(u.Highscore < u.Score) then
                            local sql = [[UPDATE UserRecordsMedium SET Highscore = ]]..u.Score..[[ WHERE id = 1]]
                            dbMedium:exec(sql)
                        end
                    end
                        transition.to(CharacterOverlayMedium,{x = _W*0.7,time = 300,onComplete = function()
                            composer.gotoScene("RebounceMedium")
                        end})
                    end
                end
            end
            function GameOverMediumSequenceSeq()
                Runtime:addEventListener("touch",SwipeTouchEventMediumGameOver)
                GameOverMedium = true
                LockDownMedium = true
                audio.stop()
                audio.dispose()
                OverlayBackgroundGameOver = display.newImage("BackgroundGameOver.png",0,0)
                OverlayBackgroundGameOver.anchorX = 0
                OverlayBackgroundGameOver.anchorY = 0
                OverlayBackgroundGameOver.width = _W
                OverlayBackgroundGameOver.height = _H
                OverlayBackgroundGameOver.alpha = 0
                groupMedium:insert(OverlayBackgroundGameOver)
                transition.to(OverlayBackgroundGameOver,{alpha=1,time = 1000})                    
                for n in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                if(n.Highscore < n.Score) then
                    local HighScoreMedium = display.newText( "个人纪录： "..tostring(n.Score).."(破纪录！）",_W*0.5,_H*0.18,"HappyZcool",50)
                    HighScoreMedium.anchorX = 0.5
                    HighScoreMedium.anchorY = 0.5
                    HighScoreMedium.alpha = 0
                    HighScoreMedium:setFillColor(0,36/255,115/255)
                    groupMedium:insert(HighScoreMedium)
                    transition.to(HighScoreMedium,{alpha=1,time = 1000})
                else
                    local HighScoreMedium = display.newText( "个人纪录： "..tostring(n.Highscore),_W*0.5,_H*0.18,"HappyZcool",50)
                    HighScoreMedium.anchorX = 0.5
                    HighScoreMedium.anchorY = 0.5
                    HighScoreMedium.alpha = 0
                    HighScoreMedium:setFillColor(0,36/255,115/255)
                    groupMedium:insert(HighScoreMedium)
                    transition.to(HighScoreMedium,{alpha=1,time = 1000})
                end
                local optionsCOE =
                {
                    width = 195,
                    height = 135,
                    numFrames = 8,
                    sheetContentWidth = 1560,  
                    sheetContentHeight = 135  
                }
                local CharacterOverlayMediumImagesheet = graphics.newImageSheet( "Character.png", optionsCOE )
                local sequenceDataCOE=
                {
                    name="CharacterOverlay",
                    start=1,
                    count=8,
                    time=1000,
                    loopCount = 0,   
                    loopDirection = "forward"    
                }
                CharacterOverlayMedium = display.newSprite( CharacterOverlayMediumImagesheet, sequenceDataCOE)
                CharacterOverlayMedium.anchorX = 0
                CharacterOverlayMedium.anchorY = 0
                CharacterOverlayMedium.x = _W*0.37
                CharacterOverlayMedium.y = _H*0.47
                CharacterOverlayMedium.alpha = 0
                CharacterOverlayMedium:scale(1,1)
                CharacterOverlayMedium:play()
                groupMedium:insert(CharacterOverlayMedium)
                transition.to(CharacterOverlayMedium,{alpha = 1,time = 1000})
            end
        end
            function GameOverMediumSequence() 
                print("Timer123 Triggered")
                transition.to(CharacterLostMedium,{alpha = 0,time = 600,onComplete=GameOverMediumSequenceSeq})
            end
    function GameOverMediumSequenceEnd()
        for n in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
            if(OTSBoolMedium == false) then
                audioLaserMedium = audio.play(LaserSound)
                LaserBeamTurretMedium.alpha = 0
                CharacterLostMedium = display.newImage("FinalCharacter.png",_W*0.36,_H*0.45)
                CharacterLostMedium.anchorX = 0
                CharacterLostMedium.anchorY = 0
                CharacterLostMedium.alpha = 0
                groupMedium:insert(CharacterLostMedium)                
                castRay(_W*0.17,_H*0.285,_W*0.48,_H*0.48)
                CharacterMedium:pause()
                CharacterMedium:setSequence(1)
                transition.dissolve(CharacterMedium,CharacterLostMedium,1000,300) 
                Timer1Medium = timer.performWithDelay(1000,LostMediumGO,1)
            end
        end
    end
    function LostMediumGO()
        if(Timer1Medium ~= nil) then
            timer.cancel(Timer1Medium)
        end
        if(Timer2Medium ~= nil) then
            timer.cancel(Timer2Medium)
        end
        audio.stop()
        GameOverMediumSequenceSeq()
    end
    local startTime = system.getTimer()  
    local seconds = 0
    for n in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
        TimeCalculationMedium = n.Time*1000
        print("TimeCalculationMedium: "..TimeCalculationMedium)
        Timer2Medium = timer.performWithDelay(TimeCalculationMedium,GameOverMediumSequenceEnd,1)
    end
    local optionsCE =
    {
        width = 195,
        height = 135,
        numFrames = 8,
        sheetContentWidth = 1560,  
        sheetContentHeight = 135  
    }
    local CharacterMediumImagesheet = graphics.newImageSheet( "Character.png", optionsCE )
    local sequenceDataCE=
    {
        name="Character",
        start=1,
        count=8,
        time=1000,
        loopCount = 0,   
        loopDirection = "forward"    
    }
    CharacterMedium = display.newSprite( CharacterMediumImagesheet, sequenceDataCE)
    CharacterMedium.anchorX = 0
    CharacterMedium.anchorY = 0
    CharacterMedium.x = _W*0.36
    CharacterMedium.y = _H*0.45
    CharacterMedium:scale(1,1)
    CharacterMedium:play()
    groupMedium:insert(CharacterMedium)
    function SWTEEMCheck(WrongIndex)
        UpdateTableMedium()
        for i in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
            local xas = false 
            AlreadySetTo1 = false
            InputCheck2(WrongIndex)
            print("---------------PRESUMMARY---------------")
            print("CorrectMedium: "..tostring(CorrectMedium))
            print("WrongIndex: "..tostring(WrongIndex))
            print("RepetitionMed: "..RepetitionMed)
            print("---------------END OF PRESUMMARY----------------")
            if(RepetitionMed == 0) then
                if(CorrectMedium == WrongIndex) then
                    xas = true
                end
            elseif(RepetitionMed == 1) then
                if(CorrectMedium == "Non Utilizzare Corretta Medio Inglese") then
                    print("XAS")
                    xas = true
                end
            end
            print("---------------SUMMARY---------------")
            print("i.SequenceWithinSequence: "..i.SequenceWithinSequence)
            print("WrongBool: "..WrongBool)
            print("XAS: "..tostring(xas))
            print("WrongIndex ~= WrongIndexBeforeMedium: ")
            print(WrongIndex ~= WrongIndexBeforeMedium)
            print("rScoreBeforeMed == 0: ")
            print(rScoreBeforeMed == 0)
            print("---------------END OF SUMMARY--------------")
            if(xas == true and WrongIndex ~= WrongIndexBeforeMedium and rScoreBeforeMed == 0) then
                print("rScore In")
                if(i.SequenceWithinSequence == 4 and WrongBool == "false") then
                    print("Flew here")
                    print("rScore Out")
                    local rScore = i.Score + 1
                    local sql = [[UPDATE UserRecordsMedium SET Score = ]]..rScore..[[ WHERE id = 1]]
                    dbMedium:exec(sql)
                    if(i.Time > SmallestTimeMedium) then
                        local h = i.Time - 0.7
                        local sql = [[UPDATE UserRecordsMedium SET Time = ]]..h..[[ WHERE id = 1]]
                        dbMedium:exec(sql)
                   end
                   local l = i.Sequence + 1
                   print("Sequence A: "..l..", "..WrongIndex.." = "..WrongIndexBeforeMedium)
                    local sql = [[UPDATE UserRecordsMedium SET Sequence = ]]..l..[[ WHERE id = 1]]
                    dbMedium:exec(sql)
                elseif(i.SequenceWithinSequence == 3 and WrongBool == "true") then
                    print("Jumped Here")
                    local rScore = i.Score + 1
                    local sql = [[UPDATE UserRecordsMedium SET Score = ]]..rScore..[[ WHERE id = 1]]
                    dbMedium:exec(sql)
                    if(i.Time > SmallestTimeMedium) then
                        local h = i.Time - 0.7
                        local sql = [[UPDATE UserRecordsMedium SET Time = ]]..h..[[ WHERE id = 1]]
                        dbMedium:exec(sql)
                    end
                    local l = i.Sequence + 1
                    print("Sequence A: "..l..", "..WrongIndex.." = "..WrongIndexBeforeMedium)
                    local sql = [[UPDATE UserRecordsMedium SET Sequence = ]]..l..[[ WHERE id = 1]]
                    dbMedium:exec(sql)
                else
                    print("In here")
                    local xix = i.SequenceWithinSequence + 1
                    print("XIX: "..xix)
                    local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = ]]..xix..[[ WHERE id = 1]]
                    dbMedium:exec(sql)  
                end
                if(WrongIndex == 1) then
                    transition.to(CharacterMedium,{time = 300, x = _W*0.13,onComplete = function() 
                        transition.to(CharacterMedium,{time = 300, x = _W*0.36,onComplete = function()
                            print("i.SequenceWithinSequence"..i.SequenceWithinSequence)
                            print("WrongBool: "..WrongBool)
                            if(i.SequenceWithinSequence == 3 and WrongBool == "true") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            elseif(i.SequenceWithinSequence == 4 and WrongBool == "false") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            else
                                print("ELSE")
                                for m in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
                                    for z in db2Medium:nrows("SELECT * FROM Medium WHERE id =  "..m.SequenceNumber) do
                                        print("IdiomMidMed[i.SequenceWithinSequence]1: "..tostring(IdiomMidMed[i.SequenceWithinSequence]))
                                        if(IdiomMidMed[i.SequenceWithinSequence] == "�") then
                                            IdiomMidMed[i.SequenceWithinSequence] = z[arrayMedium[1]]
                                            Word1Medium:setFillColor(1,1,0)
                                        elseif(IdiomMidMed[i.SequenceWithinSequence] ~= "�") then
                                            print("YAY")
                                            IdiomMidMed[i.SequenceWithinSequence+1] = z[arrayMedium[1]]
                                            Word1Medium:setFillColor(1,1,0)
                                        end
                                        UpdateSentenceMedium()
                                        WrongIndex = 0
                                        rScoreBeforeMed = 0
                                    end
                                end
                            end
                        end})
                    end})
                elseif(WrongIndex == 2) then
                    transition.to(CharacterMedium,{time = 300, x = _W*0.73,onComplete = function()
                        transition.to(CharacterMedium,{time = 300, x = _W*0.36,onComplete = function()
                            print("i.SequenceWithinSequence"..i.SequenceWithinSequence)
                            print("WrongBool: "..WrongBool)
                            if(i.SequenceWithinSequence == 3 and WrongBool == "true") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            elseif(i.SequenceWithinSequence == 4 and WrongBool == "false") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            else
                                print("ELSE")
                                for m in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
                                for z in db2Medium:nrows("SELECT * FROM Medium WHERE id =  "..m.SequenceNumber) do
                                    print("IdiomMidMed[i.SequenceWithinSequence]2: "..tostring(IdiomMidMed[i.SequenceWithinSequence]))
                                    if(IdiomMidMed[i.SequenceWithinSequence] == "�") then
                                        IdiomMidMed[i.SequenceWithinSequence] = z[arrayMedium[2]]
                                        Word2Medium:setFillColor(1,1,0)
                                    elseif(IdiomMidMed[i.SequenceWithinSequence] ~= "�") then
                                        print("YAY")
                                        IdiomMidMed[i.SequenceWithinSequence+1] = z[arrayMedium[2]]
                                        Word2Medium:setFillColor(1,1,0)
                                    end
                                    UpdateSentenceMedium()
                                    WrongIndex = 0
                                    rScoreBeforeMed = 0
                            end
                        end
                            end 
                        end})
                    end})
                elseif(WrongIndex == 3) then
                    transition.to(CharacterMedium,{time = 300, y = _H*0.23,onComplete = function() 
                        transition.to(CharacterMedium,{time = 300, y = _H*0.45,onComplete = function()
                            print("i.SequenceWithinSequence"..i.SequenceWithinSequence)
                            print("WrongBool: "..WrongBool)
                            if(i.SequenceWithinSequence == 3 and WrongBool == "true") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            elseif(i.SequenceWithinSequence == 4 and WrongBool == "false") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            else
                                print("ELSE")
                                for m in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
                                for z in db2Medium:nrows("SELECT * FROM Medium WHERE id =  "..m.SequenceNumber) do
                                    print("IdiomMidMed[i.SequenceWithinSequence]3: "..tostring(IdiomMidMed[i.SequenceWithinSequence]))
                                    if(IdiomMidMed[i.SequenceWithinSequence] == "�") then
                                        IdiomMidMed[i.SequenceWithinSequence] = z[arrayMedium[3]]
                                        Word3Medium:setFillColor(1,1,0)
                                    elseif(IdiomMidMed[i.SequenceWithinSequence] ~= "�") then
                                        print("YAY")
                                        IdiomMidMed[i.SequenceWithinSequence+1] = z[arrayMedium[3]]
                                        Word3Medium:setFillColor(1,1,0)
                                    end
                                    UpdateSentenceMedium()
                                    WrongIndex = 0
                                    rScoreBeforeMed = 0
                            end
                        end
                            end 
                        end})
                    end})
                elseif(WrongIndex == 4) then
                    transition.to(CharacterMedium,{time = 300, y = _H*0.63,onComplete = function() 
                        transition.to(CharacterMedium,{time = 300, y = _H*0.45,onComplete = function()
                            print("i.SequenceWithinSequence"..i.SequenceWithinSequence)
                            print("WrongBool: "..WrongBool)
                            if(i.SequenceWithinSequence == 3 and WrongBool == "true") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            elseif(i.SequenceWithinSequence == 4 and WrongBool == "false") then
                                print("Deleted")
                                local sql = [[UPDATE UserRecordsMedium SET SequenceWithinSequence = 1 WHERE id = 1]]
                                dbMedium:exec(sql)
                                Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                                Runtime:removeEventListener("enterFrame",enterFrame)
                                Runtime:removeEventListener("enterFrame",enterFrameS)
                                CharacterMedium.isVisible = false
                                composer.gotoScene( "RebounceMedium" )  
                            else
                                print("ELSE")
                                for m in dbMedium:nrows("SELECT SequenceNumber FROM SequenceMedium WHERE id = "..i.Sequence) do
                                for z in db2Medium:nrows("SELECT * FROM Medium WHERE id =  "..m.SequenceNumber) do
                                    print("IdiomMidMed[i.SequenceWithinSequence]4: "..tostring(IdiomMidMed[i.SequenceWithinSequence]))
                                    if(IdiomMidMed[i.SequenceWithinSequence] == "�") then
                                        IdiomMidMed[i.SequenceWithinSequence] = z[arrayMedium[4]]
                                        Word4Medium:setFillColor(1,1,0)
                                    elseif(IdiomMidMed[i.SequenceWithinSequence] ~= "�") then
                                        print("YAY")
                                        IdiomMidMed[i.SequenceWithinSequence+1] = z[arrayMedium[4]]
                                        Word4Medium:setFillColor(1,1,0)
                                    end
                                    UpdateSentenceMedium()
                                    for j in dbMedium:nrows("SELECT * FROM UserRecordsMedium WHERE id = 1") do
                                        print("SequenceWithinSequence: "..j.SequenceWithinSequence.." UPDATED 4")
                                    end
                                    WrongIndex = 0
                                    rScoreBeforeMed = 0
                            end
                        end
                            end
                        end})
                    end})
                end
            elseif(WrongIndex == 1 and CorrectMedium ~= WrongIndex) then
                transition.to(CharacterMedium,{time = 300, x = _W*0.13,onComplete = function() 
                    CharacterMedium.isVisible = false
                    print("Transt1")
                    print("Deleted")
                    Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                    Runtime:removeEventListener("enterFrame",enterFrame)
                    Runtime:removeEventListener("enterFrame",enterFrameS)
                    LostMediumGO()
                end})
            elseif(WrongIndex == 2 and CorrectMedium ~= WrongIndex) then
                transition.to(CharacterMedium,{time = 300, x = _W*0.73,onComplete = function()
                    CharacterMedium.isVisible = false
                    print("Transt2")
                    print("Deleted")
                    Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                    Runtime:removeEventListener("enterFrame",enterFrame)
                    Runtime:removeEventListener("enterFrame",enterFrameS)
                    LostMediumGO()
                end})
            elseif(WrongIndex == 3 and CorrectMedium ~= WrongIndex) then
                transition.to(CharacterMedium,{time = 300, y = _H*0.23,onComplete = function() 
                    CharacterMedium.isVisible = false
                    print("Transt3")
                    print("Deleted")
                    Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                    Runtime:removeEventListener("enterFrame",enterFrame)
                    Runtime:removeEventListener("enterFrame",enterFrameS)
                    LostMediumGO()
                end})
            elseif(WrongIndex == 4 and CorrectMedium ~= WrongIndex) then
                transition.to(CharacterMedium,{time = 300, y = _H*0.63,onComplete = function() 
                    CharacterMedium.isVisible = false
                    print("Transt4")
                    print("Deleted")
                    Runtime:removeEventListener("touch",SwipeTouchEventMedium)
                    Runtime:removeEventListener("enterFrame",enterFrame)
                    Runtime:removeEventListener("enterFrame",enterFrameS)
                    LostMediumGO()
                end})
            end
        end
        WrongIndexBeforeMedium = WrongIndex
        rScoreBeforeMed = rScore

    end
     function SwipeTouchEventMedium(event)
        print("Touched")  
        local swipeLengthX = math.abs(event.x - event.xStart) 
        local swipeLengthY = math.abs(event.y - event.yStart)
        local phase = event.phase
        if "ended" == phase or "cancelled" == phase then
            if swipeLengthX > swipeLengthY then
                if event.xStart > event.x and swipeLengthX > 50 and LockDownMedium == false then 
                    print("Swiped Left")
                    SWTEEMCheck(1)
                elseif event.xStart < event.x and swipeLengthX > 50 and LockDownMedium == false then 
                    print( "Swiped Right" )
                    SWTEEMCheck(2)
                end
            elseif swipeLengthY > swipeLengthX then
                if event.yStart > event.y and swipeLengthY > 50 and LockDownMedium == false then
                    print("Swiped Up")
                    SWTEEMCheck(3)
                elseif event.yStart < event.y and swipeLengthY > 50 and LockDownMedium == false then
                    print("Swiped Down")
                    SWTEEMCheck(4) 
                end
            end
        end
    end
    groupMedium:insert(beamGroup)
    Runtime:addEventListener("touch",SwipeTouchEventMedium)
end
function scene:show( event )
end
function scene:hide( event )
    audio.stop()
    composer.removeScene("Medium")
end

function scene:destroy( event )

   
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene