local Player, plr, Folder = game:GetService("Players").LocalPlayer, game:GetService("Players").LocalPlayer,Instance.new("Folder",game)
local API = {}
function API:swait()
	game:GetService("RunService").Stepped:Wait()
end
function API:GetPart(Target)
	game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

	return Target.Character:FindFirstChild("HumanoidRootPart") or Target.Character:FindFirstChild("Head")
end
function API:ConvertPosition(Position)
	if typeof(Position):lower() == "position" then
		return CFrame.new(Position)
	else
		return Position
	end
end
function API:GetCameraPosition(Player)
	return workspace["CurrentCamera"].CFrame
end
function API:GetPosition(Player)
	game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

	if Player then
		return API:GetPart(Player).CFrame
	elseif not Player then
		return API:GetPart(plr).CFrame
	end
end


function API:WaitForRespawn(Cframe,NoForce)
	game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

	local Cframe = API:ConvertPosition(Cframe)
	local CameraCframe = API:GetCameraPosition()
	coroutine.wrap(function()
		local a
		a = Player.CharacterAdded:Connect(function(NewCharacter)
			pcall(function()
				coroutine.wrap(function()
					workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
					API:Loop(5, function()
						workspace["CurrentCamera"].CFrame = CameraCframe
					end)
				end)()
				NewCharacter:WaitForChild("HumanoidRootPart")
				API:MoveTo(Cframe)
				if NoForce then
					task.spawn(function()
						NewCharacter:WaitForChild("ForceField"):Destroy()
					end)
				end
			end)
			a:Disconnect()
			Cframe = nil
		end)
		task.spawn(function()
			wait(2)
			if a then
				a:Disconnect()
			end
		end)
	end)()
end
function API:ChangeTeam(TeamPath,NoForce,Pos)
	pcall(function()
		repeat task.wait() until game:GetService("Players").LocalPlayer.Character
		game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")

		API:WaitForRespawn(Pos or API:GetPosition(),NoForce)
	end)
	if TeamPath == game.Teams.Criminals then
		task.spawn(function()
			workspace.Remote.TeamEvent:FireServer("Bright orange")
		end)
		repeat API:swait() until Player.Team == game.Teams.Inmates and Player.Character:FindFirstChild("HumanoidRootPart")
		repeat
			API:swait()
			if firetouchinterest then
				firetouchinterest(plr.Character:FindFirstChildOfClass("Part"), game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1], 0)
				firetouchinterest(plr.Character:FindFirstChildOfClass("Part"), game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1], 1)
			end
			game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1].Transparency = 1
			game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1].CanCollide = false
			game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1].CFrame = API:GetPosition()
		until plr.Team == game:GetService("Teams").Criminals
		game:GetService("Workspace")["Criminals Spawn"]:GetChildren()[1].CFrame = CFrame.new(0, 3125, 0)
	else
		if TeamPath == game.Teams.Neutral then
			workspace['Remote']['TeamEvent']:FireServer("Bright orange")
		else
			if not TeamPath or not TeamPath.TeamColor then
				workspace['Remote']['TeamEvent']:FireServer("Bright orange")
			else
				workspace['Remote']['TeamEvent']:FireServer(TeamPath.TeamColor.Name)
			end
		end
	end
end

function API:GetGun(Item, Ignore)
	task.spawn(function()
		workspace:FindFirstChild("Remote")['ItemHandler']:InvokeServer({
			Position = Player.Character.Head.Position,
			Parent = workspace.Prison_ITEMS:FindFirstChild(Item, true)
		})
	end)
end

function API:GiveToHumanoid(Player : Player, ...)
	for ValueName, Value in pairs(...) do
		print("Giving Humanoid", ValueName)
		local Humanoid : Humanoid = Player.Character:WaitForChild("Humanoid") :: Humanoid
        print(Value, ValueName)
		Humanoid[ValueName] = Value
	end
end
function API:KillAllPlayers(ExcludeYou : boolean, LocalPlayer : Player)
    --haha
	local BulletTable = {}
	for i,v in pairs(game.Players:GetPlayers()) do
        if v == LocalPlayer and ExcludeYou then
            continue
		elseif v then
			for i =1,15 do
				BulletTable[#BulletTable + 1] = {
					["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
					["Hit"] = v.Character:FindFirstChild("Head") or v.Character:FindFirstChildOfClass("Part"),
				}
			end
		end
	end
	wait(.4)
	API:GetGun("M9")
	local Gun = Player.Backpack:FindFirstChild("M9") or Player.Character:FindFirstChild("M9")
	repeat task.wait() Gun = Player.Backpack:FindFirstChild("M9") or Player.Character:FindFirstChild("M9") until Gun

	task.spawn(function()
		game:GetService("ReplicatedStorage").ShootEvent:FireServer(BulletTable, Gun)
	end)
end
function API:killall(TeamToKill)
	if not TeamToKill then
		local LastTeam = Player.Team
		local BulletTable = {}
		if Player.Team ~= game.Teams.Criminals then
			API:ChangeTeam(game.Teams.Criminals,true)
		end
		API:GetGun("Remington 870")
		local Gun = Player.Backpack:FindFirstChild("Remington 870") or Player.Character:FindFirstChild("Remington 870")
		repeat API:swait() Gun = Player.Backpack:FindFirstChild("Remington 870") or Player.Character:FindFirstChild("Remington 870") until Gun

		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v and v~=Player  and v.Team == game.Teams.Inmates or v.Team == game.Teams.Guards then
				for i =1,15 do
					BulletTable[#BulletTable + 1] = {
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Hit"] = v.Character:FindFirstChild("Head") or v.Character:FindFirstChildOfClass("Part"),
					}
				end
			end
		end
		task.spawn(function()
			game:GetService("ReplicatedStorage").ShootEvent:FireServer(BulletTable, Gun)
		end)
		API:ChangeTeam(game.Teams.Inmates,true)
		API:GetGun("Remington 870")
		repeat API:swait() Gun = Player.Backpack:FindFirstChild("Remington 870") or Player.Character:FindFirstChild("Remington 870") until Gun
		local Gun = Player.Backpack:FindFirstChild("Remington 870") or Player.Character:FindFirstChild("Remington 870")
		for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
			if v and v~=Player then
				for i =1,15 do
					BulletTable[#BulletTable + 1] = {
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Hit"] = v.Character:FindFirstChild("Head") or v.Character:FindFirstChildOfClass("Part"),
					}
				end
			end
		end
		task.spawn(function()
			game:GetService("ReplicatedStorage").ShootEvent:FireServer(BulletTable, Gun)
		end)
		if LastTeam ~= game.Teams.Inmates then
			API:ChangeTeam(LastTeam,true)
		end
	elseif TeamToKill then
		if TeamToKill == game.Teams.Inmates or TeamToKill == game.Teams.Guards  then
			if Player.Team ~= game.Teams.Criminals then
				API:ChangeTeam(game.Teams.Criminals)
			end
		elseif TeamToKill == game.Teams.Criminals then
			if Player.Team ~= game.Teams.Inmates then
				API:ChangeTeam(game.Teams.Inmates)
			end
		end
		local BulletTable = {}
		for i,v in pairs(TeamToKill:GetPlayers()) do
			if v and v~=Player then
				for i =1,15 do
					BulletTable[#BulletTable + 1] = {
						["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
						["Hit"] = v.Character:FindFirstChild("Head") or v.Character:FindFirstChildOfClass("Part"),
					}
				end
			end
		end
		wait(.4)
		API:GetGun("M9")
		local Gun = Player.Backpack:FindFirstChild("M9") or Player.Character:FindFirstChild("M9")
		repeat task.wait() Gun = Player.Backpack:FindFirstChild("M9") or Player.Character:FindFirstChild("M9") until Gun

		task.spawn(function()
			game:GetService("ReplicatedStorage").ShootEvent:FireServer(BulletTable, Gun)
		end)
	end
end
local giveToHumanoidValues = {
	["WalkSpeed"] = 100;
	["UseJumpPower"] = true;
	["JumpPower"] = 100;
}
API:GiveToHumanoid(game.Players.LocalPlayer, giveToHumanoidValues)
API:KillAllPlayers(false, nil)