display.setStatusBar(display.HiddenStatusBar)


local composer = require ("composer")
-- Load Corona 'ads' library 
local ads = require "ads"

local function onSystemEvent( event )
if event.type == "applicationExit" then
	local path = system.pathForFile( "UserData.sqlite", system.DocumentsDirectory )
	dbMAIN = sqlite.open( path ) 
	dbMain:close()
end
end

-- define the ads network
local adNetwork1 = "admob"
local appID1 = "ca-app-pub-9013546874981327/8328651092"

if appID1 then
	ads.init(adNetwork1, appID1)
end

composer.gotoScene("MainMenu", {params = { Execute = true}})
