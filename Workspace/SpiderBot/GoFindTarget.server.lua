local bot = script.Parent
local root = bot.HumanoidRootPart
local bothum = bot.Humanoid
local bind = bot.Target
local pfs = game:GetService("PathfindingService")
local path = pfs:CreatePath()
local rs = game:GetService("RunService")
local runningtime 
local anim = Instance.new("Animation") --walk
anim.AnimationId = "rbxassetid://124480240466645"
local track = bothum:LoadAnimation(anim)
local bombsound = bot.bomb.bombtick
local firesound = bot.bomb.firesound
local fireemit = bot.FireEmitter.Fire
local boom = Instance.new("Explosion")
boom.BlastRadius = 10
boom.BlastPressure = 10

track.Looped = true

local function bombtick()
	local tickcount = 1
	while tickcount > 0.1 do
		wait(tickcount)
		bombsound:Play()
		tickcount = tickcount - 0.1
	end
end

bind.Event:Connect(function(closest) -- chases the player
	wait(0.2)
	track:Play()
	runningtime = rs.Stepped:Connect(function()
		bothum:MoveTo(closest.HumanoidRootPart.Position)
	end)
end)

bind.Event:Connect(function(closest) -- the explosion with ticking and sound.
	firesound:Play()
	fireemit.Enabled = true
	bombtick()
	bombsound:Stop()
	firesound:Stop()
	boom.Parent = bot.bomb
	boom.Position = bot.bomb.Position	
	bot.HumanoidRootPart:Destroy()
end)
