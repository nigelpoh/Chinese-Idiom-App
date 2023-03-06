
local composer 		= require( "composer" )
local scene    		= composer.newScene()
local widget = require( "widget" )
local DDM     = require "lib.DropDownMenu"
local RowData = require "lib.RowData"
local display = require "display" 
local texttospeech = require('plugin.texttospeech')
local sqlite = require("sqlite3")
-- Load Corona 'ads' library 
local ads = require "ads"


function scene:create( event )

    function callbackDictionary(event)
        print("------INIT TTS------")
        print(event.error)
        print(event.engines)
        print(event.defaultEngine)
        print("------END------")
    end
    texttospeech.init(callbackDictionary)

widget.setTheme( "widget_theme_ios7" )
----------------------------------------------------------------------
--							LOCALS	& GLOBALS						--
----------------------------------------------------------------------
-- Variables
local w = display.contentWidth
local h = display.contentHeight
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local font1 = "Lekton-Regular"
local font2 = "Telex-Regular"
local font3 =  native.systemFont 
local font4 = "SentyZHAO"
local font5 = "SentyGoldenBell"
local font6 = "SentyCreamPuff"
local font7 = "pinyin"
local selectedSearchOption = 1 -- Search option 1 = "难度级别", option 2 = "最左字符", option 3 = "任何字符", default = option 1
ads.hide()

display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )
searchText = ""
local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
sceneGroup = self.view
local path2 = system.pathForFile("DictionaryIdioms.sqlite",system.ResourceDirectory)
db2Dictionary = sqlite.open(path2)
local dictionaryDisplayGroup = display.newGroup ()
local meaningDisplayGroup = display.newGroup ()
local dictionaryBKDisplayGroup = display.newGroup ()


-- insert background color

local background = display.newRect( 0, 0, w, h )
background.anchorX = 0
background.anchorY = 0
background.x = 0
background.y = 0
background:setFillColor( 10/255, 100/255, 200/255 )
background.alpha = 0.7
dictionaryBKDisplayGroup:insert(background)


-- display module title at the top

local titleOptions = 
{
    --parent = titleGroup,
    text = "成语词典",     
    x = w*0.5,
    y = 0.01*h,
    width = w,     --required for multi-line and alignment
    font = font4,   
    fontSize = 70,
    align = "center"  --new alignment parameter
}

local titleText = display.newText( titleOptions )
titleText.anchorX = 0.5
titleText.anchorY = 0
titleText:setFillColor( 0, 1, 0 )
dictionaryBKDisplayGroup:insert(titleText)


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


-- Display message board
wininfoMsgBox = display.newRoundedRect(0.5*w, 0.108*h, w*0.95, h*0.7+80, 20)
wininfoMsgBox:setFillColor( 1, 229/255, 204/255 )
wininfoMsgBox.strokeWidth = 10
wininfoMsgBox:setStrokeColor(0,50,0)

wininfoMsgBox.anchorX = 0.5
wininfoMsgBox.anchorY = 0
wininfoMsgBox.alpha = 0
meaningDisplayGroup:insert(wininfoMsgBox)


-- Load frames

local frame = {}

frame[1] = display.newImageRect( meaningDisplayGroup, "display1.png", w*0.85, h*0.58 )
frame[1].anchorX = 0.5
frame[1].anchorY = 0
frame[1].isVisible = false

frame[2] = display.newImageRect( meaningDisplayGroup, "display2.png", w*0.85, h*0.58 )
frame[2].anchorX = 0.5
frame[2].anchorY = 0
frame[2].isVisible = false

-- load pandas
local panda = {}

panda[1] = display.newImageRect(meaningDisplayGroup, "panda1.png", 100, 80 )
panda[1].anchorX = 0
panda[1].anchorY = 0
panda[1].isVisible = false

panda[2] = display.newImageRect(meaningDisplayGroup, "panda2.png", 100, 80 )
panda[2].anchorX = 0
panda[2].anchorY = 0
panda[2].isVisible = false

panda[3] = display.newImageRect(meaningDisplayGroup, "panda3.png", 100, 80 )
panda[3].anchorX = 0
panda[3].anchorY = 0
panda[3].isVisible = false

panda[4] = display.newImageRect(meaningDisplayGroup, "panda4.png", 100, 80 )
panda[4].anchorX = 0
panda[4].anchorY = 0
panda[4].isVisible = false

panda[5] = display.newImageRect(meaningDisplayGroup, "panda5.png", 100, 80 )
panda[5].anchorX = 0
panda[5].anchorY = 0
panda[5].isVisible = false

panda[6] = display.newImageRect(meaningDisplayGroup, "panda6.png", 100, 80 )
panda[6].anchorX = 0
panda[6].anchorY = 0
panda[6].isVisible = false

panda[7] = display.newImageRect(meaningDisplayGroup, "panda7.png", 100, 80 )
panda[7].anchorX = 0
panda[7].anchorY = 0
panda[7].isVisible = false

panda[8] = display.newImageRect(meaningDisplayGroup, "panda8.png", 100, 80 )
panda[8].anchorX = 0
panda[8].anchorY = 0
panda[8].isVisible = false




-- display 3 columns of item (eg. Search type, Search Window and Search button)

-- Draw grey box for background for user input

local backRectangle = display.newRect( 0, 0, w, 80 )
backRectangle.anchorX = 0.5
backRectangle.anchorY = 0
backRectangle.x = 0.5*w
backRectangle.y = 0.108*h - backRectangle.height*0.1
backRectangle.strokeWidth = 3
backRectangle:setFillColor( 0.5, 0.5, 0.5 )
backRectangle:setStrokeColor( 0.8, 0.8, 0.8 )
backRectangle.alpha = 0.5
dictionaryDisplayGroup:insert(backRectangle)

-- Display native input window
local inputSearchField = ""
searchText = ""

local function inputtextListener( event )

    if ( event.phase == "began" ) then
        -- user begins editing the input field
        -- do nothing here

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- User hit <Enter> on keyboard 
        native.setKeyboardFocus( nil)
        searchText = event.target.text
   
    elseif ( event.phase == "editing" ) then
        local txt = event.target.text            
        if(string.len(txt)>14)then
            txt=string.sub(txt, 1, 14)
            event.target.text=txt
            
        end
        searchText = event.target.text
        
    end
end



-- Create text field and native keyboard for input
inputSearchField = native.newTextField( 0.357*w, 0.108*h, 0.54*w, backRectangle.height * 0.8 )
inputSearchField.anchorX = 0
inputSearchField.anchorY = 0

inputSearchField.font = native.newFont(font3, 40)
inputSearchField:resizeFontToFitHeight()
inputSearchField.text = ""
inputSearchField:setTextColor(0, 0, 1, 1)
dictionaryDisplayGroup:insert(inputSearchField)

inputSearchField:addEventListener( "userInput", inputtextListener )


-- exit button for dictionary
-- Function to handle button events
local function handleExitButtonEvent( event )

    if ( "ended" == event.phase ) then
        --print( "Button was pressed and released" )
        dictionaryDisplayGroup.alpha = 0
        meaningDisplayGroup.alpha = 0
        dictionaryBKDisplayGroup.alpha  = 0
        inputSearchField:removeSelf()
        composer.gotoScene( "MainMenu", {effect = "fade", time = 500, params = {Execute = false}} )
        
    end
end

local exitButton = widget.newButton(
    {
        width = 70,
        height = 70,
        defaultFile = "Close1.png",
        overFile = "Close2.png",
        onEvent = handleExitButtonEvent
    }
)

-- Center the button
exitButton.anchorY = 0.5
exitButton.anchorX = 0.5
exitButton.x = 0.91*w
exitButton.y = 0.05*h
exitButton.alpha = 0.5
dictionaryDisplayGroup:insert(exitButton)


-- construct the table view for listing of idioms

-- inserting data

local idiomsData = {}
--[[
idiomsData[1] = { name="百年树人", pinyin = "bǎi nián shù rén", name1="百", name2="年", name3="树", name4="人", level=1, meaning = "比喻培养人才是长久之计。也强调培养人才很不容易。" }
idiomsData[2] = { name="心猿意马", pinyin = "xīn yuán yì mǎ", name1="心", name2="猿", name3="意", name4="马", level=2, meaning = "形容心思不专、不定。" }
idiomsData[3] = { name="目空一切", pinyin = "mù kōng yī qiè", name1="目", name2="空", name3="一", name4="切", level=1, meaning = "形容狂妄自大，什么都看不起。" }
idiomsData[4] = { name="洛阳纸贵", pinyin = "luò yáng zhǐ guì", name1="洛", name2="阳", name3="纸", name4="贵", level=3, meaning = "形容文章写得好，广泛流传，风行一时。" }
idiomsData[5] = { name="对牛弹琴", pinyin = "duì niú tán qín", name1="对", name2="牛", name3="弹", name4="琴", level=1, meaning = "比喻对愚蠢的人讲深奥的道理。或用来讽刺人说话不着对象。" }
idiomsData[6] = { name="鞠躬尽瘁", pinyin = "jū gōng jìn cuì", name1="鞠", name2="躬", name3="尽", name4="瘁", level=3, meaning = "形容不辞劳苦地贡献出全部力量。" }
idiomsData[7] = { name="潜移默化", pinyin = "qián yí mò huà", name1="潜", name2="移", name3="默", name4="化", level=2, meaning = "指人的思想、性格和习惯等在不知不觉中受到感染、影响而慢慢发生变化。" }
idiomsData[8] = { name="井井有条", pinyin = "jǐng jǐng yǒu tiáo", name1="井", name2="井", name3="有", name4="条", level=1, meaning = "形容条理分明，丝毫不乱。" }
idiomsData[9] = { name="潜移默化", pinyin = "qián yí mò huà", name1="潜", name2="移", name3="默", name4="化", level=2, meaning = "指人的思想、性格和习惯等在不知不觉中受到感染、影响而慢慢发生变化。" }
idiomsData[10] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[11] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[12] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[13] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[14] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[15] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[16] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[17] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsData[18] = { name="百年树人", pinyin = "bǎi nián shù rén", name1="百", name2="年", name3="树", name4="人", level=1, meaning = "比喻培养人才是长久之计。也强调培养人才很不容易。" }
]]
for i in db2Dictionary:nrows("SELECT COUNT(ID) AS id FROM Dictionary") do
	for k = 1,i.id do
		for j in db2Dictionary:nrows("SELECT * FROM Dictionary WHERE ID = "..k) do
			idiomsData[k] = {
				name = j.name,
				pinyin = j.pinyin,
				name1 = j.name1,
				name2 = j.name2,
				name3 = j.name3,
				name4 = j.name4,
				level = tonumber(j.level),
				meaning = j.meaning,
			}
		end
	end
end

-- Original Data backup array
local idiomsDataB = {}
--[[
idiomsDataB[1] = { name="百年树人", pinyin = "bǎi nián shù rén", name1="百", name2="年", name3="树", name4="人", level=1, meaning = "比喻培养人才是长久之计。也强调培养人才很不容易。" }
idiomsDataB[2] = { name="心猿意马", pinyin = "xīn yuán yì mǎ", name1="心", name2="猿", name3="意", name4="马", level=2, meaning = "形容心思不专、不定。" }
idiomsDataB[3] = { name="目空一切", pinyin = "mù kōng yī qiè", name1="目", name2="空", name3="一", name4="切", level=1, meaning = "形容狂妄自大，什么都看不起。" }
idiomsDataB[4] = { name="洛阳纸贵", pinyin = "luò yáng zhǐ guì", name1="洛", name2="阳", name3="纸", name4="贵", level=3, meaning = "形容文章写得好，广泛流传，风行一时。" }
idiomsDataB[5] = { name="对牛弹琴", pinyin = "duì niú tán qín", name1="对", name2="牛", name3="弹", name4="琴", level=1, meaning = "比喻对愚蠢的人讲深奥的道理。或用来讽刺人说话不着对象。" }
idiomsDataB[6] = { name="鞠躬尽瘁", pinyin = "jū gōng jìn cuì", name1="鞠", name2="躬", name3="尽", name4="瘁", level=3, meaning = "形容不辞劳苦地贡献出全部力量。" }
idiomsDataB[7] = { name="潜移默化", pinyin = "qián yí mò huà", name1="潜", name2="移", name3="默", name4="化", level=2, meaning = "指人的思想、性格和习惯等在不知不觉中受到感染、影响而慢慢发生变化。" }
idiomsDataB[8] = { name="井井有条", pinyin = "jǐng jǐng yǒu tiáo", name1="井", name2="井", name3="有", name4="条", level=1, meaning = "形容条理分明，丝毫不乱。" }
idiomsDataB[9] = { name="潜移默化", pinyin = "qián yí mò huà", name1="潜", name2="移", name3="默", name4="化", level=2, meaning = "指人的思想、性格和习惯等在不知不觉中受到感染、影响而慢慢发生变化。" }
idiomsDataB[10] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[11] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[12] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[13] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[14] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[15] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[16] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[17] = { name="拍案叫绝", pinyin = "pāi àn jiào jué", name1="拍", name2="案", name3="叫", name4="绝", level=3, meaning = "形容非常赞赏。" }
idiomsDataB[18] = { name="百年树人", pinyin = "bǎi nián shù rén", name1="百", name2="年", name3="树", name4="人", level=1, meaning = "比喻培养人才是长久之计。也强调培养人才很不容易。" }
]]
for i in db2Dictionary:nrows("SELECT COUNT(ID) AS id FROM Dictionary") do
	for k = 1,i.id do
		for j in db2Dictionary:nrows("SELECT * FROM Dictionary WHERE ID = "..k) do
			idiomsDataB[k] = {
				name = j.name,
				pinyin = j.pinyin,
				name1 = j.name1,
				name2 = j.name2,
				name3 = j.name3,
				name4 = j.name4,
				level = tonumber(j.level),
				meaning = j.meaning,
			}
		end
	end
end


tableRowHeight = 70
tableTextHeight = 50


-- sort data based on difficulty level
local function sortDiff()
    tempData = {}

    for j = 1, #idiomsData do
        -- transfer data from idiom data array to temp data array
        tempData[j] = idiomsData[j]
    end 

    level1Array = {}
    level2Array = {}
    level3Array = {}
    level1 = 1
    level2 = 1
    level3 = 1

    for k = 1, #tempData do 
        -- store array to the repective difficulty data array
        if tempData[k].level == 1 then
            level1Array[level1] = tempData[k]
            level1 = level1 + 1
            else
                if tempData[k].level == 2 then
                    level2Array[level2] = tempData[k]
                    level2 = level2 + 1
                
                else
                    if tempData[k].level == 3 then
                        level3Array[level3] = tempData[k]
                        level3 = level3 + 1
                    end
                end
        end
    end

    -- store the sorted data into the original array
    dataIndex = 1
    for l = 1, #level1Array do

        idiomsData[dataIndex] = level1Array[l]
        dataIndex = dataIndex + 1
    end
    for m = 1, #level2Array do

        idiomsData[dataIndex] = level2Array[m]
        dataIndex = dataIndex + 1
    end
    for n = 1, #level3Array do

        idiomsData[dataIndex] = level3Array[n]
        dataIndex = dataIndex + 1
    end
    return true
end

-- Sort based on leftmost character
local function sortLeft(sText)
-- use searchText to find the matching left most character and store them in the original idioms array
leftSearchText = string.sub(sText,1,4)

tempDataSL = {}
    -- store idioms data into temp array
    for j = 1, #idiomsData do
        -- transfer data from idiom data array to temp data array
        tempDataSL[j] = idiomsData[j]

    end 

    -- empty entire idioms array
    for i = 1, #idiomsData do
        idiomsData[i] = nil
        
    end

    -- search and find, store into idioms array when found
    foundIndex = 1
    for qq = 1, #tempDataSL do
        
        if tempDataSL[qq].name1 == string.sub(sText,1,4) then
            idiomsData[foundIndex] = tempDataSL[qq]
            foundIndex = foundIndex + 1
        end
    end

return true       

end

-- sort based on any of the character match
local function sortAny (sText)
tempDataSA = {}
    -- store idioms data into temp array
    for j = 1, #idiomsData do
        -- transfer data from idiom data array to temp data array
        tempDataSA[j] = idiomsData[j]

    end 

    -- empty entire idioms array
    for i = 1, #idiomsData do
        idiomsData[i] = nil
        
    end

    -- search and find, store into idioms array when found
    goodIndex = 1
    for pp = 1, #tempDataSA do
        found = false
        if tempDataSA[pp].name1 == string.sub(sText,1,4) then
            idiomsData[goodIndex] = tempDataSA[pp]
            goodIndex = goodIndex + 1
            found = true
        end
        if (tempDataSA[pp].name2 == string.sub(sText,1,4) and found == false) then
            idiomsData[goodIndex] = tempDataSA[pp]
            goodIndex = goodIndex + 1
            found = true
        end
        if (tempDataSA[pp].name3 == string.sub(sText,1,4) and found == false) then
            idiomsData[goodIndex] = tempDataSA[pp]
            goodIndex = goodIndex + 1
            found = true
        end
        if (tempDataSA[pp].name4 == string.sub(sText,1,4) and found == false) then
            idiomsData[goodIndex] = tempDataSA[pp]
            goodIndex = goodIndex + 1
            found = true
        end

        
        
    end

return true       


end

-- Use sort by difficulty level at the start

sortDiff()


--sText = "百" 
--sText = "拍"
--sText = "心"
--sortLeft (sText)
--sortAny(sText)
--print (idiomsData[1].name)
--print (#idiomsData)



-- row rendering for table
local function onRowRender( event )

   --Set up the localized variables to be passed via the event table

   local row = event.row
   local id = row.index
   local params = event.row.params

   -- table row background
   row.bg = display.newRect( 0, 0, w, tableRowHeight-5)
   row.bg.anchorX = 0
   row.bg.anchorY = 0
   row.bg:setFillColor( 204/255, 255/255, 249/255)
   row.bg:toBack()
   row:insert( row.bg )

   if ( event.row.params ) then  

      row.indexText = display.newText( params.SN, 12, 0, font3, tableTextHeight*0.8 )
      row.indexText.anchorX = 0
      row.indexText.anchorY = 0.5
      row.indexText:setFillColor( 0,0,1 )
     
      row.indexText.y = 30
      row.indexText.x = 20
      

      row.nameText = display.newText( params.name, 12, 0, font3, tableTextHeight )
      row.nameText.anchorX = 0
      row.nameText.anchorY = 0.5
      row.nameText:setFillColor( 0 )
      
      row.nameText.y = 30
      row.nameText.x = 150
      

      row.levelText = display.newText( "难度: "..params.level, 12, 0, font3, tableTextHeight*0.8 )
      row.levelText.anchorX = 0
      row.levelText.anchorY = 0.5
      row.levelText:setFillColor( 0.9 ,0.1,0.7 )
  
      row.levelText.y = 30
      row.levelText.x = row.nameText.x + row.nameText.width + 80
      
      
      row:insert(row.indexText)
      row:insert( row.nameText )
      row:insert( row.levelText )
      
   end
   return true
end




-- on touching a row

-- Text to show which item we selected
local optionsSelectedName = 
{
    --parent = textGroup,
    text = "" ,     
    x = 0.5*w,
    y = 10,
    width = w,     --required for multi-line and alignment
    height = h * 0.3,
    font = font3,   
    fontSize = 80,
    align = "center" -- Name alignment parameter
}

  itemSelectedName = display.newText( optionsSelectedName)
  itemSelectedName:setFillColor( 0, 0, 1 )
  optionsSelectedName.anchorX = 0.5
  optionsSelectedName.anchorY = 0
  meaningDisplayGroup:insert( itemSelectedName )

-- pinyim to show which item we selected
local optionsSelectedPinyin = 
{
    --parent = textGroup,
    text = "" ,     
    x = 0.5*w,
    y = 100,
    width = w,     --required for multi-line and alignment
    height = h * 0.3,
    font = font3,   
    fontSize = 40,
    align = "center" -- Name alignment parameter
}

  itemSelectedPinyin = display.newText( optionsSelectedPinyin)
  itemSelectedPinyin:setFillColor( 0, 0, 1 )
  optionsSelectedPinyin.anchorX = 0.5
  optionsSelectedPinyin.anchorY = 0
  meaningDisplayGroup:insert( itemSelectedPinyin )


-- Speak button for dictionary
-- Function to handle button events
local function handleSpeakButtonEvent( event )

    if ( "ended" == event.phase ) then
        --print (itemSelectedName.text)
        texttospeech.speak(itemSelectedName.text, {  
        language = 'zh-CN',
        pitch = 0.8,
        rate = 0.7,
        volume = 1.0,
        onComplete = function(id)
            print('Speech "' .. id .. '" has ended.')
        end
        }) 
    end
end

local speakButton = widget.newButton(
    {
        width = 100,
        height = 100,
        defaultFile = "speak1.png",
        overFile = "speak2.png",
        onEvent = handleSpeakButtonEvent
    }
)

-- Center the button
speakButton.anchorY = 0
speakButton.anchorX = 0.5

speakButton.alpha = 0
meaningDisplayGroup:insert(speakButton)  

local optionsSelectedMeaning = 
{
    --parent = textGroup,
    text = "解释: ",     
    x = 0.27*w,
    y = 0.37*h,
    width = w*0.50,     --required for multi-line and alignment
    height = h * 0.35,
    font = font5 ,   
    fontSize = 40,
    align = "center"  --Meaning alignment parameter
}

  itemSelectedMeaning = display.newText( optionsSelectedMeaning)
  itemSelectedMeaning:setFillColor( 1, 1, 1 )
  itemSelectedMeaning.x = 20
  itemSelectedMeaning.y = 50
  itemSelectedMeaning.alpha = 0
  meaningDisplayGroup:insert( itemSelectedMeaning )
  --dictionaryDisplayGroup:insert(itemSelected)

  -- Function to return to the tableView
  local function goBack( event )
    dictionaryDisplayGroup.anchorX = 0
    dictionaryDisplayGroup.anchorY = 0
    inputSearchField.isVisible = true
    transition.to(dictionaryDisplayGroup,{ x = 0, y = 0, time = transTimer, xScale = 1, yScale = 1, alpha = 1})

    transition.to(wininfoMsgBox,{x = rowTouchX, y = rowTouchY, time = transTimer, transition=easing.inExpo, alpha = 0})
    transition.to( itemSelectedName, { x=rowTouchX, y = rowTouchY, time=transTimer, transition=easing.inExpo, alpha = 0})
    transition.to( speakButton, { x=rowTouchX, y = rowTouchY, time=transTimer, transition=easing.inExpo, alpha = 0})
    transition.to( itemSelectedPinyin, { x=rowTouchX, y = rowTouchY, time=transTimer, transition=easing.inExpo, alpha = 0}) 
    transition.to( itemSelectedMeaning, { x=rowTouchX, y = rowTouchY, time=transTimer, transition=easing.inExpo, alpha = 0})
    transition.to(frame[fr],{x = rowTouchX, y = rowTouchY, time = transTimer, transition=easing.inExpo, alpha = 0})
    transition.to(panda[pd],{x = rowTouchX, y = rowTouchY, time = transTimer, transition=easing.inExpo, alpha = 0})

    transition.to( event.target, { x=rowTouchX, y = rowTouchY, time=transTimer, transition=easing.inExpo, alpha = 0 } )
    --backButton.isVisible = false
  end

-- Back button
  local backButton = widget.newButton {
    width = 200,
    height = 80,
    label = "返回",
    labelColor = { default={ 0.8, 0, 0 }, over={ 0, 0, 0, 0.5 } },
    font = font4 or native.systemFont,
    fontSize = 50,
    onRelease = goBack
  }
  backButton.anchorX = 0.5
  backButton.anchorY = 0.5
  backButton.x = w*0.5
  backButton.y = h*0.8
  backButton.alpha = 0
  meaningDisplayGroup:insert( backButton )
  --dictionaryDisplayGroup:insert(backButton)

local function onRowTouch (event)

  local row = event.target
  if ( "release" == event.phase ) then
    
    itemSelectedName.text = idiomsData[row.index].name
    itemSelectedPinyin.text = idiomsData[row.index].pinyin
    itemSelectedMeaning.text = "解释: \n" .. idiomsData[row.index].meaning
    --backButton.alpha = 1

    local function changeRowColor()
       row.bg:setFillColor( 204/255, 255/255, 249/255)
       --texttospeech.speak('Bazinga!')  
       return true
    end
    row.bg:setFillColor( 0.9, 0, 0)
    rowTouchX = row.x
    rowTouchY = row.y
    wininfoMsgBox.x = rowTouchX
    wininfoMsgBox.y = rowTouchY
    wininfoMsgBox:scale(0.1,0.1)

    -- Select frame and panda
    -- Randomised frame
    math.randomseed( system.getTimer())
    print (os.time())
    --print (system.getTimer())
    fr = math.random (1,2)  

    --print ("fr: "..fr)
    
    -- Randomised panda
    math.randomseed(system.getTimer() + 88)
    pd = math.random (1,8)

    --print ("pd: "..pd)
    -- define the position of panda

    if fr == 2 then
      panPosX = 0.18*w 
      panPosY = 0.72*h
      meaningPosX = w*0.27
    else--if fr == 2 then
      panPosX = 0.7*w
      panPosY = 0.72*h
      meaningPosX = 0.23*w
    end


    frame[fr].x = rowTouchX
    frame[fr].y = rowTouchY
    frame[fr]:scale(0.1,0.1)
   
    panda[pd].x = rowTouchX
    panda[pd].y = rowTouchY
    panda[pd]:scale(0.1,0.1)


    itemSelectedName.x = rowTouchX
    itemSelectedName.y = rowTouchY
    itemSelectedName:scale(0.1,0.1)

    itemSelectedPinyin.x = rowTouchX
    itemSelectedPinyin.y = rowTouchY
    itemSelectedPinyin:scale(0.1,0.1)

    itemSelectedMeaning.x = rowTouchX
    itemSelectedMeaning.y = rowTouchY
    itemSelectedMeaning:scale(0.1,0.1)

    backButton.x = rowTouchX
    backButton.y = rowTouchY
    backButton:scale(0.1,0.1)
    transTimer = 0
    transDelay = 200

    dictionaryDisplayGroup.anchorX = 0.5
    dictionaryDisplayGroup.anchorY = 0.5
    transition.to(dictionaryDisplayGroup,{ delay = transDelay, x = w*0.5, y = h*0.5, time = 0, xScale = 0, yScale = 0,  alpha = 0, onComplete= function ()
       inputSearchField.isVisible = false
    end 
    })
    --inputSearchField.isVisible = false
    transition.to(wininfoMsgBox,{delay = transDelay, x = w*0.5, y = 0.108*h, time = transTimer, xScale = 1, yScale = 1, alpha = 1})
    frame[fr].isVisible = true
    transition.to(frame[fr],{delay = transDelay, x = 0.5*w, y = 0.27*h, time = transTimer, xScale = 1, yScale = 1, alpha = 1})
    
    panda[pd].isVisible = true
    transition.to(panda[pd],{delay = transDelay, x = panPosX, y = panPosY, time = transTimer, xScale = 1, yScale = 1, alpha = 1})

    transition.to( itemSelectedName, {delay = transDelay, x = 0, y = h*0.13, time=transTimer, xScale = 1, yScale = 1, alpha = 1 } )
    transition.to(speakButton, {delay = transDelay, x = itemSelectedName.x + w * 0.85, y = h*0.13, time = transTimer, xScale = 1, yScale = 1, alpha = 1})
    transition.to( itemSelectedPinyin, {delay = transDelay, x = 0, y = h*0.22, time=transTimer, xScale = 1, yScale = 1, alpha = 1 } )
    meaningFontsize = math.floor(math.sqrt(itemSelectedMeaning.width*itemSelectedMeaning.height/(string.len(itemSelectedMeaning.text))))
    itemSelectedMeaning.size = meaningFontsize * 0.75
    transition.to( itemSelectedMeaning, {delay = transDelay, x=meaningPosX, y = 0.37*h, time=transTimer, xScale = 1, yScale = 1,  alpha = 1 } )
    transition.to( backButton, {delay = transDelay, x=0.5*w, y = h*0.8, time=transTimer, xScale = 1, yScale = 1,  alpha = 1 } )
    timer.performWithDelay( transDelay, changeRowColor )
   
  end
  


  
   
  return true 


end    

-- create empty list
--local navBarHeight = 80
local tabBarHeight = 70
--[[if ((#idiomsData)*tabBarHeight > h*0.705) then 

    maxListHeight = h * 0.705
else

    maxListHeight = (#idiomsData)*tabBarHeight
    --print (maxListHeight)
end
]]--
maxListHeight = h * 0.705

local idiomsList = widget.newTableView {
   top = h*0.168,
   left = 0.01*w, 
   width = w*0.98, 
   height = maxListHeight,
   isBounceEnabled = false,  
   onRowRender = onRowRender,
   onRowTouch = onRowTouch,
   --listener = scrollListener
}

dictionaryDisplayGroup:insert (idiomsList)

idiomsList.anchorX = 0
idiomsList.anchorY = 0


for i = 1, #idiomsData do
   idiomsList:insertRow{
      rowHeight = 70,
      isCategory = false,
      rowColor =  { default = {1, 1, 1}, over = {0.3 ,0 ,0} },
      lineColor = { default = {160/255, 160/255, 160/255}, over = {0, 0, 0} },

      params = {
         SN = tostring(i),
         name = idiomsData[i].name,
         level = idiomsData[i].level
      }
   }
end

-- reload table view

local function reloadTable ()

-- re-insert the rows in the table
for i = 1, #idiomsData do
   idiomsList:insertRow{
      rowHeight = 70,
      isCategory = false,
      rowColor = { 204/255, 255/255, 249/255 },
      lineColor = { 160/255, 160/255, 160/255 },

      params = {
         SN = tostring(i),
         name = idiomsData[i].name,
         level = idiomsData[i].level
      }
   }
end

return true

end
-- Insert the 2 buttons and 1 native input

-- Insert left most button with drop down menu

local searchTypeData = {"难度级别","最左字符","任何字符"}
for i=1, #searchTypeData do
    local rowData = RowData.new(searchTypeData[i], 
                                {ID = i, description = "This is description of the selected Search Type index by\n " .. i,})
    searchTypeData[i] = rowData

end



-------------------------
-- DROP DOWN MENU INIT --
------------------------- 
local function onRowSelected(name, rowData)
        
    local rowData = rowData
    if rowData.value == "难度级别" then
        selectedSearchOption = 1
        
        -- sort by difficulty level
       -- print ("Diffculty level")
    elseif rowData.value == "最左字符" then
        selectedSearchOption = 2
        
        -- sort by first character
        --print ("First cahacter")
    elseif rowData.value == "任何字符" then
        selectedSearchOption = 3
        
    	-- sort by any character
    	--print ("Any character")
    end
        
end
    

local searchTypeDDM = DDM.new({
    name = "Search Type",
    x = 3,
    y = 0.108*h,
    width = 0.25*w,
    height = backRectangle.height * 0.8,
    font = font3,
    fontSize = 35,
    noLines = true,
    dataList = searchTypeData,
    onRowSelected = onRowSelected,
})


dictionaryDisplayGroup:insert (searchTypeDDM)

-- Display drop down menu button


local DDMimage = display.newImageRect( "DDMimage.png", backRectangle.height*0.8, backRectangle.height*0.8)
DDMimage.anchorX = 0
DDMimage.anchorY = 0
DDMimage.x = searchTypeDDM.x + searchTypeDDM.width 
DDMimage.y = 0.108*h

dictionaryDisplayGroup:insert(DDMimage)




-- Display search icon

-- Function to handle button events
local function handleSearchButtonEvent( event )

    if ( "ended" == event.phase ) then
        -- case 1: search text input = nil
        
        if (searchText == "") then
            -- list idioms by default method
            -- restore database back to original
            
            for f = 1, #idiomsDataB do
              idiomsData[f] = idiomsDataB[f]
            end
            sortDiff()
            idiomsList:deleteAllRows()
            reloadTable ()
            idiomsList:reloadData( )

        else 
          if (selectedSearchOption == 1) then

                -- list idioms by difficult level
                for  f = 1, #idiomsDataB do
                  idiomsData[f] = idiomsDataB[f]
                end
                sortDiff()
                idiomsList:deleteAllRows()
                reloadTable ()
                idiomsList:reloadData( )

          elseif (selectedSearchOption == 2) then

                -- list idioms by left most character
                for f = 1, #idiomsDataB do
                  idiomsData[f] = idiomsDataB[f]
                end
               
                sortLeft(searchText)
                if #idiomsData == 0 then
                    for  f = 1, #idiomsDataB do
                        idiomsData[f] = idiomsDataB[f]
                    end
                    sortDiff()
                    idiomsList:deleteAllRows()
                    reloadTable ()
                    idiomsList:reloadData( )
                else    
                    idiomsList:deleteAllRows()
                    reloadTable ()
                    sortDiff() -- arrange in difficulty order after sorting
                    idiomsList:reloadData( )
                end
                

          elseif (selectedSearchOption == 3) then 
              -- list idioms by any character
                for f = 1, #idiomsDataB do
                  idiomsData[f] = idiomsDataB[f]
                end
                sortAny(searchText)
                
                if #idiomsData == 0 then
                    for  f = 1, #idiomsDataB do
                        idiomsData[f] = idiomsDataB[f]
                    end
                    sortDiff()
                    idiomsList:deleteAllRows()
                    reloadTable ()
                    idiomsList:reloadData( )
                else    
                    idiomsList:deleteAllRows()
                    reloadTable ()
                    sortDiff() -- arrange in difficulty order after sorting
                    idiomsList:reloadData( )
                end

          end
        end
    end
end

local searchButton = widget.newButton(
    {
        width = backRectangle.height * 0.8,
        height = backRectangle.height * 0.8,
        defaultFile = "searchButtonDefault.png",
        overFile = "searchButtonOver.png",
        
        onEvent = handleSearchButtonEvent
    }
)

-- Center the button
searchButton.x = inputSearchField.x + inputSearchField.width + 2
searchButton.y = inputSearchField.y
dictionaryDisplayGroup:insert(searchButton)

dictionaryBKDisplayGroup:toBack()

sceneGroup:insert(dictionaryBKDisplayGroup)
sceneGroup:insert(dictionaryDisplayGroup)
sceneGroup:insert(meaningDisplayGroup)

-- initial display of idioms based on dificulties level

-- Drop down menu for search type Search by Starting & Search by any word




end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willEnter( event )
	local sceneGroup = self.view
    
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didEnter( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:willExit( event )
	local sceneGroup = self.view
end
----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:didExit( event )
	local sceneGroup = self.view
    
    
end

----------------------------------------------------------------------
----------------------------------------------------------------------
function scene:destroy( event )
	local sceneGroup = self.view
end

----------------------------------------------------------------------
--				FUNCTION/CALLBACK DEFINITIONS						--
----------------------------------------------------------------------



---------------------------------------------------------------------------------
-- Scene Dispatch Events, Etc. - Generally Do Not Touch Below This Line
---------------------------------------------------------------------------------
function scene:show( event )
	
end
function scene:hide( event )
    composer.removeScene("Dictionary")
end
function scene:destroy( event )
   
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
return scene
