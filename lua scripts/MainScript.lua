--script runs when player spawns
--game.Players.PlayerAdded:Connect(function(player)
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		
		--variables
		local ScreenGui = player.PlayerGui:WaitForChild("ScreenGui")
		local hum = char:FindFirstChild("Humanoid")
		local hrp = char:WaitForChild("HumanoidRootPart")
		local lock = 1
		local i = 5
		local k = 0

		
		--jump and walk attributes applied to players
		hum.JumpHeight = 8
		hum.WalkSpeed = 36
		
		if lock == 0 then
			lock = 1
		end
		
		if i ~= 5 then
			i = 5
		end
		
		--lobby script
		while lock == 1 do
			if #player.PlayerGui.ScreenGui.TextLabel.Text < 2 or game.ReplicatedStorage.IntValue.Value == 1 then
				print(player.Name .. " Has a blank textbox")
				game.ReplicatedStorage.TimerValue.Value = 0
				--reset timer
			end
			--timervalue ticks to 100% before game starts
			--value is stored in Replicated Storage, will increase faster if there are multiple players in the lobby
			while game.ReplicatedStorage.TimerValue.Value < 101 do
				if ScreenGui:FindFirstChild("TextLabel") ~= nil and ScreenGui.TextLabel.Text ~= "Spectating" and #player.PlayerGui.ScreenGui.TextLabel.Text > 2 then
					print(player.Name .. " is Alive")
					ScreenGui.TextLabel.Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
					--value by default is an integer, needs to be converted to string in order to print ^^^
					
				elseif #player.PlayerGui.ScreenGui.TextLabel.Text < 2 then
					local dead = 1
					while dead > 0 do
						--keep Spectator healed, increases speed of counter when players die
						print("Healing Spectator: " .. player.Name)
						hum.Health = 100
						i = i - 1
						dead = 0
						game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
						wait(0.1)

						for _, v in ipairs(game:GetService("Players"):GetPlayers()) do

							if #v.PlayerGui.ScreenGui.TextLabel.Text < 2 then
								print(v.Name)
								--prints names of dead players
								dead = dead + 1
								
							end
						end


						print("DEAD: " .. dead)
						--prints how many dead players there are

						if dead == #game:GetService("Players"):GetPlayers() or game.ReplicatedStorage.IntValue.Value == 1 then

							k = k + 1

						end

						if k == 2 then
							ScreenGui = player.PlayerGui.ScreenGui
							game.Workspace.LargePlatform.Touchbox.CanTouch = false
							game.Workspace.SmallPlatformNE.Touchbox.CanTouch = false
							game.Workspace.MedPlatformW.Touchbox.CanTouch = false
							game.Workspace.SmallPlatformNE.SpecTouchbox.CanTouch = false
							game.Workspace.MedPlatformW.SpecTouchbox.CanTouch = false
							game.ReplicatedStorage.TimerValue.Value = 0
							ScreenGui.TextLabel.Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
							--value by default is an integer, needs to be converted to string in order to print ^^^
							print("Fixed " .. player.Name)
							game.ReplicatedStorage.IntValue.Value = 1
							--this lock is what allows all the other dead players to come back too
							k = k + 1
						end
						
						if k == 3 then
							dead = #game:GetService("Players"):GetPlayers() + 1
						end
						
					end
				
				end
				
				if hum.Health > 0 then
					game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
				end
				
				while i > -1 do
					hum.Health = 100
					i = i - 1
					wait(0.01)
				end
				i = 5
				--adjusts the speed at which the % grows
				--also heals all players so they don't die while in the lobby
				
			end
			
			if #game:GetService("Players"):GetPlayers() < 2 then
				if ScreenGui:FindFirstChild("TextLabel") ~= nil then
					ScreenGui.TextLabel.Text = "There are not enough players to start the game."
				end
				
				while i > -1 do
					hum.Health = 100
					i = i - 0.05
					wait(0.01)
				end
				game.ReplicatedStorage.TimerValue.Value = 0
				ScreenGui.TextLabel.Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
				--if <2 players restart counter
			else
				if ScreenGui:FindFirstChild("TextLabel") ~= nil then
					ScreenGui.TextLabel.Text = "Prepare to fight!"
				end
	
				while i > -1 do
					hum.Health = 100
					i = i - 0.05
					wait(0.01)
				end
				i = 1
				lock = 0
				--if >2 players start game
			end

		end
		
		hum.Health = 100
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			ScreenGui.TextLabel.Text = ""
		end
		
		--iterate through all PLayers

		--EXPLANATION: for i, v in pairs(t) is a specific instance of this; pairs is a function which returns an iterator, the state passed to it, and nil. 
		--When you use this idiom, you’re using an iterator function which goes over every key-value pair in your table t, and moves it into i, v.
		--You’d use pairs(t) in your loop when you want to go over a dictionary, for example: {a = 1, b = 2, c = 3}. pairs doesn’t iterate in any specific order, but it goes over all key-value pairs.
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
				--teleport players to starting positions
				--use .CFrame instead of .Position otherwise it gets weird
				if i == 1 then
					v.Character.HumanoidRootPart.CFrame = workspace.SmallPlatformNE.One.CFrame
				elseif i == 2 then
					v.Character.HumanoidRootPart.CFrame = workspace.SmallPlatformNE.Two.CFrame
				end

				i = i + 1
			end
		end
		
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
		--enable .Touched spectate part at spawn in case you die
			game.Workspace.Spectate.CanTouch = true
			game.ReplicatedStorage.IntValue.Value = 0
			end
		
		--timervalue ticks to 100% before match ends
		--value is stored in Replicated Storage, will increase faster if players die
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			game.ReplicatedStorage.TimerValue.Value = 0
		end
		
		while game.ReplicatedStorage.TimerValue.Value < 101 do
			print("Small Loop")
			
			if ScreenGui:FindFirstChild("TextLabel") ~= nil then
				ScreenGui:WaitForChild("TextLabel").Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
				--value by default is an integer, needs to be converted to string in order to print ^^^
			else
				break
			end
	
			if hum.Health > 0 then
				game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
			end
			
			wait(0.4)
		end	
		
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			ScreenGui.TextLabel.Text = ""
			game.Workspace.SmallPlatformNE.Touchbox.CanTouch = true
			hum.JumpHeight = 10.5
			hum.WalkSpeed = 46
			--teleport winner to M Platform

			game.Workspace.SmallPlatformNE.SpecTouchbox.CanTouch = true
			--teleport spectator to M Platform
		end
		
		
		--timervalue ticks to 100% before match ends
		--value is stored in Replicated Storage, will increase faster if players die
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			game.ReplicatedStorage.TimerValue.Value = 0
		end
		while game.ReplicatedStorage.TimerValue.Value < 101 do
			print("Med Loop")
			if ScreenGui:FindFirstChild("TextLabel") ~= nil then
				ScreenGui:WaitForChild("TextLabel").Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
				--value by default is an integer, needs to be converted to string in order to print ^^^
			else
				break
			end
			
			if hum.Health > 0 then
				game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
			end
			
			wait(0.4)
		end
		
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			ScreenGui.TextLabel.Text = ""
			game.Workspace.MedPlatformW.Touchbox.CanTouch = true	
			hum.JumpHeight = 15
			hum.WalkSpeed = 160
			--teleport winner to L Platform

			game.Workspace.MedPlatformW.SpecTouchbox.CanTouch = true
			--teleport spectator to L Platform
		end
		
		--timervalue ticks to 100% before match ends
		--value is stored in Replicated Storage, will increase faster if players die
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			game.ReplicatedStorage.TimerValue.Value = 0
		end
		
		while game.ReplicatedStorage.TimerValue.Value < 101 do
			print("Large Loop")
			if ScreenGui:FindFirstChild("TextLabel") ~= nil then
				ScreenGui:WaitForChild("TextLabel").Text = tostring(game.ReplicatedStorage.TimerValue.Value) .. "%...."
				--value by default is an integer, needs to be converted to string in order to print ^^^
			else
				break
			end
		
			if hum.Health > 0 then
				game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
			end
			
			wait(0.4)
		end
		
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			hum.JumpHeight = 8
			hum.WalkSpeed = 37
			game.Workspace.LargePlatform.Touchbox.CanTouch = true	
			--teleport everyone back to spawn
			--print winner name
			game.Workspace.Spectate.CanTouch = false
		end
		
		if ScreenGui:FindFirstChild("TextLabel") ~= nil then
			game.ReplicatedStorage.TimerValue.Value = 0
		end
		
		while game.ReplicatedStorage.TimerValue.Value < 101 do
			print("Spawn Loop")
			if ScreenGui:FindFirstChild("TextLabel") ~= nil then

				if hum.Health > 0 then
					game.ReplicatedStorage.TimerValue.Value = game.ReplicatedStorage.TimerValue.Value + 1
				end

				wait(0.1)
			else
				break
			end
			player.Character.Humanoid.Health = 100
		end
		
		print("Exit Main Script")
		return
		--ScreenGui.TextLabel.Text = player.name .. " Wins!!!"
	end)
end)
