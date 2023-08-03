local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
repeat
	wait()
until humanoid:IsDescendantOf(game)

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")
local part = game.Workspace.LargePlatform.Touchbox


part.Touched:Connect(function(itemThatTouchedPart)
	local playerCheck = Players:GetPlayerFromCharacter(itemThatTouchedPart.Parent) -- Checks if a player's Character touched the part

	if playerCheck and playerCheck == player then
		player.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
		game.ReplicatedStorage.TimerValue.Value = 0
		
		for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
	
			if v.Character.Humanoid.WalkSpeed == 37 then
				game.ReplicatedStorage.Value.Value = v.name
			end
			
		end
		
		ScreenGui.TextLabel.Text = game.ReplicatedStorage.Value.Value .. " Wins!!!"
		
		while game.ReplicatedStorage.TimerValue.Value < 101 do
			game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
			wait(0.1)
		end
		
		game.ReplicatedStorage.TimerValue.Value = 0
		humanoid.Health = 0
	end
end)