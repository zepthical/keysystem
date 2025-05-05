--// Load Services
local HttpService = game:GetService("HttpService")

--// UI Elements (Example - edit to match your UI)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local TextBox = Instance.new("TextBox", Frame)
local Button = Instance.new("TextButton", Frame)
local Status = Instance.new("TextLabel", Frame)

--// UI Properties
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

TextBox.PlaceholderText = "Enter your key"
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = Frame

Button.Text = "Submit"
Button.Size = UDim2.new(1, -20, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 60)
Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Parent = Frame

Status.Text = ""
Status.Size = UDim2.new(1, -20, 0, 30)
Status.Position = UDim2.new(0, 10, 0, 110)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(255, 0, 0)
Status.Parent = Frame

--// HWID
local hwid = tostring(identifyexecutor()) .. "_" .. (syn and syn.crypt.hash("rbx") or "default")

--// URL
local hwidURL = "https://raw.githubusercontent.com/zepthical/keysystem/main/key_hwids.json"

--// Validate Function
local function validateKey(inputKey)
    local response = game:HttpGet(hwidURL)
    local hwidTable = HttpService:JSONDecode(response)

    local savedHWID = hwidTable[inputKey]
    if not savedHWID then
        return false, "Invalid key."
    end

    if savedHWID ~= hwid then
        return false, "HWID mismatch."
    end

    return true, "Key valid. Access granted!"
end

--// Auto Load Key
if isfile("key.txt") then
    local saved = readfile("key.txt")
    local ok, msg = validateKey(saved)
    if ok then
        Status.Text = msg
        Status.TextColor3 = Color3.fromRGB(0, 255, 0)
        Frame.Visible = false
        return -- Skip UI
    else
        Status.Text = msg
    end
end

--// Button Press
Button.MouseButton1Click:Connect(function()
    local key = TextBox.Text
    local success, message = validateKey(key)
    Status.Text = message
    Status.TextColor3 = success and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if success then
        writefile("key.txt", key)
        wait(1)
        Frame.Visible = false -- Hide UI
    end
end)
