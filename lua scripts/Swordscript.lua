function hitDamage(humanoid, value)
	--this function subtracts damage from target character health, creating hit damage effect
	humanoid.Health = humanoid.Health - value
	
end

function animation(humanoid, animation)
	--this function loads in the animation ID and plays it on the player character
	humanoid:LoadAnimation(animation):Play()
	
end

--when Sword tool is clicked, run function
script.Parent.Activated:Connect(function()
	--feed player character and animation ID into animation function
	animation(script.Parent.Parent.Humanoid, script.Parent.Animation)
	wait(0.15)
	
	--fetches all objects within workspace
	local all = game.workspace:GetDescendants()
	
	--iterate through all objects
	
	--EXPLANATION: for i, v in pairs(t) is a specific instance of this; pairs is a function which returns an iterator, the state passed to it, and nil. 
	--When you use this idiom, you’re using an iterator function which goes over every key-value pair in your table t, and moves it into i, v.
	--You’d use pairs(t) in your loop when you want to go over a dictionary, for example: {a = 1, b = 2, c = 3}. pairs doesn’t iterate in any specific order, but it goes over all key-value pairs.
	for i, v in pairs(all) do
		
		--detect instances of characters in the game except player
		--use HumanoidRootPart so that the sword doesn't have to detect each body part
		if v.Parent:FindFirstChild('Humanoid') and v.Parent.Name ~= script.Parent.Parent.Name and v.Name == ('HumanoidRootPart') then
			--find distance between detector and target characters
			local distance = (script.Parent.Detector.Position - v.Position).magnitude
			
			if distance < 10 then
				--print(distance)
				--if target character is close enough to Detector, inflict damage
				hitDamage(v.Parent.Humanoid, 35)
				
			end
			
			
		end
		
	end
	
end)