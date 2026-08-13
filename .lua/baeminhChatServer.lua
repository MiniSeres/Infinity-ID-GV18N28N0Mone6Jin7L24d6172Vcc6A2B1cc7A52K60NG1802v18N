local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

--============================
-- ROLE CONFIG (phải khớp server)
--============================
local OWNERS = { "JJS_TestScript" }
local STAFFS = { "lam648291", "gshahwgsydhs" }

local function getMyRole()
    for _, n in ipairs(OWNERS) do
        if player.Name == n then return "owner" end
    end
    for _, n in ipairs(STAFFS) do
        if player.Name == n then return "staff" end
    end
    return nil
end
local MY_ROLE = getMyRole()

--============================
-- BAD WORDS FILTER
--============================
local BAD_WORDS = {
    -- English
    "nigger","nigga","niga","n1gger","n1gga",
    "fuck","fck","fuuck","fvck",
    "shit","sh1t","sht",
    "bitch","b1tch","bytch",
    "dick","d1ck","dik",
    "pussy","cunt","whore","wh0re",
    "faggot","fag","f4g",
    "retard","ret4rd","bastard",
    "cock","c0ck","slut",
    "ass","a55",
    -- Vietnamese
    "dịt","dit","đit",
    "lồn","l0n",
    "cặc","cac","c4c",
    "buồi","buoi",
    "đụ",
    "đéo","deo",
    "mẹ mày","me may",
    "bố mày","bo may",
    "con mẹ","con me",
    "đồ chó","thằng chó",
    "óc chó",
}
local function filterBadWords(text)
    for _, word in ipairs(BAD_WORDS) do
        local escaped = word:gsub("([%.%+%-%*%?%[%]%^%$%(%)%%])", "%%%1")

        local pattern = "%f[%a]" .. escaped .. "%f[%A]"
        pattern = pattern:gsub("%a", function(c)
            return "[" .. c:lower() .. c:upper() .. "]"
        end)

        text = text:gsub(pattern, string.rep("*", #word))
    end
    return text
end

--============================
-- UNIVERSAL CLIPBOARD
--============================
local function CopyToClipboard(text)
    text = tostring(text)
    if typeof(setclipboard) == "function" then
        local ok = pcall(setclipboard, text)
        if ok then return true end
    end
    if typeof(toclipboard) == "function" then
        local ok = pcall(toclipboard, text)
        if ok then return true end
    end
    if typeof(Clipboard) == "table" and Clipboard.set then
        local ok = pcall(function() Clipboard.set(text) end)
        if ok then return true end
    end
    warn("Clipboard not supported.")
    return false
end

--============================
-- REMOVE OLD UI
--============================
if player.PlayerGui:FindFirstChild("HubChatUI") then
    player.PlayerGui.HubChatUI:Destroy()
end
local gui = Instance.new("ScreenGui")
gui.Name = "HubChatUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

--============================
-- DRAGGABLE LOGIC
--============================
local function makeDraggable(frame)
    local dragging, dragInput, startPos, startFramePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startFramePos = frame.Position
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(startFramePos.X.Scale, startFramePos.X.Offset + delta.X, startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--============================
-- MINI BUTTON
--============================
local mini = Instance.new("Frame", gui)
mini.Size = UDim2.new(0, 55, 0, 55)
mini.Position = UDim2.new(0, 20, 0.4, 0)
mini.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
local miniCorner = Instance.new("UICorner", mini)
miniCorner.CornerRadius = UDim.new(0, 15)
local miniStroke = Instance.new("UIStroke", mini)
miniStroke.Color = Color3.fromRGB(0, 150, 255)
miniStroke.Thickness = 2
miniStroke.Transparency = 0.2
makeDraggable(mini)
local miniBtn = Instance.new("TextButton", mini)
miniBtn.Size = UDim2.new(1, 0, 1, 0)
miniBtn.BackgroundTransparency = 1
miniBtn.Text = "💬"
miniBtn.TextSize = 26
miniBtn.TextColor3 = Color3.new(1, 1, 1)
local notifyDot = Instance.new("Frame", mini)
notifyDot.Size = UDim2.new(0, 14, 0, 14)
notifyDot.Position = UDim2.new(1, -10, 0, -4)
notifyDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
notifyDot.Visible = false
Instance.new("UICorner", notifyDot).CornerRadius = UDim.new(1, 0)

--============================
-- MAIN WINDOW
--============================
local frame = Instance.new("Frame", gui)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.Size = UDim2.new(0.65, 0, 0.65, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.ClipsDescendants = true
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(0, 200, 255)
frameStroke.Thickness = 2
local bgImg = Instance.new("ImageLabel", frame)
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.Image = "rbxassetid://134522511102996"
bgImg.ImageTransparency = 0.65
bgImg.BackgroundTransparency = 1
bgImg.ScaleType = Enum.ScaleType.Crop
bgImg.ZIndex = 0
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BackgroundTransparency = 0.5
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)
local fixCorner = Instance.new("Frame", titleBar)
fixCorner.Size = UDim2.new(1, 0, 0, 10)
fixCorner.Position = UDim2.new(0, 0, 1, -10)
fixCorner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fixCorner.BackgroundTransparency = 0.5
local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BaeMinh Hub | Chat Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
-- ONLINE COUNT
local onlineLabel = Instance.new("TextLabel")
onlineLabel.Size = UDim2.new(0, 120, 1, 0)
onlineLabel.Position = UDim2.new(1, -170, 0, 0)
onlineLabel.BackgroundTransparency = 1
onlineLabel.Text = "⏳ Online: ..."
onlineLabel.Font = Enum.Font.GothamMedium
onlineLabel.TextSize = 13
onlineLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
onlineLabel.TextXAlignment = Enum.TextXAlignment.Right
onlineLabel.Parent = titleBar
-- STATUS REALTIME
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 170, 1, 0)
statusLabel.Position = UDim2.new(1, -700, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "🟡 Connecting to Server..."
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 13
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
statusLabel.TextXAlignment = Enum.TextXAlignment.Right
statusLabel.Parent = titleBar
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0.5, -20)
closeBtn.Text = "❌"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)

--============================
-- CHAT AREA
--============================
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 10, 0, 60)
scroll.Size = UDim2.new(1, -20, 1, -125)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
scroll.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 12)

local function getUSTime()
    local utc = os.time(os.date("!*t"))
    return os.date("%I:%M %p", utc - (5*3600))
end

local function toggleUI(show)
    if show then
        frame.Visible = true
        frame.Size = UDim2.new(0, 0, 0, 0)
        local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.65, 0, 0.65, 0)})
        tween:Play()
        notifyDot.Visible = false
    else
        local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function() frame.Visible = false end)
    end
end

--============================
-- TOAST NOTIFICATION
--============================
local function showToast(text)
    local toast = Instance.new("Frame", gui)
    toast.Size = UDim2.new(0, 240, 0, 36)
    toast.AnchorPoint = Vector2.new(0.5, 1)
    toast.Position = UDim2.new(0.5, 0, 1, -15)
    toast.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toast.BackgroundTransparency = 0.1
    toast.ZIndex = 20
    Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 8)
    local toastStroke = Instance.new("UIStroke", toast)
    toastStroke.Color = Color3.fromRGB(0, 200, 100)
    toastStroke.Thickness = 1.5
    local toastLabel = Instance.new("TextLabel", toast)
    toastLabel.Size = UDim2.new(1, -10, 1, 0)
    toastLabel.Position = UDim2.new(0, 5, 0, 0)
    toastLabel.BackgroundTransparency = 1
    toastLabel.Text = text
    toastLabel.Font = Enum.Font.GothamMedium
    toastLabel.TextSize = 13
    toastLabel.TextColor3 = Color3.fromRGB(0, 230, 110)
    toastLabel.ZIndex = 21
    TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 1, -70)
    }):Play()
    task.delay(2.2, function()
        TweenService:Create(toast, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(toastLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        task.wait(0.35)
        if toast then toast:Destroy() end
    end)
end

--============================
-- FORWARD DECLARE socket/roomId
-- (cần dùng trong nút Copy HWID)
--============================
local socket
local roomId

--============================
-- ADD MESSAGE
-- username : tên sạch (string)
-- message  : nội dung (string)
-- role     : "owner" | "staff" | nil
-- isSystem : bool
--============================
local TAG_COLOR = {
    owner = Color3.fromRGB(255, 200, 0),
    staff = Color3.fromRGB(0, 210, 255),
}
local TAG_TEXT = {
    owner = "[OWNER]",
    staff = "[STAFF]",
}
local BUBBLE_BG = {
    owner = Color3.fromRGB(65, 50, 0),
    staff = Color3.fromRGB(0, 45, 75),
}

local function addMessage(username, message, role, isSystem)
    local isMe = username == player.Name
    local tagColor = role and TAG_COLOR[role]

    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 0, 60)
    container.Parent = scroll

    -- Avatar
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 35, 0, 35)
    avatar.Position = UDim2.new(0, 0, 0, 0)
    avatar.BackgroundTransparency = 1
    avatar.Parent = container
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
    local avatarStroke = Instance.new("UIStroke", avatar)
    avatarStroke.Color = tagColor or (isMe and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(100, 100, 100))
    avatarStroke.Thickness = 2

    if not isSystem then
        task.spawn(function()
            local ok, userId = pcall(function()
                return Players:GetUserIdFromNameAsync(username)
            end)
            if ok and userId then
                local thumb = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                avatar.Image = thumb
            else
                avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            end
        end)
    else
        avatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    end

    -- Bubble
    local bubble = Instance.new("Frame")
    if isSystem then
        bubble.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    elseif role and BUBBLE_BG[role] then
        bubble.BackgroundColor3 = BUBBLE_BG[role]
    elseif isMe then
        bubble.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    else
        bubble.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
    bubble.BackgroundTransparency = 0.1
    bubble.Size = UDim2.new(0.8, 0, 0, 40)
    bubble.Position = UDim2.new(0, 45, 0, 0)
    bubble.Parent = container
    Instance.new("UICorner", bubble).CornerRadius = UDim.new(0, 8)

    -- Viền màu theo role
    if tagColor then
        local bStroke = Instance.new("UIStroke", bubble)
        bStroke.Color = tagColor
        bStroke.Thickness = 1.5
        bStroke.Transparency = 0.35
    end

    -- Tag label [OWNER]/[STAFF] — TextLabel riêng, màu rõ ràng
    local headerX = 8
    if role and TAG_TEXT[role] then
        local tagLbl = Instance.new("TextLabel")
        tagLbl.Size = UDim2.new(0, 58, 0, 15)
        tagLbl.Position = UDim2.new(0, headerX, 0, 5)
        tagLbl.BackgroundTransparency = 1
        tagLbl.Text = TAG_TEXT[role]
        tagLbl.Font = Enum.Font.GothamBold
        tagLbl.TextSize = 11
        tagLbl.TextColor3 = tagColor
        tagLbl.TextXAlignment = Enum.TextXAlignment.Left
        tagLbl.Parent = bubble
        headerX = headerX + 60
    end

    -- Tên + thời gian
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, -(headerX + 35), 0, 15)
    header.Position = UDim2.new(0, headerX, 0, 5)
    header.BackgroundTransparency = 1
    header.Text = (isSystem and "System" or username) .. " • " .. getUSTime()
    header.Font = Enum.Font.GothamMedium
    header.TextSize = 11
    header.TextColor3 = isSystem and Color3.fromRGB(140,140,140) or Color3.fromRGB(200, 200, 200)
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = bubble

    -- Nội dung
    local msg = Instance.new("TextLabel")
    msg.BackgroundTransparency = 1
    msg.TextWrapped = true
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.TextYAlignment = Enum.TextYAlignment.Top
    msg.TextColor3 = isSystem and Color3.fromRGB(175,175,175) or Color3.new(1,1,1)
    msg.Font = isSystem and Enum.Font.GothamItalic or Enum.Font.Gotham
    msg.TextSize = 14
    msg.Text = message
    msg.Size = UDim2.new(1, -16, 0, 20)
    msg.Position = UDim2.new(0, 8, 0, 24)
    msg.Parent = bubble

    -- Menu ⋯ (chỉ cho tin của người khác, không phải system)
    if not isMe and not isSystem then
        local menuH = 30

        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(0, 22, 0, 22)
        optionBtn.Position = UDim2.new(1, -25, 0, 3)
        optionBtn.Text = "⋯"
        optionBtn.TextSize = 18
        optionBtn.BackgroundTransparency = 1
        optionBtn.TextColor3 = Color3.new(1, 1, 1)
        optionBtn.Parent = bubble

        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 115, 0, menuH)
        menu.Position = UDim2.new(1, -120, 0, 25)
        menu.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        menu.Visible = false
        menu.ZIndex = 5
        menu.Parent = bubble
        Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 6)
        local menuStroke = Instance.new("UIStroke", menu)
        menuStroke.Color = Color3.fromRGB(60, 60, 60)

        -- Copy text
        local copyTextBtn = Instance.new("TextButton")
        copyTextBtn.Size = UDim2.new(1, 0, 0, 30)
        copyTextBtn.Position = UDim2.new(0, 0, 0, 0)
        copyTextBtn.Text = "📋  Copy text"
        copyTextBtn.Font = Enum.Font.Gotham
        copyTextBtn.TextSize = 12
        copyTextBtn.TextColor3 = Color3.new(1, 1, 1)
        copyTextBtn.BackgroundTransparency = 1
        copyTextBtn.ZIndex = 6
        copyTextBtn.Parent = menu
        copyTextBtn.MouseButton1Click:Connect(function()
            local ok = CopyToClipboard(message)
            menu.Visible = false
            showToast(ok and "✅ Đã copy nội dung!" or "❌ Clipboard không hỗ trợ")
        end)

        optionBtn.MouseButton1Click:Connect(function()
            menu.Visible = not menu.Visible
        end)
    end

    task.wait()
    local height = msg.TextBounds.Y + 34
    bubble.Size = UDim2.new(0.8, 0, 0, height)
    container.Size = UDim2.new(1, 0, 0, math.max(height, 35))
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    scroll.CanvasPosition = Vector2.new(0, scroll.CanvasSize.Y.Offset)
    if not frame.Visible and not isMe then
        notifyDot.Visible = true
    end
end

--============================
-- CONNECT SOCKET
--============================
socket = WebSocket.connect("wss://hubchat-server.onrender.com")
roomId = tostring(game.PlaceId)

socket.OnMessage:Connect(function(msg)
    print("🔵 RAW:", msg)
    if typeof(msg) == "table" and msg.Data then msg = msg.Data end
    if typeof(msg) ~= "string" then msg = tostring(msg) end
    local ok, data = pcall(function()
        return HttpService:JSONDecode(msg)
    end)
    if not ok then
        warn("JSON Decode failed:", msg)
        return
    end

    if data.type == "chat" then
        -- data.user = tên sạch, data.role = "owner"/"staff"/nil
        addMessage(data.user, data.text, data.role or nil, false)

    elseif data.type == "online_count" then
        onlineLabel.Text = "🟢 Online: " .. tostring(data.count)
        print("🟢 ONLINE → " .. data.count)
    end
end)

if socket.OnClose then
    socket.OnClose:Connect(function()
        statusLabel.Text = "🔴 Disconnected from Server"
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        onlineLabel.Text = "🔴 Online: ?"
        print("🔴 Server DISCONNECTED!")
    end)
end

-- Gửi join kèm HWID + role
task.wait(2)
socket:Send(HttpService:JSONEncode({
    type = "join",
    room = roomId,
    user = player.Name,
}))
print("✅ Join | Room:", roomId, "| Role:", MY_ROLE or "user")

statusLabel.Text = "🟢 Connected to Server"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)

--============================
-- INPUT & SEND
--============================
local inputContainer = Instance.new("Frame", frame)
inputContainer.Size = UDim2.new(1, -75, 0, 45)
inputContainer.Position = UDim2.new(0, 10, 1, -55)
inputContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputContainer.BackgroundTransparency = 0.3
Instance.new("UICorner", inputContainer).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", inputContainer).Color = Color3.fromRGB(80, 80, 80)
local input = Instance.new("TextBox", inputContainer)
input.Size = UDim2.new(1, -20, 1, 0)
input.Position = UDim2.new(0, 10, 0, 0)
input.PlaceholderText = (MY_ROLE == "owner" or MY_ROLE == "staff")
    and "Enter a message..."
    or  "Enter a message..."
input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
input.BackgroundTransparency = 1
input.TextColor3 = Color3.new(1, 1, 1)
input.Font = Enum.Font.GothamMedium
input.TextSize = 15
input.TextXAlignment = Enum.TextXAlignment.Left
input.ClearTextOnFocus = false
input.Text = ""
local sendBtn = Instance.new("TextButton", frame)
sendBtn.Size = UDim2.new(0, 50, 0, 45)
sendBtn.Position = UDim2.new(1, -60, 1, -55)
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
sendBtn.Text = "Send"
sendBtn.Font = Enum.Font.GothamBold
sendBtn.TextSize = 18
sendBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", sendBtn).CornerRadius = UDim.new(0, 10)

local function sendMessage()
    local text = input.Text
    if text == "" or not text:match("%S") then return end

    -- Chat thường — lọc bad words
    local filtered = filterBadWords(text)
    socket:Send(HttpService:JSONEncode({
        type = "chat",
        room = roomId,
        user = player.Name,
        text = filtered
    }))
    input.Text = ""
end

input.FocusLost:Connect(function(enter)
    if enter then sendMessage() end
end)
sendBtn.MouseButton1Click:Connect(sendMessage)
miniBtn.MouseButton1Click:Connect(function() toggleUI(true) end)
closeBtn.MouseButton1Click:Connect(function() toggleUI(false) end)
