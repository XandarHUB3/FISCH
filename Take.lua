local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/XandarHUB3/FISCH/main/Protected_3117701181880286.lua.txt"))()

local Window = Library:CreateWindow({
    Title = '<font color="#0d48c9">Razer</font><font color="#FFFFFF"> Hub</font>',
    Icon = 78836839305136
    ColorWindowMain = Color3.fromRGB(0, 0, 139),
    Keybind = Enum.KeyCode.LeftControl
})

local Page1 = Window:CreateTab({
    Title = "General",
    Icon = "home"
})

local Section2 = Page1:CreateSection({
    Title = "This is a section Left",
    Side = "Left"
})

Section2:CreateToggle({
    Title = "This is a toggle",
    Value = false,
    Callback = function(value)
        if value then
            print("UI TOGGLE ON")
        else
            print("UI TOGGLE OF")
        end
    end
})
