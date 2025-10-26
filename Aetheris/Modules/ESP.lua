local ESP = {}

ESP.Enabled = false
ESP.BoxESP = false
ESP.Tracers = false
ESP.NameESP = false
ESP.DistanceESP = false
ESP.ESPColor = Color3.fromRGB(0, 255, 0)
ESP.ESPConnections = {}

function ESP.SetEnabled(state)
    ESP.Enabled = state
    if state then
        ESP.StartESP()
    else
        ESP.ClearESP()
    end
end

function ESP.SetBoxESP(state)
    ESP.BoxESP = state
    ESP.UpdateESP()
end

function ESP.SetTracers(state)
    ESP.Tracers = state
    ESP.UpdateESP()
end

function ESP.SetNameESP(state)
    ESP.NameESP = state
    ESP.UpdateESP()
end

function ESP.SetDistanceESP(state)
    ESP.DistanceESP = state
    ESP.UpdateESP()
end

function ESP.SetColor(color)
    ESP.ESPColor = color
    ESP.UpdateESP()
end

function ESP.StartESP()
    print("👁️ ESP activated for Energy Assault")
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            ESP.CreatePlayerESP(player)
        end
    end
    
    ESP.ESPConnections.playerAdded = game.Players.PlayerAdded:Connect(function(player)
        ESP.CreatePlayerESP(player)
    end)
end

function ESP.ClearESP()
    for _, connection in pairs(ESP.ESPConnections) do
        connection:Disconnect()
    end
    ESP.ESPConnections = {}
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "AetherisESP" then
            obj:Destroy()
        end
    end
    
    print("👁️ ESP cleared")
end

function ESP.UpdateESP()
    if ESP.Enabled then
        ESP.ClearESP()
        ESP.StartESP()
    end
end

function ESP.CreatePlayerESP(player)
end

return ESP