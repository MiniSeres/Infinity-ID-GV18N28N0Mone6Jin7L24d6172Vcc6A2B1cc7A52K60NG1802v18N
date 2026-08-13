--[[
local Blacklist = {
    [10735891925] = "Reason: Spam bad words",
}

local Player = game.Players.LocalPlayer

if Blacklist[Player.UserId] then
    Player:Kick("You have been banned from using this script.\n\n" .. Blacklist[Player.UserId])
    return -- Dừng script không cho chạy tiếp
end
--]]
-- Phần code chính của bạn nằm ở đây

loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/820e69177b603c795266d37579ec0eac/raw/loadinghub.lua"))()
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:AddTheme({
    Name = "My Theme", -- theme name
    
    -- example of gradient (available for all values. e.g. Button, Icon, Text...)   --
    Icon = WindUI:Gradient({                                                      
        ["0"] = { Color = Color3.fromHex("#ffffff"), Transparency = 0 },            
        ["100"]   = { Color = Color3.fromHex("#000000"), Transparency = 0 },        
    }, {                                                                            
        Rotation = 0,                                                               
    }),   

    Toggle = WindUI:Gradient({                                                      
        ["0"] = { Color = Color3.fromHex("#32ff00"), Transparency = 0 },           
        ["100"]   = { Color = Color3.fromHex("#eeff00"), Transparency = 0 },        
    }, {                                                                            
        Rotation = 0,                                                               
    }),

	Slider = WindUI:Gradient({                                                      
        ["0"] = { Color = Color3.fromHex("#ff0000"), Transparency = 0 },           
        ["100"]   = { Color = Color3.fromHex("#00c8ff"), Transparency = 0 },        
    }, {                                                                            
        Rotation = 0,                                                               
    }),                                                                         
    
})

local Window = WindUI:CreateWindow({
    Title = "BaeMinh Hub | TSB",
    Icon = "badge-check", -- lucide icon
    Author = "by BaeMinh_Real",
    Folder = "MyHub",
    
    -- ↓ This all is Optional. You can remove it.
    Background = "rbxassetid://134522511102996",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 560),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "My Theme",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.65,
    HideSearchBar = false,
    ScrollBarEnabled = false,
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("Join My Discord :3")
        end,
    },
})

Window:EditOpenButton({
    Title = "Open BaeMinh Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("ffffff"), 
        Color3.fromHex("000000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "TSB",
    Icon = "gamepad-2",
    Color = Color3.fromHex("#ffffff"),
    Radius = 13, -- from 0 to 13
})

Window:Tag({
    Title = "v4.0.0",
    Icon = "github",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 13, -- from 0 to 13
})

Window:Tag({
    Title = "BETA",
    Icon = "code",
    Color = Color3.fromHex("#000000"),
    Radius = 13, -- from 0 to 13
})

local FPSTag = Window:Tag({
    Title = "FPS: 0",
    Color = Color3.fromRGB(100, 150, 255),
})
 
local RunService = game:GetService("RunService")
local lastUpdate = tick()
local frameCount = 0
 
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    
    if now - lastUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastUpdate))
        FPSTag:SetTitle("FPS: " .. fps)
        
        if fps >= 50 then
            FPSTag:SetColor(Color3.fromRGB(0, 255, 0)) -- Green
        elseif fps >= 30 then
            FPSTag:SetColor(Color3.fromRGB(255, 200, 0)) -- Yellow
        else
            FPSTag:SetColor(Color3.fromRGB(255, 0, 0)) -- Red
        end
        
        
        frameCount = 0
        lastUpdate = now
    end
end)

local PingTag = Window:Tag({
    Title = "Ping: 0ms",
    Color = Color3.fromRGB(100, 200, 255),
})
 
task.spawn(function()
    while true do
        local success, ping = pcall(function()
            local Stats = game:GetService("Stats")
            local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            return math.floor(pingValue)
        end)
        
        if success and ping then
            PingTag:SetTitle("Ping: " .. ping .. "ms")
            
            if ping <= 50 then
                PingTag:SetColor(Color3.fromRGB(0, 255, 0)) -- Green
            elseif ping <= 100 then
                PingTag:SetColor(Color3.fromRGB(255, 200, 0)) -- Yellow
            elseif ping <= 200 then
                PingTag:SetColor(Color3.fromRGB(255, 150, 0)) -- Orange
            else
                PingTag:SetColor(Color3.fromRGB(255, 0, 0)) -- Red
            end
        end
        
        task.wait(2)
    end
end)

-- ===== GLOBAL STATE (DUY NHẤT) =====
local MasterEnabled = false
local CombatEnabled = false
local CamlockEnabled = false
local CurrentTarget = nil

--//Movesets
local MovesetsTab = Window:Tab({
    Title = "Movesets",
    Desc = "Only u see", -- optional
    Icon = "eye", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromHex("a3a3a3"), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = false, -- add border around tab. optional
})

local SaitamaSection = MovesetsTab:Section({
    Title = "Saitama",
    Desc = "Only you see", -- optional
    Icon = "rbxassetid://15114667107", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(255, 0, 0), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

SaitamaSection:Button({
    Title = "Sukuna Manga",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/5d663066367d2fabaf241c7f7bbc625d/raw/movesetsukunamanga.lua"))()
    end
})

SaitamaSection:Button({
    Title = "Gojo v2",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/7120c19f9b83d4e3c361bd529c1e499a/raw/Gojo%2520by%2520BaeMinhReal.lua"))()
    end
})

SaitamaSection:Button({
    Title = "Gojo",
    Desc = "by i.am.an.agent", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/KJ-The-Strongest-Battlegrounds-battleground-gojo-script-saitama-to-gojo-26980"))()
    end
})

SaitamaSection:Button({
    Title = "Kars",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OfficialAposty/RBLX-Scripts/refs/heads/main/UltimateLifeForm.lua"))()
    end
})

SaitamaSection:Button({
    Title = "Wally West",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nova2ezz/west/refs/heads/main/Protected_4638864115822087.lua.txt"))()
    end
})

SaitamaSection:Button({
    Title = "MAFIOSO",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Lovelymoonlight/Lovelymoonlight/refs/heads/main/Baldy%20to%20mafioso'))()
    end
})

SaitamaSection:Button({
    Title = "Beerus",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sparksnaps/Beerus-The-Destroyer/refs/heads/main/Lua"))()
    end
})

SaitamaSection:Button({
    Title = "Overhaul",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/ngm2807-sudo/a29b5993d5ba5b308d35d7b7cf93398d/raw/overhaulsaitama.lua'))()
    end
})

SaitamaSection:Button({
    Title = "Madara",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        getgenv().Cutscene = False -- //𝖲𝖤𝖳 𝖨𝖳 "𝖥𝖠𝖫𝖲𝖤" 𝖨𝖥 𝖴 𝖣𝖮𝖭'𝖳 𝖶𝖠𝖭𝖳 𝖢𝖴𝖳𝖲𝖢𝖤𝖭𝖤 𝖠𝖭𝖣 𝖨𝖥 𝖴 𝖶𝖠𝖭𝖳 "𝖳𝖱𝖴𝖤" 𝖨𝖳\

		loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/SCRIPTSBYVEUX/refs/heads/main/BoombasticLol.lua.txt"))()
    end
})

SaitamaSection:Button({
    Title = "Golden Head",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        getgenv().stand = false --- if you want golden to be your pookie bear I mean to be your stand
		getgenv().ken = false ---set true if you want to play flappy bird 
		getgenv().Spawn = true ---set true if you want cutscenes spawn animation 
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Saitama%20to%20golden%20sigma'))() 
    end
})

SaitamaSection:Button({
    Title = "Jun",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/GoldenHeads2/f66279000c58a020e894a6db44914838/raw/62e53e1acacec0b38b43cd0f594292c32e09c39b/gistfile1.txt"))()
    end
})

SaitamaSection:Button({
    Title = "Mahito",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        getgenv().Swordm1= true -- set true if you want have sword thing on mahito m1
		getgenv().night = false  -- set true if you want night 
		getgenv().plushie = false ---set true if you want plushie mahito 
		getgenv().blackflash = true ---set true if you want v1 truly black flash
		getgenv().chat = false ---set true if you visual to other pov that your mahito
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Mahito%20v2%20sigma%20tp%20exploit'))()
    end
})

SaitamaSection:Button({
    Title = "Naruto",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/NarutoBeatUpSasukeAss/refs/heads/main/NarutoCums"))()
    end
})

local GarouSection = MovesetsTab:Section({
    Title = "Garou",
    Desc = "Only you see", -- optional
    Icon = "rbxassetid://15124465439", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(0, 255, 255), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

GarouSection:Button({
    Title = "Gabriel",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/damir512/youinsinificants/main/insignificantFuck.txt",true))()
    end
})

GarouSection:Button({
    Title = "Void Garou",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Void%20Reaper%20Obfuscated.txt"))()
    end
})

GarouSection:Button({
    Title = "Mastery Deku",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/xKextYP5"))()
    end
})

GarouSection:Button({
    Title = "SONIC.EXE",
    Desc = "by GoldenHead", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/4zLt8a2P/raw"))()
    end
})

local EffectsSection = MovesetsTab:Section({
    Title = "Effects",
    Desc = "Only you see", -- optional
    Icon = "sparkle", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(0, 255, 255), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

EffectsSection:Button({
    Title = "Gojo Effects",
    Desc = "Effects M1s", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/r3k33551-bot/Acortador-de-scripts/refs/heads/main/gojos%20infinity.txt"))()
    end
})

MovesetsTab:Button({
    Title = "Movesets UI",
    Desc = "for Saitama, Garou, Sonic, ...", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/proscripter400/b24547203a4cc12bdcfe77fd13dd7580/raw/fb8048c0d5b59d626879b1a06cfedaae3e7ee205/charhub'))()
    end
})

--//Help: Tech and Tool
local MainTab = Window:Tab({
    Title = "Main",
    Desc = "Help you in PvP", -- optional
    Icon = "heart-handshake", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromHex("#00ffee"), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local AutoBlockSection = MainTab:Section({
    Title = "AutoBlock",
    Desc = "Auto Block when player attack", -- optional
    Icon = "shield", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(235, 255, 0), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
})

AutoBlockSection:Button({
    Title = "Open UI Auto Block",
    Desc = "Work good with low ping", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Soon", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/3db1d11dea92c230feb6f6859c299059/raw/autoblockhihi"))()
    end
})

local TechSection = MainTab:Section({
    Title = "Tech",
    Desc = "Tech will have you cool in PvP", -- optional
    Icon = "star", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(235, 255, 0), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
})

TechSection:Button({
    Title = "Binding Cloth Dash",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/ngm2807-sudo/aeccf3ce4aef451f61f56d6b21ade701/raw/bindingclothdash.lua'))()
    end
})

TechSection:Button({
    Title = "Crowd Buster Dash",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/ngm2807-sudo/d5eedc61ed24e5fbdc5362d26dc60af5/raw/crowdbusterdash.lua'))()
    end
})

TechSection:Button({
    Title = "Gojo Tech",
    Desc = "by tsb.scripts8", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet('https://gojotech.tsbscripts.workers.dev/'))()
    end
})

TechSection:Button({
    Title = "Loop Dash",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/f7b310f3f91e83ce067a031c63123a53/raw/loopdash.lua"))()
    end
})

TechSection:Button({
    Title = "Surfing Tech",
    Desc = "by Notpaki", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/GarouSurfingTech/refs/heads/main/Protected_2674673126232747.lua"))()
    end
})

TechSection:Button({
    Title = "Lethal Revamp",
    Desc = "by Notpaki",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/InstantLethalRevamp/refs/heads/main/Protected_6977817281150270.lua"))()
    end
})

TechSection:Button({
    Title = "Reflex Tech",
    Desc = "by Notpaki",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/ReflexTech/refs/heads/main/Protected_7459802026542834.lua"))()
    end
})

TechSection:Paragraph({
    Title = "PC user:",
    Desc = "M1 Reset: R\nEmote Dash: T\nRotation: H\n\nby mvp_kfc",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "app-window",
            Title = "M1 Reset",
            Callback = function()
				getgenv().keybinds = {
					m1reset = Enum.KeyCode.R,  -- M1 Reset 
					emotedash = Enum.KeyCode.T, -- Emote Dash
					rotation = Enum.KeyCode.H   -- Auto Rotation
				}
				
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Slaphello/M1-Reset-And-Emote-Dash-TSB-OLD-/refs/heads/main/M1R%26ED%20TSB"))() 
			end,
        }
    }
})

TechSection:Paragraph({
    Title = "PC user:",
    Desc = "V to select player\nC to use side dash assit\nRightAlt to on/off UI\nby Nopaki",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "app-window",
            Title = "Side Dash",
            Callback = function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/FakeDash/refs/heads/main/Protected_5833389828844912.lua"))()
			end,
        }
    }
})

TechSection:Button({
    Title = "Oreo Tech",
    Desc = "by Notpaki",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/OreoTech/refs/heads/main/Protected_6856895483929371.lua"))()
    end
})

TechSection:Button({
    Title = "Lethal Dash",
    Desc = "by BaeMinhReal",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/2f6adbbbf0107718ec1c17e123a59c9b/raw/lethaldash.lua"))()
    end
})

TechSection:Button({
    Title = "Instant Twisted",
    Desc = "by Notpaki",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/InstantTwistedRevamp/refs/heads/main/Protected_7455521176683315.lua"))()
    end
})

TechSection:Button({
    Title = "SUPA v3",
    Desc = "by Merebennie",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/ea0b7cbd8c395e01ec38271794b2559808d26501bd6e6e30c48660759a7db7b3.lua"))()
    end
})

TechSection:Button({
    Title = "Kiba",
    Desc = "by (idk)",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kietsonphongthanhnghia-a11y/Uhyeah/refs/heads/main/Protected_1425045629292384.lua.txt"))()
    end
})

TechSection:Button({
    Title = "Auto Kyoto",
    Desc = "by Notpaki",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/KyotoTechRework/refs/heads/main/Protected_9378660372508532.lua"))()
    end
})

local ToolsSection = MainTab:Section({
    Title = "Tools",
    Desc = "Tools will have you in PvP", -- optional
    Icon = "crosshair", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(235, 255, 0), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
})

local AIMGroup = ToolsSection:HStack({})

AIMGroup:Button({
    Title = "Silent Aim",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/effc6661fe36a771dac4a854e9aaa029/raw/silentaimbyBaeMinh.lua"))()
    end
})

AIMGroup:Button({
    Title = "Cam Lock",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/56ae2701b7aef97891e2aa4178af4577/raw/camlockbyBaeMinh.lua"))()
    end
})

ToolsSection:Divider()

ToolsSection:Button({
    Title = "Trash-can man",
    Desc = "Use Saitama if u want ULT",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/yes1nt/yes/refs/heads/main/Trashcan%20Man",true))()
    end
})

ToolsSection:Button({
    Title = "Hitbox expander",
    Desc = "Use Deady Ninja for auto load after die",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-SION-ELTNAM-ATLASIA-61168"))()
    end
})

ToolsSection:Button({
    Title = "Open UI Fling Player",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/7155874edfab6e1d774d5017ea0b3018/raw/flingplayerv2.lua"))()
    end
})

ToolsSection:Button({
    Title = "Open UI Anti DC, Notify DC and Counetr move",
    Desc = "Notify DC and Counetr move, Anti DC", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/88ec1b782099e3284a902d9baa9cea52/raw/idk.lua"))()
    end
})

ToolsSection:Button({
    Title = "Open UI Auto Walvombo + Bring + ...",
    Desc = "by BaeMinhReal", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/341a409bb8a24ce32dadaa7b7f868dc6/raw/wallcomboui.lua"))()
    end
})

--==================================================
-- UI SECTION
--==================================================
local AutoKillSection = MainTab:Section({
	Title = "Auto Kill",
	Desc = "Kill Player Select",
	Icon = "skull",
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

AutoKillSection:Button({
    Title = "Open UI Old Auto Kill",
    Desc = "by our team", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/e83a65fa2c0fb0b5cd696426a8863bd5/raw/autokillv1.lua"))()
    end
})

AutoKillSection:Divider()

--// SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(c)
    char = c
    hrp = c:WaitForChild("HumanoidRootPart")
end)

--// STATE
local targetPlayer = nil
local killEnabled = false
local currentMode = "Orbit"
local orbitSpeed = 5
local orbitDistance = 5

--// ATTACK FUNCTION
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

task.spawn(function()
    while task.wait(0.1) do
        if killEnabled and targetPlayer then
            pcall(function()
                local char = player.Character
                if not char then return end

                if char:FindFirstChild("Communicate") then
                    char.Communicate:FireServer({
                        Goal = "LeftClick",
                        Mobile = true
                    })
                end

                pressKey("One")
                task.wait(0.1)
                pressKey("Two")
                task.wait(0.1)
                pressKey("Three")
                task.wait(0.1)
                pressKey("Four")
                task.wait(0.1)
                pressKey("Q")
                task.wait(0.1)
                pressKey("G")
            end)
        end
    end
end)

--// MOVEMENT LOOP
RunService.RenderStepped:Connect(function()
    if killEnabled and targetPlayer and targetPlayer.Character then
        local root = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root and hrp then

            if currentMode == "Orbit" then
                local angle = tick() * orbitSpeed
                local offset = Vector3.new(
                    math.cos(angle) * orbitDistance,
                    0,
                    math.sin(angle) * orbitDistance
                )
                hrp.CFrame = CFrame.new(root.Position + offset, root.Position)

            elseif currentMode == "Behind" then
                hrp.CFrame = CFrame.new(
                    root.Position - root.CFrame.LookVector * orbitDistance,
                    root.Position
                )

            elseif currentMode == "Under" then
                hrp.CFrame = CFrame.new(
                    root.Position - Vector3.new(0, orbitDistance, 0),
                    root.Position
                )

            elseif currentMode == "Up" then
                hrp.CFrame = CFrame.new(
                    root.Position + Vector3.new(0, orbitDistance + 3, 0),
                    root.Position
                )
            end

            hrp.Velocity = Vector3.zero
        end
    end
end)

-- Player Paragraph (hiển thị info player)
local PlayerParagraph = AutoKillSection:Paragraph({
    Title = "...",
    Desc = "...",
    Image = Players:GetUserThumbnailAsync(1, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420),
})

-- Table chứa player
local PlayersTable = {}

local function RefreshPlayersTable()
    PlayersTable = {}

    for _, Player in pairs(Players:GetPlayers()) do
        table.insert(PlayersTable, {
            Title = Player.DisplayName,
            _Name = Player.Name,
            _UserId = Player.UserId,
            Icon = Players:GetUserThumbnailAsync(
                Player.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size420x420
            ),
        })
    end

    return PlayersTable
end

-- Dropdown chọn player
local Dropdown = AutoKillSection:Dropdown({
    Title = "Select Player",
    Values = {},
    Value = nil,
    Callback = function(selectedplayer)
        if not selectedplayer then return end

        targetPlayer = Players:FindFirstChild(selectedplayer._Name)

        PlayerParagraph:SetTitle(selectedplayer.Title)
        PlayerParagraph:SetDesc(selectedplayer._Name)
        PlayerParagraph:SetImage(selectedplayer.Icon)
    end,
})

-- Load lần đầu
Dropdown:Refresh(RefreshPlayersTable())

-- Auto update khi player join/leave
Players.PlayerAdded:Connect(function()
    Dropdown:Refresh(RefreshPlayersTable())
end)

Players.PlayerRemoving:Connect(function()
    Dropdown:Refresh(RefreshPlayersTable())
end)

AutoKillSection:Dropdown({
    Title = "Select mode",
    Desc = "mode for auto kill",
    Values = {
        "Orbit",
        "Behind",
        "Under",
        "Up"
    },
    Value = "Orbit",
    Multi = false,
    Locked = false,
    Flag = "my_dropdown",
	Callback = function(selected)
		currentMode = selected
	end
})

AutoKillSection:Toggle({
    Title = "Auto Kill",
    Desc = "by BaeMinhReal", -- optional
    Icon = "power", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Color = Color3.fromRGB(100, 200, 100), -- custom color. optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
	Callback = function(state)
		if not targetPlayer then
			warn("No player selected!")
			return
		end

		killEnabled = state
	end
})

AutoKillSection:Input({
    Title = "Orbit Speed",
    Desc = "Change speed(only mode: orbit)",
    Placeholder = "Default: 5",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            orbitSpeed = math.clamp(num, 1, 50)
        else
            warn("Invalid number for Orbit Speed")
        end
    end
})

AutoKillSection:Input({
    Title = "Distance",
    Desc = "Change Distance (all mode)",
    Placeholder = "Default: 5",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            orbitDistance = math.clamp(num, 1, 20)
        else
            warn("Invalid number for Orbit Distance")
        end
    end
})

--==================================================
-- ATTACK ALL SECTION
--==================================================
local AttackAllSection = MainTab:Section({
    Title = "Attack All",
    Desc = "Attack everyone in the server with specific moves",
    Icon = "swords",
    TextSize = 20,
    TextXAlignment = "Center",
    Box = true,
    BoxBorder = true,
    Opened = false,
})

-- Biến toàn cục để lưu trạng thái của UI
local AttackAllEnabled = false
local AttackAllMoves = {
    ["Savage Tornado"] = false,
    ["Brutal Beatdown"] = false,
    ["Crushed Rock Variant"] = false,
    ["Twin Fangs"] = false
}

AttackAllSection:Toggle({
    Title = "Attack All",
    Desc = "Bật / Tắt Attack All", 
    Icon = "power", 
    Value = false, 
    Type = "Toggle", 
    Locked = true, 
    Flag = "attack_all_toggle", 
    Callback = function(state)
        AttackAllEnabled = state
    end
})

AttackAllSection:Dropdown({
    Title = "Select Move",
    Desc = "Chọn chiêu thức để áp dụng Attack All",
    Values = {
        "Savage Tornado",
        "Brutal Beatdown",
        "Crushed Rock Variant",
        "Twin Fangs"
    },
    Value = {}, 
    Multi = true,
    Locked = true,
    Flag = "attack_all_dropdown",
    Callback = function(selected)
        -- Reset lại toàn bộ chiêu về false
        for k in pairs(AttackAllMoves) do
            AttackAllMoves[k] = false
        end
        -- Bật true cho các chiêu được chọn từ Dropdown
        for _, moveName in pairs(selected) do
            AttackAllMoves[moveName] = true
        end
    end
})

--==================================================
-- ATTACK ALL LOGIC (HOOK ANIMATION)
--==================================================
local function SetupAttackAll()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local lp = Players.LocalPlayer

    -- Sự kiện bắt Animation của nhân vật
    local function onAnimationPlayed(animTrack)
        if not AttackAllEnabled then return end
        local _AnimationId = tostring(animTrack.Animation.AnimationId)
        
        -- Start Attack All Logic
        -- Attack All: attach/detach — estilo Welder
        local _aaCurrentConn = nil
        local _aaRotConn     = nil
        local _aaMyRoot      = nil
        local _aaTargetRoot  = nil

        local function _aaDetach()
            if _aaCurrentConn then
                _aaCurrentConn:Disconnect()
                _aaCurrentConn = nil
            end
            if _aaRotConn then
                _aaRotConn:Disconnect()
                _aaRotConn = nil
            end
            -- reseta PhysicsRepRootPart de volta pra nil antes de soltar
            if sethiddenproperty then
                if _aaMyRoot and _aaMyRoot.Parent then
                    pcall(function() sethiddenproperty(_aaMyRoot, "PhysicsRepRootPart", nil) end)
                end
                if _aaTargetRoot and _aaTargetRoot.Parent then
                    pcall(function() sethiddenproperty(_aaTargetRoot, "PhysicsRepRootPart", nil) end)
                end
            end
            if _aaMyRoot and _aaMyRoot.Parent then
                _aaMyRoot.CFrame                  = CFrame.new(_aaMyRoot.Position)
                _aaMyRoot.AssemblyLinearVelocity  = Vector3.zero
                _aaMyRoot.AssemblyAngularVelocity = Vector3.zero
                pcall(function() _aaMyRoot.Velocity    = Vector3.zero end)
                pcall(function() _aaMyRoot.RotVelocity = Vector3.zero end)
                local _detachHum = _aaMyRoot.Parent:FindFirstChildOfClass("Humanoid")
                if _detachHum then pcall(function() _detachHum.AutoRotate = true end) end
            end
            _aaMyRoot     = nil
            _aaTargetRoot = nil
        end

        local function _aaEnd()
            _aaDetach()
        end

        local function _aaAttach(myRoot, targetRoot)
            if _aaCurrentConn then
                _aaCurrentConn:Disconnect()
                _aaCurrentConn = nil
            end
            if _aaMyRoot and _aaMyRoot.Parent then
                _aaMyRoot.AssemblyLinearVelocity  = Vector3.zero
                _aaMyRoot.AssemblyAngularVelocity = Vector3.zero
                pcall(function() _aaMyRoot.Velocity    = Vector3.zero end)
                pcall(function() _aaMyRoot.RotVelocity = Vector3.zero end)
            end
            if not myRoot or not targetRoot then return end
            _aaMyRoot     = myRoot
            _aaTargetRoot = targetRoot
            -- Keep AutoRotate set to false on every RenderStepped, consistent with lock-on behaviour.
            if _aaRotConn then _aaRotConn:Disconnect() _aaRotConn = nil end
            local _rotHum = myRoot.Parent and myRoot.Parent:FindFirstChildOfClass("Humanoid")
            if _rotHum then
                _aaRotConn = RunService.RenderStepped:Connect(function()
                    if _rotHum and _rotHum.Parent then
                        pcall(function() _rotHum.AutoRotate = false end)
                    end
                end)
            end
            -- TP imediato 5 studs atrás do alvo
            myRoot.CFrame                  = targetRoot.CFrame * CFrame.new(0, 0, 5)
            myRoot.AssemblyLinearVelocity  = Vector3.zero
            myRoot.AssemblyAngularVelocity = Vector3.zero
            if sethiddenproperty then
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", myRoot) end)
                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot) end)
            end
            -- heartbeat contínuo
            local _selfConn
            _selfConn = RunService.Heartbeat:Connect(function()
                if not myRoot or not myRoot.Parent
                or not targetRoot or not targetRoot.Parent then
                    _selfConn:Disconnect()
                    if _aaCurrentConn == _selfConn then _aaCurrentConn = nil end
                    if sethiddenproperty then
                        if myRoot and myRoot.Parent then
                            pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
                        end
                        if targetRoot and targetRoot.Parent then
                            pcall(function() sethiddenproperty(targetRoot, "PhysicsRepRootPart", nil) end)
                        end
                    end
                    if myRoot and myRoot.Parent then
                        myRoot.AssemblyLinearVelocity  = Vector3.zero
                        myRoot.AssemblyAngularVelocity = Vector3.zero
                        pcall(function() myRoot.Velocity    = Vector3.zero end)
                        pcall(function() myRoot.RotVelocity = Vector3.zero end)
                    end
                    return
                end
                myRoot.CFrame                  = targetRoot.CFrame * CFrame.new(0, 0, 5)
                myRoot.AssemblyLinearVelocity  = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                if sethiddenproperty then
                    pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot) end)
                end
            end)
            _aaCurrentConn = _selfConn
        end

        if _AnimationId:match('14719290328') and AttackAllMoves['Savage Tornado'] then
            task.spawn(function()
                local myChar = _pGetChar(lp)
                local myRoot = myChar and _pGetRoot(myChar)
                if not myRoot then return end
                local savedCF = myRoot.CFrame
                RunService.Heartbeat:Once(function() myRoot.CFrame = CFrame.new(0, -10000, 0) end)
                task.wait(0.9)
                local t = tick()
                repeat
                    _pGrabRandom(true)
                    task.wait(0.03)
                until tick() >= t + 1.75
                game:GetService("TweenService"):Create(myRoot, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    CFrame = CFrame.new(352, 438, 392),
                }):Play()
                task.wait(1.5)
                RunService.Heartbeat:Once(function() myRoot.CFrame = savedCF end)
            end)
        end
        if _AnimationId:match('14701242661') and AttackAllMoves['Brutal Beatdown'] then
            task.spawn(function()
                local myChar = _pGetChar(lp)
                local myRoot = myChar and _pGetRoot(myChar)
                if not myRoot then return end
                RunService.Heartbeat:Once(function() myRoot.CFrame = CFrame.new(0, -10000, 0) end)
                task.wait(2)
                local t = tick()
                repeat
                    _pGrabRandom(true)
                    task.wait(0.05)
                until tick() >= t + 4.5
                local t2 = tick()
                repeat
                    _pGrabRandom(true)
                    task.wait(0.05)
                until tick() >= t2 + 1.3
            end)
        end
        if _AnimationId:match('18896229321') and AttackAllMoves['Twin Fangs'] then
            task.spawn(function()
                -- only fires if you're Purple and Ulted
                local _myChar = _pGetChar(lp)
                if not _myChar then return end
                if _myChar:GetAttribute("Character") ~= "Purple" then return end
                if not _myChar:GetAttribute("Ulted") then return end
                local deadline      = tick() + 3
                local tfActive      = true
                -- just trust the process
                local _tfStart = tick()
                task.spawn(function()
                    repeat task.wait() until tick() >= _tfStart + 2.5 or not tfActive
                    if not tfActive then return end
                    -- only desync if still ulted at fire time
                    local _dc = _pGetChar(lp)
                    if not _dc or not _dc:GetAttribute("Ulted") then return end
                    getgenv().desync = { CFrame = CFrame.new(0, -29000, 0) }
                    task.wait(0.2)
                    getgenv().desync = nil
                end)
                local anchor        = _bringAllAnchor(function() return tfActive end)
                local grabbed       = {}
                local currentTarget = nil  -- Player ou dummy Model
                local targetSince   = tick()

                local savedCFrame = nil
                do
                    local _sc = _pGetChar(lp)
                    local _sr = _sc and _pGetRoot(_sc)
                    if _sr then savedCFrame = _sr.CFrame end
                end

                -- helpers: accept Player OR dummy Model as target
                local function _tGetChar(t)
                    if not t then return nil end
                    if t:IsA("Player") then return _pGetChar(t) end
                    return t -- dummy char ready
                end
                local function _tGetHum(t)
                    return _pGetHum(_tGetChar(t))
                end
                local function _tGetRoot(t)
                    return _pGetRoot(_tGetChar(t))
                end

                local function _hasAnyFF(c)
                    if not c then return false end
                    if c:FindFirstChild("ForceField") then return true end
                    if c:FindFirstChild("AbsoluteImmortal") then return true end
                    if c:FindFirstChild("BeingGrabbed") then return true end
                    if c:FindFirstChild("HunterCounter") then return true end
                    if c:FindFirstChild("AtomicCounter") then return true end
                    return false
                end
                local function _isBlacklisted(target)
                    local c = _tGetChar(target)
                    local h = c and _pGetHum(c)
                    if not c or not h then return true end
                    if h.Health <= 0 then return true end
                    -- checks extras só pra players reais
                    if target:IsA("Player") then
                        if _hasAnyFF(c) then return true end
                        if c:FindFirstChild("Counter") then return true end
                        if _pIsAnimPlaying(h, "15128849047") then return true end
                        if c:GetAttribute("Ulted") and c:GetAttribute("Character") == "Batter" then return true end
                    end
                    return false
                end
                local function _isVictim(target)
                    local h = _tGetHum(target)
                    return h and (_pIsAnimPlaying(h, '18896222853') or _pIsAnimPlaying(h, '137434257516014'))
                end
                local function _isOnlyFF(target)
                    if not target or not target:IsA("Player") then return false end
                    local c = _pGetChar(target)
                    local h = c and _pGetHum(c)
                    if not c or not h then return false end
                    if h.Health <= 0 then return false end
                    if _pIsAnimPlaying(h, "15128849047") then return false end
                    return _hasAnyFF(c)
                end

                local function _getDummy()
                    local d = workspace.Live:FindFirstChild("Weakest Dummy")
                    if not d then return nil end
                    local h = _pGetHum(d)
                    if not h or h.Health <= 0 then return nil end
                    return d
                end

                local function _pickTarget(excluded)
                    local favored = {}
                    local candidates = {}
                    for _, p in pairs(_pGetAllPlayers()) do
                        if p == excluded or grabbed[p] then continue end
                        if table.find(RevenantWhitelist, p) then continue end
                        local pr = _tGetRoot(p)
                        if not _isBlacklisted(p) and not _isVictim(p) and pr then
                            if _aaIsFavoredCharacterTarget(p) then
                                table.insert(favored, p)
                            else
                                table.insert(candidates, p)
                            end
                        end
                    end
                    if #favored > 0 then return favored[math.random(1, #favored)] end
                    if #candidates > 0 then return candidates[math.random(1, #candidates)] end
                    local d = _getDummy()
                    if d and d ~= excluded and not grabbed[d] then
                        return d
                    end
                    return nil
                end

                local _currentTargetAnimConn = nil

                local function _tfSwitchTarget(next)
                    if _currentTargetAnimConn then
                        pcall(function() _currentTargetAnimConn:Disconnect() end)
                        _currentTargetAnimConn = nil
                    end

                    _aaDetach()
                    currentTarget = next
                    targetSince   = tick()
                    if next then
                        local myChar = _pGetChar(lp)
                        local myRoot = myChar and _pGetRoot(myChar)
                        local tr = _tGetRoot(next)
                        if myRoot and tr then
                            _aaAttach(myRoot, tr)
                            
                            local h = _tGetHum(next)
                            if h then
                                local animator = h:FindFirstChildOfClass("Animator")
                                local event = animator and animator.AnimationPlayed or h.AnimationPlayed
                                _currentTargetAnimConn = event:Connect(function(track)
                                    local id = tostring(track.Animation.AnimationId)
                                    if id:match('18896222853') or id:match('137434257516014') then
                                        -- INSTANT grab: no flag, no heartbeat wait, act right now
                                        if not tfActive then return end
                                        local victim = currentTarget
                                        if not victim then return end
                                        grabbed[victim] = true
                                        _aaDetach()
                                        local nextP = _pickTarget(victim)
                                        if nextP then
                                            _tfSwitchTarget(nextP)
                                            if _pickTarget(nextP) == nil and not _hasFFPending() then
                                                task.wait(0.1)
                                                grabbed[nextP] = true
                                                _everybodyDone = true
                                                _tfCleanup()
                                            end
                                        else
                                            if _hasFFPending() then
                                                _aaDetach()
                                                currentTarget = nil
                                            else
                                                _everybodyDone = true
                                                _tfCleanup()
                                            end
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end

                local function _returnToSaved()
                    if not savedCFrame then return end
                    local _mc = _pGetChar(lp)
                    local _mr = _mc and _pGetRoot(_mc)
                    if _mr then pcall(function() _mr.CFrame = savedCFrame end) end
                end
                local function _tfRestoreAR()
                    local _mc = _pGetChar(lp)
                    local _mh = _mc and _pGetHum(_mc)
                    if _mh then pcall(function() _mh.AutoRotate = true end) end
                end

                local _dummyRespawnConn = workspace.Live.ChildAdded:Connect(function(child)
                    if child.Name == "Weakest Dummy" then
                        grabbed[child] = nil
                    end
                end)

                local _ffWatchConn = RunService.RenderStepped:Connect(function()
                    for _, p in pairs(_pGetAllPlayers()) do
                        if table.find(RevenantWhitelist, p) then continue end
                        if not grabbed[p] then continue end
                        local pc = _pGetChar(p)
                        local ph = pc and _pGetHum(pc)
                        if pc and ph and ph.Health > 0 and not _hasAnyFF(pc) then
                            grabbed[p] = nil
                            if not currentTarget then
                                _tfSwitchTarget(p)
                            end
                        end
                    end
                end)

                local function _hasFFPending()
                    for _, p in pairs(_pGetAllPlayers()) do
                        if grabbed[p] then continue end
                        if table.find(RevenantWhitelist, p) then continue end
                        if _isOnlyFF(p) then return true end
                    end
                    return false
                end

                local _tfCleaned = false
                local function _tfCleanup()
                    if _tfCleaned then return end
                    _tfCleaned = true
                    _aaDetach()
                    _tfRestoreAR()
                    if _ffWatchConn then
                        pcall(function() _ffWatchConn:Disconnect() end)
                    end
                    if _dummyRespawnConn then
                        pcall(function() _dummyRespawnConn:Disconnect() end)
                    end
                    if _currentTargetAnimConn then
                        pcall(function() _currentTargetAnimConn:Disconnect() end)
                        _currentTargetAnimConn = nil
                    end
                    tfActive = false
                    _aaEnd()
                end

                local _everybodyDone = false
                local _firstTarget = _pickTarget(nil)
                if _firstTarget then
                    _tfSwitchTarget(_firstTarget)
                    if _pickTarget(_firstTarget) == nil then
                        task.wait(0.1)
                        grabbed[_firstTarget] = true
                        _everybodyDone = true
                        _tfCleanup()
                        return
                    end
                end

                while animTrack.IsPlaying and tick() < deadline do
                    RunService.Heartbeat:Wait()

                    local now = tick()
                    local needSwitch = false

                    if not currentTarget then
                        needSwitch = true
                    else
                        if _isBlacklisted(currentTarget) then
                            if not _isOnlyFF(currentTarget) then
                                grabbed[currentTarget] = true
                            end
                            needSwitch = true
                        elseif now - targetSince >= 0.8 then
                            grabbed[currentTarget] = true
                            needSwitch = true
                        end
                    end

                    if needSwitch then
                        local next = _pickTarget(currentTarget)
                        if not next then
                            if _hasFFPending() then
                                _aaDetach()
                                currentTarget = nil
                            else
                                _everybodyDone = true
                                _tfCleanup()
                                break
                            end
                        else
                            _tfSwitchTarget(next)
                            if _pickTarget(next) == nil and not _hasFFPending() then
                                task.wait(0.1)
                                grabbed[next] = true
                                _everybodyDone = true
                                _tfCleanup()
                                break
                            end
                        end
                    end

                    do
                        local _dum = _getDummy()
                        if _dum and not grabbed[_dum] then
                            local _dumHum = _dum:FindFirstChild("Humanoid")
                            local _dumAnimator = _dumHum and _dumHum:FindFirstChild("Animator")
                            local function _dumIsAnimPlaying(id)
                                if not _dumAnimator then return false end
                                for _, t in pairs(_dumAnimator:GetPlayingAnimationTracks()) do
                                    if tostring(t.Animation.AnimationId):match(id) then return true end
                                end
                                return false
                            end
                            if _dumHum and (_dumIsAnimPlaying('18896222853') or _dumIsAnimPlaying('137434257516014')) then
                                grabbed[_dum] = true
                                if currentTarget == _dum then
                                    _aaDetach()
                                    local nextP = _pickTarget(_dum)
                                    if nextP then
                                        _tfSwitchTarget(nextP)
                                        if _pickTarget(nextP) == nil and not _hasFFPending() then
                                            task.wait(0.1)
                                            grabbed[nextP] = true
                                            _everybodyDone = true
                                            _tfCleanup()
                                            break
                                        end
                                    else
                                        if _hasFFPending() then
                                            currentTarget = nil
                                        else
                                            _everybodyDone = true
                                            _tfCleanup()
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                _tfCleanup()
            end)
        end

        if _AnimationId:match('93546004428904') and AttackAllMoves['Crushed Rock Variant'] then
            _crBlacklistCount = 0
            _crStopDesync     = false
            task.spawn(function()
                local _mc = _pGetChar(lp)
                local _mh = _mc and _pGetHum(_mc)
                local _ma = _mh and _mh:FindFirstChild("Animator")
                if not _ma then return end
                while true do
                    local _windupStillOn = false
                    for _, t in pairs(_ma:GetPlayingAnimationTracks()) do
                        if tostring(t.Animation.AnimationId):match('93546004428904') then
                            _windupStillOn = true break
                        end
                    end
                    if not _windupStillOn then
                        _crBlacklistCount = 0
                        _crStopDesync     = false
                        break
                    end
                    for _, p in pairs(Players:GetPlayers()) do
                        if p == lp then continue end
                        local pc = _pGetChar(p)
                        local ph = pc and _pGetHum(pc)
                        if ph and pc and not pc:GetAttribute('CrushedRockVariant') then
                            if _pIsAnimPlaying(ph, '129945907044125') then
                                pc:SetAttribute('CrushedRockVariant', true)
                                _crBlacklistCount = _crBlacklistCount + 1
                            end
                        end
                    end
                    local _dum = workspace.Live:FindFirstChild("Weakest Dummy")
                    local _dumH = _dum and _dum:FindFirstChild("Humanoid")
                    local _dumA = _dumH and _dumH:FindFirstChild("Animator")
                    if _dumA and _dum and not _dum:GetAttribute('CrushedRockVariant') then
                        for _, t in pairs(_dumA:GetPlayingAnimationTracks()) do
                            if tostring(t.Animation.AnimationId):match('129945907044125') then
                                _dum:SetAttribute('CrushedRockVariant', true)
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end

        if _AnimationId:match('72451715583225') and AttackAllMoves['Crushed Rock Variant'] then
            task.spawn(function()
                for _, p in pairs(Players:GetPlayers()) do
                    if p == lp then continue end
                    local pc = _pGetChar(p)
                    if pc then pc:SetAttribute('CrushedRockVariant', nil) end
                end
                local _dum = workspace.Live:FindFirstChild("Weakest Dummy")
                if _dum then _dum:SetAttribute('CrushedRockVariant', nil) end
            end)
            if _crWindupSuccess then
                _crWindupSuccess = false 
            end
        end

        if _AnimationId:match('131226430469931') and AttackAllMoves['Crushed Rock Variant'] then
            task.spawn(function()
                task.wait(1.2)
                local _mc3 = _pGetChar(lp)
                local _mr3 = _mc3 and _pGetRoot(_mc3)
                if not _mr3 then return end
                if (tonumber(lp:GetAttribute("Ultimate")) or 0) >= 100 then return end
                getgenv().desync = { CFrame = CFrame.new(0, -29000, 0) }
                task.wait(0.65)
                getgenv().desync = nil
            end)
        end
        if _AnimationId:match('135104210400610') and AttackAllMoves['Crushed Rock Variant'] then
            local _currentHitConfirmed = false
            local _respawnConns = {}           

            local _crCurrentConn = nil
            local _crRotConn     = nil
            local _crMyRoot      = nil
            local _crTargetRoot  = nil

            local function _crDetach()
                if _crCurrentConn then _crCurrentConn:Disconnect() _crCurrentConn = nil end
                if _crRotConn     then _crRotConn:Disconnect()     _crRotConn     = nil end
                if sethiddenproperty then
                    if _crMyRoot     and _crMyRoot.Parent     then pcall(function() sethiddenproperty(_crMyRoot,     "PhysicsRepRootPart", nil) end) end
                    if _crTargetRoot and _crTargetRoot.Parent then pcall(function() sethiddenproperty(_crTargetRoot, "PhysicsRepRootPart", nil) end) end
                end
                if _crMyRoot and _crMyRoot.Parent then
                    _crMyRoot.CFrame                  = CFrame.new(_crMyRoot.Position)
                    _crMyRoot.AssemblyLinearVelocity  = Vector3.zero
                    _crMyRoot.AssemblyAngularVelocity = Vector3.zero
                    pcall(function() _crMyRoot.Velocity    = Vector3.zero end)
                    pcall(function() _crMyRoot.RotVelocity = Vector3.zero end)
                    local _dh = _crMyRoot.Parent:FindFirstChildOfClass("Humanoid")
                    if _dh then pcall(function() _dh.AutoRotate = true end) end
                end
                _crMyRoot     = nil
                _crTargetRoot = nil
            end

            local function _crAttach(myRoot, targetRoot)
                if _crCurrentConn then _crCurrentConn:Disconnect() _crCurrentConn = nil end
                if _crMyRoot and _crMyRoot.Parent then
                    _crMyRoot.AssemblyLinearVelocity  = Vector3.zero
                    _crMyRoot.AssemblyAngularVelocity = Vector3.zero
                    pcall(function() _crMyRoot.Velocity    = Vector3.zero end)
                    pcall(function() _crMyRoot.RotVelocity = Vector3.zero end)
                end
                if not myRoot or not targetRoot then return end
                _crMyRoot     = myRoot
                _crTargetRoot = targetRoot
                if _crRotConn then _crRotConn:Disconnect() _crRotConn = nil end
                local _rotHum = myRoot.Parent and myRoot.Parent:FindFirstChildOfClass("Humanoid")
                if _rotHum then
                    _crRotConn = RunService.RenderStepped:Connect(function()
                        if _rotHum and _rotHum.Parent then
                            pcall(function() _rotHum.AutoRotate = false end)
                        end
                    end)
                end
                myRoot.CFrame                  = targetRoot.CFrame * CFrame.new(0, 0, 5)
                myRoot.AssemblyLinearVelocity  = Vector3.zero
                myRoot.AssemblyAngularVelocity = Vector3.zero
                if sethiddenproperty then
                    pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", myRoot) end)
                    pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot) end)
                end
                local _selfConn
                _selfConn = RunService.Heartbeat:Connect(function()
                    if not myRoot or not myRoot.Parent
                    or not targetRoot or not targetRoot.Parent then
                        _selfConn:Disconnect()
                        if _crCurrentConn == _selfConn then _crCurrentConn = nil end
                        if sethiddenproperty then
                            if myRoot and myRoot.Parent then
                                pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", nil) end)
                            end
                            if targetRoot and targetRoot.Parent then
                                pcall(function() sethiddenproperty(targetRoot, "PhysicsRepRootPart", nil) end)
                            end
                        end
                        if myRoot and myRoot.Parent then
                            myRoot.AssemblyLinearVelocity  = Vector3.zero
                            myRoot.AssemblyAngularVelocity = Vector3.zero
                            pcall(function() myRoot.Velocity    = Vector3.zero end)
                            pcall(function() myRoot.RotVelocity = Vector3.zero end)
                        end
                        return
                    end
                    myRoot.CFrame                  = targetRoot.CFrame * CFrame.new(0, 0, 5)
                    myRoot.AssemblyLinearVelocity  = Vector3.zero
                    myRoot.AssemblyAngularVelocity = Vector3.zero
                    if sethiddenproperty then
                        pcall(function() sethiddenproperty(myRoot, "PhysicsRepRootPart", targetRoot) end)
                    end
                end)
                _crCurrentConn = _selfConn
            end

            local function _crEnd()
                _crDetach()
            end

            for _, p in pairs(Players:GetPlayers()) do
                if p == lp then continue end
                local pc = _pGetChar(p)
                local ph = pc and pc:FindFirstChildOfClass("Humanoid")
                if ph then
                    local dc = ph.Died:Connect(function()
                        local chr = _pGetChar(p)
                        if chr then chr:SetAttribute('CrushedRockVariant', nil) end
                    end)
                    table.insert(_respawnConns, dc)
                end
                local cc = p.CharacterAdded:Connect(function(chr)
                    task.wait(0.1)
                    if chr then chr:SetAttribute('CrushedRockVariant', nil) end
                end)
                table.insert(_respawnConns, cc)
            end
            task.spawn(function()
                local _dum  = workspace.Live:FindFirstChild("Weakest Dummy")
                if _dum then
                    local ac = _dum.AncestryChanged:Connect(function()
                        if not _dum:IsDescendantOf(workspace) then
                            pcall(function() _dum:SetAttribute('CrushedRockVariant', nil) end)
                        end
                    end)
                    table.insert(_respawnConns, ac)
                end
            end)

            local function _pickCrushTarget()
                local favored = {}
                local candidates = {}

                for _, p in pairs(_pGetAllPlayers()) do
                    if table.find(RevenantWhitelist, p) then continue end
                    local pc = _pGetChar(p)
                    local ff = pc and (pc:FindFirstChild('ForceField') or pc:FindFirstChild('AbsoluteImmortal') or pc:FindFirstChild('BeingGrabbed') or pc:FindFirstChild('HunterCounter') or pc:FindFirstChild('AtomicCounter'))
                    if pc and not ff and not pc:GetAttribute('CrushedRockVariant') then
                        if not (pc:GetAttribute("Ulted") and pc:GetAttribute("Character") == "Batter") then
                            if _aaIsFavoredCharacterTarget(p) then
                                table.insert(favored, p)
                            else
                                table.insert(candidates, p)
                            end
                        end
                    end
                end

                if #favored > 0 then return favored[math.random(1, #favored)] end
                if #candidates > 0 then return candidates[math.random(1, #candidates)] end

                local dummy = workspace.Live:FindFirstChild("Weakest Dummy")
                local dRoot = dummy and (dummy:FindFirstChild("HumanoidRootPart") or dummy.PrimaryPart)
                local dHum  = dummy and dummy:FindFirstChildOfClass("Humanoid")
                if dRoot and dHum and dHum.Health > 0
                and not dummy:GetAttribute('CrushedRockVariant')
                and not dummy:GetAttribute('Freeze') and not dummy:FindFirstChild('BeingGrabbed')
                and not dummy:FindFirstChild('HunterCounter') and not dummy:FindFirstChild('AtomicCounter') then
                    return dummy
                end
                return nil
            end

            local currentTarget = _pickCrushTarget()
            local _isDummy      = currentTarget == workspace.Live:FindFirstChild("Weakest Dummy")
            local currentTChar  = _isDummy and currentTarget or (currentTarget and _pGetChar(currentTarget))

            do
                local myChar = _pGetChar(lp)
                local myRoot = myChar and _pGetRoot(myChar)
                local initTr = currentTChar and (currentTChar:FindFirstChild("HumanoidRootPart") or _pGetRoot(currentTChar))
                if myRoot and initTr then _crAttach(myRoot, initTr) end
                if _isDummy and currentTChar then
                    currentTChar:SetAttribute('CrushedRockVariant', true)
                end
            end

            local function _crSwitch(newTarget, hitConfirmed)
                _crDetach()
                if hitConfirmed and currentTChar then
                    currentTChar:SetAttribute('CrushedRockVariant', true)
                end
                _currentHitConfirmed = false
                local isDummy = newTarget == workspace.Live:FindFirstChild("Weakest Dummy")
                currentTarget = isDummy and nil or newTarget
                currentTChar  = isDummy and newTarget or (newTarget and _pGetChar(newTarget))
                if isDummy and currentTChar then
                    currentTChar:SetAttribute('CrushedRockVariant', true)
                end

                local myChar = _pGetChar(lp)
                local myRoot = myChar and _pGetRoot(myChar)
                local tr = currentTChar and (currentTChar:FindFirstChild("HumanoidRootPart") or _pGetRoot(currentTChar))
                if myRoot and tr then _crAttach(myRoot, tr) end
            end

            local _crAllDone     = false  

            local conn
            conn = RunService.Heartbeat:Connect(function()
                if _crAllDone then
                    conn:Disconnect()
                    _crEnd()
                    for _, c in pairs(_respawnConns) do pcall(function() c:Disconnect() end) end
                    _respawnConns = {}
                    return
                end
                if not animTrack.IsPlaying then
                    conn:Disconnect()
                    _crEnd()
                    for _, c in pairs(_respawnConns) do pcall(function() c:Disconnect() end) end
                    _respawnConns = {}
                    if _currentHitConfirmed and currentTChar and currentTChar ~= workspace.Live:FindFirstChild("Weakest Dummy") then
                        currentTChar:SetAttribute('CrushedRockVariant', true)
                    end
                    return
                end

                if animTrack.TimePosition >= 1 then
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= lp then
                            local pc = _pGetChar(p)
                            if pc then pc:SetAttribute('CrushedRockVariant', nil) end
                        end
                    end
                end

                local myChar = _pGetChar(lp)
                local myRoot = myChar and _pGetRoot(myChar)
                local myHum  = myChar and _pGetHum(myChar)

                for _, p in pairs(Players:GetPlayers()) do
                    if p == lp then continue end
                    local pc = _pGetChar(p)
                    local ph = pc and pc:FindFirstChildOfClass("Humanoid")
                    local pr = pc and pc:FindFirstChild("HumanoidRootPart")
                    if not ph or not pr then continue end
                    if pc:GetAttribute('CrushedRockVariant') then continue end
                    if pc:FindFirstChild('AbsoluteImmortal') or pc:FindFirstChild('HunterCounter') or pc:FindFirstChild('AtomicCounter') then continue end
                    if _pIsAnimPlaying(ph, '129945907044125')
                    and myHum and _pIsAnimPlaying(myHum, '131226430469931') then
                        if currentTarget == p then
                            _currentHitConfirmed = true
                            local next = _pickCrushTarget()
                            if next and next ~= currentTarget then
                                _crSwitch(next, true)
                            elseif not next then
                                _crDetach()
                                if currentTChar then currentTChar:SetAttribute('CrushedRockVariant', true) end
                                _crAllDone = true
                            end
                        end
                    end
                end

                for _, p in pairs(Players:GetPlayers()) do
                    if p == lp then continue end
                    local pc = _pGetChar(p)
                    local ph = pc and pc:FindFirstChildOfClass("Humanoid")
                    local pr = pc and pc:FindFirstChild("HumanoidRootPart")
                    if not ph or not pr then continue end
                    if pc:GetAttribute('CrushedRockVariant') then continue end
                    if pc:FindFirstChild('AbsoluteImmortal') or pc:FindFirstChild('HunterCounter') or pc:FindFirstChild('AtomicCounter') then continue end
                    if _pIsAnimPlaying(ph, '80910065447206') then
                        if myRoot and pr then
                            local _liveDum = workspace.Live:FindFirstChild("Weakest Dummy")
                            if currentTChar and currentTChar == _liveDum then
                                currentTChar:SetAttribute('CrushedRockVariant', true)
                            end
                            _crAttach(myRoot, pr)
                            pc:SetAttribute('CrushedRockVariant', true)
                            currentTarget = p
                            currentTChar  = pc
                            _currentHitConfirmed = true
                        end
                    end
                end

                do
                    local _dum = workspace.Live:FindFirstChild("Weakest Dummy")
                    local _dumHum = _dum and _dum:FindFirstChild("Humanoid")
                    local _dumAnimator2 = _dumHum and _dumHum:FindFirstChild("Animator")
                    local function _dumIsAnimPlaying2(id)
                        if not _dumAnimator2 then return false end
                        for _, t in pairs(_dumAnimator2:GetPlayingAnimationTracks()) do
                            if tostring(t.Animation.AnimationId):match(id) then return true end
                        end
                        return false
                    end
                    if _dum and _dumHum and not _dum:GetAttribute('CrushedRockVariant') then
                        if _dumIsAnimPlaying2('129945907044125')
                        or _dumIsAnimPlaying2('80910065447206') then
                            _dum:SetAttribute('CrushedRockVariant', true)
                            if _dumIsAnimPlaying2('80910065447206') then
                                local _myC2 = _pGetChar(lp)
                                local _myH2 = _myC2 and _pGetHum(_myC2)
                                if _myH2 and _pIsAnimPlaying(_myH2, '131226430469931') then
                                    task.spawn(function()
                                        task.wait(1.2)
                                        local _mc3 = _pGetChar(lp)
                                        local _mr3 = _mc3 and _pGetRoot(_mc3)
                                        if not _mr3 then return end
                                        if (tonumber(lp:GetAttribute("Ultimate")) or 0) >= 100 then return end
                                        getgenv().desync = { CFrame = CFrame.new(0, -29000, 0) }
                                        task.wait(0.65)
                                        getgenv().desync = nil
                                    end)
                                end
                            end
                            if currentTChar == _dum then
                                _crDetach()
                                local next = _pickCrushTarget()
                                if next and next ~= _dum then
                                    _crSwitch(next, false)
                                else
                                    _crAllDone = true
                                end
                            end
                        end
                    end
                end

                if currentTChar and not currentTChar.Parent then
                    pcall(function() currentTChar:SetAttribute('CrushedRockVariant', nil) end)
                    local next = _pickCrushTarget()
                    if next then
                        _crSwitch(next, false)
                    else
                        _crAllDone = true
                    end
                end

                local currFF = currentTChar and (currentTChar:FindFirstChild('ForceField') or currentTChar:FindFirstChild('AbsoluteImmortal') or currentTChar:FindFirstChild('BeingGrabbed') or currentTChar:FindFirstChild('HunterCounter') or currentTChar:FindFirstChild('AtomicCounter'))
                if currFF then
                    local next = _pickCrushTarget()
                    if next and next ~= currentTarget then
                        _crSwitch(next, false)
                    elseif not next then
                        _crAllDone = true
                    end
                end
            end)
        end
    end

    -- Đăng ký sự kiện khi người chơi có Animator
    local function characterAdded(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if humanoid then
            local animator = humanoid:WaitForChild("Animator", 5)
            if animator then
                animator.AnimationPlayed:Connect(onAnimationPlayed)
            end
        end
    end

    if lp.Character then 
        characterAdded(lp.Character) 
    end
    lp.CharacterAdded:Connect(characterAdded)
end

-- Chạy Setup Hook
SetupAttackAll()
--==================================================

local TeleportsSection = MainTab:Section({
    Title = "Teleports",
    Desc = "Tele to jail, mountain, middle map,...", -- optional
    Icon = "shield", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(235, 255, 0), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

--==============================
-- MAP CFRAME
--==============================
local Maps = {
    ['Arena'] = CFrame.new(-130, 440, -373) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Baseplate'] = CFrame.new(-42, 1860, 25227) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Below Baseplate'] = CFrame.new(-42, 1475, 25227) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Jail'] = CFrame.new(440, 440, -395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Jail But Smaller'] = CFrame.new(20, 439, -460) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Bigger Jail'] = CFrame.new(290, 440, 465) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Even Bigger Jail'] = CFrame.new(378, 439, 457) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Dark Domain'] = CFrame.new(-80, 84, 20395) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Death Counter'] = CFrame.new(-66, 29, 20383) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Middle'] = CFrame.new(155, 441, 45) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Mountain 1'] = CFrame.new(306, 671, 411) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Mountain 2'] = CFrame.new(-1, 653, -354) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
    ['Mountain Edge'] = CFrame.new(-297, 594, -336) * CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(-90), 0, 0),
}

-- lưu map được chọn
local SelectedMap = nil

--==============================
-- DROPDOWN
--==============================
TeleportsSection:Dropdown({
    Title = "Select map",
    Desc = "TP to map u chose",
    Values = {
        "Arena",
        "Baseplate",
        "Below Baseplate",
        "Jail",
        "Jail But Smaller",
        "Even Bigger Jail",
        "Bigger Jail",
        "Dark Domain",
        "Death Counter",
        "Middle",
        "Mountain 1",
        "Mountain 2",
        "Mountain Edge"
    },
    Value = "",
    Multi = false,
    Locked = false,
    Flag = "my_dropdown",
    Callback = function(selected)
        SelectedMap = selected
    end
})

--==============================
-- BUTTON TELEPORT
--==============================
TeleportsSection:Button({
    Title = "Teleport",
    Desc = "Click to teleport",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",

    Callback = function()

        if not SelectedMap then
            warn("No map selected")
            return
        end

        local char = player.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local cf = Maps[SelectedMap]
        if cf then
            hrp.CFrame = cf
        end

    end
})

-- ── STAND LOGIC & UI ──────────────────────────────────────────────────────────
do
    local Players    = game:GetService("Players")
    local lp         = Players.LocalPlayer
    local RunService = game:GetService("RunService")
    
    -- State
    local _standTarget          = nil   -- Player object
    local _standFollowMode      = true  -- true = Follow, false = Don't Follow
    local _standActive          = false

    -- Connections 
    local _standHeartbeat          = nil   
    local _standAnimConn           = nil   
    local _standCharConn           = nil   
    local _standMyAnimConn         = nil   
    local _standMyCharConn         = nil   
    local _standPlayerRemovingConn = nil   
    local _standIdleRenderConn     = nil   
    local _standIdleTrack          = nil   
    local _lastIdleStart           = 0     

    local _standCooldowns       = { 0, 0, 0, 0 }
    local _blockCount           = 0     
    local _suppressFollow       = 0     
    local _tempMoveConn         = nil 
    local _startFollowLoop      -- forward-declared

    local _idleOffset           = CFrame.new(-2, 2, 5)
    local _attackOffset         = CFrame.new(0, 0, -4)
    local _currentOffset        = _idleOffset
    
    -- Biến lưu cấu hình từ UI
    local currentIdleSelection  = "1" 

    local _moveList = {
        { 'Normal Punch',             10468665991,   20,   1, 'Normal Punch'             },
        { 'Consecutive Punches',      10466974800,   15,   2, 'Consecutive Punches'      },
        { 'Shove',                    10471336737,   10,   3, 'Shove'                    },
        { 'Uppercut',                 12510170988,   20,   4, 'Uppercut'                 },
        { 'Table Flip',               11365563255,   20,   2, 'Table Flip'               },
        { 'Serious Punch',            12983333733,   20,   3, 'Serious Punch'            },
        { 'Omni Directional Punch',   13927612951,   20,   4, 'Omni Directional Punch'   },
        { 'Lethal Whirlwind Stream',  12296882427,   20,   2, 'Lethal Whirlwind Stream'  },
        { 'Flowing Water',            12272894215,   17.5, 1, 'Flowing Water'            },
        { 'Hunters Grasp',            12307656616,   15,   3, "Hunter's Grasp"           },
        { 'Preys Peril',              12351854556,   17,   4, "Prey's Peril"             },
        { 'Water Stream Cutting Fist',12460977270,   8.45, 1, 'Water Stream Cutting Fist'},
        { 'The Final Hunt',           12463072679,   101,  2, 'The Final Hunt'           },
        { 'Rock Splitting Fist',      14057231976,   14,   3, 'Rock Splitting Fist'      },
        { 'Crushed Rock',             13630786846,   9.58, 4, 'Crushed Rock'             },
        { 'Machine Gun Blows',        12534735382,   15,   1, 'Machine Gun Blows'        },
        { 'Ignition Burst',           12502664044,   17.5, 2, 'Ignition Burst'           },
        { 'Blitz Shot',               12618271998,   25,   3, 'Blitz Shot'               },
        { 'Jet Dive',                 12684390285,   17.5, 4, 'Jet Dive'                 },
        { 'Thunder Kick',             14721837245,   15,   1, 'Thunder Kick'             },
        { 'Speedblitz Dropkick',      12832505612,   20,   2, 'Speedblitz Dropkick'      },
        { 'Flamewave Cannon',         13083332742,   25,   3, 'Flamewave Cannon'         },
        { 'Incinerate',               13146710762,   101,  4, 'Incinerate'               },
        { 'Flash Strike',             13309500827,   17.5, 1, 'Flash Strike'             },
        { 'Whirlwind Kick',           13294790250,   20,   2, 'Whirlwind Kick'           },
        { 'Scatter',                  13362587853,   21.25,3, 'Scatter'                  },
        { 'Explosive Shuriken',       13501296372,   17.5, 4, 'Explosive Shuriken'       },
        { 'Twinblade Rush',           13632347366,   20,   1, 'Twinblade Rush'           },
        { 'Straight On',              13643152947,   17,   2, 'Straight On'              },
        { 'Carnage',                  13723174078,   25,   3, 'Carnage'                  },
        { 'Fourfold Flashstrike',     13881335713,   25,   4, 'Fourfold Flashstrike'     },
        { 'Homerun',                  14004235777,   17.5, 1, 'Homerun'                  },
        { 'Grand Slam',               14299135500,   20,   3, 'Grand Slam'               },
        { 'Foul Ball',                14351441234,   23,   4, 'Foul Ball'                },
        { 'Savage Tornado',           14719290328,   17,   1, 'Savage Tornado'           },
        { 'Brutal Beatdown',          14701242661,   30,   2, 'Brutal Beatdown'          },
        { 'Strength Difference',      14900168720,   20,   3, 'Strength Difference'      },
        { 'Death Blow',               15128849047,   101,  4, 'Death Blow'               },
        { 'Quick Slice',              15290930205,   20,   1, 'Quick Slice'              },
        { 'Atmos Cleave',             15145462680,   22,   2, 'Atmos Cleave'             },
        { 'Pinpoint Cut',             15295895753,   17,   3, 'Pinpoint Cut'             },
        { 'Split Second Counter',     15311685628,   17.5, 4, 'Split Second Counter'     },
        { 'Sunset',                   15520132233,   15,   1, 'Sunset'                   },
        { 'Solar Cleave',             15676072469,   15,   2, 'Solar Cleave'             },
        { 'Sunrise',                  16062410809,   20,   3, 'Sunrise'                  },
        { 'Atomic Slash',             16082123712,   101,  4, 'Atomic Slash'             },
        { 'Crushing Pull',            16139108718,   21,   1, 'Crushing Pull'            },
        { 'Windstorm Fury',           16515850153,   20,   2, 'Windstorm Fury'           },
        { 'Stone Coffin',             16431491215,   25,   3, 'Stone Coffin'             },
        { 'Expulsive Push',           16597322398,   19,   4, 'Expulsive Push'           },
        { 'Cosmic Strike',            16737255386,   30,   1, 'Cosmic Strike'            },
        { 'Psychic Ricochet',         17464644182,   15,   2, 'Psychic Ricochet'         },
        { 'Terrible Tornado',         17275150809,   101,  3, 'Terrible Tornado'         },
        { 'Sky Snatcher',             17860467628,   17,   4, 'Sky Snatcher'             },
        { 'Bullet Barrage',           17799224866,   20,   1, 'Bullet Barrage'           },
        { 'Vanishing Kick',           17838006839,   23,   2, 'Vanishing Kick'           },
        { 'Whirlwind Drop',           17857788598,   15,   3, 'Whirlwind Drop'           },
        { 'Head First',               18179181663,   20,   4, 'Head First'               },
        { 'Grand Fissure',            129651400898906, 18, 1, 'Grand Fissure'            },
        { 'Twin Fangs',               18896229321,   15,   2, 'Twin Fangs'               },
        { 'Earth Splitting Strike',   18897119503,   30,   3, 'Earth Splitting Strike'   },
        { 'Last Breath',              106755459092436, 101, 4, 'Last Breath'             },
        { 'Ravage',                   16945573694,   17.5, 1, 'Ravage'                   },
        { 'Swift Sweep',              16944265635,   15,   2, 'Swift Sweep'              },
        { 'Collateral Ruin',          17325254223,   22.5, 3, 'Collateral Ruin'          },
        { 'Spiraling Storm',          78521642007560, 22.5, 4, 'Spiraling Storm'         },
        { 'Stoic Bomb',               17141153099,   15,   1, 'Stoic Bomb'               },
        { '202020 Dropkick',          17354976067,   101,  2, '20-20-20 Dropkick'        },
        { 'Five Seasons',             18462892217,   100,  3, 'Five Seasons'             },
        { 'Unlimited Flex Works',     77727115892579, 0,   4, 'Unlimited Flex Works'     },
        { 'Permafrost',               100558589307006, 20, 1, 'Permafrost'               },
        { 'Frost Forge',              137561511768861, 15, 2, 'Frost Forge'              },
        { 'Freezing Path',            112620365240235, 25, 3, 'Freezing Path'            },
        { 'Judgement Chain',          75547590335774, 20,  4, 'Judgement Chain'          },
        { 'Weboom',                   113166426814229, 20, 1, 'Weboom'                   },
        { 'Trinity Tear',             77509627104305, 25,  2, 'Trinity Tear'             },
        { 'Plasma Cannon',            116753755471636, 20, 3, 'Plasma Cannon'            },
        { 'Double Trouble',           138443750790136, 20, 4, 'Double Trouble'           },
        { 'Doom Dive',                101588604872680, 23, 1, 'Doom Dive'               },
        { 'Crowd Buster',             105442749844047, 22, 2, 'Crowd Buster'             },
        { 'Hammer Heel',              109617620932970, 18, 3, 'Hammer Heel'              },
        { 'Binding Cloth',            125955606488863, 20, 4, 'Binding Cloth'            },
        { 'Hammer Heel',              135289891173395, 18, 3, 'Hammer Heel'              },
        { 'Machine Gun Blows',        12971270638,   15,   1, 'Machine Gun Blows'        },
        { 'Crushed Rock',             72451715583225, 9.58, 4, 'Crushed Rock'            },
        { 'Block',                    13380778193,   0,    0, 'Block'                    },
        { 'Block',                    13370310513,   0,    0, 'Block'                    },
        { 'Block',                    13935548552,   0,    0, 'Block'                    },
    }

    local function _removeCollision()
        local char = lp.Character
        if not char then return end
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA('BasePart') then p.CanCollide = false end
        end
    end

    local _standPartsState = {}

    local function _applyAttach()
        if not _standTarget or not _standTarget.Character then return end
        if not lp.Character then return end
        local myHRP     = lp.Character:FindFirstChild('HumanoidRootPart')
        local targetHRP = _standTarget.Character:FindFirstChild('HumanoidRootPart')
        if not myHRP or not targetHRP then return end

        _standPartsState = {}
        for _, p in pairs(lp.Character:GetDescendants()) do
            if p:IsA('BasePart') then
                _standPartsState[p] = { CanCollide = p.CanCollide, Massless = p.Massless }
                p.CanCollide = false
                p.Massless   = true
            end
        end

        local hum = lp.Character:FindFirstChildOfClass('Humanoid')
        if hum then
            pcall(function() hum.AutoRotate = false end)
            hum.PlatformStand = true
        end

        myHRP.CFrame                     = targetHRP.CFrame * _currentOffset
        myHRP.AssemblyLinearVelocity     = Vector3.zero
        myHRP.AssemblyAngularVelocity    = Vector3.zero
        if sethiddenproperty then
            pcall(function() sethiddenproperty(myHRP, 'PhysicsRepRootPart', targetHRP) end)
        end
    end

    local function _setAttachOffset(cf)
        _currentOffset = cf
    end

    local _standAttrConns = {}
    local function _disconnectAttrConns()
        for _, c in pairs(_standAttrConns) do pcall(function() c:Disconnect() end) end
        _standAttrConns = {}
    end

    -- Dictionary thay cho mảng để dễ dàng truy xuất thông qua key dạng String từ UI
    local _idleVariants = {
        ["1"] = { id = '16136144568', name = 'Idle 1', tpos = 0.69, free = true,  oscillate = true, tposMin = 0.45, tposMax = 0.70, speed = 0.1 },
        ["2"] = { id = '18450698238', name = 'Idle 2', tpos = 1,    free = false, oscillate = false },
        ["3"] = { id = '16524522673', name = 'Idle 3', tpos = 0.71, free = false, oscillate = false },
        ["4"] = { id = '15099756132', name = 'Idle 4', tpos = 0,    free = true,  oscillate = false },
    }

    local function _startIdleAnim()
        if not _standActive or not _standFollowMode then return end
        local _now = tick()
        if _standIdleTrack and _standIdleTrack.IsPlaying and (_now - _lastIdleStart) < 0.1 then return end
        _lastIdleStart = _now
        
        local char = lp.Character
        local hum2 = char and char:FindFirstChildWhichIsA('Humanoid')
        local animator = hum2 and hum2:FindFirstChildWhichIsA('Animator')
        if not animator then return end

        -- Lấy variant dựa trên UI, mặc định là "1"
        local picked = _idleVariants[currentIdleSelection] or _idleVariants["1"]
        
        if _standIdleRenderConn then _standIdleRenderConn:Disconnect() _standIdleRenderConn = nil end
        if _standIdleTrack then pcall(function() _standIdleTrack:Stop(0) end) _standIdleTrack = nil end
        
        local idleAnim = Instance.new('Animation')
        idleAnim.AnimationId = 'rbxassetid://' .. picked.id
        local idleTrack = animator:LoadAnimation(idleAnim)
        idleTrack.Priority = Enum.AnimationPriority.Action4
        idleTrack.Looped   = true
        _standIdleTrack = idleTrack
        
        if picked.free then
            idleTrack:Play()
            idleTrack:AdjustWeight(1)
            if picked.oscillate then
                idleTrack.TimePosition = picked.tpos
                idleTrack:AdjustSpeed(-(picked.speed or 0.1))
            elseif picked.tpos then
                idleTrack.TimePosition = picked.tpos
            end
            _standIdleRenderConn = RunService.RenderStepped:Connect(function()
                if not _standActive then
                    if _standIdleRenderConn then _standIdleRenderConn:Disconnect() _standIdleRenderConn = nil end
                    pcall(function() idleTrack:Stop(0) end)
                    _standIdleTrack = nil
                    return
                end
                if _suppressFollow > 0 then
                    if idleTrack.IsPlaying then pcall(function() idleTrack:Stop(0) end) end
                    return
                end
                if not idleTrack.IsPlaying then return end
                idleTrack:AdjustWeight(1)
                if picked.freezeAt and idleTrack.TimePosition >= picked.freezeAt then
                    idleTrack:AdjustSpeed(0)
                    idleTrack.TimePosition = picked.freezeAt
                elseif picked.oscillate then
                    local spd = picked.speed or 0.1
                    if idleTrack.TimePosition >= picked.tposMax then
                        idleTrack:AdjustSpeed(-spd)
                    elseif idleTrack.TimePosition <= picked.tposMin then
                        idleTrack:AdjustSpeed(spd)
                    end
                end
            end)
        else
            idleTrack:Play()
            idleTrack:AdjustSpeed(0)
            idleTrack:AdjustWeight(1)
            idleTrack.TimePosition = picked.tpos
            _standIdleRenderConn = RunService.RenderStepped:Connect(function()
                if not _standActive then
                    if _standIdleRenderConn then _standIdleRenderConn:Disconnect() _standIdleRenderConn = nil end
                    pcall(function() idleTrack:Stop(0) end)
                    _standIdleTrack = nil
                    return
                end
                if _suppressFollow > 0 then
                    if idleTrack.IsPlaying then pcall(function() idleTrack:Stop(0) end) end
                    return
                end
                if not idleTrack.IsPlaying then return end
                idleTrack:AdjustSpeed(0)
                idleTrack:AdjustWeight(1)
                idleTrack.TimePosition = picked.tpos
            end)
        end
    end

    local function _standDisconnectAll()
        _suppressFollow = 0
        _lastIdleStart  = 0
        if _standIdleRenderConn     then _standIdleRenderConn:Disconnect()     _standIdleRenderConn     = nil end
        if _standIdleTrack          then pcall(function() _standIdleTrack:Stop(0) end) _standIdleTrack = nil end
        if _standHeartbeat          then _standHeartbeat:Disconnect()          _standHeartbeat          = nil end
        if _tempMoveConn            then _tempMoveConn:Disconnect()            _tempMoveConn            = nil end
        if _standAnimConn           then _standAnimConn:Disconnect()           _standAnimConn           = nil end
        if _standCharConn           then _standCharConn:Disconnect()           _standCharConn           = nil end
        if _standMyAnimConn         then _standMyAnimConn:Disconnect()         _standMyAnimConn         = nil end
        if _standPlayerRemovingConn then _standPlayerRemovingConn:Disconnect() _standPlayerRemovingConn = nil end
        _disconnectAttrConns()
        pcall(function()
            if lp.Character then
                local hum = lp.Character:FindFirstChildWhichIsA('Humanoid')
                if hum then
                    hum.PlatformStand = false
                    pcall(function() hum.AutoRotate = true end)
                end
                local root = lp.Character:FindFirstChild('HumanoidRootPart')
                if root then
                    root.AssemblyLinearVelocity  = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                    pcall(function() root.Velocity    = Vector3.zero end)
                    pcall(function() root.RotVelocity = Vector3.zero end)
                    if sethiddenproperty then
                        pcall(function() sethiddenproperty(root, 'PhysicsRepRootPart', root) end)
                    end
                end
                for v, state in pairs(_standPartsState) do
                    if v and v.Parent then
                        v.CanCollide = state.CanCollide
                        v.Massless   = state.Massless
                    end
                end
                _standPartsState = {}
            end
        end)
        _standCooldowns = { 0, 0, 0, 0 }
    end

    local function _toggleFollowMode()
        _standFollowMode = not _standFollowMode
        if _standFollowMode then
            _startFollowLoop()
        else
            if _standHeartbeat then _standHeartbeat:Disconnect() _standHeartbeat = nil end
            if _tempMoveConn then _tempMoveConn:Disconnect() _tempMoveConn = nil end
            pcall(function()
                local hum2 = lp.Character and lp.Character:FindFirstChildOfClass('Humanoid')
                if hum2 then hum2.PlatformStand = false end
            end)
        end
    end

    local function _hookTargetAnims(targetPlayer)
        local char = targetPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildWhichIsA('Humanoid')
        if not hum then return end

        if _standAnimConn then _standAnimConn:Disconnect() _standAnimConn = nil end
        _standAnimConn = hum.AnimationPlayed:Connect(function(track)
            local animId = track.Animation and track.Animation.AnimationId or ''
            if animId:match('10470389827') or animId:match('13380778193') or animId:match('13370310513') or animId:match('13935548552') then
                _blockCount = _blockCount + 1
                if _blockCount >= 3 then
                    _blockCount = 0
                    _toggleFollowMode()
                end
                task.delay(1, function()
                    if _blockCount > 0 then
                        _blockCount = _blockCount - 1
                    end
                end)
                return
            end
            for _, move in pairs(_moveList) do
                if animId == 'rbxassetid://' .. tostring(move[2]) then
                    local slot = move[4]
                    if slot == 0 then break end
                    _standCooldowns[slot] = move[3]
                    task.spawn(function()
                        task.wait(move[3])
                        _standCooldowns[slot] = 0
                    end)
                end
            end
        end)

        _disconnectAttrConns()
        for _, move in pairs(_moveList) do
            local attrName = 'Holding' .. string.gsub(move[1], ' ', '')
            pcall(function() char:SetAttribute(attrName, false) end)
            local conn = char:GetAttributeChangedSignal(attrName):Connect(function()
                if char:GetAttribute(attrName) == true and _standCooldowns[move[4]] ~= 0 then
                    for _, other in pairs(_moveList) do
                        if other[4] == move[4] and lp.Backpack:FindFirstChild(other[5]) then
                            pcall(function()
                                lp.Character.Communicate:FireServer(unpack({{
                                    Tool = lp.Backpack:WaitForChild(other[5]),
                                    Goal = 'Console Move',
                                }}))
                            end)
                        end
                    end
                end
            end)
            table.insert(_standAttrConns, conn)
        end
    end

    local function _hookLocalAnims()
        if _standMyAnimConn then _standMyAnimConn:Disconnect() _standMyAnimConn = nil end
        local char = lp.Character
        if not char then return end
        local hum      = char:FindFirstChildWhichIsA('Humanoid')
        local animator = hum and hum:FindFirstChildWhichIsA('Animator')
        if not hum then return end

        local function onAnimPlayed(track)
            local animId = track.Animation and track.Animation.AnimationId or ''
            animId = animId:gsub('%s+', '')
            for _, move in pairs(_moveList) do
                local moveId = 'rbxassetid://' .. tostring(move[2])
                if animId == moveId then
                    if move[4] == 0 then break end
                    _setAttachOffset(_attackOffset)
                    task.spawn(function()
                        if _tempMoveConn then _tempMoveConn:Disconnect() _tempMoveConn = nil end
                        local mh0     = lp.Character and lp.Character:FindFirstChild('HumanoidRootPart')
                        local savedCF = (not _standFollowMode) and mh0 and mh0.CFrame
                        _suppressFollow = _suppressFollow + 1
                        pcall(function()
                            local hum = lp.Character and lp.Character:FindFirstChildWhichIsA('Humanoid')
                            if hum then hum.PlatformStand = false end
                        end)

                        _tempMoveConn = RunService.Heartbeat:Connect(function()
                            local mh = lp.Character and lp.Character:FindFirstChild('HumanoidRootPart')
                            local th = _standTarget and _standTarget.Character
                                       and _standTarget.Character:FindFirstChild('HumanoidRootPart')
                            if mh and th then
                                mh.CFrame                  = th.CFrame * _attackOffset
                                mh.AssemblyLinearVelocity  = Vector3.zero
                                mh.AssemblyAngularVelocity = Vector3.zero
                                if sethiddenproperty then
                                    pcall(function() sethiddenproperty(mh, 'PhysicsRepRootPart', th) end)
                                end
                            end
                        end)
                        track.Stopped:Wait()
                        if _tempMoveConn then _tempMoveConn:Disconnect() _tempMoveConn = nil end
                        _suppressFollow = math.max(0, _suppressFollow - 1)
                        if _suppressFollow > 0 then return end
                        _setAttachOffset(_idleOffset)
                        if _standFollowMode then
                            _lastIdleStart = 0
                        else
                            local mhFinal = lp.Character and lp.Character:FindFirstChild('HumanoidRootPart')
                            if mhFinal and savedCF then
                                mhFinal.CFrame                  = savedCF
                                mhFinal.AssemblyLinearVelocity  = Vector3.zero
                                mhFinal.AssemblyAngularVelocity = Vector3.zero
                            end
                        end
                    end)
                    break
                end
            end
        end

        _standMyAnimConn = hum.AnimationPlayed:Connect(onAnimPlayed)
        if animator then
            local animatorConn = animator.AnimationPlayed:Connect(onAnimPlayed)
            local origConn = _standMyAnimConn
            _standMyAnimConn = {
                Disconnect = function()
                    pcall(function() origConn:Disconnect() end)
                    pcall(function() animatorConn:Disconnect() end)
                end
            }
        end
    end

    _startFollowLoop = function()
        if _standHeartbeat then _standHeartbeat:Disconnect() _standHeartbeat = nil end
        _standHeartbeat = RunService.Heartbeat:Connect(function()
            if not _standActive or _suppressFollow > 0 then return end
            if not _standTarget or not _standTarget.Character then return end
            if not lp.Character then return end
            local myHRP     = lp.Character:FindFirstChild('HumanoidRootPart')
            local targetHRP = _standTarget.Character:FindFirstChild('HumanoidRootPart')
            if not myHRP or not targetHRP then return end
            local hum = lp.Character:FindFirstChildOfClass('Humanoid')
            if hum then
                pcall(function() hum.AutoRotate = false end)
                if _standFollowMode then hum.PlatformStand = true end
            end
            if _standFollowMode then
                _removeCollision()
                myHRP.CFrame                  = targetHRP.CFrame * _currentOffset
                myHRP.AssemblyLinearVelocity  = Vector3.zero
                myHRP.AssemblyAngularVelocity = Vector3.zero
                if sethiddenproperty then
                    pcall(function() sethiddenproperty(myHRP, 'PhysicsRepRootPart', targetHRP) end)
                end
                local _needIdle = false
                if not _standIdleTrack then
                    _needIdle = true
                else
                    local _ok, _playing = pcall(function() return _standIdleTrack.IsPlaying end)
                    _needIdle = not _ok or not _playing
                end
                if _needIdle then
                    local now = tick()
                    if now - _lastIdleStart >= 1 then
                        _lastIdleStart = now
                        task.defer(_startIdleAnim)
                    end
                end
            end
        end)
    end

    local function _standDeactivate()
        _standActive = false
        _standDisconnectAll()
        if _standMyCharConn then _standMyCharConn:Disconnect() _standMyCharConn = nil end
    end

    local function _standActivate(targetPlayer)
        _standDisconnectAll()
        _standActive = true
        _standTarget = targetPlayer
        _currentOffset = _idleOffset
        local char = targetPlayer.Character
        if not char then
            _standCharConn = targetPlayer.CharacterAdded:Connect(function(c)
                local hum = c:WaitForChild('Humanoid', 10)
                if not hum then return end
                hum:WaitForChild('Animator', 10)
                _standActivate(targetPlayer)
            end)
            return
        end
        _applyAttach()
        _hookTargetAnims(targetPlayer)
        _hookLocalAnims()
        _startFollowLoop()
        task.defer(_startIdleAnim)
        
        _standCharConn = targetPlayer.CharacterAdded:Connect(function(c)
            local hum = c:WaitForChild('Humanoid', 10)
            if not hum then return end
            hum:WaitForChild('Animator', 10)
            if _standActive then _standActivate(targetPlayer) end
        end)
        
        if _standPlayerRemovingConn then _standPlayerRemovingConn:Disconnect() end
        _standPlayerRemovingConn = Players.PlayerRemoving:Connect(function(p)
            if p == targetPlayer then
                _standDeactivate()
                print("[Stand]: Target left the game.")
            end
        end)
        
        if _standMyCharConn then _standMyCharConn:Disconnect() end
        _standMyCharConn = lp.CharacterAdded:Connect(function(c)
            local hum = c:WaitForChild('Humanoid', 10)
            if not hum then return end
            hum:WaitForChild('Animator', 10)
            if not _standActive then return end
            if _standIdleRenderConn then _standIdleRenderConn:Disconnect() _standIdleRenderConn = nil end
            if _standIdleTrack then pcall(function() _standIdleTrack:Stop(0) end) _standIdleTrack = nil end
            _lastIdleStart = 0
            _applyAttach()
            _hookLocalAnims()
            if _standFollowMode then task.defer(_startIdleAnim) end
        end)
    end

    -- Hàm tìm kiếm người chơi thông qua chuỗi viết tắt
    local function GetPlayerFromPartialName(String)
        if not String or String == "" then return nil end
        local strl = string.lower(String)
        for _, p in ipairs(Players:GetPlayers()) do
            if string.lower(string.sub(p.Name, 1, #String)) == strl or string.lower(string.sub(p.DisplayName, 1, #String)) == strl then
                return p
            end
        end
        return nil
    end

    -- ── PHẦN UI TÍCH HỢP ────────────────────────────────────────────────────────
    
    local StandSection = MainTab:Section({
        Title = "Stand",
        Desc = "Need 2 player (use alt account)", 
        Icon = "bot",
        IconColor = Color3.fromRGB(235, 255, 0),
        TextSize = 20, 
        TextXAlignment = "Center", 
        Box = true, 
        BoxBorder = true, 
        Opened = false, 
        FontWeight = Enum.FontWeight.SemiBold, 
        DescFontWeight = Enum.FontWeight.Medium, 
        TextTransparency = 0, 
        DescTextTransparency = 0.4, 
    })

    local Input = StandSection:Input({
        Title = "Target Player",
        Placeholder = "Enter username to target...",
        Callback = function(text)
            local foundPlayer = GetPlayerFromPartialName(text)
            if foundPlayer then
                _standTarget = foundPlayer
                print("[Stand]: Target selected ->", foundPlayer.Name)
                
                -- Nếu Stand đang bật thì tự động re-activate lên mục tiêu mới
                if _standActive then
                    _standActivate(foundPlayer)
                end
            else
                print("[Stand]: Player not found")
            end
        end
    })

    local ModeDropdown = StandSection:Dropdown({
        Title = "Select Mode",
        Desc = "",
        Values = {
            "Off",
            "Follow",
            "Unfollow"
        },
        Value = "Off",
        Multi = false,
        Locked = false,
        Flag = "stand_mode_dropdown",
        Callback = function(selected)
            if selected == "Off" then
                _standActive = false
                _standFollowMode = true
                _standDeactivate()
                
            elseif selected == "Follow" then
                _standFollowMode = true
                if _standTarget then
                    _standActivate(_standTarget)
                else
                    print("[Stand]: Vui lòng nhập Target Player trước.")
                end
                
            elseif selected == "Unfollow" then
                _standFollowMode = false
                if _standTarget then
                    _standActivate(_standTarget)
                    
                    if _standHeartbeat then _standHeartbeat:Disconnect() _standHeartbeat = nil end
                    pcall(function()
                        local hum = lp.Character and lp.Character:FindFirstChildWhichIsA('Humanoid')
                        if hum then hum.PlatformStand = false end
                    end)
                else
                    print("[Stand]: Vui lòng nhập Target Player trước.")
                end
            end
        end
    })

    local IdleDropdown = StandSection:Dropdown({
        Title = "Select Idle Animation",
        Desc = "",
        Values = {
            "1",
            "2",
            "3",
            "4"
        },
        Value = "1",
        Multi = false,
        Locked = false,
        Flag = "stand_idle_dropdown",
        Callback = function(selected)
            currentIdleSelection = selected
            
            -- Nếu đang Follow thì Restart animation ngay lập tức
            if _standActive and _standFollowMode then
                if _standIdleRenderConn then _standIdleRenderConn:Disconnect() _standIdleRenderConn = nil end
                if _standIdleTrack then pcall(function() _standIdleTrack:Stop(0) end) _standIdleTrack = nil end
                _lastIdleStart = 0
                task.defer(_startIdleAnim)
            end
        end
    })

    StandSection:Paragraph({
        Title = "HOW TO USE",
        Desc = "Select a target and choose Follow or Don't Follow.\n\nStand attaches behind the target and mirrors their position.\n\n3 blocks in a row from the target toggles the mode.\n\nWhen you use a move and the target has that move on cooldown, Stand auto-uses it.\n\nIn Unfollow mode, you stay in place. Stand only acts during your moves.",
        Color = Color3.fromRGB(100, 200, 255),
    })

end
-- ── KẾT THÚC STAND LOGIC & UI ─────────────────────────────────────────────────

--//Info
local InfoTab = Window:Tab({
    Title = "Info",
    Desc = "Info of script!", -- optional
    Icon = "info", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(0, 0, 0), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

InfoTab:Paragraph({
    Title = "Server Discord",
    Desc = "join our server discord to get more info",
    Image = "info",
    ImageSize = 50,
    Thumbnail = "rbxassetid://125730749882439",
    ThumbnailSize = 280,
    Color = Color3.fromRGB(88, 101, 242),
    Buttons = {
        {
            Title = "Copy Link",
            Icon = "link",
            Callback = function()
                setclipboard("discord.gg/invite/CFqVFhdFeJ")
            end
        }
    }
})

InfoTab:Paragraph({
    Title = "UPDATE SCRIPT:",
    Color = "White",
    Desc = "[+] Remove Some Place For TP\n[+] Change Postion Baseplate, Below Baseplate, Mountain1, Mountai2 \n[+] Added Mountain 3, Ferries Wheel\n[+] Fixed UI Fly for Mobile user",
})

local ShaderTab = Window:Tab({
    Title = "Shader",
    Desc = "Make game beautiful", -- optional
    Icon = "blend", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(25, 255, 0), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

ShaderTab:Button({
    Title = "PShade Ultimate",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua'))()
    end
})

local PlayerTab = Window:Tab({
    Title = "Player",
    Desc = "Help you have best experience", -- optional
    Icon = "circle-user", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(10, 70, 250), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local PlayerSection = PlayerTab:Section({
    Title = "Player",
    Desc = "Help you have best experience", -- optional
    Icon = "user", -- lucide icon or "rbxassetid://". optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

PlayerSection:Toggle({
    Title = "No-Clip",
    Desc = "walk through walk",
    Icon = "brick-wall",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Flag = "my_toggle",
	Callback = function(state)

		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")

		local player = Players.LocalPlayer

		-- Biến lưu connection ngoài để không tạo trùng
		if _G.NoClipConnection then
			_G.NoClipConnection:Disconnect()
			_G.NoClipConnection = nil
		end

		if _G.NoClipCharConnection then
			_G.NoClipCharConnection:Disconnect()
			_G.NoClipCharConnection = nil
		end

		local function setCollision(character, value)
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = value
				end
			end
		end

		if state then

			local character = player.Character or player.CharacterAdded:Wait()

			-- Loop noclip
			_G.NoClipConnection = RunService.Stepped:Connect(function()
				if character and character.Parent then
					for _, part in ipairs(character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)

			-- Khi respawn vẫn giữ noclip
			_G.NoClipCharConnection = player.CharacterAdded:Connect(function(newChar)
				character = newChar
			end)

		else
			-- Tắt noclip
			local character = player.Character
			if character then
				setCollision(character, true)
			end
		end
	end
})

PlayerSection:Toggle({
    Title = "No Dash Cooldown",
	Desc = "Only work with Slidedash & Backdash",
    Value = false,
    Flag = "Player_NoDashCD",
    Callback = function(state)
        if state then
            workspace:SetAttribute("VIPServer", tostring(game.Players.LocalPlayer.UserId))
            workspace:SetAttribute("VIPServerOwner", game.Players.LocalPlayer.Name)
            workspace:SetAttribute("NoDashCooldown", true)
        else
            workspace:SetAttribute("NoDashCooldown", false)
        end
    end
})


PlayerSection:Button({
    Title = "Invisibility",
	Desc = "Only Invisible you cant attack anyone",
    Value = false,
    Flag = "my_fflag",
    Callback = function(state)
		-- Dọn dẹp kết nối cũ nếu có
		if _G.a then
			for _, conn in pairs(_G.a) do
				if conn then conn:Disconnect() end
			end
			_G.a = nil
		end

		repeat task.wait() until game.Players.LocalPlayer

		local _LocalPlayer = game.Players.LocalPlayer
		local RunService = game:GetService('RunService')
		local u6, u7, u8 = nil, nil, nil
		local u9 = false
		local u10 = {}
		local v31 = {} -- Chứa mọi Connection để xóa sạch khi Close

		local function u16()
			u6 = _LocalPlayer.Character or _LocalPlayer.CharacterAdded:Wait()
			u7 = u6:WaitForChild('Humanoid')
			u8 = u6:WaitForChild('HumanoidRootPart')
			u10 = {}

			for _, part in pairs(u6:GetDescendants()) do
				if part:IsA('BasePart') and part.Transparency == 0 then
					table.insert(u10, part)
				end
			end
		end

		u16()

		-- ==========================================
		-- UI PREMIUM: BAEMINH HUB
		-- ==========================================
		local ScreenGui = Instance.new('ScreenGui')
		ScreenGui.Name = "BaeMinhPremiumInvisible"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.Parent = game.CoreGui or _LocalPlayer:WaitForChild('PlayerGui')

		local MainFrame = Instance.new('Frame')
		MainFrame.Size = UDim2.new(0, 240, 0, 140)
		MainFrame.Position = UDim2.new(0.5, -120, 0.2, 0)
		MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18) -- Tối hơn để viền nổi bật
		MainFrame.BorderSizePixel = 0
		MainFrame.Parent = ScreenGui

		local UICorner = Instance.new('UICorner')
		UICorner.CornerRadius = UDim.new(0, 8)
		UICorner.Parent = MainFrame

		-- Hiệu ứng Animated Gradient Stroke cho MainFrame
		local UIStroke = Instance.new('UIStroke')
		UIStroke.Thickness = 2.5
		UIStroke.Parent = MainFrame

		local StrokeGradient = Instance.new('UIGradient')
		StrokeGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)),   -- Tím
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), -- Xanh ngọc
			ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255))    -- Tím (để loop mượt)
		})
		StrokeGradient.Parent = UIStroke

		-- Animation quay vòng cho Gradient
		local rotation = 0
		v31["GradientAnim"] = RunService.Heartbeat:Connect(function(dt)
			rotation = rotation + (dt * 60) -- Tốc độ chạy màu (tăng số 60 để nhanh hơn)
			if rotation >= 360 then rotation = 0 end
			StrokeGradient.Rotation = rotation
		end)

		-- Header / Tiêu đề
		local Title = Instance.new('TextLabel')
		Title.Size = UDim2.new(1, -40, 0, 30)
		Title.Position = UDim2.new(0, 15, 0, 5)
		Title.BackgroundTransparency = 1
		Title.Text = "Inivisible  |  BaeMinh Hub"
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.Font = Enum.Font.GothamBlack
		Title.TextSize = 13
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Parent = MainFrame

		-- Nút Close xịn xò
		local CloseBtn = Instance.new('TextButton')
		CloseBtn.Size = UDim2.new(0, 30, 0, 30)
		CloseBtn.Position = UDim2.new(1, -35, 0, 5)
		CloseBtn.BackgroundTransparency = 1
		CloseBtn.Text = "X"
		CloseBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
		CloseBtn.Font = Enum.Font.GothamBlack
		CloseBtn.TextSize = 15
		CloseBtn.Parent = MainFrame

		-- Gradient cho chữ Toggle để đồng bộ phong cách
		local ToggleBtn = Instance.new('TextButton')
		ToggleBtn.Size = UDim2.new(0, 190, 0, 40)
		ToggleBtn.Position = UDim2.new(0.5, -95, 0.4, 0)
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		ToggleBtn.Text = "Status: OFF"
		ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleBtn.Font = Enum.Font.GothamBold
		ToggleBtn.TextSize = 15
		ToggleBtn.Parent = MainFrame

		local ToggleCorner = Instance.new('UICorner')
		ToggleCorner.CornerRadius = UDim.new(0, 6)
		ToggleCorner.Parent = ToggleBtn

		local ToggleStroke = Instance.new('UIStroke')
		ToggleStroke.Color = Color3.fromRGB(50, 50, 60)
		ToggleStroke.Thickness = 1
		ToggleStroke.Parent = ToggleBtn

		-- Footer
		local Footer = Instance.new('TextLabel')
		Footer.Size = UDim2.new(1, 0, 0, 20)
		Footer.Position = UDim2.new(0, 0, 1, -25)
		Footer.BackgroundTransparency = 1
		Footer.Text = "by BaeMinhReal"
		Footer.TextColor3 = Color3.fromRGB(120, 120, 130)
		Footer.Font = Enum.Font.GothamSemibold
		Footer.TextSize = 10
		Footer.Parent = MainFrame

		-- ==========================================
		-- LOGIC KÉO THẢ UI (DRAGGABLE MƯỢT MÀ)
		-- ==========================================
		local dragging, dragInput, dragStart, startPos

		MainFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = MainFrame.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		MainFrame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				local delta = input.Position - dragStart
				MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)

		-- ==========================================
		-- CHỨC NĂNG INVISIBLE & CÁC KẾT NỐI
		-- ==========================================
		local function toggleInvisible()
			u9 = not u9
			
			if u9 then
				ToggleBtn.Text = "Status: ON"
				ToggleStroke.Color = Color3.fromRGB(0, 255, 255) -- Viền nút sáng lên khi bật
			else
				ToggleBtn.Text = "Status: OFF"
				ToggleStroke.Color = Color3.fromRGB(50, 50, 60)
			end

			for _, part in pairs(u10) do
				if part and part.Parent then
					part.Transparency = u9 and 0.5 or 0
				end
			end
		end

		ToggleBtn.MouseButton1Click:Connect(toggleInvisible)

		v31["Keybind"] = _LocalPlayer:GetMouse().KeyDown:Connect(function(key)
			if key:lower() == 'g' then
				toggleInvisible()
			end
		end)

		v31["InvisibleLoop"] = RunService.Heartbeat:Connect(function()
			if u9 and u8 and u7 then
				local _CFrame = u8.CFrame
				local _CameraOffset = u7.CameraOffset
				local v40 = _CFrame * CFrame.new(0, -200000, 0)
				local _Position = v40:ToObjectSpace(CFrame.new(_CFrame.Position)).Position

				u8.CFrame = v40
				u7.CameraOffset = _Position

				RunService.RenderStepped:Wait()

				u8.CFrame = _CFrame
				u7.CameraOffset = _CameraOffset
			end
		end)

		v31["CharAdded"] = _LocalPlayer.CharacterAdded:Connect(function()
			u9 = false
			ToggleBtn.Text = "Status: OFF"
			ToggleStroke.Color = Color3.fromRGB(50, 50, 60)
			u16()
		end)

		-- ==========================================
		-- LOGIC CLOSE (CLEANUP HOÀN TOÀN)
		-- ==========================================
		CloseBtn.MouseButton1Click:Connect(function()
			if u9 then
				u9 = false
				for _, part in pairs(u10) do
					if part and part.Parent then part.Transparency = 0 end
				end
			end
			
			for _, conn in pairs(v31) do
				if conn then conn:Disconnect() end
			end
			_G.a = nil
			ScreenGui:Destroy()
		end)

		_G.a = v31
	end
})

PlayerSection:Divider()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Biến lưu trữ connection để dễ dàng Disconnect khi người dùng tắt Toggle
local antiFlingConn
local antiInvisConn
local antiTrashcanConn

PlayerSection:Toggle({
    Title = "Anti-Fling",
    Desc = "make u not get fling",
    Icon = "shield",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false, -- Đã mở khóa để test
    LockedTitle = "Beta",
    Flag = "anti_fling",
    Callback = function(state)
        if state then
            -- Tắt va chạm (CanCollide) với tất cả người chơi khác để chống fling
            antiFlingConn = RunService.Stepped:Connect(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character then
                        for _, part in pairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        else
            if antiFlingConn then
                antiFlingConn:Disconnect()
                antiFlingConn = nil
            end
        end
    end
})

PlayerSection:Toggle({
    Title = "Anti-Invisibility",
    Desc = "make u can see player invisible",
    Icon = "eye",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false,
    LockedTitle = "Beta",
    Flag = "anti_invis",
    Callback = function(state)
        if state then
            -- Quét liên tục và ép Transparency của các part tàng hình về 0
            antiInvisConn = RunService.RenderStepped:Connect(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= lp and player.Character then
                        for _, part in pairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                if part.Transparency > 0.5 then
                                    part.Transparency = 0
                                end
                            end
                        end
                    end
                end
            end)
        else
            if antiInvisConn then
                antiInvisConn:Disconnect()
                antiInvisConn = nil
            end
        end
    end
})

PlayerSection:Toggle({
    Title = "Anti-Trashcan",
    Desc = "make u not get trashcan",
    Icon = "trash",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false,
    LockedTitle = "Beta",
    Flag = "anti_trashcan",
    Callback = function(state)
        if state then
            -- Logic xóa object Trashcan dựa trên game TSB
            local function clearTrashcan(child)
                if child:IsA("Model") and (child.Name == "Trashcan" or child.Name:match("Trash")) then
                    task.wait()
                    pcall(function() child:Destroy() end)
                end
            end

            -- Xóa các trashcan mới sinh ra
            antiTrashcanConn = workspace.ChildAdded:Connect(clearTrashcan)
            
            -- Xóa các trashcan đang tồn tại sẵn trong map
            for _, child in pairs(workspace:GetChildren()) do
                clearTrashcan(child)
            end
        else
            if antiTrashcanConn then
                antiTrashcanConn:Disconnect()
                antiTrashcanConn = nil
            end
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local antiVoidConnection
local voidPart

local floorY = -400

PlayerSection:Toggle({
    Title = "Anti-Void",
    Desc = "make u not die by the void",
    Icon = "wind",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Flag = "my_toggle",

    Callback = function(state)

        -- Xóa nếu còn tồn tại
        if antiVoidConnection then
            antiVoidConnection:Disconnect()
            antiVoidConnection = nil
        end

        if voidPart then
            voidPart:Destroy()
            voidPart = nil
        end

        if state then

            -- Tạo sàn vô hình
            voidPart = Instance.new("Part")
            voidPart.Size = Vector3.new(500, 5, 500)
            voidPart.Anchored = true
            voidPart.CanCollide = true
            voidPart.Transparency = 1
            voidPart.Name = "AntiVoidFloor"
            voidPart.Parent = workspace

            antiVoidConnection = RunService.Heartbeat:Connect(function()
                local char = player.Character
                if not char then return end

                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- Sàn theo vị trí X/Z của bạn
                voidPart.Position = Vector3.new(
                    hrp.Position.X,
                    floorY,
                    hrp.Position.Z
                )
            end)

        end
    end
})

--[[PlayerSection:Button({
    Title = "Free Rotate ULT",
    Desc = "Make you can rotate ULT like ULT of Saitama", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function(state)
        if state then
			local lp = game.Players.LocalPlayer
			local cam = workspace.CurrentCamera
			local runService = game:GetService("RunService")

			_G.FaceCamConnection = runService.RenderStepped:Connect(function()
				local char = lp.Character
				if not char then return end

				local hrp = char:FindFirstChild("HumanoidRootPart")
				if not hrp then return end

				local camLook = cam.CFrame.LookVector
				local lookDir = Vector3.new(camLook.X, 0, camLook.Z).Unit
				hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + lookDir)
			end)
        else
			if _G.FaceCamConnection then
				_G.FaceCamConnection:Disconnect()
				_G.FaceCamConnection = nil
			end
        end
    end,
}) 
--]]

PlayerSection:Toggle({
    Title = "Anti Invisibility",
    Desc = "see player use invisibility",
    Icon = "eye",
    Value = false,
    Type = "Toggle",
    Locked = false,
    Flag = "anti_invis_toggle",
    Callback = function(state)
        AntiInvisibility = state
        if not state then
            InvisibilityCache = {}
        end
    end
})

PlayerSection:Toggle({
    Title = "Anti AFK",
    Desc = "make u not kick after 20m not active", -- optional
    Icon = "power", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function(state)
        if state then
            AntiAfkConnection = Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.zero)
            end)
        else
            if AntiAfkConnection then
                AntiAfkConnection:Disconnect()
                AntiAfkConnection = nil
            end
        end
    end
})

PlayerSection:Toggle({
    Title = "Anti Stun",
    Desc = "Not 100%", -- optional
    Icon = "power", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function(state)
        getgenv().AutoNoSlow = state
        task.spawn(function()
            local conn
            conn = RunService_BM.RenderStepped:Connect(function()
                if not getgenv().AutoNoSlow then
                    conn:Disconnect()
                else
                    pcall(function()
                        Players.LocalPlayer.Character.Humanoid.WalkSpeed = 25
                    end)
                end
            end)
        end)
    end
})

local BoomboxSection = PlayerTab:Section({
    Title = "Boombox",
    Desc = "Help you have best experience", -- optional
    Icon = "music", -- lucide icon or "rbxassetid://". optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

local MusicList = {
    ["Track 06"] = 107416390117542,
    ["Ai đưa em về (prod.Yunee)"] = 119589720384457,
    ["Tử cửu môn hồi ức\n(辞九门回忆)"] = 124384558101360,
    ["Mercy - Living Stone"] = 112545816639972,
    ["My ordinary life - Living Stone"] = 131387015642491,
    ["Discord - Living Stone"] = 77595469047336,
    ["Young Girl A"] = 117044716417145,
	["Bass Da Da Da"] = 138410854139543,
	["Coook Pardon"] = 122525489670033,
	["The World Revolving"] = 126101283149087,
    ["Finale - Undertale"] = 117064854285259,
    ["Last Breath"] = 97889274347145,
    ["Stronger Than You (Chara Ver)"] = 74109325185963,
    ["Stronger Than You (Frisk Ver)"] = 92969307461807,
}

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Sound
local SelectedMusic = "Mercy - Living Stone"
local CurrentVolume = 0.5
local IsLooped = false

local function CreateSound()
	if Sound then
		pcall(function()
			Sound:Stop()
			Sound:Destroy()
		end)
	end

	Sound = Instance.new("Sound")
	Sound.Name = "BoomboxSound"
	Sound.Parent = camera -- 🔥 QUAN TRỌNG: local 2D sound
	Sound.Volume = CurrentVolume
	Sound.Looped = IsLooped
	Sound.SoundId = "rbxassetid://" .. MusicList[SelectedMusic]

	Sound:Stop() -- reset state
end

-- init
CreateSound()

-- nếu camera bị reset (hiếm nhưng nên có)
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	camera = workspace.CurrentCamera
	if Sound then
		Sound.Parent = camera
	end
end)

local Dropdown = BoomboxSection:Dropdown({
    Title = "Select Music",
    Desc = "Choose music you want",
    Values = {
        "Track 06",
        "Ai đưa em về (prod.Yunee)",
        "Tử cửu môn hồi ức\n(辞九门回忆)",
        {
            Type = "Divider",
        },
        "Mercy - Living Stone",
        "My ordinary life - Living Stone",
        "Discord - Living Stone",
        {
            Type = "Divider",
        },
        "Young Girl A",
        {
            Type = "Divider",
        },
		"Bass Da Da Da",
		"Coook Pardon",
		{
			Type = "Divider",
		},
		"The World Revolving",
        "Finale - Undertale",
        "Last Breath",
        "Stronger Than You (Chara Ver)",
        "Stronger Than You (Frisk Ver)"
    },
    Value = "Mercy - Living Stone",
    Multi = false,
    Locked = false,
    Callback = function(selected)
        SelectedMusic = selected
        if Sound then
            Sound.SoundId = "rbxassetid://" .. MusicList[selected]
            Sound:Stop()
            Sound.TimePosition = 0
        end
    end
})

BoomboxSection:Input({
    Title = "Custom Music",
    Placeholder = "Enter Music ID...",
    Callback = function(text)
        local id = tonumber(text)

        if id then
            SelectedMusic = nil -- bỏ chọn list cũ

            if Sound then
                Sound.SoundId = "rbxassetid://" .. id
                Sound:Stop()
                Sound.TimePosition = 0
            end

            print("Loaded custom music ID:", id)
        else
            warn("Invalid Music ID")
        end
    end
})

local BoomboxGroup = BoomboxSection:Group({})

BoomboxGroup:Button({
    Title = "Play",
    Desc = "press button to play music", -- optional
    Icon = "circle-play",
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
        Callback = function()
            if not Sound then return end

            if Sound.SoundId == "" then
                Sound.SoundId = "rbxassetid://" .. MusicList[SelectedMusic]
            end

            Sound:Stop()
            Sound.TimePosition = 0
            Sound:Play()
        end
})

BoomboxGroup:Button({
    Title = "Stop",
    Desc = "press button to stop music", -- optional
    Icon = "circle-stop",
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
        Callback = function()
            if Sound then
                Sound:Stop()
            end
        end
})

BoomboxSection:Toggle({
    Title = "Loop",
    Desc = "Loop music on/off",
    Icon = "repeat",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false,
        Callback = function(state)
            IsLooped = state
            if Sound then
                Sound.Looped = state
            end
        end
})

BoomboxSection:Slider({
    Title = "Volume",
    Desc = "Default is 50", -- optional
    Value = {
        Min = 0, -- minimum value
        Max = 1000, -- maximum value
        Default = 50 -- initial value
    },
    Step = 10, -- increment step (use 0.1 for floats). optional
    Locked = false, -- disable slider. optional
    Flag = "my_slider", -- for config saving. optional
        Callback = function(value)
            CurrentVolume = value / 100
            if Sound then
                Sound.Volume = CurrentVolume
            end
        end
})

local VisualSection = PlayerTab:Section({
    Title = "Visual",
    Desc = "Only you see", -- optional
    Icon = "zap", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(100, 100, 255), -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

VisualSection:Button({
    Title = "Golden Shoulder",
    Desc = "Elemental Crystal Golem", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
		local function Accs(AccsName, char, Mesh, Texture, Scale, CF, Welded, Angle)
			local acc = Instance.new("Accessory")
			acc.Name = AccsName
			acc.Parent = char

			local handle = Instance.new("Part")
			handle.Name = "Handle"
			handle.Size = Vector3.new(1,1,1)
			handle.Anchored = false
			handle.Massless = true
			handle.CanCollide = false
			handle.Parent = acc

			local mesh = Instance.new("SpecialMesh")
			mesh.MeshId = Mesh
			mesh.TextureId = Texture
			mesh.Scale = Scale
			mesh.Parent = handle

			local weld = Instance.new("Weld")
			weld.Part0 = handle
			weld.Part1 = char:WaitForChild(Welded)
			weld.C0 = CF * Angle
			weld.Parent = handle
		end

		local lp = game.Players.LocalPlayer
		local char = lp.Character or lp.CharacterAdded:Wait()

		-- xóa nếu đã tồn tại
		if char:FindFirstChild("GoldenShoulder") then
			char.GoldenShoulder:Destroy()
		end

		-- Elemental Crystal Golem Shoulder Rock
		Accs(
			"GoldenShoulder",
			char,
			"rbxassetid://4307568890", -- Mesh
			"rbxassetid://4307568951", -- Texture
			Vector3.new(1,1,1),
			CFrame.new(-0.6, -1.3, 0), -- chỉnh vị trí
			"Right Arm",               -- weld vào tay phải
			CFrame.Angles(0, 0, 0)
		)
	end
})

VisualSection:Divider()

VisualSection:Button({
    Title = "Outfit Six Eyes Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
        local HEAD_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0.4, 0)  -- tóc xoay + nâng
		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(14864453032, "Pants")
		equipClothing(14864448009,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(14909401527,  HAIR1_OFFSET, "Hair1 (Tóc Gojo)")
        fakeWear(16736408557,  HAIR2_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(70670293631110, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(14142088846, HEAD_OFFSET, "Head (head Gojo)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Button({
    Title = "Outfit Awakened Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)q
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.3, 0)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
        local NECK_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0.5, 0)

		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(16394174851, "Pants")
		equipClothing(16394118768,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
        fakeWear(16736408557,  HAIR2_OFFSET, "Hair1 (Tóc Gojo)")
		fakeWear(17686541020,  HAIR1_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(96643613272423, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(95774755274570, NECK_OFFSET, "Neck (head Gojo)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Button({
    Title = "Outfit Blindfold Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, -0.1)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.6, -0.1)  -- tóc xoay + nâng
        local HEAD_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0.4, 0)  -- tóc xoay + nâng
		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(14864453032, "Pants")
		equipClothing(14864448009,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(17420201885,  HAIR1_OFFSET, "Hair1 (Tóc Gojo)")
        fakeWear(17853856206,  HAIR2_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(14028471576, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(14142088846, HEAD_OFFSET, "Head (head Gojo)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Button({
    Title = "Outfit 0.2 Domain Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
        local HEAD_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0.4, 0)

		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(14667104344, "Pants")
		equipClothing(14667108384,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(15073725114,  HAIR1_OFFSET, "Hair1 (Tóc Gojo)")
        fakeWear(16736408557,  HAIR2_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(137468361564327, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(15163981338, HEAD_OFFSET, "Head (head Gojo)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Button({
    Title = "Outfit Rampage Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
        local HEAD_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 0.4, 0)

		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(14899882558, "Pants")
		equipClothing(14900041111,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(15073725114,  HAIR1_OFFSET, "Hair1 (Tóc Gojo)")
        fakeWear(16736408557,  HAIR2_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(137468361564327, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(15163986978, HEAD_OFFSET, "Head (head Gojo)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Button({
    Title = "Outfit Unsealed Gojo",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:WaitForChild("Humanoid")
		local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, -0.2)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên
        local HAIR2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, -0.5, -0.2)  -- tóc xoay + nâng
        local HEAD_OFFSET = CFrame.new()
        local ACCESS1_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(-1.7, 0.3, -0.5)  -- tóc xoay + nâng
        local ACCESS2_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(1.7, 0.3, -0.5)
        local ACCESS3_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(0, 1.1, -1.8)
        local ACCESS4_OFFSET = CFrame.Angles(0, math.rad(0), 0) * CFrame.new(-0.2, 0, -0.7)

		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(9263815671, "Pants")
		equipClothing(13898961719,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(17373679896,  HAIR1_OFFSET, "Hair1 (Tóc Gojo)")
        fakeWear(17379316131,  HAIR2_OFFSET, "Hair2 (Tóc Gojo)")
		fakeWear(70670293631110, FACE_OFFSET, "Face (Mặt Gojo)")
        fakeWear(16276333944, ACCESS1_OFFSET, "Access (Unsealed Gojo)")
        fakeWear(16276337922, ACCESS2_OFFSET, "Access (Unsealed Gojo)")
        fakeWear(14500356356, ACCESS3_OFFSET, "Access (Unsealed Gojo)")
        fakeWear(17163475788, ACCESS4_OFFSET, "Access (Unsealed Gojo)")
    

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

VisualSection:Divider()

VisualSection:Button({
    Title = "Outfit Monster Garou v1",
    Desc = "Visual", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
	Callback = function()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local head = character:WaitForChild("Head")

		--==============================
		-- XÓA HẾT ĐỒ CŨ TRƯỚC
		--==============================
		humanoid:RemoveAccessories()

		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end

		if head then
			local oldFace = head:FindFirstChildOfClass("Decal") or head:FindFirstChild("face")
			if oldFace then oldFace:Destroy() end
		end

		--==============================
		-- CONFIG OFFSET (chỉnh tóc nếu muốn)
		--==============================
		local HAIR_OFFSET = CFrame.Angles(0, math.rad(180), 0) * CFrame.new(0, -0.5, 0)  -- tóc xoay + nâng
		local FACE_OFFSET = CFrame.new()  -- mặt để nguyên

		--==============================
		-- HÀM FAKE WEAR (Weld trực tiếp - chống delete MeshPart)
		--==============================
		local function fakeWear(id, offset, itemName)
			local objs
			pcall(function()
				objs = game:GetObjects("rbxassetid://" .. id)
			end)

			for _, obj in ipairs(objs) do
				local acc = nil
				if obj:IsA("Accessory") and obj:FindFirstChild("Handle") then
					acc = obj
				elseif obj:IsA("Model") then
					acc = obj:FindFirstChildWhichIsA("Accessory", true)
				end
				
				if acc and acc:FindFirstChild("Handle") then
					acc.Parent = character
					
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = acc.Handle
					weld.C0 = CFrame.new()
					weld.C1 = offset or CFrame.new()
					weld.Parent = acc.Handle
					
					return
				end
			end
		end

		--==============================
		-- MẶC SHIRT + PANTS
		--==============================
		local function equipClothing(id, className)
			local success, asset = pcall(function()
				return game:GetObjects("rbxassetid://" .. id)[1]
			end)
			if not success or not asset then return end
			
			if asset:IsA("Model") then
				for _, child in ipairs(asset:GetDescendants()) do
					if child:IsA(className) then
						child.Parent = character
						asset:Destroy()
						return
					end
				end
			elseif asset:IsA(className) then
				asset.Parent = character
			else
				asset:Destroy()
			end
		end

		equipClothing(129756433530849, "Pants")
		equipClothing(83921834803801,  "Shirt")

		--==============================
		-- MẶC TÓC + MẶT (theo cách bạn đưa)
		--==============================
		fakeWear(18987061084,  HAIR_OFFSET, "Hair (Tóc Garou)")
		fakeWear(82834916088924, FACE_OFFSET, "Face (Mặt Garou)")

		--==============================
		-- CHỈNH MÀU DA FULL BODY (giống chính xác swatch bạn chọn trong ảnh)
		--==============================
		local bodyColors = character:FindFirstChild("BodyColors")
		if not bodyColors then
			bodyColors = Instance.new("BodyColors")
			bodyColors.Parent = character
		end

		local skinColor = Color3.fromRGB(255, 204, 153)  -- MÀU DA SÁNG PEACH giống swatch thứ 5 trong ảnh của bạn

		bodyColors.HeadColor3 = skinColor
		bodyColors.LeftArmColor3 = skinColor
		bodyColors.RightArmColor3 = skinColor
		bodyColors.LeftLegColor3 = skinColor
		bodyColors.RightLegColor3 = skinColor
		bodyColors.TorsoColor3 = skinColor

		--==============================
		-- CHỈNH TRANSPARENCY FULL BODY
		--==============================
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				head.Transparency = 1
			end
		end

		print("DONE!")
	end
})

local TargetName = "" -- lưu username

PlayerTab:Input({
    Title = "Enter Target",
    Placeholder = "Enter username", -- placeholder text. optional
    Callback = function(text)
        TargetName = text
    end
})

PlayerTab:Paragraph({
    Title = "Stand Script",
    Desc = "* Need 2 account\n* Block 3 times in a second to summon/unsummon\n* Use the move on again while cd to make the stand attack\n* It make you become stand of target",
    Image = "flame",
    Buttons = {
        {
            Title = "Active Stand",
            Icon = "mouse-pointer-click",
            Callback = function()
                if TargetName ~= "" then
                    getgenv().TargetUsername = TargetName
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Dragonfly5101/Minosr/refs/heads/main/Stand"))()
                else
                    warn("Please enter a username first!")
                end
            end
        }
    }
})

PlayerTab:Divider()

-- SERVICES
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local lp = Players.LocalPlayer

-- SOUND
local soundId = nil
local killConnection = nil

local sound = Instance.new("Sound")
sound.Name = "KillSound"
sound.Volume = 1
sound.Looped = false
sound.Parent = SoundService

------------------------------------------------
-- THEO DÕI LEADERSTATS -> KILLS
------------------------------------------------
local function watchKills()
	local leaderstats = lp:WaitForChild("leaderstats", 10)
	if not leaderstats then return end

	local kills = leaderstats:FindFirstChild("Kills")
	if not kills or not kills:IsA("ValueBase") then return end

	-- nếu đã có connection cũ thì ngắt
	if killConnection then
		killConnection:Disconnect()
	end

	killConnection = kills:GetPropertyChangedSignal("Value"):Connect(function()
		if soundId then
			sound:Play()
		end
	end)
end

------------------------------------------------
-- INPUT UI
------------------------------------------------
PlayerTab:Input({
	Title = "Kill Sound",
	Desc = "Only Public Server",
	Placeholder = "Enter Sound ID",
	Callback = function(text)
		text = tostring(text):gsub("%s+", "")

		-- TẮT SOUND
		if text == "" then
			soundId = nil
			sound:Stop()
			return
		end

		-- BẬT SOUND
		if tonumber(text) then
			soundId = "rbxassetid://" .. text
			sound.SoundId = soundId

			watchKills()
		end
	end
})

-- ===== FREE 8 EMOTE SLOTS =====
PlayerTab:Button({
	Title = "Free 8 Emote Slots",
	Icon = "rbxassetid://14404604332", -- lucide icon or "rbxassetid://14404604332". optional
	Desc = "Gamepass free",
	Value = false,
	Callback = function(state)
		LocalPlayer:SetAttribute("ExtraSlots", true)
	end
})

-- ===== FREE EMOTE PAGE =====
PlayerTab:Button({
	Title = "Free Emote Page",
	Icon = "rbxassetid://17452458905", -- lucide icon or "rbxassetid://17452458905". optional
	Desc = "Gamepass free",
	Value = false,
	Callback = function(state)
		LocalPlayer:SetAttribute("EmoteSearchBar", true)
	end
})

PlayerTab:Divider()

--==============================
-- BUTTON IN PLAYER TAB
--==============================
PlayerTab:Button({
    Title = "Fix Lag MAX (Boost)",
    Desc = "Remove VFX + Shadow + FULL Trees  + ...",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/447d05ded53df3c50df9067303b5b6e9/raw/fixlagmax.lua"))()
    end
})


--// Emote Limited
local EmoteTab = Window:Tab({
    Title = "Emote Limeted, Free",
    Desc = "Visual Emote", -- optional
    Icon = "sparkles", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(240, 240, 0), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local LimetedSection = EmoteTab:Section({
    Title = "Emote Limeted",
    Desc = "Only u can see", -- optional
    Icon = "sparkles", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(100, 100, 255), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

LimetedSection:Button({
    Title = "Final Stand",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Animation
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://113876851900426"
humanoid:LoadAnimation(anim):Play()

-- VFX bind
task.delay(0.1, function()
    local acc = Instance.new("Accessory")
    acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
    acc.Parent = character
    acc:SetAttribute("EmoteProperty", true)

    require(ReplicatedStorage.Emotes.VFX):MainFunction({
        Character = character,
        vfxName = "Final Stand",
        SpecificModule = ReplicatedStorage.Emotes.VFX,
        AnimSent = 113876851900426,
        RealBind = acc,
    })
end)

-- SOUND + AURA
task.delay(9, function()
    if not character or not character.Parent then return end
    if not workspace:FindFirstChild("Live") then return end
    if not workspace.Live:FindFirstChild(character.Name) then return end

    -- LOOP SOUND (GIỮ NGUYÊN SOURCE)
    local sounds = {
        {SoundId = "rbxassetid://112446641141594", Volume = 1},
        {SoundId = "rbxassetid://98080224862986", Volume = 0.3},
    }

    for _,info in pairs(sounds) do
        local s = Instance.new("Sound")
        s.SoundId = info.SoundId
        s.Volume = info.Volume
        s.Looped = true
        s.Parent = character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
        s:Play()

        task.delay(60, function()
            TweenService:Create(s, TweenInfo.new(0.5), {Volume = 0}):Play()
            task.delay(0.75, function()
                if s then s:Destroy() end
            end)
        end)
    end

    -- AURA (FS)
    local auraClone = ReplicatedStorage.Emotes.VFX.VfxMods.FS.vfx.Aura:Clone()

    for _,part in pairs(auraClone:GetChildren()) do
        local charPart = character:FindFirstChild(part.Name)
        if part.Name == "HumanoidRootPart" then
            charPart = character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
        end

        if charPart then
            for _,fx in pairs(part:GetChildren()) do
                if fx:IsA("ParticleEmitter") then
                    fx.LockedToPart = true
                end

                fx:SetAttribute("LimitedAura", true)
                fx.Parent = charPart

                task.delay(60, function()
                    if fx:IsA("ParticleEmitter") then
                        fx.Enabled = false
                    else
                        for _,sub in pairs(fx:GetChildren()) do
                            if sub:IsA("ParticleEmitter") then
                                sub.Enabled = false
                            end
                        end
                    end
                end)

                task.delay(65, function()
                    if fx then fx:Destroy() end
                end)
            end
        end
    end

    auraClone:Destroy()
end)

    end
})

LimetedSection:Button({
    Title = "Inner Rage",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- màu fallback (source gốc thiếu)
local v3189 = Color3.fromRGB(
    math.random(100,255),
    math.random(50,150),
    math.random(50,150)
)

local v67 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
local vu68 = {}

-- animation đầu
local v69 = Instance.new("Animation")
v69.AnimationId = "rbxassetid://96993907314948"
local v70 = humanoid:LoadAnimation(v69)
v70:Play()

-- animation tiếp
v70.Stopped:Connect(function()
    local v71 = Instance.new("Animation")
    v71.AnimationId = "rbxassetid://127234845846317"
    humanoid:LoadAnimation(v71):Play()
end)

-- holder
local vu72 = Instance.new("Accessory")
vu72.Name = "#EmoteHolder_" .. math.random(1,100000)
vu72.Parent = character
CollectionService:AddTag(vu72, "emoteendstuff"..character.Name)

-- VFX chính
require(ReplicatedStorage.Emotes.VFX):MainFunction({
    Character = character,
    vfxName = "Energy Explosion",
    AnimSent = 96993907314948,
    RealBind = vu72,
    NoInsertion = true,
    Colour = v67,
})

local vu73, vu74, vu75 = {}, {}, {}

-- xử lý tóc + aura
task.delay(1.3, function()
    if not vu72.Parent then return end

    for _,acc in pairs(character.FakeHead:GetChildren()) do
        if acc:IsA("Accessory")
        and acc:FindFirstChild("Handle")
        and acc.Handle:FindFirstChild("HairAttachment") then

            local handle = acc.Handle
            table.insert(vu74, handle)

            for _,mesh in pairs(handle:GetChildren()) do
                if mesh:IsA("SpecialMesh") then
                    mesh:SetAttribute("basetext", mesh.TextureId)
                end
            end
        end
    end

    for _,hair in pairs(vu74) do
        local clone = hair:Clone()
        table.insert(vu73, clone)

        local weld = Instance.new("Weld")
        weld.Part0 = clone
        weld.Part1 = hair
        weld.Parent = clone

        clone.Parent = workspace.Thrown
        hair.Transparency = 1

        TweenService:Create(hair, TweenInfo.new(0.25), {Transparency = 0}):Play()

        local mesh = hair:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.TextureId = ""
            local glow = ReplicatedStorage.Resources.DeathEffect.Template:Clone()
            glow.Color3 = Color3.new(v3189.R*5, v3189.G*5, v3189.B*5)
            glow.Parent = clone
        end
    end

    vu68[character] = {hairs = vu74, destroy = vu73}

    -- aura holder
    local auraHolder = Instance.new("Folder")
    auraHolder.Name = "AuraHolder"
    auraHolder:SetAttribute("LimAura", true)
    auraHolder:SetAttribute("EmoteEffect", true)
    auraHolder.Parent = character

    task.delay(203, function()
        if auraHolder then auraHolder:Destroy() end
    end)

    -- aura real
    for _,obj in pairs(ReplicatedStorage.Emotes.AuraReal:GetChildren()) do
        local clone = obj:Clone()
        clone:SetAttribute("LimAura", true)

        if clone:IsA("Attachment") then
            clone.Parent = character.PrimaryPart
        else
            local weld = Instance.new("Weld")
            weld.Part0 = character.PrimaryPart
            weld.Part1 = clone
            weld.Parent = clone
        end

        for _,fx in pairs(clone:GetDescendants()) do
            if fx:IsA("ParticleEmitter") or fx:IsA("PointLight") then
                fx.Enabled = false
                fx:SetAttribute("LimitedAura", true)
                fx:SetAttribute("InnerRageAura", true)

                if fx:IsA("ParticleEmitter") then
                    fx.Color = ColorSequence.new(v3189)
                end
                if fx:IsA("PointLight") then
                    fx.Color = v3189
                    fx.Brightness = 1.3
                end

                table.insert(vu75, fx)
            end
        end

        task.delay(203, function()
            if clone then clone:Destroy() end
        end)
    end
end)

-- bật aura + đổi anim
task.delay(5.3, function()
    if not vu72.Parent then return end

    for _,fx in pairs(vu75) do
        fx.Enabled = true
    end

    task.wait(0.05)

    for _,track in pairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation.AnimationId == "rbxassetid://127234845846317" then
            track:Stop()
            local v132 = Instance.new("Animation")
            v132.AnimationId = "rbxassetid://117177504280717"
            humanoid:LoadAnimation(v132):Play()
        end
    end
end)

    end
})

LimetedSection:Button({
    Title = "Shadow Eruption",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--========================
-- START SOUND (delay-based)
--========================
local soundList = {
    {
        SoundId = "rbxassetid://117425361961655",
        Volume = 0,
        ParentTorso = true,
    },
}

for delayTime, info in pairs(soundList) do
    task.delay(delayTime, function()
        local s = Instance.new("Sound")
        s.SoundId = info.SoundId
        s.Volume = info.Volume or 1
        s.Looped = info.Looped or false
        s.Parent = info.ParentTorso
            and (character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart"))
            or workspace
        s:Play()
    end)
end

--========================
-- ANIMATION
--========================
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://121032789756540"
humanoid:LoadAnimation(anim):Play()

--========================
-- MAIN VFX
--========================
task.delay(0.1, function()
    local acc = Instance.new("Accessory")
    acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
    acc.Parent = character

    require(ReplicatedStorage.Emotes.VFX):MainFunction({
        Character = character,
        vfxName = "Shadow Eruption",
        SpecificModule = ReplicatedStorage.Emotes.VFX,
        AnimSent = 121032789756540,
        RealBind = acc,
    })
end)

--========================
-- AURA + LOOP SOUND
--========================
task.delay(8.1, function()
    if not character or not character.Parent then return end
    if not workspace:FindFirstChild("Live") then return end
    if not workspace.Live:FindFirstChild(character.Name) then return end

    -- Aura holder
    local auraFolder = Instance.new("Folder")
    auraFolder.Name = "AuraHolder"
    auraFolder.Parent = character

    -- ⚠️ THAY THẾ script.auraNew
    -- 👉 PHẢI TỒN TẠI Ở ReplicatedStorage
    local auraSource = ReplicatedStorage:WaitForChild("Emotes"):WaitForChild("AuraNew")

    for _,part in pairs(auraSource:GetChildren()) do
        local charPart = character:FindFirstChild(part.Name)
        if charPart then
            local clone = part:Clone()
            clone.Parent = auraFolder
            clone:SetAttribute("LimitedAura", true)

            task.delay(65, function()
                if clone then clone:Destroy() end
            end)

            for _,fx in pairs(clone:GetDescendants()) do
                if fx:IsA("Trail") or fx:IsA("Beam") or fx:IsA("ParticleEmitter") then
                    fx.Enabled = true
                    task.delay(60, function()
                        if fx then fx.Enabled = false end
                    end)
                end
            end
        end
    end

    -- LOOP SOUND
    local loopSound = Instance.new("Sound")
    loopSound.SoundId = "rbxassetid://128082194939921"
    loopSound.Looped = true
    loopSound.Volume = 1
    loopSound.Parent = character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
    loopSound:Play()

    Debris:AddItem(loopSound, 80)

    task.delay(60, function()
        TweenService:Create(loopSound, TweenInfo.new(1), {Volume = 0}):Play()
        Debris:AddItem(loopSound, 1.2)

        for _,v in pairs(character:GetDescendants()) do
            if v:GetAttribute("aura") then
                if v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") then
                    v.Enabled = false
                    Debris:AddItem(v, 5)
                end
            end
        end
    end)
end)

    end
})

LimetedSection:Button({
    Title = "Divine Form",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==============================
-- DELAYED AURA (7.14s)
--==============================
task.spawn(function()
    task.wait(7.14)

    local char = player.Character
    if not char then return end

    local auraSource =
        ReplicatedStorage.Emotes.VFX.VfxMods.Evolved.vfx.Folder

    local auraFolder = Instance.new("Folder")
    auraFolder.Name = "AuraHolder"
    auraFolder:SetAttribute("DivineForm", true)
    auraFolder:SetAttribute("LimAura", true)
    auraFolder:SetAttribute("EmoteEffect", true)
    auraFolder.Parent = char

    for _,obj in pairs(auraSource:GetChildren()) do
        if obj:IsA("BasePart") then
            local bodyPart = char:FindFirstChild(obj.Name)
            if bodyPart then
                local clone = obj:Clone()
                clone.Transparency = 1
                clone.Massless = true
                clone.Name = tostring(math.random(1, 1000))
                clone:SetAttribute("LimAura", true)
                clone.Parent = auraFolder

                local weld = Instance.new("Weld")
                weld.Part0 = bodyPart
                weld.Part1 = clone
                weld.Parent = clone

                for _,fx in pairs(clone:GetDescendants()) do
                    if fx:IsA("ParticleEmitter") or fx:IsA("Beam") then
                        fx:SetAttribute("LimitedAura", true)
                        task.delay(240, function()
                            if fx then fx.Enabled = false end
                        end)
                    end
                end

                task.delay(244, function()
                    if clone and clone.Parent then
                        clone:Destroy()
                    end
                end)
            end
        end
    end
end)

--==============================
-- MAIN ANIMATION
--==============================
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://116187503451999"
humanoid:LoadAnimation(anim):Play()

--==============================
-- MAIN VFX BIND
--==============================
local acc = Instance.new("Accessory")
acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
acc.Parent = character
acc:SetAttribute("EmoteProperty", true)

require(ReplicatedStorage.Emotes.VFX):MainFunction({
    Character = character,
    vfxName = "Divine Form",
    SpecificModule = ReplicatedStorage.Emotes.VFX,
    AnimSent = 116187503451999,
    RealBind = acc,
})

--==============================
-- SECOND AURA (7s)
--==============================
task.delay(7, function()
    if not acc or not acc.Parent then return end
    if not workspace:FindFirstChild("Live") then return end
    if not workspace.Live:FindFirstChild(character.Name) then return end

    local auraFolder = Instance.new("Folder")
    auraFolder.Name = "AuraHolder"
    auraFolder:SetAttribute("DivineForm", true)
    auraFolder:SetAttribute("LimAura", true)
    auraFolder:SetAttribute("EmoteEffect", true)
    auraFolder.Parent = character

    local auraSource =
        ReplicatedStorage.Emotes.VFX.VfxMods.Evolved.vfx.Folder

    for _,obj in pairs(auraSource:GetChildren()) do
        if obj:IsA("BasePart") then
            local bodyPart = character:FindFirstChild(obj.Name)
            if bodyPart then
                local clone = obj:Clone()
                clone.Transparency = 1
                clone.Massless = true
                clone.Name = tostring(math.random(1, 1000))
                clone:SetAttribute("LimAura", true)
                clone.Parent = auraFolder

                local weld = Instance.new("Weld")
                weld.Part0 = bodyPart
                weld.Part1 = clone
                weld.Parent = clone

                for _,fx in pairs(clone:GetDescendants()) do
                    if fx:IsA("ParticleEmitter") or fx:IsA("Beam") then
                        fx:SetAttribute("LimitedAura", true)
                        task.delay(2, function()
                            if fx then fx.Enabled = false end
                        end)
                    end
                end

                task.delay(4, function()
                    if clone and clone.Parent then
                        clone:Destroy()
                    end
                end)
            end
        end
    end
end)

    end
})

LimetedSection:Button({
    Title = "The Strongest",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        local pq72 = game:GetService("Players").LocalPlayer.Character
        local xk19 = {
            [0] = {SoundId = "rbxassetid://117787451950766", Volume = 2},
            [0.01] = {SoundId = "rbxassetid://97998065677521", Volume = 1.85},
            [2.29] = {SoundId = "rbxassetid://99535007576182", Looped = true, Volume = 2}
        }
        local v9_a, v9_b, v9_c = pairs(xk19)
        while true do
            local fz88
            v9_c, fz88 = v9_a(v9_b, v9_c)
            if v9_c == nil then break end
            task.delay(v9_c, function()
                local sw44 = Instance.new("Sound")
                sw44.SoundId = fz88.SoundId
                sw44.Volume = fz88.Volume or 1
                sw44.Looped = fz88.Looped or false
                sw44.Parent = workspace
                sw44:Play()
            end)
        end

        local anm3 = Instance.new("Animation")
        anm3.AnimationId = "rbxassetid://86505219150915"
        local tk99 = pq72.Humanoid:LoadAnimation(anm3)
        tk99:Play()

        local cx82
        local function zx11()
            if cx82 then cx82:Disconnect() end
            local rz5 = game.ReplicatedStorage.Emotes:FindFirstChild("TheStrongestEmote")
            if not rz5 then return end
            
            for _, grp2 in ipairs(rz5:GetChildren()) do
                local bp66 = pq72:FindFirstChild(grp2.Name)
                if bp66 and bp66:IsA("BasePart") then
                    local fl31 = Instance.new("Folder")
                    fl31.Name = "Strongest_" .. grp2.Name
                    fl31.Parent = pq72
                    
                    for _, ob8 in ipairs(grp2:GetChildren()) do
                        local nx7 = ob8:Clone()
                        
                        if nx7:IsA("BasePart") or nx7:IsA("Model") then
                            nx7.Parent = fl31
                            local pm2 = nx7:IsA("Model") and (nx7.PrimaryPart or nx7:FindFirstChildWhichIsA("BasePart")) or nx7
                            
                            if pm2 then
                                local wl5 = Instance.new("Weld")
                                wl5.Part0 = bp66
                                wl5.Part1 = pm2
                                wl5.C0 = CFrame.new(0, 0, 0)
                                wl5.Parent = pm2
                                
                                local function mdf4(it9)
                                    if it9:IsA("BasePart") then
                                        it9.Anchored = false
                                        it9.CanCollide = false
                                        it9.CanTouch = false
                                        it9.CanQuery = false
                                        it9.Massless = true
                                    end
                                    if it9:IsA("ParticleEmitter") then
                                        it9.Enabled = true
                                        it9:Emit(50)
                                    end
                                end
                                
                                mdf4(nx7)
                                for _, ds1 in ipairs(nx7:GetDescendants()) do mdf4(ds1) end
                            end
                        elseif nx7:IsA("ParticleEmitter") or nx7:IsA("Attachment") then
                            nx7.Parent = bp66
                            if nx7:IsA("ParticleEmitter") then 
                                nx7.Enabled = true 
                                nx7:Emit(50)
                            end
                        end
                    end
                end
            end
        end

        cx82 = tk99.Stopped:Connect(zx11)

        task.delay(0.1, function()
            local fd88 = Instance.new("Folder")
            fd88.Name = "PrideBind"
            fd88.Parent = pq72
            fd88:SetAttribute("EmoteProperty", true)
            require(game.ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = pq72,
                vfxName = "Boss Raid",
                SpecificModule = game.ReplicatedStorage.Emotes.VFX,
                AnimSent = 86505219150915,
                RealBind = fd88
            })
        end)
        WindUI:Notify({
            Title = "Credit:",
            Content = "by MIYKO",
            Icon = "check-circle", -- lucide icon or "rbxassetid://". optional
            Duration = 5, -- time in seconds. optional
        })
    end
})

LimetedSection:Button({
    Title = "Boundless Rage",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

-- SAFE CHARACTER
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--==============================
-- ANIMATION
--==============================
local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://107649573628906"
humanoid:LoadAnimation(anim):Play()

local emoteAcc = nil
local noRotateFolder = nil

--==============================
-- MAIN VFX + NO ROTATE (0.1s)
--==============================
task.delay(0.1, function()
    emoteAcc = Instance.new("Accessory")
    emoteAcc.Name = "#EmoteHolder_" .. math.random(1, 100000)
    emoteAcc.Parent = character
    emoteAcc:SetAttribute("EmoteProperty", true)

    require(ReplicatedStorage.Emotes.VFX):MainFunction({
        Character = character,
        vfxName = "Boundless Rage",
        SpecificModule = ReplicatedStorage.Emotes.VFX,
        AnimSent = 107649573628906,
        RealBind = emoteAcc,
    })

    noRotateFolder = Instance.new("Folder")
    noRotateFolder.Name = "NoRotate"
    noRotateFolder.Parent = character
    noRotateFolder:SetAttribute("EmoteProperty", true)
end)

--==============================
-- AURA + LOOP SOUND (4s)
--==============================
task.delay(4, function()
    if not character or not character.Parent then return end

    -- ❌ bỏ workspace.Live cứng → tránh crash
    local auraTemplate =
        ReplicatedStorage.Emotes.VFX.VfxMods.Boundless.vfx.AuraChar:Clone()

    Debris:AddItem(auraTemplate, 5)

    if noRotateFolder and noRotateFolder.Parent then
        noRotateFolder:Destroy()
    end

    -- LOOP SOUND
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://81055990581650"
    sound.Looped = true
    sound.Volume = 1
    sound.Name = "CrushEmoteAmbience"
    sound.Parent =
        character:FindFirstChild("HumanoidRootPart")
        or character:FindFirstChild("Torso")
        or character

    sound:Play()

    -- APPLY AURA
    for _,part in pairs(auraTemplate:GetChildren()) do
        if part:IsA("BasePart") then
            local charPart = character:FindFirstChild(part.Name)
            if charPart then
                for _,obj in pairs(part:GetChildren()) do
                    if obj:IsA("Attachment") or obj:IsA("ParticleEmitter") then
                        local clone = obj:Clone()
                        clone.Parent = charPart
                        clone:SetAttribute("LimitedAura", true)

                        -- FADE OUT + SOUND STOP
                        task.delay(60, function()
                            TweenService:Create(
                                sound,
                                TweenInfo.new(0.5),
                                { Volume = 0 }
                            ):Play()

                            task.delay(0.75, function()
                                if sound and sound.Parent then
                                    sound:Destroy()
                                end
                            end)

                            if clone:IsA("ParticleEmitter") then
                                clone.Enabled = false
                            else
                                for _,fx in pairs(clone:GetChildren()) do
                                    if fx:IsA("ParticleEmitter") or fx:IsA("Beam") then
                                        fx.Enabled = false
                                    end
                                end
                            end
                        end)

                        task.delay(65, function()
                            if clone and clone.Parent then
                                clone:Destroy()
                            end
                        end)
                    end
                end
            end
        end
    end

    auraTemplate:Destroy()
end)

    end
})

LimetedSection:Button({
    Title = "The Fallen",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()

local v231 = game:GetService("Players")
                local vu232 = game:GetService("ReplicatedStorage")
                local vu233 = v231.LocalPlayer.Character
                local v234 = Instance.new("Animation")
                v234.AnimationId = "rbxassetid://133818134745501"
                vu233.Humanoid:LoadAnimation(v234):Play()
                task.delay(0.1, function()
                    local v235 = vu233:FindFirstChild("DismantleEffect")
                    if v235 then
                        v235:Destroy()
                    end
                    local v236 = Instance.new("Accessory")
                    v236.Name = "DismantleEffect"
                    v236.Parent = vu233
                    v236:SetAttribute("EmoteEffect", true)
                    require(vu232.Emotes.VFX):MainFunction({
                        Character = vu233,
                        vfxName = "Pride",
                        SpecificModule = vu232.Emotes.VFX,
                        AnimSent = 133818134745501,
                        RealBind = v236,
                        CanRotate = true
                    })
                    local v237 = Instance.new("Sound")
                    v237.SoundId = "rbxassetid://93369149563360"
                    v237.Volume = 2
                    v237.Looped = false
                    v237.Parent = vu233:FindFirstChild("Torso")
                    v237:Play()
                end)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

_G.SukunaVFXEnabled = true
local hitConnection = nil

local function GetVictimModel(hitAttr)
    if not hitAttr then return nil end
    local name = hitAttr:match("([^;]+)")
    if not name then return nil end
    local player = Players:FindFirstChild(name)
    if player and player.Character then return player.Character end
    local live = Workspace:FindFirstChild("Live")
    if live then
        local dummy = live:FindFirstChild(name)
        if dummy then return dummy end
    end
    return Workspace:FindFirstChild(name)
end

local function createSingleDisc(targetRoot, offsetCFrame, sizeValue)
    if not targetRoot or not targetRoot.Parent then return end
    local part = Instance.new("Part")
    part.Size = Vector3.new(1, 1, 1)
    part.Transparency = 1
    part.CanCollide = false
    part.Massless = true 
    part.Parent = Workspace
    
    local emitter = Instance.new("ParticleEmitter")
    emitter.Texture = "rbxassetid://18463718356"
    emitter.Shape = Enum.ParticleEmitterShape.Disc
    emitter.Lifetime = NumberRange.new(0.04) 
    emitter.Brightness = 30
    emitter.Rate = 500
    emitter.ZOffset = 3
    emitter.Size = NumberSequence.new(sizeValue, 0)
    emitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    emitter.Parent = part
    
    local weld = Instance.new("Weld")
    weld.Part0 = targetRoot
    weld.Part1 = part
    weld.C0 = offsetCFrame
    weld.Parent = part
    
    task.delay(0.2, function()
        emitter.Rate = 0
        task.wait(0.1)
        part:Destroy()
    end)
end

local function setupSukunaVFX()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    hitConnection = character:GetAttributeChangedSignal("LastM1Hitted"):Connect(function()
        if not _G.SukunaVFXEnabled then return end
        
        local hitAttr = character:GetAttribute("LastM1Hitted")
        local victim = GetVictimModel(hitAttr)
        if victim then
            local targetRoot = victim:FindFirstChild("HumanoidRootPart") or victim:FindFirstChild("Torso") or victim:FindFirstChild("UpperTorso")
            if targetRoot then
                task.spawn(createSingleDisc, targetRoot, CFrame.new(0, 0, 0), 5)
                task.spawn(createSingleDisc, targetRoot, CFrame.new(-1.5, 1.5, 0), 3.5)
                task.spawn(createSingleDisc, targetRoot, CFrame.new(1.5, -1.5, 0), 2.5)
            end
        end
    end)

    humanoid.Died:Connect(function()
        if hitConnection then
            hitConnection:Disconnect()
            hitConnection = nil
        end
        _G.SukunaVFXEnabled = false
    end)
end

setupSukunaVFX()

	end
})

LimetedSection:Button({
    Title = "True Aura",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()

        --==============================
        -- SERVICES (GIỮ NGUYÊN)
        --==============================
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CollectionService = game:GetService("CollectionService")

        local character = Players.LocalPlayer.Character
        if not character then return end

        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end

        --==============================
        -- ANIMATION
        --==============================
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://103668868712897"
        humanoid:LoadAnimation(anim):Play()

        task.delay(0.1, function()
            if not character or not character.Parent then return end

            --==============================
            -- ACCESSORY BIND
            --==============================
            local acc = Instance.new("Accessory")
            acc.Name = "#EmoteHolder_" .. math.random(1, 100000)
            acc.Parent = character

            CollectionService:AddTag(acc, "emoteendstuff" .. character.Name)

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "True Aura",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 103668868712897,
                RealBind = acc,
            })

            --==============================
            -- SPECIAL USER CHECK (GIỮ NGUYÊN, KHÔNG SỬA LOGIC)
            --==============================
            local root = character.PrimaryPart

            if tostring(character) == "YungCrepetics" and root then
                task.delay(6.3, function()
                    if acc and acc.Parent then
                        for _, part in pairs(
                            workspace:GetPartBoundsInRadius(root.Position, 40)
                        ) do
                            local _ = part:GetAttribute("IsTree") or part.Name == "TreeRoot"
                            local hum = part.Parent:FindFirstChildOfClass("Humanoid")

                            if hum and hum.Name ~= "FakeHumanoid" then
                                local _ = hum == humanoid
                            end
                        end
                    end
                end)
            end

            --==============================
            -- SOUND (R6 ONLY → TORSO)
            --==============================
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://83049960731792"
            sound.Volume = 3
            sound.Looped = false
            sound.Parent = character:FindFirstChild("Torso")

            if sound.Parent then
                sound:Play()
            end
        end)
    end
})

LimetedSection:Button({
    --//BUG
    Title = "Eternal Seal",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        -- SERVICES
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local CollectionService = game:GetService("CollectionService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local torso = character:WaitForChild("Torso") -- R6

        --============================== 
        -- ANIMATION + MAIN VFX 
        --============================== 
        task.spawn(function()
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://100255267749203"
            humanoid:LoadAnimation(anim):Play()
            local silent = Instance.new("Sound")
            silent.SoundId = "rbxassetid://79605009444651"
            silent.Volume = 0
            silent.Parent = torso
            silent:Play()
            local bind = Instance.new("Folder")
            bind.Name = "RuthlessBind"
            bind.Parent = character
            bind:SetAttribute("EmoteProperty", true)
            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = character,
                vfxName = "Eternal Seal",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 100255267749203,
                RealBind = bind,
            })
        end)

        --============================== 
        -- SOUND 
        --============================== 
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://79605009444651"
        sound.Volume = 2
        sound.Parent = torso
        sound:Play()

        --============================== 
        -- THROWN FOLDER 
        --============================== 
        local thrown = Workspace:FindFirstChild("Thrown")
        if not thrown then
            thrown = Instance.new("Folder")
            thrown.Name = "Thrown"
            thrown.Parent = Workspace
        end
        local tracked = {}
        local function register(obj)
            obj:SetAttribute("EmoteProperty", true)
            CollectionService:AddTag(obj, "emoteendstuff" .. character.Name)
            table.insert(tracked, obj)
            obj.Parent = thrown
        end

        --============================== 
        -- CLONE MODELS 
        --============================== 
        local Prison = ReplicatedStorage.Emotes.PrisonRealmRig:Clone()
        local Prism = ReplicatedStorage.Emotes.RealmPrism:Clone()
        local Strings = ReplicatedStorage.Emotes.Strings:Clone()
        register(Prison)
        register(Prism)
        register(Strings)

        --============================== 
        -- SET INITIAL TRANSPARENCY & SIZE (THÊM TỪ MẪU ĐỂ ẨN BAN ĐẦU)
        --==============================
        local hiddenParts = {
            Prison.Cube_2, Prison.Cube_finals, Prison.OPEN, Prison.CIRCLE_001, Prison.Sphere_001,
            Prism.RealmPrismPart,
            Strings.String4.Eye_014, Strings.String2.Cube_001, Strings.String6.Cube_001, Strings.String6.Eye_014,
            Strings.String1.Eye_014, Strings.String3.Cube_001, Strings.String1.Cube_001, Strings.String2.Eye_014,
            Strings.String3.Eye_014, Strings.String4.Cube_001, Strings.String5.Cube_001, Strings.String5.Eye_014,
            Prison.Talismanmesh
        }
        for _, part in pairs(hiddenParts) do
            if part then
                part.Transparency = 1
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(0.01, 0.01, 0.01)
                end
            end
        end

        --============================== 
        -- WELD (GIỮ NGUYÊN LOGIC GỐC) 
        --============================== 
        for _, model in pairs({ Prison, Prism, unpack(Strings:GetChildren()) }) do
            model.PrimaryPart.Anchored = false
            local weld = Instance.new("Weld")
            weld.Part0 = character.PrimaryPart or torso
            weld.Part1 = model.PrimaryPart
            weld.C0 = model:GetAttribute("Offset") -- ⚠️ QUAN TRỌNG
            weld.Parent = model.PrimaryPart
        end

        --============================== 
        -- BONE SOUND 
        --============================== 
        local boneSound = Instance.new("Sound")
        boneSound.SoundId = "rbxassetid://116434570262349"
        boneSound.Volume = 2
        boneSound.Parent = Prison:FindFirstChild("Bone_L", true)
        boneSound:Play()

        --============================== 
        -- MODEL ANIMATIONS 
        --============================== 
        local function playAnim(model, id)
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. id
            local controller = model:FindFirstChild("AnimationController") or model:FindFirstChildOfClass("Humanoid")
            if controller then
                controller:LoadAnimation(anim):Play()
            end
        end
        playAnim(Prison, 132931842051377)
        playAnim(Prism, 73313263538976)
        local ids = { 115400109213203, 129152881643120, 116148929833466, 106613129685108, 85535076926939, 136688312702757 }
        for i, id in ipairs(ids) do
            local stringModel = Strings:FindFirstChild("String" .. i)
            if stringModel then
                playAnim(stringModel, id)
            end
        end

        --============================== 
        -- TWEEN FUNCTIONS (THÊM TỪ MẪU)
        --==============================
        local function tween(part, props, info)
            TweenService:Create(part, info or TweenInfo.new(0.016, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), props):Play()
        end

        -- Particle emit (thêm từ mẫu)
        task.delay(3.667, function()
            if Prison.Parent and Prison:FindFirstChild("RootPart") and Prison.RootPart:FindFirstChild("PrismRootPart") and Prison.RootPart.PrismRootPart:FindFirstChild("Talisman") then
                Prison.RootPart.PrismRootPart.Talisman.ParticleEmitter:Emit(1)
            end
        end)

        -- Tween cho Prism (thời gian từ mẫu)
        task.delay(9.15, function() tween(Prism.RealmPrismPart, {Transparency = 0}) end)
        task.delay(9.166, function() tween(Prism.RealmPrismPart, {Size = Vector3.new(3.34, 3.31, 3.32)}) end)
        task.delay(9.183, function() tween(Prism.RealmPrismPart, {Size = Vector3.new(1.67, 1.66, 1.66)}, TweenInfo.new(0.05)) end)
        task.delay(9.233, function() tween(Prism.RealmPrismPart, {Size = Vector3.new(1.06, 2, 1.057)}, TweenInfo.new(0.116)) end)
        task.delay(9.35, function() tween(Prism.RealmPrismPart, {Size = Vector3.new(0.5, 0.5, 0.5)}, TweenInfo.new(0.283)) end)
        task.delay(9.633, function() tween(Prism.RealmPrismPart, {Transparency = 0}, TweenInfo.new(3.65)) end)  -- Fade in lâu
        task.delay(13.283, function() tween(Prism.RealmPrismPart, {Transparency = 1}) end)  -- Fade out

        -- Tween cho Strings' Eyes và Cubes (thêm từ mẫu, loop qua list)
        local stringParts = {
            Strings.String1.Eye_014, Strings.String2.Cube_001, Strings.String3.Eye_014, Strings.String6.Cube_001,
            Strings.String5.Eye_014, Strings.String5.Cube_001, Strings.String4.Eye_014, Strings.String1.Cube_001,
            Strings.String2.Eye_014, Strings.String3.Cube_001, Strings.String4.Cube_001, Strings.String6.Eye_014
        }
        for _, part in pairs(stringParts) do
            if part then
                task.delay(6.85, function() tween(part, {Transparency = 0, Size = Vector3.new(0.01, 0.01, 0.01)}) end)
                task.delay(6.866, function() tween(part, {Size = Vector3.new(1.71, 1.69, 1.69)}, TweenInfo.new(0.316)) end)
                task.delay(7.183, function() tween(part, {Size = Vector3.new(1.71, 1.69, 1.69)}, TweenInfo.new(1.916)) end)
                task.delay(9.1, function() tween(part, {Transparency = 0}, TweenInfo.new(0.116)) end)
                task.delay(9.216, function() tween(part, {Transparency = 1, Size = Vector3.new(0.01, 0.01, 0.01)}) end)
            end
        end

        -- Tween cho Prison parts (OPEN, Cube_finals, v.v.)
        local prisonParts = { Prison.OPEN, Prison.Cube_finals, Prison.Cube_2, Prison.Sphere_001, Prison.CIRCLE_001 }
        task.delay(0.4, function()
            for _, part in pairs(prisonParts) do
                tween(part, {Transparency = 0})
            end
        end)
        task.delay(0.416, function()
            tween(Prison.OPEN, {Size = Vector3.new(1.176, 1.181, 0.518)}, TweenInfo.new(4.133))
            tween(Prison.Cube_finals, {Size = Vector3.new(1.568, 1.568, 0.41)}, TweenInfo.new(4.133))
            tween(Prison.Cube_2, {Size = Vector3.new(1.568, 1.568, 0.661)}, TweenInfo.new(4.133))
            tween(Prison.Sphere_001, {Size = Vector3.new(0.549, 0.549, 0.549)}, TweenInfo.new(4.133))
            tween(Prison.CIRCLE_001, {Size = Vector3.new(0.489, 0.439, 0.201)}, TweenInfo.new(4.133))
        end)
        task.delay(4.55, function()
            tween(Prison.Talismanmesh, {Transparency = 1})
            tween(Prison.OPEN, {Size = Vector3.new(7.461, 7.494, 2.774)}, TweenInfo.new(0.316))
            tween(Prison.Cube_finals, {Size = Vector3.new(10.256, 10.256, 2)}, TweenInfo.new(0.316))
            tween(Prison.Cube_2, {Size = Vector3.new(10.256, 10.256, 3.788)}, TweenInfo.new(0.316))
            tween(Prison.Sphere_001, {Size = Vector3.new(2.997, 2.997, 2.997)}, TweenInfo.new(0.316))
            tween(Prison.CIRCLE_001, {Size = Vector3.new(2.565, 2.211, 0.513)}, TweenInfo.new(0.316))
            wait(2.2)  -- Delay destroy như mẫu
            if Prison.Parent then
                Prison:Destroy()
            end
        end)

        --============================== 
        -- ANTI FREEZE (GIỮ PLAYER DI CHUYỂN) 
        --============================== 
        RunService.RenderStepped:Connect(function()
            if character and character.Parent then
                for _, p in pairs(character:GetDescendants()) do
                    if p:IsA("BasePart") and p.Anchored then
                        p.Anchored = false
                    end
                end
            end
        end)
    end
})

LimetedSection:Button({
    Title = "World Cutting Slash",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Locked = false,
    Justify = "Between",
    Flag = "world_cutting_slash",

    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TweenService = game:GetService("TweenService")
        local Debris = game:GetService("Debris")

        local Player = Players.LocalPlayer
        local Character = Player.Character
        if not Character then return end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid then return end

        -- Animation
        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://120001337057214"

        local Track = Humanoid:LoadAnimation(Animation)
        Track:Play()

        task.delay(0.1, function()

            -- Emote Holder
            local Accessory = Instance.new("Accessory")
            Accessory.Name = "#EmoteHolder_" .. math.random(1,99999)
            Accessory:SetAttribute("EmoteProperty", true)
            Accessory.Parent = Character

            -- VFX
            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = Character,
                vfxName = "HugeSlash",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 120001337057214,
                RealBind = Accessory,
                CanRotate = true,
            })

            -- Marker trigger
            local connection
            connection = Track:GetMarkerReachedSignal("fifth"):Once(function()

                if not (Accessory and Accessory.Parent) then return end

                local root = Character.PrimaryPart
                if not root then return end

                local baseCFrame = root.CFrame
                Character:SetAttribute("ForcedCFrame", baseCFrame)

                local hitbox = Instance.new("Part")
                hitbox.Size = Vector3.new(55,35,10)
                hitbox.Transparency = 1
                hitbox.Anchored = true
                hitbox.CanCollide = false
                hitbox.CanTouch = false
                hitbox.CFrame = baseCFrame * CFrame.new(0,-10,-4)
                hitbox.Parent = workspace:FindFirstChild("Thrown") or workspace

                Debris:AddItem(hitbox,1)

                TweenService:Create(hitbox,TweenInfo.new(0.19,Enum.EasingStyle.Linear),{
                    CFrame = baseCFrame * CFrame.new(0,-10,-114)
                }):Play()

                local hitList = {}
                local startTime = tick()

                while hitbox and hitbox.Parent and tick() - startTime <= 1 do
                    task.wait()

                    for _, part in ipairs(workspace:GetPartsInPart(hitbox)) do
                        local model = part.Parent
                        local hum = model and model:FindFirstChildOfClass("Humanoid")

                        if hum and hum ~= Humanoid and hum.Health > 0 and not table.find(hitList, model) then
                            table.insert(hitList, model)
                        end
                    end
                end
            end)

            task.delay(4,function()
                if connection then
                    connection:Disconnect()
                end
            end)

            -- Sound
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://103835306879590"
            sound.Volume = 3
            sound.Parent = Character:FindFirstChild("Torso") or Character.PrimaryPart
            sound:Play()

        end)
    end
})

LimetedSection:Button({
    Title = "My Brother",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Locked = false,
    Justify = "Between",
    Flag = "my_brother",

    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

        local Replication = ReplicatedStorage:FindFirstChild("Replication")
        if not Replication then
            warn("Replication not found")
            return
        end

        ----------------------------------------------------------------
        -- 🔥 GET RANDOM FRIEND (OFFLINE OR ONLINE)
        ----------------------------------------------------------------
        local function GetRandomFriend()
            local success, pages = pcall(function()
                return Players:GetFriendsAsync(LocalPlayer.UserId)
            end)

            if not success or not pages then
                warn("Failed to fetch friends list")
                return nil
            end

            local allFriends = {}

            repeat
                for _, friend in ipairs(pages:GetCurrentPage()) do
                    table.insert(allFriends, friend)
                end

                if pages.IsFinished then
                    break
                end

                pages:AdvanceToNextPageAsync()
            until false

            if #allFriends == 0 then
                warn("No friends found!")
                return nil
            end

            local randomFriend = allFriends[math.random(1, #allFriends)]
            return randomFriend.Id
        end

        local targetId = GetRandomFriend()
        if not targetId then
            return
        end

        ----------------------------------------------------------------
        -- ROCK SPAWN
        ----------------------------------------------------------------
        local RockTemplate = ReplicatedStorage:FindFirstChild("Emotes") and
                             ReplicatedStorage.Emotes:FindFirstChild("RockThrow")

        if not RockTemplate then
            warn("RockThrow not found")
            return
        end

        local Rock = RockTemplate:Clone()
        Rock:SetAttribute("EmoteProperty", true)
        Rock.Name = "Rock"
        Rock.Parent = Character

        local weld = Rock:WaitForChild("Rock", 2)
        if weld and Character.PrimaryPart then
            weld:SetAttribute("EmoteProperty", true)
            weld.Part0 = Character.PrimaryPart
            weld.Part1 = Rock
            weld.Parent = Character.PrimaryPart
        end

        ----------------------------------------------------------------
        -- SOUND DELAY
        ----------------------------------------------------------------
        task.delay(0.573,function()
            if Rock and Rock.Parent then
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://91571189388577"
                sound.Volume = 1
                sound.RollOffMaxDistance = 100
                sound.Parent = Rock
                sound:Play()
            end
        end)

        ----------------------------------------------------------------
        -- ANIMATION
        ----------------------------------------------------------------
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://123464270068243"
            Humanoid:LoadAnimation(anim):Play()
        end

        ----------------------------------------------------------------
        -- TORSO SOUNDS
        ----------------------------------------------------------------
        local torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
        if torso then
            local s1 = Instance.new("Sound")
            s1.SoundId = "rbxassetid://104813362309681"
            s1.Volume = 1
            s1.Parent = torso
            s1:Play()

            task.delay(0.01,function()
                local s2 = Instance.new("Sound")
                s2.SoundId = "rbxassetid://103206475338370"
                s2.Volume = 0.8
                s2.Parent = torso
                s2:Play()
            end)
        end

        ----------------------------------------------------------------
        -- FAKE REPLICATION (VISUAL ONLY)
        ----------------------------------------------------------------
        task.wait(2.4)

        for _,conn in pairs(getconnections(Replication.OnClientEvent)) do
            if conn.Function then
                pcall(function()
                    conn.Function({
                        Effect = "Best Brother",
                        char = Character,
                        Id = targetId,
                    })
                end)
            end
        end

        ----------------------------------------------------------------
        -- HIDE ROCK
        ----------------------------------------------------------------
        if Rock then
            Rock.Transparency = 1
        end

    end
})

LimetedSection:Button({
    Title = "Final Spark",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Locked = false,
    Justify = "Between",
    Flag = "final_spark",

    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")

        -- Animation
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://129361308786827"
        Humanoid:LoadAnimation(anim):Play()

        -- Emote Holder
        local accessory = Instance.new("Accessory")
        accessory.Name = "#EmoteHolder_" .. math.random(1,99999)
        accessory:SetAttribute("EmoteProperty", true)
        accessory.Parent = Character

        -- VFX
        if ReplicatedStorage:FindFirstChild("Emotes") 
        and ReplicatedStorage.Emotes:FindFirstChild("VFX") then

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = Character,
                vfxName = "Final Spark",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 129361308786827,
                RealBind = accessory,
            })
        else
            warn("Emotes.VFX not found")
        end

    end
})

LimetedSection:Button({
    Title = "Last Will",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Locked = false,
    Justify = "Between",
    Flag = "last_will",

    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")

        -- Animation
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://113450724032380"
        Humanoid:LoadAnimation(anim):Play()

        -- Emote Holder
        local accessory = Instance.new("Accessory")
        accessory.Name = "#EmoteHolder_" .. math.random(1,99999)
        accessory:SetAttribute("EmoteProperty", true)
        accessory.Parent = Character

        -- VFX
        if ReplicatedStorage:FindFirstChild("Emotes") 
        and ReplicatedStorage.Emotes:FindFirstChild("VFX") then

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = Character,
                vfxName = "Last Will",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 113450724032380,
                RealBind = accessory,
            })
        else
            warn("Emotes.VFX not found")
        end

    end
})

LimetedSection:Button({
    Title = "The Fallen Finisher",
    Desc = "Limited Emote",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Locked = false,
    Justify = "Between",
    Flag = "fallen_finisher",

    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")

        local torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")

        -- 🔊 Sound 1 (Torso)
        if torso then
            local sound1 = Instance.new("Sound")
            sound1.SoundId = "rbxassetid://113267998039039"
            sound1.Volume = 1.65
            sound1.Parent = torso
            sound1:Play()
        end

        -- 🔊 Sound 2 (Global)
        local sound2 = Instance.new("Sound")
        sound2.SoundId = "rbxassetid://87401852788032"
        sound2.Volume = 1
        sound2.Parent = workspace
        sound2:Play()

        -- 🎬 Animation
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://95171537920426"
        Humanoid:LoadAnimation(anim):Play()

        -- 🎭 Emote Holder
        local accessory = Instance.new("Accessory")
        accessory.Name = "#EmoteHolder_" .. math.random(1,99999)
        accessory:SetAttribute("EmoteProperty", true)
        accessory.Parent = Character

        -- ✨ VFX
        if ReplicatedStorage:FindFirstChild("Emotes")
        and ReplicatedStorage.Emotes:FindFirstChild("VFX") then

            require(ReplicatedStorage.Emotes.VFX):MainFunction({
                Character = Character,
                vfxName = "slice combo",
                SpecificModule = ReplicatedStorage.Emotes.VFX,
                AnimSent = 95171537920426,
                RealBind = accessory,
            })
        else
            warn("Emotes.VFX not found")
        end

    end
})

local FreeSection = EmoteTab:Section({
    Title = "Emote Free",
    Desc = "Only u can see", -- optional
    Icon = "star", -- lucide icon or "rbxassetid://". optional
    IconColor = Color3.fromRGB(100, 100, 255), -- custom icon color. optional
    TextSize = 20, -- title text size. optional
    TextXAlignment = "Center", -- "Left", "Center", "Right". optional
    Box = true, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = false, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0, -- title transparency. optional
    DescTextTransparency = 0.5, -- description transparency. optional
})

FreeSection:Paragraph({
    Title = "NOTE!",
    Desc = "Use Emote Nah I'd Win first if dont want bug some emote"
})

FreeSection:Button({
    Title = "Embers",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		local _Players13 = game:GetService('Players')
        local _ReplicatedStorage11 = game:GetService('ReplicatedStorage')
        local _LocalPlayer12 = _Players13.LocalPlayer
        local v420 = _LocalPlayer12.Character or _LocalPlayer12.CharacterAdded:Wait()
        local _Humanoid9 = v420:WaitForChild('Humanoid')
        local _Animation18 = Instance.new('Animation')

        _Animation18.AnimationId = 'rbxassetid://83905432418191'

        _Humanoid9:LoadAnimation(_Animation18):Play()

        local _Accessory11 = Instance.new('Accessory')

        _Accessory11.Name = '#EmoteHolder_' .. math.random(1, 100000)
    	_Accessory11.Parent = v420

        _Accessory11:SetAttribute('EmoteProperty', true)
        require(_ReplicatedStorage11.Emotes.VFX):MainFunction({
            Character = v420,
            vfxName = 'Embers',
            SpecificModule = _ReplicatedStorage11.Emotes.VFX,
            AnimSent = 83905432418191,
            RealBind = _Accessory11,
        })

        local _Sound18 = Instance.new('Sound')

        _Sound18.SoundId = 'rbxassetid://94529938730886'
        _Sound18.Volume = 3.45
        _Sound18.Parent = game.Players.LocalPlayer.Character:FindFirstChild('Torso') or (game.Players.LocalPlayer.Character:FindFirstChild('UpperTorso') or workspace)

        _Sound18:Play()
    end
})

FreeSection:Button({
    Title = "Time Shift",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		local _Players14 = game:GetService('Players')
        local _ReplicatedStorage12 = game:GetService('ReplicatedStorage')
        local _LocalPlayer13 = _Players14.LocalPlayer
        local v428 = _LocalPlayer13.Character or _LocalPlayer13.CharacterAdded:Wait()
        local _Humanoid10 = v428:WaitForChild('Humanoid')
        local _Animation19 = Instance.new('Animation')

        _Animation19.AnimationId = 'rbxassetid://114451374603244'

        local v431 = _Humanoid10:LoadAnimation(_Animation19)

        v431:Play()

        local _Accessory12 = Instance.new('Accessory')

        _Accessory12.Name = '#EmoteHolder_' .. math.random(1, 100000)
        _Accessory12.Parent = v428

        _Accessory12:SetAttribute('EmoteProperty', true)
        require(_ReplicatedStorage12.Emotes.VFX):MainFunction({
            Character = v428,
            vfxName = 'Time Shift',
            SpecificModule = _ReplicatedStorage12.Emotes.VFX,
            AnimSent = 114451374603244,
            RealBind = _Accessory12,
        })

        local _Sound19 = Instance.new('Sound')

        _Sound19.SoundId = 'rbxassetid://78909185953598'
        _Sound19.Volume = 3
        _Sound19.Parent = workspace

        _Sound19:Play()
        task.wait(7.9)
        v431:Stop()
        _Sound19:Stop()
	end
})

FreeSection:Button({
    Title = "Boxed Up",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _Players15 = game:GetService('Players')
                local _ReplicatedStorage13 = game:GetService('ReplicatedStorage')
                local _LocalPlayer14 = _Players15.LocalPlayer
                local v437 = _LocalPlayer14.Character or _LocalPlayer14.CharacterAdded:Wait()
                local _Humanoid11 = v437:WaitForChild('Humanoid')
                local _Animation20 = Instance.new('Animation')

                _Animation20.AnimationId = 'rbxassetid://111810635064735'

                _Humanoid11:LoadAnimation(_Animation20):Play()

                local _Accessory13 = Instance.new('Accessory')

                _Accessory13.Name = '#EmoteHolder_' .. math.random(1, 100000)
                _Accessory13.Parent = v437

                _Accessory13:SetAttribute('EmoteProperty', true)
                require(_ReplicatedStorage13.Emotes.VFX):MainFunction({
                    Character = v437,
                    vfxName = 'Boxed Up',
                    SpecificModule = _ReplicatedStorage13.Emotes.VFX,
                    AnimSent = 111810635064735,
                    RealBind = _Accessory13,
                })

                local _Sound20 = Instance.new('Sound')

                _Sound20.SoundId = 'rbxassetid://90314606305113'
                _Sound20.Volume = 3
                _Sound20.Parent = workspace

                _Sound20:Play()
	end
})

FreeSection:Button({
    Title = "Nad I'd Win",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                script = game:GetService('ReplicatedStorage'):WaitForChild('Emotes')

                local _LocalPlayer15 = game:GetService('Players').LocalPlayer
                local u443 = _LocalPlayer15.Character or _LocalPlayer15.CharacterAdded:Wait()
                local v444 = u443
                local v445 = u443.WaitForChild(v444, 'Humanoid')
                local v446 = u443
                local u447 = u443.WaitForChild(v446, 'HumanoidRootPart')

                local function u455(p448, p449)
                    local v450 = string.lower(p449)
                    local v451, v452, v453 = ipairs(p448:GetDescendants())

                    while true do
                        local v454

                        v453, v454 = v451(v452, v453)

                        if v453 == nil then
                            break
                        end
                        if string.lower(v454.Name) == v450 then
                            return v454
                        end
                    end
                end
                local function u461(p456)
                    local v457, v458, v459 = ipairs(p456:GetDescendants())

                    while true do
                        local v460

                        v459, v460 = v457(v458, v459)

                        if v459 == nil then
                            break
                        end
                        if v460:IsA('BasePart') then
                            return v460
                        end
                    end
                end
                local function v477(p462, _, p463)
                    local u464 = u455(script, 'dialogue') or script:FindFirstChild('dialogue', true)

                    if u464 then
                        local u465 = nil

                        pcall(function()
                            u465 = u464:Clone()
                        end)

                        if u465 then
                            task.spawn(function()
                                wait(8)
                                u465:Destroy()
                            end)
                            table.insert(p462, u465)

                            local v466 = u465

                            u465.SetAttribute(v466, 'EmoteProperty', true)

                            p463.rock = u465
                            u465.Name = 'Handle'

                            local v467 = u465
                            local v468 = u465.FindFirstChild(v467, 'Handle') or u461(u465)

                            if v468 then
                                v468.Anchored = false
                                v468.CanCollide = false
                                v468.Transparency = 0
                                v468.Position = u447.Position + u447.CFrame.LookVector * 3 + Vector3.new(0, 2, 0)
                            end

                            local v469 = u455(u465, 'm6d')

                            if not v469 then
                                v469 = Instance.new('Motor6D')
                                v469.Name = 'm6d'
                            end

                            v469.Part0 = u447
                            v469.Part1 = v468 or u447
                            v469.Parent = u447

                            local v470 = u465
                            local v471, v472, v473 = ipairs(u465.GetDescendants(v470))
                            local v474 = u465

                            while true do
                                local v475

                                v473, v475 = v471(v472, v473)

                                if v473 == nil then
                                    break
                                end
                                if v475:IsA('BasePart') then
                                    v475.Transparency = 0
                                    v475.CanCollide = false
                                elseif v475:IsA('BillboardGui') then
                                    v475.Enabled = true

                                    local _CanvasGroup = v475:FindFirstChild('CanvasGroup')

                                    if _CanvasGroup then
                                        _CanvasGroup.Enabled = true
                                    end
                                elseif v475:IsA('SurfaceGui') then
                                    v475.Enabled = true
                                end
                            end

                            v474.Parent = u443
                        else
                            warn('Failed to clone dialogue')
                        end
                    else
                        warn('Dialogue not found inside Emotes')

                        return
                    end
                end

                local _Animation21 = Instance.new('Animation')

                _Animation21.AnimationId = 'rbxassetid://16746843881'

                local v479 = v445:LoadAnimation(_Animation21)

                v479:Play()

                local u480 = {}

                v477(u480, nil, {});
                ({
                    visible = function(p481)
                        if p481.rock then
                            local v482, v483, v484 = ipairs(p481.rock:GetDescendants())

                            while true do
                                local v485

                                v484, v485 = v482(v483, v484)

                                if v484 == nil then
                                    break
                                end
                                if v485:IsA('BasePart') then
                                    v485.Transparency = 0
                                elseif v485:IsA('BillboardGui') or v485:IsA('SurfaceGui') then
                                    v485.Enabled = true
                                end
                            end
                        end
                    end,
                }).visible(u480)
                v479.Stopped:Connect(function()
                    if u480.rock and u480.rock.Parent then
                        u480.rock:Destroy()
                    end
                end)

                local v486, v487, v488 = pairs({
                    {
                        SoundId = 'rbxassetid://16746854243',
                        Volume = 1.5,
                        Looped = false,
                        ParentTorso = true,
                    },
                })
                local v489 = u447
                local v490 = u443

                while true do
                    local v491

                    v488, v491 = v486(v487, v488)

                    if v488 == nil then
                        break
                    end

                    local _Sound21 = Instance.new('Sound')

                    _Sound21.SoundId = v491.SoundId
                    _Sound21.Volume = v491.Volume
                    _Sound21.Looped = v491.Looped

                    if v491.ParentTorso then
                        _Sound21.Parent = v490:FindFirstChild('Torso') or (v490:FindFirstChild('UpperTorso') or v489)
                    else
                        _Sound21.Parent = v490
                    end

                    _Sound21:Play()
                end
	end
})

FreeSection:Button({
    Title = "Blades of Jade",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer16 = game:GetService('Players').LocalPlayer
                local u494 = _LocalPlayer16.Character or _LocalPlayer16.CharacterAdded:Wait()
                local _Humanoid12 = u494:WaitForChild('Humanoid')
                local _CollectionService3 = game:GetService('CollectionService')
                local _Sound22 = Instance.new('Sound')

                _Sound22.SoundId = 'rbxassetid://82078299414169'
                _Sound22.Volume = 1
                _Sound22.Looped = true
                _Sound22.Parent = u494:FindFirstChild('HumanoidRootPart') or u494.PrimaryPart

                _Sound22:Play()

                local _Animation22 = Instance.new('Animation')

                _Animation22.AnimationId = 'rbxassetid://121440687354239'

                local u499 = _Humanoid12:LoadAnimation(_Animation22)

                u499.Looped = true

                u499:Play()

                local _BladesOfJade = script.BladesOfJade

                if _BladesOfJade then
                    local u501 = {}

                    local function v503(p502)
                        p502:SetAttribute('EmoteProperty', true)
                        table.insert(u501, p502)
                        _CollectionService3:AddTag(p502, 'emoteendstuff' .. _LocalPlayer16.Name)
                    end

                    local v504, v505, v506 = pairs(_BladesOfJade.Attach:GetChildren())
                    local u507 = u501

                    while true do
                        local v508

                        v506, v508 = v504(v505, v506)

                        if v506 == nil then
                            break
                        end

                        local v509 = v508:Clone()

                        v509.Parent = u494:WaitForChild('Head')

                        v503(v509)
                    end

                    local v510, v511, v512 = pairs({
                        _BladesOfJade.JadeL,
                        _BladesOfJade.JadeR,
                    })

                    while true do
                        local v513

                        v512, v513 = v510(v511, v512)

                        if v512 == nil then
                            break
                        end

                        local v514 = v513:Clone()

                        v503(v514)

                        local _Motor6D = v514:FindFirstChildOfClass('Motor6D')

                        v503(_Motor6D)

                        local _RightArm = u494['Right Arm']

                        if v513.Name == 'JadeL' then
                            _RightArm = u494['Left Arm']
                        end

                        _Motor6D.Part0 = _RightArm
                        _Motor6D.Part1 = v514.ChainPart1
                        _Motor6D.Parent = _RightArm
                        v514.Parent = u494
                        _Motor6D.Name = 'ChainPart1'
                    end

                    local _ClashVFX = _BladesOfJade.Part:FindFirstChild('ClashVFX')

                    if _ClashVFX then
                        local v518 = _ClashVFX:Clone()

                        v518.Parent = u494.PrimaryPart

                        v503(v518)
                    end

                    local u519 = RaycastParams.new()

                    u519.FilterType = Enum.RaycastFilterType.Exclude
                    u519.FilterDescendantsInstances = {
                        workspace:FindFirstChild('Thrown'),
                        workspace:FindFirstChild('Live'),
                    }

                    local function v530()
                        local v520 = u494
                        local v521, v522, v523 = pairs(v520:GetDescendants())

                        while true do
                            local v524

                            v523, v524 = v521(v522, v523)

                            if v523 == nil then
                                break
                            end
                            if (tostring(v524) == 'JadeL' or tostring(v524) == 'JadeR') and v524:IsA('Model') then
                                local v525, v526, v527 = pairs(v524:GetDescendants())

                                while true do
                                    local v528

                                    v527, v528 = v525(v526, v527)

                                    if v527 == nil then
                                        break
                                    end
                                    if v528:IsA('ParticleEmitter') then
                                        local v529 = tostring(v528) == 'smoke' and workspace:Raycast(u494.PrimaryPart.Position, Vector3.new(0, -10, 0), u519)

                                        if v529 then
                                            v528.Color = ColorSequence.new(v529.Instance.Color)
                                        end

                                        v528:Emit(v528:GetAttribute('EmitCount') or 10)
                                    end
                                end
                            end
                        end
                    end

                    u499:GetMarkerReachedSignal('floorhit'):Connect(v530)
                    u499:GetMarkerReachedSignal('touchfloor'):Connect(function()
                        local _ClashVFX2 = u494.PrimaryPart:FindFirstChild('ClashVFX')

                        if _ClashVFX2 then
                            local v532, v533, v534 = pairs(_ClashVFX2:GetDescendants())

                            while true do
                                local v535

                                v534, v535 = v532(v533, v534)

                                if v534 == nil then
                                    break
                                end
                                if v535:IsA('ParticleEmitter') then
                                    v535:Emit(v535:GetAttribute('EmitCount') or 10)
                                end
                            end
                        end
                    end)
                    task.delay(10, function()
                        u499:Stop()
                        _Sound22:Stop()

                        local v536, v537, v538 = pairs(u507)

                        while true do
                            local v539

                            v538, v539 = v536(v537, v538)

                            if v538 == nil then
                                break
                            end
                            if v539 and v539.Parent then
                                v539:Destroy()
                            end
                        end
                    end)
                end
	end
})

FreeSection:Button({
    Title = "Death",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer17 = game:GetService('Players').LocalPlayer
                local u541 = _LocalPlayer17.Character or _LocalPlayer17.CharacterAdded:Wait()
                local _Humanoid13 = u541:WaitForChild('Humanoid')
                local _CollectionService4 = game:GetService('CollectionService')
                local _Sound23 = Instance.new('Sound')

                _Sound23.SoundId = 'rbxassetid://125713401851477'
                _Sound23.Volume = 2
                _Sound23.Looped = true
                _Sound23.Parent = u541:FindFirstChild('HumanoidRootPart') or u541.PrimaryPart

                _Sound23:Play()

                local _Animation23 = Instance.new('Animation')

                _Animation23.AnimationId = 'rbxassetid://74441004296237'

                local u546 = _Humanoid13:LoadAnimation(_Animation23)

                u546.Looped = true

                local v547 = u546

                u546.Play(v547)

                local u548 = {}

                local function u550(p549)
                    p549:SetAttribute('EmoteProperty', true)
                    table.insert(u548, p549)
                    _CollectionService4:AddTag(p549, 'emoteendstuff' .. _LocalPlayer17.Name)
                end
                local function u555()
                    local v551, v552, v553 = pairs(u541.PrimaryPart:GetChildren())

                    while true do
                        local v554

                        v553, v554 = v551(v552, v553)

                        if v553 == nil then
                            break
                        end
                        if v554:GetAttribute('Wolf') then
                            v554:Destroy()
                        end
                    end
                end
                local function v564(p556)
                    local v557, v558, v559 = pairs(p556.things)

                    while true do
                        local v560

                        v559, v560 = v557(v558, v559)

                        if v559 == nil then
                            break
                        end

                        local v561 = v560:Clone()

                        u550(v561)

                        v561.Parent = p556.Parent or u541

                        local _Motor6D2 = v561:FindFirstChildOfClass('Motor6D')

                        if _Motor6D2 then
                            u550(_Motor6D2)

                            local _RightArm2 = u541['Right Arm']

                            if v560.Name == p556.Left then
                                _RightArm2 = u541['Left Arm']
                            end
                            if p556.Parent then
                                _RightArm2 = p556.Parent
                            end

                            _Motor6D2.Part0 = _RightArm2
                            _Motor6D2.Part1 = v561
                            _Motor6D2.Parent = _RightArm2
                        end
                        if p556.set then
                            v561:SetAttribute('Wolf', true)
                        end
                    end
                end

                local _BadWolf = script.BadWolf

                v564({
                    things = {
                        _BadWolf.HandleL,
                        _BadWolf.HandleR,
                    },
                    Left = 'HandleL',
                })
                v564({
                    things = {
                        _BadWolf.Left,
                        _BadWolf.Right,
                    },
                    Left = 'Left',
                    Parent = u541.PrimaryPart,
                    set = true,
                })

                local function v572()
                    local _Sparks2 = u541:FindFirstChild('Sparks2')

                    if not _Sparks2 then
                        _Sparks2 = _BadWolf.Sparks2:Clone()
                        _Sparks2.Parent = u541

                        local _Motor6D3 = _Sparks2:FindFirstChildOfClass('Motor6D')

                        if _Motor6D3 then
                            _Motor6D3.Part0 = u541.PrimaryPart
                            _Motor6D3.Part1 = _Sparks2
                            _Motor6D3.Parent = u541.PrimaryPart
                        end
                    end

                    local v568, v569, v570 = pairs(_Sparks2:GetDescendants())

                    while true do
                        local v571

                        v570, v571 = v568(v569, v570)

                        if v570 == nil then
                            break
                        end
                        if v571:IsA('ParticleEmitter') then
                            v571:Emit(v571:GetAttribute('EmitCount') or 10)
                        end
                    end
                end
                local function v593()
                    u555()

                    local v573 = u541

                    if not (u541:FindFirstChild('SpinL') or v573:FindFirstChild('SpinR')) then
                        local v574, v575, v576 = pairs({
                            _BadWolf.SpinL,
                            _BadWolf.SpinR,
                        })

                        while true do
                            local v577

                            v576, v577 = v574(v575, v576)

                            if v576 == nil then
                                break
                            end

                            local v578 = v577:Clone()

                            u550(v578)

                            v578.Parent = u541

                            local _Motor6D4 = v578:FindFirstChildOfClass('Motor6D')
                            local v580 = v577.Name == 'SpinL' and u541['Left Arm'] or u541['Right Arm']

                            _Motor6D4.Part0 = v580
                            _Motor6D4.Part1 = v578
                            _Motor6D4.Parent = v580
                        end
                    end

                    local v581 = {
                        u541:FindFirstChild('SpinL'),
                        (u541:FindFirstChild('SpinR')),
                    }
                    local v582, v583, v584 = pairs(v581)

                    local function v591(p585)
                        local v586, v587, v588 = pairs(p585:GetDescendants())

                        while true do
                            local u589

                            v588, u589 = v586(v587, v588)

                            if v588 == nil then
                                break
                            end
                            if u589:IsA('ParticleEmitter') then
                                task.spawn(function()
                                    u589.Enabled = true

                                    local v590 = u589

                                    task.wait(v590:GetAttribute('EmitDuration') or 1)

                                    if u589 and u589.Parent then
                                        u589.Enabled = false
                                    end
                                end)
                            end
                        end
                    end

                    while true do
                        local v592

                        v584, v592 = v582(v583, v584)

                        if v584 == nil then
                            break
                        end
                        if v592 then
                            v591(v592)
                        end
                    end
                end

                local v594 = u546

                u546.GetMarkerReachedSignal(v594, 'stop'):Connect(u555)

                local v595 = u546

                u546.GetMarkerReachedSignal(v595, 'clang'):Connect(v572)

                local v596 = u546

                u546.GetMarkerReachedSignal(v596, 'restart'):Connect(function()
                    local v597, v598, v599 = pairs(u541.PrimaryPart:GetChildren())

                    while true do
                        local v600

                        v599, v600 = v597(v598, v599)

                        if v599 == nil then
                            break
                        end
                        if v600:GetAttribute('Wolf') then
                            local v601, v602, v603 = pairs(v600:GetDescendants())

                            while true do
                                local v604

                                v603, v604 = v601(v602, v603)

                                if v603 == nil then
                                    break
                                end
                                if v604:IsA('ParticleEmitter') then
                                    v604:Emit(v604:GetAttribute('EmitCount') or 10)
                                end
                            end
                        end
                    end
                end)

                local v605 = u546

                u546.GetMarkerReachedSignal(v605, 'spin'):Connect(v593)
                task.delay(6, function()
                    u546:Stop()
                    _Sound23:Stop()

                    local v606, v607, v608 = pairs(u548)

                    while true do
                        local v609

                        v608, v609 = v606(v607, v608)

                        if v608 == nil then
                            break
                        end
                        if v609 and v609.Parent then
                            v609:Destroy()
                        end
                    end

                    u555()
                end)
	end
})

FreeSection:Button({
    Title = "Amplify",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer18 = game:GetService('Players').LocalPlayer
                local u611 = _LocalPlayer18.Character or _LocalPlayer18.CharacterAdded:Wait()
                local _Humanoid14 = u611:WaitForChild('Humanoid')
                local _CollectionService5 = game:GetService('CollectionService')
                local _Debris4 = game:GetService('Debris')
                local _Sound24 = Instance.new('Sound')

                _Sound24.SoundId = 'rbxassetid://112089323132965'
                _Sound24.Volume = 2
                _Sound24.Parent = u611:FindFirstChild('HumanoidRootPart') or u611.PrimaryPart

                _Sound24:Play()

                local _Animation24 = Instance.new('Animation')

                _Animation24.AnimationId = 'rbxassetid://106778226674700'

                local u617 = _Humanoid14:LoadAnimation(_Animation24)

                u617.Looped = false

                local v618 = u617

                u617.Play(v618)

                local u619 = {}

                local function u621(p620)
                    p620:SetAttribute('EmoteProperty', true)
                    table.insert(u619, p620)
                    _CollectionService5:AddTag(p620, 'emoteendstuff' .. _LocalPlayer18.Name)
                end

                local _AmplifyVfx = script.AmplifyVfx

                local function u632(p623, p624, p625)
                    local v626 = _AmplifyVfx[p623]:Clone()

                    v626.Parent = p624

                    _Debris4:AddItem(v626, 5)
                    u621(v626)

                    local _Motor6D5 = v626:FindFirstChildOfClass('Motor6D')

                    if _Motor6D5 then
                        v626.CanCollide = false
                        v626.Massless = true
                        v626.Anchored = false
                        _Motor6D5.Part0 = p624
                        _Motor6D5.Part1 = v626
                    else
                        v626.CFrame = u611.PrimaryPart.CFrame * CFrame.new(0, 0, -2)
                    end

                    local v628, v629, v630 = pairs(v626:GetDescendants())

                    while true do
                        local v631

                        v630, v631 = v628(v629, v630)

                        if v630 == nil then
                            break
                        end
                        if v631:IsA('ParticleEmitter') then
                            v631:Emit(v631:GetAttribute('EmitCount') or 10)

                            if _Motor6D5 then
                                v631.Enabled = true
                            end
                            if p623 == 'head' and (p625 and p625.head) then
                                table.insert(p625.head, v631)
                            end
                            if p625 and p625.all then
                                table.insert(p625.all, v631)
                            end
                        end
                    end
                end
                local function v643()
                    local v633 = {}
                    local v634 = {}

                    u632('arm', u611['Right Arm'], {all = v634})
                    u632('head', u611.Head, {
                        head = v633,
                        all = v634,
                    })
                    task.wait(1.1)

                    local v635, v636, v637 = pairs(v633)

                    while true do
                        local v638

                        v637, v638 = v635(v636, v637)

                        if v637 == nil then
                            break
                        end

                        v638.Enabled = false
                    end

                    local v639, v640, v641 = pairs(v634)

                    while true do
                        local v642

                        v641, v642 = v639(v640, v641)

                        if v641 == nil then
                            break
                        end

                        v642.Enabled = false

                        _Debris4:AddItem(v642, 1)
                    end
                end
                local function v646()
                    u632('arm2', u611['Left Arm'])
                    u632('auraoff', u611['Left Arm'])

                    local _Part2 = Instance.new('Part')

                    _Part2.Size = Vector3.new(1, 1, 1)
                    _Part2.Transparency = 1
                    _Part2.Anchored = false
                    _Part2.CanCollide = false
                    _Part2.Parent = u611.PrimaryPart

                    local _ParticleEmitter = Instance.new('ParticleEmitter')

                    _ParticleEmitter.Texture = 'rbxassetid://10826594435'
                    _ParticleEmitter.Rate = 50
                    _ParticleEmitter.Lifetime = NumberRange.new(1)
                    _ParticleEmitter.Speed = NumberRange.new(2)
                    _ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
                    _ParticleEmitter.Parent = _Part2

                    task.spawn(function()
                        _ParticleEmitter.Enabled = true

                        task.wait(1)

                        _ParticleEmitter.Enabled = false

                        _Debris4:AddItem(_Part2, 2)
                    end)
                end

                local v647 = u617

                u617.GetMarkerReachedSignal(v647, 'first'):Connect(v643)

                local v648 = u617

                u617.GetMarkerReachedSignal(v648, 'sec'):Connect(v646)
                task.delay(5, function()
                    u617:Stop()
                    _Sound24:Stop()

                    local v649, v650, v651 = pairs(u619)

                    while true do
                        local v652

                        v651, v652 = v649(v650, v651)

                        if v651 == nil then
                            break
                        end
                        if v652 and v652.Parent then
                            v652:Destroy()
                        end
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Locked In",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer19 = game:GetService('Players').LocalPlayer
                local u654 = _LocalPlayer19.Character or _LocalPlayer19.CharacterAdded:Wait()
                local _Humanoid15 = u654:WaitForChild('Humanoid')
                local _CollectionService6 = game:GetService('CollectionService')
                local _Sound25 = Instance.new('Sound')

                _Sound25.SoundId = 'rbxassetid://131221493098961'
                _Sound25.Volume = 2
                _Sound25.Looped = true
                _Sound25.Parent = u654:FindFirstChild('HumanoidRootPart') or u654.PrimaryPart

                _Sound25:Play()

                local _Animation25 = Instance.new('Animation')

                _Animation25.AnimationId = 'rbxassetid://132769857103497'

                local u659 = _Humanoid15:LoadAnimation(_Animation25)

                u659.Looped = true

                local v660 = u659

                u659.Play(v660)

                local u661 = {}

                local function u663(p662)
                    p662:SetAttribute('EmoteProperty', true)
                    table.insert(u661, p662)
                    _CollectionService6:AddTag(p662, 'emoteendstuff' .. _LocalPlayer19.Name)
                end
                local function u668(p664, p665, p666)
                    local _Motor6D6 = p664:FindFirstChildOfClass('Motor6D')

                    if _Motor6D6 then
                        u663(_Motor6D6)

                        _Motor6D6.Part0 = p665
                        _Motor6D6.Part1 = p666 or p664
                        _Motor6D6.Parent = p665
                    end
                end

                (function()
                    local v669 = script.SumWater:Clone()

                    u663(v669)

                    v669.Parent = u654

                    local _SumWater = v669:FindFirstChild('SumWater')

                    if _SumWater then
                        u668(_SumWater, u654.Head, v669)
                    end

                    local v671 = script.AuraRen:Clone()

                    u663(v671)

                    v671.Parent = u654

                    if v671:FindFirstChildOfClass('Motor6D') then
                        u668(v671, u654.PrimaryPart, v671)
                    end

                    local v672 = script.tounge:Clone()

                    u663(v672)

                    v672.Parent = u654

                    local _tounge = v672:FindFirstChild('tounge')

                    if _tounge then
                        u668(_tounge, u654.Head, v672)
                    end
                end)()
                task.delay(10, function()
                    u659:Stop()
                    _Sound25:Stop()

                    local v674, v675, v676 = pairs(u661)

                    while true do
                        local v677

                        v676, v677 = v674(v675, v676)

                        if v676 == nil then
                            break
                        end
                        if v677 and v677.Parent then
                            v677:Destroy()
                        end
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Perfect Concentration",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer20 = game:GetService('Players').LocalPlayer
                local u679 = _LocalPlayer20.Character or _LocalPlayer20.CharacterAdded:Wait()
                local _Humanoid16 = u679:WaitForChild('Humanoid')
                local _CollectionService7 = game:GetService('CollectionService')

                game:GetService('Debris')

                local _TweenService5 = game:GetService('TweenService')
                local _Sound26 = Instance.new('Sound')

                _Sound26.SoundId = 'rbxassetid://124276204137474'
                _Sound26.Volume = 2
                _Sound26.Looped = true
                _Sound26.Parent = u679:FindFirstChild('HumanoidRootPart') or u679.PrimaryPart

                _Sound26:Play()

                local _Animation26 = Instance.new('Animation')

                _Animation26.AnimationId = 'rbxassetid://120577018823573'

                local u685 = _Humanoid16:LoadAnimation(_Animation26)

                u685.Looped = false

                local v686 = u685

                u685.Play(v686)

                local _Animation27 = Instance.new('Animation')

                _Animation27.AnimationId = 'rbxassetid://102959457211902'

                local u688 = _Humanoid16:LoadAnimation(_Animation27)

                u688.Looped = true

                local u689 = {}

                local function u691(p690)
                    p690:SetAttribute('EmoteProperty', true)
                    table.insert(u689, p690)
                    _CollectionService7:AddTag(p690, 'emoteendstuff' .. _LocalPlayer20.Name)
                end
                local function u695(p692, p693)
                    local _WeldConstraint = Instance.new('WeldConstraint')

                    _WeldConstraint.Part0 = p692
                    _WeldConstraint.Part1 = p693
                    _WeldConstraint.Parent = p693
                end

                local _Concentration = script.Concentration

                task.delay(0.35, function()
                    if _Concentration and u679.PrimaryPart then
                        local v697 = _Concentration.Impact:Clone()

                        v697.Parent = workspace.Thrown

                        u691(v697)

                        v697.CFrame = u679.PrimaryPart.CFrame * v697:GetAttribute('Offset')

                        u695(u679.PrimaryPart, v697)

                        local _Highlight = Instance.new('Highlight')

                        _Highlight.Parent = u679

                        u691(_Highlight)

                        _Highlight.OutlineColor = Color3.fromRGB(84, 255, 113)
                        _Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                        _Highlight.FillTransparency = 1
                        _Highlight.OutlineTransparency = 1
                        _Highlight.DepthMode = Enum.HighlightDepthMode.Occluded

                        _TweenService5:Create(_Highlight, TweenInfo.new(0.125, Enum.EasingStyle.Quint), {
                            FillTransparency = 0.55,
                            OutlineTransparency = 0,
                        }):Play()
                        task.delay(0.2, function()
                            if _Highlight and _Highlight.Parent then
                                _TweenService5:Create(_Highlight, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
                                    FillTransparency = 1,
                                    OutlineTransparency = 1,
                                }):Play()
                            end
                        end)
                    end
                end)
                task.delay(0.43, function()
                    if _Concentration and u679.PrimaryPart then
                        local v699, v700, v701 = pairs(_Concentration.Puzzle:GetDescendants())

                        while true do
                            local v702

                            v701, v702 = v699(v700, v701)

                            if v701 == nil then
                                break
                            end
                            if v702:IsA('Part') then
                                local v703 = v702:Clone()

                                v703.Parent = workspace.Thrown

                                u691(v703)

                                v703.CFrame = u679.PrimaryPart.CFrame * v703:GetAttribute('Offset')

                                u695(u679.PrimaryPart, v703)
                            end
                        end
                    end
                end)
                u685.Stopped:Connect(function()
                    u688:Play()
                end)
                task.delay(10, function()
                    u685:Stop()
                    u688:Stop()
                    _Sound26:Stop()

                    local v704, v705, v706 = pairs(u689)

                    while true do
                        local v707

                        v706, v707 = v704(v705, v706)

                        if v706 == nil then
                            break
                        end
                        if v707 and v707.Parent then
                            v707:Destroy()
                        end
                    end
                end)
	end
})

FreeSection:Button({
    Title = "The Shadow",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer21 = game:GetService('Players').LocalPlayer
                local u709 = _LocalPlayer21.Character or _LocalPlayer21.CharacterAdded:Wait()
                local v710 = u709
                local v711 = u709.WaitForChild(v710, 'Humanoid')
                local _CollectionService8 = game:GetService('CollectionService')
                local _Sound27 = Instance.new('Sound')

                _Sound27.SoundId = 'rbxassetid://140523806098392'
                _Sound27.Volume = 2
                _Sound27.Parent = u709.PrimaryPart

                _Sound27:Play()

                local _Sound28 = Instance.new('Sound')

                _Sound28.SoundId = 'rbxassetid://72724090837907'
                _Sound28.Volume = 2
                _Sound28.Looped = true
                _Sound28.Parent = u709.PrimaryPart

                task.delay(1.25, function()
                    _Sound28:Play()
                end)

                local _Animation28 = Instance.new('Animation')

                _Animation28.AnimationId = 'rbxassetid://100667788888119'

                local u716 = v711:LoadAnimation(_Animation28)

                u716.Looped = false

                local v717 = u716

                u716.Play(v717)

                local _Animation29 = Instance.new('Animation')

                _Animation29.AnimationId = 'rbxassetid://84711944358577'

                local u719 = v711:LoadAnimation(_Animation29)

                u719.Looped = true

                local u720 = {}

                local function u722(p721)
                    p721:SetAttribute('EmoteProperty', true)
                    table.insert(u720, p721)
                    _CollectionService8:AddTag(p721, 'emoteendstuff' .. _LocalPlayer21.Name)
                end

                task.delay(0.65, function()
                    if not ({interrupted = false}).interrupted then
                        local v723 = script.AllParticles.FaceShade:Clone()

                        v723.Parent = u709.Head

                        u722(v723)

                        local v724 = script.AllParticles.Star:Clone()

                        v724.Parent = u709.Torso

                        u722(v724)
                    end
                end)
                u716.Stopped:Connect(function()
                    u719:Play()
                end)
                task.delay(10, function()
                    u716:Stop()
                    u719:Stop()
                    _Sound28:Destroy()

                    local v725, v726, v727 = pairs(u720)

                    while true do
                        local v728

                        v727, v728 = v725(v726, v727)

                        if v727 == nil then
                            break
                        end
                        if v728 and v728.Parent then
                            v728:Destroy()
                        end
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Weak",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer25 = game:GetService('Players').LocalPlayer
                local v806 = _LocalPlayer25.Character or _LocalPlayer25.CharacterAdded:Wait()
                local _Humanoid19 = v806:WaitForChild('Humanoid')
                local _Animation33 = Instance.new('Animation')

                _Animation33.AnimationId = 'rbxassetid://93125757361125'

                _Humanoid19:LoadAnimation(_Animation33):Play()

                local _Sound32 = Instance.new('Sound')

                _Sound32.SoundId = 'rbxassetid://128113260968190'
                _Sound32.Volume = 3
                _Sound32.Parent = v806:FindFirstChild('HumanoidRootPart') or v806.PrimaryPart

                _Sound32:Play()

                local _Folder9 = Instance.new('Folder')

                _Folder9.Name = 'PrideBind'
                _Folder9.Parent = v806

                _Folder9:SetAttribute('EmoteProperty', true)
                require(game:GetService('ReplicatedStorage').Emotes.VFX):MainFunction({
                    Character = v806,
                    vfxName = 'Weak',
                    SpecificModule = game:GetService('ReplicatedStorage').Emotes.VFX,
                    AnimSent = 93125757361125,
                    RealBind = _Folder9,
                })
	end
})

FreeSection:Button({
    Title = "Ruthless",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer26 = game:GetService('Players').LocalPlayer
                local v812 = _LocalPlayer26.Character or _LocalPlayer26.CharacterAdded:Wait()
                local _Humanoid20 = v812:WaitForChild('Humanoid')
                local _Animation34 = Instance.new('Animation')

                _Animation34.AnimationId = 'rbxassetid://129295156336675'

                _Humanoid20:LoadAnimation(_Animation34):Play()

                local _Sound33 = Instance.new('Sound')

                _Sound33.SoundId = 'rbxassetid://108336805340224'
                _Sound33.Volume = 2
                _Sound33.Parent = v812:FindFirstChild('HumanoidRootPart') or v812.PrimaryPart

                _Sound33:Play()

                local _Folder10 = Instance.new('Folder')

                _Folder10.Name = 'RuthlessBind'
                _Folder10.Parent = v812

                _Folder10:SetAttribute('EmoteProperty', true)
                require(game.ReplicatedStorage.Emotes.VFX):MainFunction({
                    Character = v812,
                    vfxName = 'Ruthless',
                    SpecificModule = game.ReplicatedStorage.Emotes.VFX,
                    AnimSent = 129295156336675,
                    RealBind = _Folder10,
                })
	end
})

FreeSection:Button({
    Title = "Aka Stance",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _Players17 = game:GetService('Players')
                local _CollectionService11 = game:GetService('CollectionService')
                local _LocalPlayer27 = _Players17.LocalPlayer
                local v820 = _LocalPlayer27.Character or _LocalPlayer27.CharacterAdded:Wait()
                local _Humanoid21 = v820:WaitForChild('Humanoid')
                local v822 = v820:FindFirstChild('Torso') or v820:FindFirstChild('UpperTorso')
                local _Sound34 = Instance.new('Sound')

                _Sound34.SoundId = 'rbxassetid://91565431637142'
                _Sound34.Volume = 0.5
                _Sound34.Looped = true
                _Sound34.Parent = v822

                _Sound34:Play()

                local _Animation35 = Instance.new('Animation')

                _Animation35.AnimationId = 'rbxassetid://' .. 131177495882827

                local v825 = _Humanoid21:LoadAnimation(_Animation35)

                v825:Play()

                local v826 = v820:FindFirstChild('Right Arm') or v820:FindFirstChild('RightHand')
                local u827 = {}
                local v828 = 118383042869348

                for _ = 1, 2 do
                    local v829 = script:WaitForChild('cursedEnergy2'):Clone()

                    v829.Parent = v820

                    v829:SetAttribute('EmoteProperty', true)
                    table.insert(u827, v829)
                    _CollectionService11:AddTag(v829, 'emoteendstuff' .. v820.Name)

                    local _Weld7 = Instance.new('Weld')

                    _Weld7.Part0 = v826
                    _Weld7.Part1 = v829
                    _Weld7.Parent = v829
                    _Weld7.C0 = CFrame.new(0, -1, 0)
                    v826 = v820:FindFirstChild('Left Arm')

                    if not v826 then
                        v826 = v820:FindFirstChild('LeftHand')
                    end
                end

                local _Animation36 = Instance.new('Animation')

                _Animation36.AnimationId = 'rbxassetid://' .. v828

                local u832 = nil

                v825.Stopped:Connect(function()
                    u832 = _Humanoid21:LoadAnimation(_Animation36)

                    u832:Play()
                end)
                task.delay(10, function()
                    local v833, v834, v835 = ipairs(u827)

                    while true do
                        local v836

                        v835, v836 = v833(v834, v835)

                        if v835 == nil then
                            break
                        end
                        if v836 and v836.Parent then
                            v836:Destroy()
                        end
                    end

                    if _Sound34 and _Sound34.Parent then
                        _Sound34:Stop()
                        _Sound34:Destroy()
                    end
                    if u832 then
                        u832:Stop()
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Ao Stance",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _Players18 = game:GetService('Players')
                local _CollectionService12 = game:GetService('CollectionService')
                local _LocalPlayer28 = _Players18.LocalPlayer
                local v840 = _LocalPlayer28.Character or _LocalPlayer28.CharacterAdded:Wait()
                local _Humanoid22 = v840:WaitForChild('Humanoid')
                local v842 = v840:FindFirstChild('Torso') or v840:FindFirstChild('UpperTorso')
                local _Sound35 = Instance.new('Sound')

                _Sound35.SoundId = 'rbxassetid://91565431637142'
                _Sound35.Volume = 0.5
                _Sound35.Looped = true
                _Sound35.Parent = v842

                _Sound35:Play()

                local _Animation37 = Instance.new('Animation')

                _Animation37.AnimationId = 'rbxassetid://' .. 104243341468337

                local v845 = _Humanoid22:LoadAnimation(_Animation37)

                v845:Play()

                local v846 = v840:FindFirstChild('Right Arm') or v840:FindFirstChild('RightHand')
                local u847 = {}
                local v848 = 113201609340793

                for _ = 1, 2 do
                    local v849 = script:WaitForChild('cursedEnergy'):Clone()

                    v849.Parent = v840

                    v849:SetAttribute('EmoteProperty', true)
                    table.insert(u847, v849)
                    _CollectionService12:AddTag(v849, 'emoteendstuff' .. v840.Name)

                    local _Weld8 = Instance.new('Weld')

                    _Weld8.Part0 = v846
                    _Weld8.Part1 = v849
                    _Weld8.Parent = v849
                    _Weld8.C0 = CFrame.new(0, -1, 0)
                    v846 = v840:FindFirstChild('Left Arm')

                    if not v846 then
                        v846 = v840:FindFirstChild('LeftHand')
                    end
                end

                local _Animation38 = Instance.new('Animation')

                _Animation38.AnimationId = 'rbxassetid://' .. v848

                local u852 = nil

                v845.Stopped:Connect(function()
                    u852 = _Humanoid22:LoadAnimation(_Animation38)

                    u852:Play()
                end)
                task.delay(10, function()
                    local v853, v854, v855 = ipairs(u847)

                    while true do
                        local v856

                        v855, v856 = v853(v854, v855)

                        if v855 == nil then
                            break
                        end
                        if v856 and v856.Parent then
                            v856:Destroy()
                        end
                    end

                    if _Sound35 and _Sound35.Parent then
                        _Sound35:Stop()
                        _Sound35:Destroy()
                    end
                    if u852 then
                        u852:Stop()
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Chosen",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _Players19 = game:GetService('Players')
                local _CollectionService13 = game:GetService('CollectionService')
                local _TweenService6 = game:GetService('TweenService')
                local _LocalPlayer29 = _Players19.LocalPlayer
                local v861 = _LocalPlayer29.Character or _LocalPlayer29.CharacterAdded:Wait()
                local _Humanoid23 = v861:WaitForChild('Humanoid')
                local u863 = {}
                local _Sound36 = Instance.new('Sound')

                _Sound36.SoundId = 'rbxassetid://18843153605'
                _Sound36.Volume = 1.2
                _Sound36.Looped = false
                _Sound36.Parent = v861:FindFirstChild('Torso') or v861:FindFirstChild('UpperTorso')

                _Sound36:Play()

                local _Sound37 = Instance.new('Sound')

                _Sound37.SoundId = 'rbxassetid://1838611838'
                _Sound37.Volume = 0.5
                _Sound37.Looped = true
                _Sound37.TimePosition = 33
                _Sound37.Parent = v861:FindFirstChild('Torso') or v861:FindFirstChild('UpperTorso')

                _Sound37:Play()

                local _Folder11 = Instance.new('Folder')

                _Folder11.Name = 'Freeze'

                _Folder11:SetAttribute('DontInterrupt', true)
                _Folder11:SetAttribute('NoStop', true)
                _Folder11:SetAttribute('EmoteProperty', true)

                _Folder11.Parent = v861

                table.insert(u863, _Folder11)

                local v867 = script:WaitForChild('chosenparticles'):Clone()

                v867:SetAttribute('EmoteProperty', true)
                _CollectionService13:AddTag(v867, 'emoteendstuff' .. v861.Name)

                local v868, v869, v870 = pairs(v867:GetChildren())
                local u871 = {}

                while true do
                    local v872, v873 = v868(v869, v870)

                    if v872 == nil then
                        break
                    end

                    v870 = v872

                    if v873:IsA('Beam') and v873.Enabled then
                        table.insert(u871, {
                            v873,
                            v873.Width1,
                        })

                        v873.Enabled = false
                        v873.Width1 = 0
                    end
                end

                local _Weld9 = Instance.new('Weld')

                _Weld9.Part0 = v861.PrimaryPart
                _Weld9.Part1 = v867
                _Weld9.C0 = CFrame.new(-1.32054138, 4.14816093, 1.88685989, 1, 0, 0, 0, 0.965925872, 0.258818984, 0, -0.258818984, 0.965925872)
                _Weld9.Parent = v867
                v867.Parent = v861

                table.insert(u863, v867)
                task.delay(2, function()
                    local v875, v876, v877 = pairs(u871)

                    while true do
                        local v878

                        v877, v878 = v875(v876, v877)

                        if v877 == nil then
                            break
                        end

                        local v879 = v878[1]

                        v879.Enabled = true

                        _TweenService6:Create(v879, TweenInfo.new(1 + math.random(), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                            Width1 = v878[2],
                        }):Play()
                    end
                end)

                local _Animation39 = Instance.new('Animation')

                _Animation39.AnimationId = 'rbxassetid://' .. 18897534746

                local v881 = _Humanoid23:LoadAnimation(_Animation39)

                v881:Play()

                local _Animation40 = Instance.new('Animation')

                _Animation40.AnimationId = 'rbxassetid://' .. 18897538537

                local u883 = nil

                v881.Stopped:Connect(function()
                    u883 = _Humanoid23:LoadAnimation(_Animation40)

                    u883:Play()
                end)
                task.delay(10, function()
                    local v884, v885, v886 = pairs(u863)

                    while true do
                        local v887

                        v886, v887 = v884(v885, v886)

                        if v886 == nil then
                            break
                        end
                        if v887 and v887.Parent then
                            v887:Destroy()
                        end
                    end

                    if _Sound36 and _Sound36.Parent then
                        _Sound36:Stop()
                        _Sound36:Destroy()
                    end
                    if _Sound37 and _Sound37.Parent then
                        _Sound37:Stop()
                        _Sound37:Destroy()
                    end
                    if u883 then
                        u883:Stop()
                    end
                end)

                local _Sound38 = Instance.new('Sound')

                _Sound38.SoundId = 'rbxassetid://15443922202'
                _Sound38.Volume = 1
                _Sound38.Looped = false
                _Sound38.Parent = v861:FindFirstChild('Torso') or v861:FindFirstChild('UpperTorso')

                table.insert(u863, _Sound38)
	end
})

FreeSection:Button({
    Title = "Hunter Pose",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _Players20 = game:GetService('Players')
                local _CollectionService14 = game:GetService('CollectionService')
                local _LocalPlayer30 = _Players20.LocalPlayer
                local u892 = _LocalPlayer30.Character or _LocalPlayer30.CharacterAdded:Wait()
                local _Humanoid24 = u892:WaitForChild('Humanoid')
                local u894 = {}
                local v895 = u892:FindFirstChild('Torso') or u892:FindFirstChild('UpperTorso')
                local _Sound39 = Instance.new('Sound')

                _Sound39.SoundId = 'rbxassetid://117253563855238'
                _Sound39.Volume = 2
                _Sound39.Looped = false
                _Sound39.Parent = v895

                local v897 = _Sound39

                _Sound39.Play(v897)

                local u898 = script:WaitForChild('RockBig'):Clone()

                u898.Parent = u892
                u898.Anchored = true

                local v899 = u898

                u898.SetAttribute(v899, 'EmoteProperty', true)
                table.insert(u894, u898)
                _CollectionService14:AddTag(u898, 'emoteendstuff' .. u892.Name)
                spawn(function()
                    local v900 = tick()

                    while true do
                        task.wait()

                        if tick() - v900 >= 0.5 or not (u898 and u898.Parent) then
                            break
                        end

                        u898.CFrame = u892.PrimaryPart.CFrame * CFrame.new(0, -1.5, 4)
                    end
                end)

                local _Animation41 = Instance.new('Animation')

                _Animation41.AnimationId = 'rbxassetid://' .. 78615192673057

                local v902 = _Humanoid24:LoadAnimation(_Animation41)

                v902:Play()

                local _Animation42 = Instance.new('Animation')

                _Animation42.AnimationId = 'rbxassetid://' .. 123794818363362

                local u904 = nil

                v902.Stopped:Connect(function()
                    u904 = _Humanoid24:LoadAnimation(_Animation42)

                    u904:Play()
                end)
                task.delay(10, function()
                    local v905, v906, v907 = pairs(u894)

                    while true do
                        local v908

                        v907, v908 = v905(v906, v907)

                        if v907 == nil then
                            break
                        end
                        if v908 and v908.Parent then
                            v908:Destroy()
                        end
                    end

                    if _Sound39 and _Sound39.Parent then
                        _Sound39:Stop()
                        _Sound39:Destroy()
                    end
                    if u904 then
                        u904:Stop()
                    end
                end)
	end
})

FreeSection:Button({
    Title = "Energy Barrage",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer31 = game:GetService('Players').LocalPlayer
                local v910 = _LocalPlayer31.Character or _LocalPlayer31.CharacterAdded:Wait()
                local _Humanoid25 = v910:WaitForChild('Humanoid')
                local _Animation43 = Instance.new('Animation')

                _Animation43.AnimationId = 'rbxassetid://101680746241828'

                _Humanoid25:LoadAnimation(_Animation43):Play()

                local _Sound40 = Instance.new('Sound')

                _Sound40.SoundId = 'rbxassetid://82169026724146'
                _Sound40.Volume = 2
                _Sound40.Parent = v910:FindFirstChild('HumanoidRootPart') or v910.PrimaryPart

                _Sound40:Play()

                local _Folder12 = Instance.new('Folder')

                _Folder12.Name = 'RuthlessBind'
                _Folder12.Parent = v910

                _Folder12:SetAttribute('EmoteProperty', true)
                require(game.ReplicatedStorage.Emotes.VFX):MainFunction({
                    Character = v910,
                    vfxName = 'Energy Barrage',
                    SpecificModule = game.ReplicatedStorage.Emotes.VFX,
                    AnimSent = 101680746241828,
                    RealBind = _Folder12,
                })
	end
})
FreeSection:Button({
    Title = "Dragon Combo",
    Desc = "Free Emote", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Bug", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
                local _LocalPlayer32 = game:GetService('Players').LocalPlayer
                local v916 = _LocalPlayer32.Character or _LocalPlayer32.CharacterAdded:Wait()
                local _Humanoid26 = v916:WaitForChild('Humanoid')
                local _Animation44 = Instance.new('Animation')

                _Animation44.AnimationId = 'rbxassetid://136363608783208'

                _Humanoid26:LoadAnimation(_Animation44):Play()

                local _Sound41 = Instance.new('Sound')

                _Sound41.SoundId = 'rbxassetid://131083520587944'
                _Sound41.Volume = 2
                _Sound41.Parent = v916:FindFirstChild('HumanoidRootPart') or v916.PrimaryPart

                _Sound41:Play()

                local _Folder13 = Instance.new('Folder')

                _Folder13.Name = 'RuthlessBind'
                _Folder13.Parent = v916

                _Folder13:SetAttribute('EmoteProperty', true)
                require(game.ReplicatedStorage.Emotes.VFX):MainFunction({
                    Character = v916,
                    vfxName = 'Dragon Combo',
                    SpecificModule = game.ReplicatedStorage.Emotes.VFX,
                    AnimSent = 136363608783208,
                    RealBind = _Folder13,
                })
	end
})

EmoteTab:Button({
    Title = "Buy Emote Limeted",
    Desc = "Buy any emote limeted", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/c77b9b27b7cc23a71bf4edb509b1804e/raw/buyanyemotelimeted.lua"))()
    end
})

EmoteTab:Button({
    Title = "Buy Emote Limeted v2",
    Desc = "some Emote Limeted cant display because limited size", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
		--// như bên suộc mình gửi
    end
})

EmoteTab:Button({
    Title = "Basic Emote",
    Desc = "Keybind: T", -- optional
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    IconAlign = "Right", -- "Left" or "Right". optional
    Locked = false, -- disable button. optional
    LockedTitle = "Locked", -- text shown when locked. optional
    Justify = "Between", -- "Between" or "Center". optional
    Flag = "my_button", -- for config saving. optional
    Callback = function()
        getgenv().GuiKeybind = 'T'

        loadstring(game:HttpGet('https://raw.githubusercontent.com/Cyborg883/EmoteGui/refs/heads/main/Protected_4900496055951847.lua'))()
    end,
})

local SettingsTab = Window:Tab({
    Title = "Settings",
    Desc = "setting of script!", -- optional
    Icon = "settings", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(0, 0, 0), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local Dropdown = SettingsTab:Dropdown({
    Title = "Select Theme",
    Values = {
        {
            Title = "Nazuna",
            Desc = "my wife :>",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://134522511102996")
            end
        },
		{ Type = "Divider", },
        {
            Title = "Hutao 1",
            Desc = "Hutao :3",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://108791580780762")
            end
        },
		{ Type = "Divider", },
        {
            Title = "Chara 1",
            Desc = "Chara GT",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://117011100817764")
            end
        },
        {
            Title = "Chara 2",
            Desc = "X!Chara",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://92469674774033")
            end
        },
        {
            Title = "Chara 3",
            Desc = "X!Chara",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://125730749882439")
            end
        },
		{ Type = "Divider", },
		{
            Title = "Frisk 1",
            Desc = "Frisk GT",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://139131717590518")
            end
        },
		{
            Title = "Frisk 2",
            Desc = "X!Frisk",
            Icon = "image-up",
            Callback = function() 
                Window:SetBackgroundImage("rbxassetid://110901432936996")
            end
        },
    }
})

SettingsTab:Input({
    Title = "Custom Theme",
    Placeholder = "Enter ID Theme...",
    Locked = false,
    Callback = function(text)
        local id = tonumber(text)

        if id then
            Window:SetBackgroundImage("rbxassetid://" .. id)
            print("Set custom theme:", id)
        else
            warn("Invalid Theme ID")
        end
    end
})

local MiscTab = Window:Tab({
    Title = "Misc",
    Desc = "some feature", -- optional
    Icon = "table-of-contents", -- lucide icon or "rbxassetid://" or URL. optional
    IconColor = Color3.fromRGB(255, 255, 255), -- custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    IconThemed = true, -- use theme colors. optional
    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

local Players = game:GetService("Players")

-- Paragraph WindUI
local ServerInfoParagraph = MiscTab:Paragraph({
    Title = "📊 Server Info",
    Desc = "Loading..."
})

-- format uptime
local function formatTime(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = math.floor(sec % 60)
    return string.format("%02dh %02dm %02ds", h, m, s)
end

-- update loop
task.spawn(function()
    while true do
        local currentPlayers = #Players:GetPlayers()
        local maxPlayers = Players.MaxPlayers
        local placeId = game.PlaceId
        local jobId = game.JobId
        local uptime = workspace.DistributedGameTime

        ServerInfoParagraph:SetDesc(
            "👥 Players: "..currentPlayers.." / "..maxPlayers..
            "\n👀 PlaceId: "..placeId..
            "\n⌚ Session Time: "..formatTime(uptime)..
            "\n🧩 JobId: "..jobId
        )

        task.wait(1)
    end
end)

MiscTab:Divider()

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--------------------------------------------------
-- COPY JOB ID
--------------------------------------------------
MiscTab:Button({
    Title = "📋 Copy JobId",
    Desc = "Copy current server JobId",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function()
        if setclipboard then
            setclipboard(game.JobId)
        end
    end
})

--------------------------------------------------
-- JOIN JOB ID
--------------------------------------------------

local Input = MiscTab:Input({
    Title = "👾 Join JobID",
	Placeholder = "Paste JobId & Enter",
    Callback = function(text)
        if text and text ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, text, LocalPlayer)
        end
    end
})

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

MiscTab:Button({
    Title = "🔄 Rejoin Server",
    Desc = "Rejoin current server",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function()
        pcall(function()
            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                game.JobId,
                LocalPlayer
            )
        end)
    end
})

MiscTab:Divider()

--------------------------------------------------
-- SERVER HOP CORE
--------------------------------------------------
local function getServers(maxPages)
    local servers = {}
    local cursor = ""
    local pages = 0

    repeat
        pages += 1
        local url =
            "https://games.roblox.com/v1/games/"
            .. game.PlaceId
            .. "/servers/Public?sortOrder=Asc&limit=100"
            .. (cursor ~= "" and "&cursor=" .. cursor or "")

        local success, res = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if not success or not res or not res.data then break end

        for _, srv in ipairs(res.data) do
            if srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
                table.insert(servers, srv)
            end
        end

        cursor = res.nextPageCursor
    until not cursor or pages >= (maxPages or 5)

    return servers
end

--------------------------------------------------
-- RANDOM SERVER HOP
--------------------------------------------------
MiscTab:Button({
    Title = "🎲 Hop Server",
    Desc = "Random public server",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function()
        local servers = getServers(6)
        if #servers == 0 then return end

        local low, mid, high = {}, {}, {}

        for _, srv in ipairs(servers) do
            local ratio = srv.playing / srv.maxPlayers

            if ratio <= 0.3 then
                table.insert(low, srv)
            elseif ratio <= 0.7 then
                table.insert(mid, srv)
            else
                table.insert(high, srv)
            end
        end

        -- build available buckets
        local buckets = {}
        if #low > 0 then table.insert(buckets, low) end
        if #mid > 0 then table.insert(buckets, mid) end
        if #high > 0 then table.insert(buckets, high) end
        if #buckets == 0 then return end

        -- random bucket FIRST (equal chance)
        local chosenBucket = buckets[math.random(1, #buckets)]
        local pick = chosenBucket[math.random(1, #chosenBucket)]

        task.wait(0.2)
        TeleportService:TeleportToPlaceInstance(
            game.PlaceId,
            pick.id,
            LocalPlayer
        )
    end
})

--------------------------------------------------
-- LOWEST PLAYER SERVER
--------------------------------------------------
MiscTab:Button({
    Title = "👥 Hop Lowest Player ",
    Desc = "Join server have low player",
    Icon = "mouse-pointer-click", -- lucide icon or "rbxassetid://". optional
    Value = false, -- initial state. optional
    Type = "Toggle", -- "Toggle" or "Checkbox". optional
    Locked = false, -- disable toggle. optional
    Flag = "my_toggle", -- for config saving. optional
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local servers = {}
        local cursor = ""

        repeat
            local url =
                "https://games.roblox.com/v1/games/"
                .. game.PlaceId
                .. "/servers/Public?sortOrder=Asc&limit=100"
                .. (cursor ~= "" and "&cursor=" .. cursor or "")

            local success, res = pcall(function()
                return HttpService:JSONDecode(game:HttpGet(url))
            end)

            if success and res and res.data then
                for _, srv in ipairs(res.data) do
                    if srv.playing
                        and srv.playing >= 1
                        and srv.playing < srv.maxPlayers
                        and srv.id ~= game.JobId then

                        table.insert(servers, srv)
                    end
                end
                cursor = res.nextPageCursor
            else
                break
            end
        until not cursor or #servers >= 200

        table.sort(servers, function(a, b)
            return a.playing < b.playing
        end)

        if servers[1] then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(
                    game.PlaceId,
                    servers[1].id,
                    LocalPlayer
                )
            end)
        end
    end
})
loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/cc8db5b2127d8b359f0a5faf84eb7e7b/raw/hubchat.lua"))()
loadstring(game:HttpGet("https://gist.githubusercontent.com/ngm2807-sudo/cf8733c64e62440b302f300ab301c49b/raw/jumpscarebaeminh.lua"))()