local HttpService = game:GetService("HttpService")
local Analytics = game:GetService("RbxAnalyticsService")

local hwid = Analytics:GetClientId()

-- Create UI
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(1, -20, 0, 40)
textbox.Position = UDim2.new(0, 10, 0, 10)
textbox.PlaceholderText = "Enter your key"
textbox.Text = ""
textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 60)
button.Text = "Submit"
button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 110)
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = ""
status.BackgroundTransparency = 1

-- Key check
button.MouseButton1Click:Connect(function()
    local userKey = textbox.Text
    local success, result = pcall(function()
        return HttpService:GetAsync("https://raw.githubusercontent.com/zepthical/keysystem/main/key_hwids.json")
    end)

    if success then
        local data = HttpService:JSONDecode(result)
        if data[userKey] then
            if data[userKey] == hwid then
                status.Text = "Access Granted!"
                wait(1)
                gui:Destroy()
                -- Insert your script loading here
                loadstring(game:HttpGet("https://your-script-url.com/script.lua"))()
            else
                status.Text = "HWID mismatch. Key used on wrong device."
            end
        else
            status.Text = "Invalid key."
        end
    else
        status.Text = "Failed to connect to server."
    end
end)
