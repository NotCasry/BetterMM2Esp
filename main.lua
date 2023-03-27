local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotCasry/SurfaceGui/main/main.lua"))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

function create_box(player : Player)
    if player.Name ~= Players.LocalPlayer.Name and workspace:FindFirstChild(player.Name) then
        local Char = workspace:FindFirstChild(player.Name)

        if Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Head") then
            local hrp = Char:FindFirstChild("HumanoidRootPart")
            local head = Char:FindFirstChild("Head")
            
            if not hrp:FindFirstChild("ESP") and not head:FindFirstChild("ESPLABEL") then
                local Create = Library.Create("ESP", Char.HumanoidRootPart)
                local Create2 = Library.Create("ESPLABEL", Char.Head)

                Create.MaxDistance = math.huge
                Create.StudsOffset = Vector3.new(0, 0, 0)
                Create.BillboardSize = UDim2.new(5,0,6,0)

                Create2.MaxDistance = math.huge
                Create2.StudsOffset = Vector3.new(0, 1.7, 0)
                Create2.BillboardSize = UDim2.new(5,0,1,0)
                
                local NewSurface = Create.CreateSurface()
                local NewSurface2 = Create2.CreateSurface()

                local NewQuad = Create:CreateQuad("ESP_QUAD", NewSurface)
                local NewText = Create:CreateText("ESP_LABEL", NewSurface2)
                
                NewQuad.Frame_BackgroundTransparency = 0.7
                NewQuad.Frame_BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
                NewText.Text_TextDisplay = player.Name
                NewText.Text_BackgroundTransparency = 1
                NewText.Text_TextColor3 = Color3.fromRGB(255, 255, 255)

                NewQuad.CreateFrame()
                NewText.CreateLabel()
            end
        end
    end
end

function role_check(player : Player)
    if player.Name ~= Players.LocalPlayer.Name then
        if workspace:FindFirstChild(player.Name) then
            local element = Library.ReturnUIElement("ESP_QUAD", workspace:FindFirstChild(player.Name))
            local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()

            if element then
                for i, v in pairs(roles) do
                    if player.Name == i and player.Name ~= Players.LocalPlayer.Name then
                        if v.Role == "Innocent" then
                            element.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                        elseif v.Role == "Sheriff" then
                            element.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
                        elseif v.Role == "Murderer" then
                            element.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end

            end
        end
    end
end

function delete_box(player : Player)
    if player.Name ~= Players.LocalPlayer.Name and workspace:FindFirstChild(player.Name) then
        local Char = workspace:FindFirstChild(player.Name)

        if Char:FindFirstChild("HumanoidRootPart") and Char:FindFirstChild("Head") then
            local hrp = Char:FindFirstChild("HumanoidRootPart")
            local head = Char:FindFirstChild("Head")

            if hrp:FindFirstChild("ESP") and head:FindFirstChild("ESPLABEL") then
                local element = Library.ReturnUIElement("ESP", workspace:FindFirstChild(player.Name))
                local element2 = Library.ReturnUIElement("ESPLABEL", workspace:FindFirstChild(player.Name))

                if element and element2 then
                    element:Destroy()
                    element2:Destroy()
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    create_box(player)
    role_check(player)
end)

while task.wait() do
    for i, player in pairs(Players:GetChildren()) do
        create_box(player)
        role_check(player)
    end
end
