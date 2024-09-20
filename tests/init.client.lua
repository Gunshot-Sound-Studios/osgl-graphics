--!optimize 2
-- ^^ This flag optimises

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local windowUi = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui").Window

local OSGL = require(ReplicatedStorage.OSGL)
local Window = OSGL.Window
local color = OSGL.color
local draw = OSGL.draw

local SIZE_X = 1024
local SIZE_Y = 1024

local myWindow = Window.new(windowUi, { sizeX = SIZE_X, sizeY = SIZE_Y })

local iterationCount = 0
local times = {}
while iterationCount <= 10 do
    local start = os.clock()

    for x = 0, SIZE_X - 1 do
        for y = 0, SIZE_Y - 1 do
            draw.pixel(myWindow, x, y, color.new(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
        end
    end

    myWindow:Render()

    table.insert(times, os.clock() - start)
    iterationCount += 1

    task.wait()
end

print(times)
