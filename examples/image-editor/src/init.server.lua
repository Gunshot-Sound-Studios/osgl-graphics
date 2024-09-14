local CoreGui = game:GetService("CoreGui")

local Editor = require(script.Editor)

local toolbar = plugin:CreateToolbar("OSGL Image Editor")
local mainButton = toolbar:CreateButton(
    "Toggle UI",
    "Toggles the UI of the Image Editor.",
    "rbxassetid://14978048121"
)

-- mainButton.ClickableWhenViewportHidden = false

local oldUi = CoreGui:FindFirstChild("osglUiEditor")
if oldUi then
    oldUi:Destroy()
end

local ui = script.osglUiEditor
ui.Parent = CoreGui

Editor.new(plugin:GetMouse(), ui)

mainButton.Click:Connect(function()
    ui.Enabled = not ui.Enabled

    plugin:Activate(ui.Enabled)
end)
