local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local text = game:HttpGet('https://raw.githubusercontent.com/PandaHubRoblox/Ler.lua/main/source.lua')
 
if text == nil then
    print("bug what the hell")
end

source = require(text)

local HumanoidStupidTable = {}

local MainWindow = Rayfield:CreateWindow({
    Name = "Main",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Falxe",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "McDonalds Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "McDonalds Hub",
       Subtitle = "Key System",
       Note = "Key: McDonalds",
       FileName = "SiriusKey",
       SaveKey = true,
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "McDonalds"
    }
 })
 
 
local MainTab = MainWindow:CreateTab("Main", 4483362458) -- Title, Image
 
 
local Button = MainTab:CreateButton({
    Name = "Give to humanoid";
    Callback = function(v)
        source:GiveToHumanoid(game.Players.LocalPlayer, HumanoidStupidTable) 
    end;
})

local Button = MainTab:CreateButton({
    Name = "Kill All Players";
    Callback = function(v)
        source:KillAllPlayers(false, nil)
    end;
})
 
 
 
local Toggle = MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(InfiniteJumpEnabled)
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
    end,
})
 
 
 
 local Slider = MainTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 250},
    Increment = 10,
    Suffix = "Walkspeed",
    CurrentValue = 10,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(v)
        if HumanoidStupidTable["WalkSpeed"] == nil then
            HumanoidStupidTable["WalkSpeed"] = v
        else
            HumanoidStupidTable["WalkSpeed"] = v
        end
    end,
 })
 
 
 
 local Slider = MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 10,
    Suffix = "JumpPower",
    CurrentValue = 10,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(v)
        HumanoidStupidTable["UseJumpPower"] = true
        if HumanoidStupidTable["JumpPower"] == nil then
            HumanoidStupidTable["JumpPower"] = v
        else
            HumanoidStupidTable["JumpPower"] = v
        end
    end,
 })
 
