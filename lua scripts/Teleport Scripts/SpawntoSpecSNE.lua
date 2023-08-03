local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
repeat
	wait()
until humanoid:IsDescendantOf(game)

local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")
local part = workspace.Spectate


part.Touched:Connect(function(itemThatTouchedPart)
	local playerCheck = Players:GetPlayerFromCharacter(itemThatTouchedPart.Parent) -- Checks if a player's Character touched the part

	if playerCheck and playerCheck == player then
		ScreenGui.TextLabel.Text = "Spectating"	
		player.Character.HumanoidRootPart.CFrame = workspace.SmallPlatformNE.Camera.CFrame
	end
	
end)