local Aimbot = {}

Aimbot.Enabled = false
Aimbot.FOV = 60
Aimbot.SilentAim = false
Aimbot.TriggerBot = false
Aimbot.TargetPart = "Head"
Aimbot.AimbotConnection = nil

function Aimbot.SetEnabled(state)
    Aimbot.Enabled = state
    if state then
        Aimbot.StartAimbot()
    else
        Aimbot.StopAimbot()
    end
end

function Aimbot.SetFOV(value)
    Aimbot.FOV = value
end

function Aimbot.SetSilentAim(state)
    Aimbot.SilentAim = state
end

function Aimbot.SetTriggerBot(state)
    Aimbot.TriggerBot = state
end

function Aimbot.SetTargetPart(part)
    Aimbot.TargetPart = part
end

function Aimbot.StartAimbot()
    print("🎯 Aimbot activated for Energy Assault")
    
    Aimbot.AimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not Aimbot.Enabled then return end
        
        local target = Aimbot.FindClosestEnemy()
        if target then
            Aimbot.AimAtTarget(target)
        end
    end)
end

function Aimbot.StopAimbot()
    if Aimbot.AimbotConnection then
        Aimbot.AimbotConnection:Disconnect()
        Aimbot.AimbotConnection = nil
    end
    print("🎯 Aimbot deactivated")
end

function Aimbot.FindClosestEnemy()
    local closestPlayer = nil
    local closestDistance = Aimbot.FOV
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                local distance = (head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    
    return closestPlayer
end

function Aimbot.AimAtTarget(target)
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild(Aimbot.TargetPart)
    if not targetPart then return end
end

return Aimbot