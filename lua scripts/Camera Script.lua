local RunService = game:GetService('RunService')

local LocalPlayer = game:GetService('Players').LocalPlayer

if not LocalPlayer.Character then
	LocalPlayer.CharacterAdded:Wait()
end

task.wait()
--change camera type only once character is loaded in

local CurrentCam = workspace.CurrentCamera

CurrentCam.CameraType = Enum.CameraType.Scriptable
--makes cam scriptable

RunService.RenderStepped:Connect(function(_)
	--this service runs every frame
	local PlayerPosition = LocalPlayer.Character.PrimaryPart.Position
	local FocusPosition
	local Spectate = 0
	
	--fetches all objects within workspace
	local all = game.workspace:GetDescendants()
	
	--iterate through all objects

	--EXPLANATION: for i, v in pairs(t) is a specific instance of this; pairs is a function which returns an iterator, the state passed to it, and nil. 
	--When you use this idiom, you’re using an iterator function which goes over every key-value pair in your table t, and moves it into i, v.
	--You’d use pairs(t) in your loop when you want to go over a dictionary, for example: {a = 1, b = 2, c = 3}. pairs doesn’t iterate in any specific order, but it goes over all key-value pairs.
	for i, v in pairs(all) do
		
		--detect instances of Focus points in the game
		if v.Name == ('Focus') then
			--find distance between Player and Focus
			local distance = (PlayerPosition - v.Position).magnitude
			if distance < 200 then
				--if Focus  is close enough to Player, focus camera
				FocusPosition = v.Position
			end
		end
	end
	
	local namecheck = game.workspace:GetDescendants()
	for i, v in pairs(namecheck) do
		if v.Name == ('Focus') then
			CurrentCam.CFrame = CFrame.new(PlayerPosition + Vector3.new(PlayerPosition.X - FocusPosition.X, PlayerPosition.Y + 2, PlayerPosition.Z - FocusPosition.Z + 4), FocusPosition)
			--sets cam position and focus
		end
	end
	
		
end)
