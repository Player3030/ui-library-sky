local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by nao sei & naka",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Criando as abas "Main", "Settings" e "Funções"
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    Funcoes = Window:AddTab({ Title = "Funções", Icon = "zap" }) -- Ícone opcional de raio (zap)
}

local Options = Fluent.Options

-- Função de Auto Clicker
local function StartAutoClicker()
    task.spawn(function()
        while Options.AutoClicker.Value do -- Verifica se o Auto Clicker está ativado
            mouse1click() -- Simula o clique do mouse
            wait(0.1) -- Intervalo entre os cliques (pode ser ajustado)
        end
    end)
end

-- Adicionando o Toggle "Auto Clicker" na aba "Funções"
local AutoClickerToggle = Tabs.Funcoes:AddToggle("AutoClicker", { Title = "Auto Clicker", Default = false })

-- Função para ativar/desativar o Auto Clicker
AutoClickerToggle:OnChanged(function()
    if Options.AutoClicker.Value then
        print("Auto Clicker ativado!")
        StartAutoClicker()
    else
        print("Auto Clicker desativado!")
    end
end)

Options.AutoClicker:SetValue(false)

-- Restante do código para notificação, sliders, dropdowns, etc.
