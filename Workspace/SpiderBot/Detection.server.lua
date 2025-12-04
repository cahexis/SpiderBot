local bot = script.Parent
local root = bot.HumanoidRootPart
local bothum = bot.Humanoid
local rs = game:GetService("RunService")
local TARGETSPOTTED = false
local runningtime
local closest
local rep = game:GetService("ReplicatedStorage")
local head = bot.head
local ts = game:GetService("TweenService")
local markinfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false)
local markpostween = ts:Create(head.ExclamationMark, markinfo, {StudsOffset = Vector3.new(0,1.2,0)})
local markparencytween = ts:Create(head.ExclamationMark.ImageLabel, markinfo, {ImageTransparency = 1})
local animsleep = Instance.new("Animation")
animsleep.AnimationId = "rbxassetid://92561083819496"
local sleeptrack = bothum:LoadAnimation(animsleep)

local anim = Instance.new("Animation") --wakeup
anim.AnimationId = "rbxassetid://139819329204805"
local track = bothum:LoadAnimation(anim)
local bind = bot.Target

local function awake() --animation to play when it detects a player
	sleeptrack:Stop()
	track:Play()
	head.alert:Play()
	head.ExclamationMark.ImageLabel.ImageTransparency = 0
	markpostween:Play()
	markparencytween:Play()
	
end

game.Players.PlayerAdded:Connect(function()
	sleeptrack:Play()	
end)
runningtime = rs.Stepped:Connect(function() --attempt at learning to not use a hidden part most of the time, it actually detects in a range around it for a player.
	local range = 20
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("Humanoid") and v ~= bothum then
			local target = v:FindFirstAncestorOfClass("Model")
			local distance = (root.Position - target:FindFirstChild("HumanoidRootPart").Position).magnitude
			if distance <= range then
				closest = target
				print(target.Name.." is in radius")
				TARGETSPOTTED = true
				runningtime:Disconnect()
				awake()
				wait(0.7)
				bind:Fire(closest)
			else
				print(target.Name.." is not in range")
				closest = nil
			end
		end
	end
end)


