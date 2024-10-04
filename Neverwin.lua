-- Carregar a biblioteca NeverWin diretamente do arquivo local
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Player3030/ui-library-sky/refs/heads/main/NeverWin%20ui%20lib"))()
print(Library)

-- Criar a janela principal da interface
local Window = Library:Window({
    text = "Sky-Script"
})

-- Criar a seção de abas (TabSection)
local TabSection = Window:TabSection({
    text = "Menu de opções"
})

-- Criar uma aba (Tab)
local Tab = TabSection:Tab({
    text = "Funções",
    icon = "rbxassetid://7999345313",
})

-- Criar uma seção (Section)
local Section = Tab:Section({
    text = "Section"
})

-- Adicionar os botões e outros elementos de UI
Section:Button({
    text = "Button",
    callback = function()
        print("Clicked button")
    end,
})

Section:Toggle({
    text = "Toggle",
    state = false, 
    callback = function(boolean)
        print("Toggle current: ", boolean)
    end
})

Section:Slider({
    text = "Slider",
    min = 10,
    max = 100,
    callback = function(number)
        print(number)
    end
})

Section:Dropdown({
    text = "Dropdown",
    list = {"Apple", "Banana", "Coconut"},
    default = "Apple",
    callback = function(String)
        print(String)
    end
})

Section:Textbox({
    text = "Textbox",
    value = "Default",
    callback = function(String)
        print(String)
    end
})

Section:Colorpicker({
    text = "Colorpicker",
    color = Color3.new(1,1,1),
    callback = function(HSV)
        print(HSV)
    end
})

Section:Keybind({
    text = "Keybind",
    default = Enum.KeyCode.Z,
    callback = function(defaultBind)
        print("Triggered keybind")
        print(defaultBind)
    end
})
