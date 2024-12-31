local Library = loadstring(game:HttpGet("https://shz.al/xw6n"))()

    local Window = Library:CreateWindow({
        Title = "Razer Hub",
        Icon = 82496531647577 -- Id Logo
    })

    local Tab1 = Window:CreateTab({
        Title = "หน้า หลัก",
        Icon = "home"
    })

    local Section1 = Tab1:CreateSection({
        Title = "🏡 เมนู 🏡",
        Side = "Left"
    })

    local Section2 = Tab1:CreateSection({
        Title = "🥷🏻 ตั่งค่ายิงหัว 🥷🏻",
        Side = "Right"
    })
------------------------------------------------------------------------------
    Section1:CreateToggle({
        Title = "Toggle",
        Value = false,
        Callback = function(value)
            _G.Lol = value
    end})

Section1:CreateButton({
    Title = "Button",
    Callback = function()
        
end})

    Section2:CreateDropdown({
        Title = "Dropdown",
        List = {"1", "2", "3"},
        Multi = false,
        Value = "8",
        Callback = function(value)
            _G.Number = value
    end})
