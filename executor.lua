local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local InputBox = Instance.new("TextBox")
local ConsoleBox = Instance.new("TextBox")
local ExecuteButton = Instance.new("TextButton")
local ClearButton = Instance.new("TextButton")
local SaveButton = Instance.new("TextButton")
local LoadDropdown = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local PhantomOrb = Instance.new("TextButton")
local ExpandButton = Instance.new("TextButton")

local savedScripts = {}
local minimized = false

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "ShadowExecutorProV5"

-- Phantom Orb (hidden at start)
PhantomOrb.Size = UDim2.new(0, 60, 0, 60)
PhantomOrb.Position = UDim2.new(0.5, -30, 0.1, 0)
PhantomOrb.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
PhantomOrb.Text = "Phantom"
PhantomOrb.TextColor3 = Color3.fromRGB(255, 255, 255)
PhantomOrb.Font = Enum.Font.SourceSansBold
PhantomOrb.TextSize = 14
PhantomOrb.Visible = false
PhantomOrb.Parent = ScreenGui
PhantomOrb.BorderSizePixel = 0
PhantomOrb.BackgroundTransparency = 0.2

-- Frame
Frame.Size = UDim2.new(0, 500, 0, 420)
Frame.Position = UDim2.new(0.5, -250, 0.5, -210)
Frame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

-- Title
Title.Size = UDim2.new(1, -60, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
Title.Text = "CODE PHANTOM EXECUTOR"
Title.TextColor3 = Color3.fromRGB(200, 0, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

-- Close
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = Frame

-- Minimize
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 0, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Parent = Frame

-- Expand button (hidden at start)
ExpandButton.Size = UDim2.new(0, 30, 0, 30)
ExpandButton.Position = UDim2.new(1, -60, 0, 0)
ExpandButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
ExpandButton.Text = "+"
ExpandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExpandButton.Visible = false
ExpandButton.Parent = Frame

-- Toggle
ToggleButton.Size = UDim2.new(0, 120, 0, 30)
ToggleButton.Position = UDim2.new(0, 0, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 0, 90)
ToggleButton.Text = "Mode: Executor"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = Frame

-- Input
InputBox.Size = UDim2.new(1, -20, 1, -100)
InputBox.Position = UDim2.new(0, 10, 0, 40)
InputBox.BackgroundColor3 = Color3.fromRGB(25, 0, 35)
InputBox.TextColor3 = Color3.fromRGB(220, 220, 255)
InputBox.PlaceholderText = "Type your script here..."
InputBox.ClearTextOnFocus = false
InputBox.MultiLine = true
InputBox.Font = Enum.Font.Code
InputBox.TextSize = 14
InputBox.TextYAlignment = Enum.TextYAlignment.Top
InputBox.Parent = Frame

-- Console
ConsoleBox.Size = UDim2.new(1, -20, 1, -100)
ConsoleBox.Position = UDim2.new(0, 10, 0, 40)
ConsoleBox.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
ConsoleBox.TextColor3 = Color3.fromRGB(0, 255, 150)
ConsoleBox.Text = "Console ready...\n"
ConsoleBox.ClearTextOnFocus = false
ConsoleBox.MultiLine = true
ConsoleBox.Font = Enum.Font.Code
ConsoleBox.TextSize = 12
ConsoleBox.TextYAlignment = Enum.TextYAlignment.Top
ConsoleBox.TextXAlignment = Enum.TextXAlignment.Left
ConsoleBox.Visible = false
ConsoleBox.Parent = Frame

-- Buttons setup
local function makeButton(btn, text, pos)
    btn.Size = UDim2.new(0.25, -8, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = Frame
end

makeButton(ExecuteButton, "Execute", UDim2.new(0, 10, 1, -40))
makeButton(ClearButton, "Clear", UDim2.new(0.25, 2, 1, -40))
makeButton(SaveButton, "Save Script", UDim2.new(0.5, 4, 1, -40))
makeButton(LoadDropdown, "Load Script", UDim2.new(0.75, 6, 1, -40))

-- Functionality
local function minimizeFrame()
    minimized = true
    Frame.Size = UDim2.new(0, 300, 0, 30)
    Frame.Position = UDim2.new(0.5, -150, 0, 0)
    Title.Text = "CODE PHANTOM"
    ExpandButton.Visible = true
    MinimizeButton.Visible = false
    InputBox.Visible = false
    ConsoleBox.Visible = false
    ExecuteButton.Visible = false
    ClearButton.Visible = false
    SaveButton.Visible = false
    LoadDropdown.Visible = false
    ToggleButton.Visible = false
end

local function expandFrame()
    minimized = false
    Frame.Size = UDim2.new(0, 500, 0, 420)
    Frame.Position = UDim2.new(0.5, -250, 0.5, -210)
    Title.Text = "CODE PHANTOM EXECUTOR"
    ExpandButton.Visible = false
    MinimizeButton.Visible = true
    InputBox.Visible = true
    ToggleButton.Visible = true
    ExecuteButton.Visible = true
    ClearButton.Visible = true
    SaveButton.Visible = true
    LoadDropdown.Visible = true
    if not InputBox.Visible then
        ConsoleBox.Visible = true
    end
end

MinimizeButton.MouseButton1Click:Connect(minimizeFrame)
ExpandButton.MouseButton1Click:Connect(expandFrame)

CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    PhantomOrb.Visible = true
end)

PhantomOrb.MouseButton1Click:Connect(function()
    Frame.Visible = true
    PhantomOrb.Visible = false
end)

ToggleButton.MouseButton1Click:Connect(function()
    InputBox.Visible = not InputBox.Visible
    ConsoleBox.Visible = not InputBox.Visible
    ToggleButton.Text = InputBox.Visible and "Mode: Executor" or "Mode: Console"
end)

ExecuteButton.MouseButton1Click:Connect(function()
    if InputBox.Visible then
        local code = InputBox.Text
        if code ~= "" then
            local f, e = loadstring(code)
            if f then pcall(f) else warn(e) end
        end
    end
end)

ClearButton.MouseButton1Click:Connect(function()
    if InputBox.Visible then InputBox.Text = "" else ConsoleBox.Text = "Console ready...\n" end
end)

SaveButton.MouseButton1Click:Connect(function()
    if InputBox.Text ~= "" then
        table.insert(savedScripts, InputBox.Text)
        warn("Script saved. Total: " .. #savedScripts)
    end
end)

LoadDropdown.MouseButton1Click:Connect(function()
    if #savedScripts > 0 then
        InputBox.Text = savedScripts[#savedScripts]
        warn("Loaded saved script #" .. #savedScripts)
    else
        warn("No saved scripts.")
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        Frame.Visible = not Frame.Visible
        if Frame.Visible then PhantomOrb.Visible = false end
    end
end)
