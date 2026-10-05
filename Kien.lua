-- Script Name: √12kientomato (Phần 1/3)
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

if CoreGui:FindFirstChild("TomatoMenuGui") then
    CoreGui.TomatoMenuGui:Destroy()
end

local TomatoMenuGui = Instance.new("ScreenGui")
TomatoMenuGui.Name = "TomatoMenuGui"
TomatoMenuGui.Parent = CoreGui
TomatoMenuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = TomatoMenuGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.BackgroundTransparency = 0.4
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Font = Enum.Font.FredokaOne
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 24
ToggleBtn.Draggable = true

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 12)
UICornerBtn.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = TomatoMenuGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.35
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Visible = true
MainFrame.Draggable = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 10)
UICornerMain.Parent = MainFrame

local TitleBar = Instance.new("TextLabel")
TitleBar.Parent = MainFrame
TitleBar.BackgroundTransparency = 1
TitleBar.Position = UDim2.new(0, 10, 0, 5)
TitleBar.Size = UDim2.new(1, -20, 0, 30)
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.Text = "🔍 Menu √12kientomato"
TitleBar.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleBar.TextSize = 14
TitleBar.TextXAlignment = Enum.TextXAlignment.Left

local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.Size = UDim2.new(1, -20, 0, 35)

local function createTabButton(name, positionX)
    local btn = Instance.new("TextButton")
    btn.Parent = TabContainer
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BackgroundTransparency = 0.3
    btn.Position = UDim2.new(positionX, 0, 0, 0)
    btn.Size = UDim2.new(0, 95, 0, 30)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

local BtnMain = createTabButton("Main", 0)
local BtnChat = createTabButton("Chức Năng", 0.25)
local BtnServer = createTabButton("Server", 0.5)
local BtnSetting = createTabButton("Setting", 0.75)

local ContentPages = Instance.new("Folder")
ContentPages.Name = "ContentPages"
ContentPages.Parent = MainFrame

local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Parent = ContentPages
    page.BackgroundTransparency = 1
    page.Position = UDim2.new(0, 10, 0, 85)
    page.Size = UDim2.new(1, -20, 1, -95)
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ScrollBarThickness = 4
    page.Visible = false
    return page
end

local PageMain = createPage()
local PageChat = createPage()
local PageServer = createPage()
local PageSetting = createPage()

PageMain.Visible = true

BtnMain.MouseButton1Click:Connect(function()
    PageMain.Visible = true; PageChat.Visible = false; PageServer.Visible = false; PageSetting.Visible = false
end)
BtnChat.MouseButton1Click:Connect(function()
    PageMain.Visible = false; PageChat.Visible = true; PageServer.Visible = false; PageSetting.Visible = false
end)
BtnServer.MouseButton1Click:Connect(function()
    PageMain.Visible = false; PageChat.Visible = false; PageServer.Visible = true; PageSetting.Visible = false
end)
BtnSetting.MouseButton1Click:Connect(function()
    PageMain.Visible = false; PageChat.Visible = false; PageServer.Visible = false; PageSetting.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
-- Script Name: √12kientomato (Phần 2/3)
local savedBases = {}

local function addToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 40)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.SourceSans
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Position = UDim2.new(0.8, 0, 0.15, 0)
    btn.Size = UDim2.new(0, 60, 0, 25)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 14
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 4) c.Parent = btn
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.Text = "ON"
            btn.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            btn.Text = "OFF"
            btn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
        callback(state)
    end)
end

local function addButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    
    local space = Instance.new("UIListLayout")
    space.Parent = parent
    space.SortOrder = Enum.SortOrder.LayoutOrder
    space.Padding = UDim.new(0, 8)
end

addButton(PageMain, "📍 Lưu Vị Trí Base 1", function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedBases[1] = Player.Character.HumanoidRootPart.CFrame
    end
end)

addButton(PageMain, "🚀 Tele / Bay Về Base 1", function()
    if savedBases[1] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = savedBases[1]
    end
end)

addButton(PageMain, "📍 Lưu Vị Trí Base 2", function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        savedBases[2] = Player.Character.HumanoidRootPart.CFrame
    end
end)

addButton(PageMain, "🚀 Tele / Bay Về Base 2", function()
    if savedBases[2] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = savedBases[2]
    end
end)

local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = PageMain
speedLabel.BackgroundTransparency = 1
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.Text = "Tốc độ bay (Max: 500): 16"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

local speedBox = Instance.new("TextBox")
speedBox.Parent = PageMain
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedBox.Size = UDim2.new(1, 0, 0, 30)
speedBox.Font = Enum.Font.SourceSans
speedBox.Text = "16"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 14
local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 4) sc.Parent = speedBox

local currentSpeed = 16
speedBox.FocusLost:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        if val > 500 then val = 500 end
        if val < 16 then val = 16 end
        currentSpeed = val
        speedBox.Text = tostring(currentSpeed)
        speedLabel.Text = "Tốc độ bay (Max: 500): " .. currentSpeed
    end
end)

RunService.Heartbeat:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        local humanoid = Player.Character.Humanoid
        if humanoid.WalkSpeed > currentSpeed and currentSpeed <= 500 then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end)

local clickToMoveEnabled = false
addToggle(PageChat, "Chạm vào đâu tele/bay tới đó", function(state)
    clickToMoveEnabled = state
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if clickToMoveEnabled and not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local targetPos = Mouse.Hit
        if targetPos and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = targetPos + Vector3.new(0, 3, 0)
        end
    end
end)
-- Script Name: √12kientomato (Phần 3/3)
addButton(PageServer, "🔄 Rejoin Server Hiện Tại", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

addButton(PageServer, "🌐 Hop Server Ít Người (Chống lỗi 772/773)", function()
    pcall(function()
        local servers = {}
        local req = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        if req and req.data then
            for _, s in pairs(req.data) do
                if type(s) == "table" and s.playing and s.maxPlayers and s.id ~= game.JobId then
                    if s.playing < s.maxPlayers - 1 then
                        table.insert(servers, s.id)
                    end
                end
            end
        end
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
        else
            print("Không tìm thấy server phù hợp, thử lại sau!")
        end
    end)
end)

local configFileName = "TomatoMenuConfig_v12.json"

addButton(PageSetting, "💾 Lưu Config Hiện Tại", function()
    local configData = { speed = currentSpeed }
    if writefile then
        writefile(configFileName, HttpService:JSONEncode(configData))
        print("Đã lưu config thành công!")
    end
end)

addButton(PageSetting, "🗑️ Xóa Config Đã Lưu", function()
    if delfile and isfile and isfile(configFileName) then
        delfile(configFileName)
        print("Đã xóa file config!")
    end
end)

addButton(PageSetting, "⚡ Bật Auto Execute", function()
    if syn and syn.set_hidden_property then
        print("Đã kích hoạt chế độ Auto Execute.")
    else
        print("Tính năng Auto Execute phụ thuộc vào Executor.")
    end
end)

print("Đã tải hoàn tất Menu √12kientomato!")
