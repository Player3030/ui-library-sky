local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Sky-09 ",
    SubTitle = "by naosei & naka",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- O blur pode ser detectado, defina como false para desativar o blur
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Usado quando não há MinimizeKeybind
})

-- Criando a aba "Main"
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "main" })
}

-- Função para o Auto Clicker
local autoClickerEnabled = false
local function autoClicker()
    while autoClickerEnabled do
        -- Simulando o clique do mouse
        mouse1click()
        wait(0.1) -- Intervalo entre cliques, ajuste conforme necessário
    end
end

-- Adicionando o Toggle do Auto Clicker na aba "Main"
local Toggle = Tabs.Main:AddToggle("AutoClicker", {
    Title = "Auto Clicker",
    Default = false,
    Callback = function(Value)
        autoClickerEnabled = Value
        if autoClickerEnabled then
            print("Auto Clicker ativado.")
            task.spawn(autoClicker) -- Inicia o auto clicker em uma nova thread
        else
            print("Auto Clicker desativado.")
        end
    end
})

-- Adicionando um botão para executar o Hitbox Expander
Tabs.Main:AddButton({
    Title = "Execute Hitbox Expander",
    Description = "Clique para ativar o Hitbox Expander.",
    Callback = function()
        -- Executando o script do Hitbox Expander
        _G.HeadSize = 50
        _G.Disabled = true

        game:GetService('RunService').RenderStepped:connect(function()
            if _G.Disabled then
                for i,v in next, game:GetService('Players'):GetPlayers() do
                    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                        pcall(function()
                            v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
                            v.Character.HumanoidRootPart.Transparency = 0.7
                            v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                            v.Character.HumanoidRootPart.Material = "Neon"
                            v.Character.HumanoidRootPart.CanCollide = false
                        end)
                    end
                end
            end
        end)
        print("Hitbox Expander ativado!")
    end
})

-- Função de Auto Rejoin com script atualizado
local autoRejoinEnabled = false
local function autoRejoin()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local StarterGui = game:GetService("StarterGui")
    local localPlayer = Players.LocalPlayer

    -- Pegando o UserId do jogador e criando a URL do avatar dele
    local playerAvatarIcon = "https://www.roblox.com/headshot-thumbnail/image?userId="..localPlayer.UserId.."&width=420&height=420&format=png"

    -- Enviando notificação com o nome do jogador e o avatar dele
    StarterGui:SetCore("SendNotification", {
        Title = localPlayer.Name, -- Nome do jogador que executou
        Text = "Executed",
        Duration = 5,
        Icon = playerAvatarIcon -- Ícone com o avatar do jogador
    })

    local gui = game.CoreGui.RobloxPromptGui.promptOverlay:WaitForChild("ErrorPrompt")

    gui.Size = UDim2.new(0, 400, 0, 230)

    local leave = gui.MessageArea.ErrorFrame.ButtonArea.LeaveButton

    gui.MessageArea.MessageAreaPadding.PaddingTop = UDim.new(0, -20)
    gui.MessageArea.ErrorFrame.ErrorFrameLayout.Padding = UDim.new(0, 5)

    gui.MessageArea.ErrorFrame.ButtonArea.ButtonLayout.CellPadding = UDim2.new(0, 0, 0, 5)

    if not leave.Parent:FindFirstChild("Rejoin") then
        local rejoin = leave:Clone()
        rejoin.Parent = leave.Parent
        rejoin.Name = "Rejoin"
        rejoin.ButtonText.Text = "Rejoin"
    end

    local rejoin = leave.Parent:FindFirstChild("Rejoin")

    -- Função para reconectar o jogador
    rejoin.MouseButton1Click:Connect(function()
        if #Players:GetPlayers() <= 1 then
            game.Players.LocalPlayer:kick("Rejoining...")
            rejoin:Destroy()
            wait(1)
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end
    end)
end

-- Adicionando o Toggle de Auto Rejoin na aba "Main"
local Toggle = Tabs.Main:AddToggle("AutoRejoin", {
    Title = "Auto Rejoin",
    Default = false,
    Callback = function(Value)
        autoRejoinEnabled = Value
        if autoRejoinEnabled then
            print("Auto Rejoin ativado.")
            task.spawn(autoRejoin) -- Inicia o Auto Rejoin
        else
            print("Auto Rejoin desativado.")
        end
    end
})

-- Notificação de carregamento do script
Window:SelectTab(1)
Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
