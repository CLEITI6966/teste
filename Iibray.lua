--[[
    CLEITI6966 HUBS LIBRARY
    A professional UI library for Roblox scripting
    Designed by CLEITI6966
]]

local CLEITI6966_Library = {}
local themes = {}
local icons = {}
local utility = {}

-- Utility functions
function utility:DeepCopy(t)
    local copy = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            v = utility:DeepCopy(v)
        end
        copy[k] = v
    end
    return setmetatable(copy, getmetatable(t))
end

function utility:Tween(obj, props, duration, style, direction)
    game:GetService("TweenService"):Create(
        obj,
        TweenInfo.new(duration or 0.2, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
        props
    ):Play()
end

function utility:RippleEffect(button, color)
    local ripple = Instance.new("Frame")
    ripple.Name = "RippleEffect"
    ripple.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.ZIndex = 10
    ripple.Parent = button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ripple
    
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local pos = UDim2.new(0, mouse.X - button.AbsolutePosition.X, 0, mouse.Y - button.AbsolutePosition.Y)
    ripple.Position = pos
    
    utility:Tween(ripple, {
        Size = UDim2.new(2, 0, 2, 0),
        BackgroundTransparency = 1
    }, 0.5)
    
    game:GetService("Debris"):AddItem(ripple, 0.5)
end

-- Default themes
themes.Default = {
    Main = Color3.fromRGB(30, 30, 46),
    Header = Color3.fromRGB(49, 50, 68),
    Text = Color3.fromRGB(205, 214, 244),
    Accent = Color3.fromRGB(137, 180, 250),
    Button = Color3.fromRGB(137, 180, 250),
    ButtonText = Color3.fromRGB(30, 30, 46),
    TabActive = Color3.fromRGB(137, 180, 250),
    TabInactive = Color3.fromRGB(69, 71, 90),
    TabTextActive = Color3.fromRGB(30, 30, 46),
    TabTextInactive = Color3.fromRGB(205, 214, 244),
    Section = Color3.fromRGB(69, 71, 90),
    Element = Color3.fromRGB(49, 50, 68),
    CloseButton = Color3.fromRGB(243, 139, 168),
    MinimizeButton = Color3.fromRGB(250, 179, 135),
    Slider = Color3.fromRGB(69, 71, 90),
    SliderFill = Color3.fromRGB(137, 180, 250),
    Toggle = Color3.fromRGB(137, 180, 250),
    ToggleKnob = Color3.fromRGB(205, 214, 244),
    Dropdown = Color3.fromRGB(49, 50, 68),
    DropdownArrow = Color3.fromRGB(205, 214, 244)
}

themes.Purple = utility:DeepCopy(themes.Default)
themes.Purple.Accent = Color3.fromRGB(180, 140, 255)
themes.Purple.Button = Color3.fromRGB(180, 140, 255)
themes.Purple.TabActive = Color3.fromRGB(180, 140, 255)
themes.Purple.SliderFill = Color3.fromRGB(180, 140, 255)
themes.Purple.Toggle = Color3.fromRGB(180, 140, 255)

-- Default icons
icons.Home = "rbxassetid://10709822452"
icons.Settings = "rbxassetid://10709823680"
icons.Scripts = "rbxassetid://10709824567"
icons.Discord = "rbxassetid://10709825890"

-- Library functions
function CLEITI6966_Library:GetIcon(iconName)
    return icons[iconName] or ""
end

function CLEITI6966_Library:SetTheme(themeName)
    self.CurrentTheme = themes[themeName] or themes.Default
    if self.UpdateTheme then
        self:UpdateTheme()
    end
end

function CLEITI6966_Library:SetScale(scale)
    self.Scale = scale or 1
    if self.MainFrame then
        self.MainFrame.Size = UDim2.new(0, 400 * self.Scale, 0, 300 * self.Scale)
    end
end

-- Window creation
function CLEITI6966_Library:MakeWindow(options)
    options = options or {}
    local title = options.Title or "CLEITI6966 HUBS"
    local subTitle = options.SubTitle or "by: CLEITI6966"
    local saveFolder = options.SaveFolder or false
    
    -- Create main screen gui
    local gui = Instance.new("ScreenGui")
    gui.Name = "CLEITI6966_Library"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")
    
    -- Main container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400 * (self.Scale or 1), 0, 300 * (self.Scale or 1))
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = self.CurrentTheme.Main
    mainFrame.ClipsDescendants = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(60, 60, 80)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    mainFrame.Parent = gui
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = self.CurrentTheme.Header
    header.ZIndex = 2
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 15)
    headerCorner.Parent = header
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = self.CurrentTheme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 3
    titleLabel.Parent = header
    
    -- Subtitle
    local subTitleLabel = Instance.new("TextLabel")
    subTitleLabel.Name = "SubTitle"
    subTitleLabel.Text = subTitle
    subTitleLabel.Font = Enum.Font.Gotham
    subTitleLabel.TextSize = 12
    subTitleLabel.TextColor3 = self.CurrentTheme.Text
    subTitleLabel.BackgroundTransparency = 1
    subTitleLabel.Position = UDim2.new(1, -150, 0, 0)
    subTitleLabel.Size = UDim2.new(0, 135, 1, 0)
    subTitleLabel.TextXAlignment = Enum.TextXAlignment.Right
    subTitleLabel.ZIndex = 3
    subTitleLabel.Parent = header
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 16, 0, 16)
    closeBtn.Position = UDim2.new(1, -25, 0.5, 0)
    closeBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    closeBtn.BackgroundColor3 = self.CurrentTheme.CloseButton
    closeBtn.AutoButtonColor = false
    closeBtn.Text = ""
    closeBtn.ZIndex = 3
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.Parent = header
    
    -- Minimize button
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeButton"
    minimizeBtn.Size = UDim2.new(0, 16, 0, 16)
    minimizeBtn.Position = UDim2.new(1, -50, 0.5, 0)
    minimizeBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    minimizeBtn.BackgroundColor3 = self.CurrentTheme.MinimizeButton
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Text = ""
    minimizeBtn.ZIndex = 3
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(1, 0)
    minimizeCorner.Parent = minimizeBtn
    
    minimizeBtn.Parent = header
    
    header.Parent = mainFrame
    
    -- Tabs container
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Name = "TabsContainer"
    tabsContainer.Size = UDim2.new(0, 80, 0, 220)
    tabsContainer.Position = UDim2.new(0, 10, 0, 60)
    tabsContainer.BackgroundColor3 = self.CurrentTheme.Header
    tabsContainer.ZIndex = 2
    
    local tabsCorner = Instance.new("UICorner")
    tabsCorner.CornerRadius = UDim.new(0, 5)
    tabsCorner.Parent = tabsContainer
    
    tabsContainer.Parent = mainFrame
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(0, 270, 0, 220)
    contentContainer.Position = UDim2.new(0, 100, 0, 60)
    contentContainer.BackgroundColor3 = self.CurrentTheme.Header
    contentContainer.ClipsDescendants = true
    contentContainer.ZIndex = 2
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 5)
    contentCorner.Parent = contentContainer
    
    contentContainer.Parent = mainFrame
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Window functions
    local window = {}
    window.Gui = gui
    window.MainFrame = mainFrame
    window.Header = header
    window.TabsContainer = tabsContainer
    window.ContentContainer = contentContainer
    window.Tabs = {}
    window.CurrentTab = nil
    
    function window:CloseBtn()
        local dialog = self:Dialog({
            Title = "Close Window",
            Text = "Are you sure you want to close the window?",
            Options = {
                {
                    Title = "Yes",
                    Callback = function()
                        self.Gui:Destroy()
                    end
                },
                {
                    Title = "No",
                    Callback = function() end
                }
            }
        })
    end
    
    function window:MinimizeBtn()
        self:Minimize()
    end
    
    function window:Minimize()
        if mainFrame.Size.Y.Offset == 40 then
            utility:Tween(mainFrame, {Size = UDim2.new(0, 400 * (self.Scale or 1), 0, 300 * (self.Scale or 1))})
        else
            utility:Tween(mainFrame, {Size = UDim2.new(0, 400 * (self.Scale or 1), 0, 40)})
        end
    end
    
    function window:Set(title, subTitle)
        titleLabel.Text = title or titleLabel.Text
        subTitleLabel.Text = subTitle or subTitleLabel.Text
    end
    
    function window:SelectTab(tabName)
        for _, tab in pairs(self.Tabs) do
            if tab.Name == tabName then
                tab:Show()
                self.CurrentTab = tab
            else
                tab:Hide()
            end
        end
    end
    
    function window:MakeTab(options)
        options = options or {}
        local tabName = options.Title or "Tab"
        local tabIcon = options.Icon or ""
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Size = UDim2.new(0, 70, 0, 30)
        tabButton.Position = UDim2.new(0, 5, 0, 10 + (#self.Tabs * 40))
        tabButton.BackgroundColor3 = #self.Tabs == 0 and self.CurrentTheme.TabActive or self.CurrentTheme.TabInactive
        tabButton.AutoButtonColor = false
        tabButton.Text = ""
        tabButton.ZIndex = 3
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 5)
        tabCorner.Parent = tabButton
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "Label"
        tabLabel.Text = tabName
        tabLabel.Font = Enum.Font.Gotham
        tabLabel.TextSize = 12
        tabLabel.TextColor3 = #self.Tabs == 0 and self.CurrentTheme.TabTextActive or self.CurrentTheme.TabTextInactive
        tabLabel.BackgroundTransparency = 1
        tabLabel.Size = UDim2.new(1, 0, 1, 0)
        tabLabel.TextXAlignment = Enum.TextXAlignment.Center
        tabLabel.ZIndex = 4
        tabLabel.Parent = tabButton
        
        if tabIcon ~= "" then
            local icon = Instance.new("ImageLabel")
            icon.Name = "Icon"
            icon.Image = tabIcon
            icon.Size = UDim2.new(0, 16, 0, 16)
            icon.Position = UDim2.new(0, 5, 0.5, 0)
            icon.AnchorPoint = Vector2.new(0, 0.5)
            icon.BackgroundTransparency = 1
            icon.ZIndex = 4
            icon.Parent = tabButton
            
            tabLabel.Position = UDim2.new(0, 25, 0, 0)
            tabLabel.Size = UDim2.new(1, -25, 1, 0)
            tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        end
        
        tabButton.Parent = tabsContainer
        
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.ScrollBarThickness = 3
        tabContent.ScrollBarImageColor3 = self.CurrentTheme.Accent
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = #self.Tabs == 0
        tabContent.ZIndex = 3
        tabContent.Parent = contentContainer
        
        local layout = Instance.new("UIListLayout")
        layout.Name = "Layout"
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)
        layout.Parent = tabContent
        
        local padding = Instance.new("UIPadding")
        padding.Name = "Padding"
        padding.PaddingTop = UDim.new(0, 5)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 5)
        padding.Parent = tabContent
        
        local tab = {}
        tab.Name = tabName
        tab.Button = tabButton
        tab.Content = tabContent
        tab.Elements = {}
        tab.Enabled = true
        tab.Visible = true
        
        function tab:Show()
            self.Content.Visible = true
            utility:Tween(self.Button, {BackgroundColor3 = self.CurrentTheme.TabActive})
            tabLabel.TextColor3 = self.CurrentTheme.TabTextActive
        end
        
        function tab:Hide()
            self.Content.Visible = false
            utility:Tween(self.Button, {BackgroundColor3 = self.CurrentTheme.TabInactive})
            tabLabel.TextColor3 = self.CurrentTheme.TabTextInactive
        end
        
        function tab:Disable()
            self.Enabled = false
            self.Button.AutoButtonColor = false
            tabLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        function tab:Enable()
            self.Enabled = true
            self.Button.AutoButtonColor = false
            if self == window.CurrentTab then
                tabLabel.TextColor3 = self.CurrentTheme.TabTextActive
            else
                tabLabel.TextColor3 = self.CurrentTheme.TabTextInactive
            end
        end
        
        function tab:Visible(state)
            self.Visible = state
            self.Button.Visible = state
            if self == window.CurrentTab then
                self.Content.Visible = state
            end
        end
        
        function tab:Destroy()
            self.Button:Destroy()
            self.Content:Destroy()
            for i, t in pairs(window.Tabs) do
                if t == self then
                    table.remove(window.Tabs, i)
                    break
                end
            end
        end
        
        function tab:AddSection(options)
            options = options or {}
            local sectionName = options.Title or "Section"
            
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "Section"
            sectionFrame.Size = UDim2.new(1, -20, 0, 30)
            sectionFrame.BackgroundColor3 = self.CurrentTheme.Section
            sectionFrame.ZIndex = 4
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 5)
            sectionCorner.Parent = sectionFrame
            
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Name = "Label"
            sectionLabel.Text = sectionName
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 14
            sectionLabel.TextColor3 = self.CurrentTheme.Text
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Position = UDim2.new(0, 10, 0, 0)
            sectionLabel.Size = UDim2.new(1, -10, 1, 0)
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.ZIndex = 5
            sectionLabel.Parent = sectionFrame
            
            sectionFrame.Parent = tabContent
            
            local section = {}
            section.Name = sectionName
            section.Frame = sectionFrame
            
            function section:Visible(state)
                self.Frame.Visible = state
            end
            
            function section:Destroy()
                self.Frame:Destroy()
            end
            
            function section:Set(newName)
                self.Name = newName or self.Name
                sectionLabel.Text = self.Name
            end
            
            table.insert(tab.Elements, section)
            return section
        end
        
        function tab:AddParagraph(options)
            options = options or {}
            local paraTitle = options.Title or "Paragraph"
            local paraText = options.Text or "This is a paragraph"
            
            local paraFrame = Instance.new("Frame")
            paraFrame.Name = "Paragraph"
            paraFrame.Size = UDim2.new(1, -20, 0, 50)
            paraFrame.BackgroundTransparency = 1
            paraFrame.ZIndex = 4
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Name = "Title"
            titleLabel.Text = paraTitle
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 14
            titleLabel.TextColor3 = self.CurrentTheme.Text
            titleLabel.BackgroundTransparency = 1
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
            titleLabel.Size = UDim2.new(1, 0, 0, 20)
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.ZIndex = 5
            titleLabel.Parent = paraFrame
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "Text"
            textLabel.Text = paraText
            textLabel.Font = Enum.Font.Gotham
            textLabel.TextSize = 12
            textLabel.TextColor3 = self.CurrentTheme.Text
            textLabel.TextWrapped = true
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.new(0, 0, 0, 20)
            textLabel.Size = UDim2.new(1, 0, 0, 30)
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.ZIndex = 5
            textLabel.Parent = paraFrame
            
            paraFrame.Parent = tabContent
            
            local paragraph = {}
            paragraph.Title = paraTitle
            paragraph.Text = paraText
            paragraph.Frame = paraFrame
            
            function paragraph:Visible(state)
                self.Frame.Visible = state
            end
            
            function paragraph:Destroy()
                self.Frame:Destroy()
            end
            
            function paragraph:Set(newTitle, newText)
                self.Title = newTitle or self.Title
                self.Text = newText or self.Text
                titleLabel.Text = self.Title
                textLabel.Text = self.Text
            end
            
            function paragraph:SetTitle(newTitle)
                self.Title = newTitle or self.Title
                titleLabel.Text = self.Title
            end
            
            function paragraph:SetDesc(newText)
                self.Text = newText or self.Text
                textLabel.Text = self.Text
            end
            
            table.insert(tab.Elements, paragraph)
            return paragraph
        end
        
        function tab:AddButton(options)
            options = options or {}
            local btnTitle = options.Title or "Button"
            local btnDesc = options.Desc or ""
            local btnCallback = options.Callback or function() end
            
            local btnFrame = Instance.new("Frame")
            btnFrame.Name = "Button"
            btnFrame.Size = UDim2.new(1, -20, 0, btnDesc ~= "" and 50 or 30)
            btnFrame.BackgroundTransparency = 1
            btnFrame.ZIndex = 4
            
            local btn = Instance.new("TextButton")
            btn.Name = "Button"
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, btnDesc ~= "" and 1 or 0, btnDesc ~= "" and -30 or 0)
            btn.BackgroundColor3 = self.CurrentTheme.Button
            btn.AutoButtonColor = false
            btn.Text = ""
            btn.ZIndex = 5
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 5)
            btnCorner.Parent = btn
            
            local btnLabel = Instance.new("TextLabel")
            btnLabel.Name = "Label"
            btnLabel.Text = btnTitle
            btnLabel.Font = Enum.Font.GothamBold
            btnLabel.TextSize = 12
            btnLabel.TextColor3 = self.CurrentTheme.ButtonText
            btnLabel.BackgroundTransparency = 1
            btnLabel.Size = UDim2.new(1, 0, 1, 0)
            btnLabel.TextXAlignment = Enum.TextXAlignment.Center
            btnLabel.ZIndex = 6
            btnLabel.Parent = btn
            
            if btnDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = btnDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = btnFrame
            end
            
            btn.Parent = btnFrame
            btnFrame.Parent = tabContent
            
            -- Button effects
            btn.MouseEnter:Connect(function()
                utility:Tween(btn, {BackgroundColor3 = Color3.new(
                    self.CurrentTheme.Button.R * 1.2,
                    self.CurrentTheme.Button.G * 1.2,
                    self.CurrentTheme.Button.B * 1.2
                )})
            end)
            
            btn.MouseLeave:Connect(function()
                utility:Tween(btn, {BackgroundColor3 = self.CurrentTheme.Button})
            end)
            
            btn.MouseButton1Down:Connect(function()
                utility:Tween(btn, {Size = UDim2.new(0.95, 0, 0.95, 0), Position = UDim2.new(0.025, 0, btnDesc ~= "" and 1.025 or 0.025, btnDesc ~= "" and -29.25 or 0.025)})
            end)
            
            btn.MouseButton1Up:Connect(function()
                utility:Tween(btn, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, btnDesc ~= "" and 1 or 0, btnDesc ~= "" and -30 or 0)})
                utility:RippleEffect(btn, Color3.new(1, 1, 1))
                btnCallback()
            end)
            
            local button = {}
            button.Title = btnTitle
            button.Desc = btnDesc
            button.Frame = btnFrame
            button.Button = btn
            button.Callback = btnCallback
            
            function button:Visible(state)
                self.Frame.Visible = state
            end
            
            function button:Destroy()
                self.Frame:Destroy()
            end
            
            function button:Callback(newCallback)
                self.Callback = newCallback or self.Callback
            end
            
            function button:Set(newTitle, newDesc)
                self.Title = newTitle or self.Title
                self.Desc = newDesc or self.Desc
                btnLabel.Text = self.Title
                if self.Desc ~= "" then
                    btnFrame:FindFirstChild("Desc").Text = self.Desc
                end
            end
            
            table.insert(tab.Elements, button)
            return button
        end
        
        function tab:AddToggle(options)
            options = options or {}
            local toggleTitle = options.Title or "Toggle"
            local toggleDesc = options.Desc or ""
            local toggleCallback = options.Callback or function() end
            local toggleDefault = options.Default or false
            local toggleFlag = options.Flag or false
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = "Toggle"
            toggleFrame.Size = UDim2.new(1, -20, 0, toggleDesc ~= "" and 50 or 30)
            toggleFrame.BackgroundTransparency = 1
            toggleFrame.ZIndex = 4
            
            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle"
            toggle.Size = UDim2.new(1, 0, 0, 30)
            toggle.Position = UDim2.new(0, 0, toggleDesc ~= "" and 1 or 0, toggleDesc ~= "" and -30 or 0)
            toggle.BackgroundColor3 = self.CurrentTheme.Element
            toggle.AutoButtonColor = false
            toggle.Text = ""
            toggle.ZIndex = 5
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 5)
            toggleCorner.Parent = toggle
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Name = "Label"
            toggleLabel.Text = toggleTitle
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextSize = 12
            toggleLabel.TextColor3 = self.CurrentTheme.Text
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Position = UDim2.new(0, 10, 0, 0)
            toggleLabel.Size = UDim2.new(1, -50, 1, 0)
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.ZIndex = 6
            toggleLabel.Parent = toggle
            
            local toggleBackground = Instance.new("Frame")
            toggleBackground.Name = "Background"
            toggleBackground.Size = UDim2.new(0, 30, 0, 20)
            toggleBackground.Position = UDim2.new(1, -40, 0.5, 0)
            toggleBackground.AnchorPoint = Vector2.new(0, 0.5)
            toggleBackground.BackgroundColor3 = toggleDefault and self.CurrentTheme.Toggle or Color3.fromRGB(70, 70, 70)
            toggleBackground.ZIndex = 6
            
            local toggleBackgroundCorner = Instance.new("UICorner")
            toggleBackgroundCorner.CornerRadius = UDim.new(1, 0)
            toggleBackgroundCorner.Parent = toggleBackground
            
            local toggleKnob = Instance.new("Frame")
            toggleKnob.Name = "Knob"
            toggleKnob.Size = UDim2.new(0, 16, 0, 16)
            toggleKnob.Position = toggleDefault and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            toggleKnob.AnchorPoint = Vector2.new(0, 0.5)
            toggleKnob.BackgroundColor3 = self.CurrentTheme.ToggleKnob
            toggleKnob.ZIndex = 7
            
            local toggleKnobCorner = Instance.new("UICorner")
            toggleKnobCorner.CornerRadius = UDim.new(1, 0)
            toggleKnobCorner.Parent = toggleKnob
            
            toggleKnob.Parent = toggleBackground
            toggleBackground.Parent = toggle
            
            if toggleDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = toggleDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = toggleFrame
            end
            
            toggle.Parent = toggleFrame
            toggleFrame.Parent = tabContent
            
            local state = toggleDefault
            local debounce = false
            
            local function updateToggle()
                if state then
                    utility:Tween(toggleBackground, {BackgroundColor3 = self.CurrentTheme.Toggle})
                    utility:Tween(toggleKnob, {Position = UDim2.new(1, -18, 0.5, 0)})
                else
                    utility:Tween(toggleBackground, {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
                    utility:Tween(toggleKnob, {Position = UDim2.new(0, 2, 0.5, 0)})
                end
            end
            
            toggle.MouseButton1Click:Connect(function()
                if debounce then return end
                debounce = true
                
                state = not state
                updateToggle()
                toggleCallback(state)
                
                debounce = false
            end)
            
            updateToggle()
            
            local toggleObj = {}
            toggleObj.Title = toggleTitle
            toggleObj.Desc = toggleDesc
            toggleObj.Frame = toggleFrame
            toggleObj.Toggle = toggle
            toggleObj.State = state
            toggleObj.Callback = toggleCallback
            
            function toggleObj:Visible(state)
                self.Frame.Visible = state
            end
            
            function toggleObj:Destroy()
                self.Frame:Destroy()
            end
            
            function toggleObj:Callback(newCallback)
                self.Callback = newCallback or self.Callback
            end
            
            function toggleObj:Set(newTitle, newDesc)
                self.Title = newTitle or self.Title
                self.Desc = newDesc or self.Desc
                toggleLabel.Text = self.Title
                if self.Desc ~= "" then
                    toggleFrame:FindFirstChild("Desc").Text = self.Desc
                end
            end
            
            function toggleObj:SetState(newState)
                state = newState
                updateToggle()
            end
            
            table.insert(tab.Elements, toggleObj)
            return toggleObj
        end
        
        function tab:AddDropdown(options)
            options = options or {}
            local ddTitle = options.Title or "Dropdown"
            local ddDesc = options.Desc or ""
            local ddOptions = options.Options or {}
            local ddCallback = options.Callback or function() end
            local ddDefault = options.Default or nil
            local ddFlag = options.Flag or false
            local ddMultiSelect = options.MultiSelect or false
            
            local ddFrame = Instance.new("Frame")
            ddFrame.Name = "Dropdown"
            ddFrame.Size = UDim2.new(1, -20, 0, ddDesc ~= "" and 50 or 30)
            ddFrame.BackgroundTransparency = 1
            ddFrame.ZIndex = 4
            
            local dd = Instance.new("TextButton")
            dd.Name = "Dropdown"
            dd.Size = UDim2.new(1, 0, 0, 30)
            dd.Position = UDim2.new(0, 0, ddDesc ~= "" and 1 or 0, ddDesc ~= "" and -30 or 0)
            dd.BackgroundColor3 = self.CurrentTheme.Element
            dd.AutoButtonColor = false
            dd.Text = ""
            dd.ZIndex = 5
            
            local ddCorner = Instance.new("UICorner")
            ddCorner.CornerRadius = UDim.new(0, 5)
            ddCorner.Parent = dd
            
            local ddLabel = Instance.new("TextLabel")
            ddLabel.Name = "Label"
            ddLabel.Text = ddTitle
            ddLabel.Font = Enum.Font.Gotham
            ddLabel.TextSize = 12
            ddLabel.TextColor3 = self.CurrentTheme.Text
            ddLabel.BackgroundTransparency = 1
            ddLabel.Position = UDim2.new(0, 10, 0, 0)
            ddLabel.Size = UDim2.new(1, -40, 1, 0)
            ddLabel.TextXAlignment = Enum.TextXAlignment.Left
            ddLabel.ZIndex = 6
            ddLabel.Parent = dd
            
            local ddArrow = Instance.new("Frame")
            ddArrow.Name = "Arrow"
            ddArrow.Size = UDim2.new(0, 20, 0, 20)
            ddArrow.Position = UDim2.new(1, -25, 0.5, 0)
            ddArrow.AnchorPoint = Vector2.new(0, 0.5)
            ddArrow.BackgroundTransparency = 1
            ddArrow.ZIndex = 6
            ddArrow.Parent = dd
            
            local ddArrowIcon = Instance.new("ImageLabel")
            ddArrowIcon.Name = "Icon"
            ddArrowIcon.Image = "rbxassetid://10709826345"
            ddArrowIcon.Size = UDim2.new(1, 0, 1, 0)
            ddArrowIcon.BackgroundTransparency = 1
            ddArrowIcon.ImageColor3 = self.CurrentTheme.DropdownArrow
            ddArrowIcon.ZIndex = 7
            ddArrowIcon.Parent = ddArrow
            
            if ddDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = ddDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = ddFrame
            end
            
            dd.Parent = ddFrame
            ddFrame.Parent = tabContent
            
            local ddList = Instance.new("Frame")
            ddList.Name = "DropdownList"
            ddList.Size = UDim2.new(1, 0, 0, 0)
            ddList.Position = UDim2.new(0, 0, 1, 5)
            ddList.BackgroundColor3 = self.CurrentTheme.Element
            ddList.ClipsDescendants = true
            ddList.Visible = false
            ddList.ZIndex = 10
            
            local ddListCorner = Instance.new("UICorner")
            ddListCorner.CornerRadius = UDim.new(0, 5)
            ddListCorner.Parent = ddList
            
            local ddListLayout = Instance.new("UIListLayout")
            ddListLayout.Name = "Layout"
            ddListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ddListLayout.Padding = UDim.new(0, 1)
            ddListLayout.Parent = ddList
            
            ddList.Parent = dd
            
            local selected = {}
            local open = false
            local debounce = false
            
            local function updateDropdown()
                if not ddMultiSelect then
                    if selected[1] then
                        ddLabel.Text = selected[1]
                    else
                        ddLabel.Text = ddTitle
                    end
                else
                    if #selected > 0 then
                        ddLabel.Text = table.concat(selected, ", ")
                    else
                        ddLabel.Text = ddTitle
                    end
                end
            end
            
            local function toggleDropdown()
                if debounce then return end
                debounce = true
                
                open = not open
                
                if open then
                    utility:Tween(ddArrowIcon, {Rotation = 180})
                    utility:Tween(ddList, {Size = UDim2.new(1, 0, 0, math.min(#ddOptions * 30, 150))})
                    ddList.Visible = true
                else
                    utility:Tween(ddArrowIcon, {Rotation = 0})
                    utility:Tween(ddList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
                        ddList.Visible = false
                    end)
                end
                
                debounce = false
            end
            
            local function createOption(option)
                local optionBtn = Instance.new("TextButton")
                optionBtn.Name = option
                optionBtn.Size = UDim2.new(1, 0, 0, 30)
                optionBtn.BackgroundColor3 = self.CurrentTheme.Element
                optionBtn.AutoButtonColor = false
                optionBtn.Text = ""
                optionBtn.ZIndex = 11
                optionBtn.Parent = ddList
                
                local optionCorner = Instance.new("UICorner")
                optionCorner.CornerRadius = UDim.new(0, 5)
                optionCorner.Parent = optionBtn
                
                local optionLabel = Instance.new("TextLabel")
                optionLabel.Name = "Label"
                optionLabel.Text = option
                optionLabel.Font = Enum.Font.Gotham
                optionLabel.TextSize = 12
                optionLabel.TextColor3 = self.CurrentTheme.Text
                optionLabel.BackgroundTransparency = 1
                optionLabel.Position = UDim2.new(0, 10, 0, 0)
                optionLabel.Size = UDim2.new(1, -10, 1, 0)
                optionLabel.TextXAlignment = Enum.TextXAlignment.Left
                optionLabel.ZIndex = 12
                optionLabel.Parent = optionBtn
                
                local optionSelected = Instance.new("Frame")
                optionSelected.Name = "Selected"
                optionSelected.Size = UDim2.new(0, 16, 0, 16)
                optionSelected.Position = UDim2.new(1, -20, 0.5, 0)
                optionSelected.AnchorPoint = Vector2.new(0, 0.5)
                optionSelected.BackgroundColor3 = self.CurrentTheme.Accent
                optionSelected.Visible = false
                optionSelected.ZIndex = 12
                optionSelected.Parent = optionBtn
                
                local optionSelectedCorner = Instance.new("UICorner")
                optionSelectedCorner.CornerRadius = UDim.new(0, 5)
                optionSelectedCorner.Parent = optionSelected
                
                optionBtn.MouseEnter:Connect(function()
                    utility:Tween(optionBtn, {BackgroundColor3 = Color3.fromRGB(
                        self.CurrentTheme.Element.R * 1.2,
                        self.CurrentTheme.Element.G * 1.2,
                        self.CurrentTheme.Element.B * 1.2
                    )})
                end)
                
                optionBtn.MouseLeave:Connect(function()
                    utility:Tween(optionBtn, {BackgroundColor3 = self.CurrentTheme.Element})
                end)
                
                optionBtn.MouseButton1Click:Connect(function()
                    if ddMultiSelect then
                        local found = false
                        for i, v in pairs(selected) do
                            if v == option then
                                table.remove(selected, i)
                                found = true
                                break
                            end
                        end
                        
                        if not found then
                            table.insert(selected, option)
                        end
                        
                        optionSelected.Visible = not optionSelected.Visible
                    else
                        selected = {option}
                        for _, child in pairs(ddList:GetChildren()) do
                            if child:IsA("TextButton") then
                                child.Selected.Visible = child.Name == option
                            end
                        end
                        toggleDropdown()
                    end
                    
                    updateDropdown()
                    ddCallback(ddMultiSelect and selected or selected[1])
                end)
                
                if ddDefault and (option == ddDefault or (type(ddDefault) == "table" and table.find(ddDefault, option))) then
                    if ddMultiSelect then
                        table.insert(selected, option)
                    else
                        selected = {option}
                    end
                    optionSelected.Visible = true
                    updateDropdown()
                end
            end
            
            for _, option in pairs(ddOptions) do
                createOption(option)
            end
            
            dd.MouseButton1Click:Connect(toggleDropdown)
            
            local dropdown = {}
            dropdown.Title = ddTitle
            dropdown.Desc = ddDesc
            dropdown.Frame = ddFrame
            dropdown.Dropdown = dd
            dropdown.Options = ddOptions
            dropdown.Selected = selected
            dropdown.Callback = ddCallback
            dropdown.MultiSelect = ddMultiSelect
            
            function dropdown:Visible(state)
                self.Frame.Visible = state
            end
            
            function dropdown:Destroy()
                self.Frame:Destroy()
            end
            
            function dropdown:Callback(newCallback)
                self.Callback = newCallback or self.Callback
            end
            
            function dropdown:Add(...)
                local newOptions = {...}
                for _, option in pairs(newOptions) do
                    table.insert(self.Options, option)
                    createOption(option)
                end
            end
            
            function dropdown:Remove(option)
                for i, v in pairs(self.Options) do
                    if v == option then
                        table.remove(self.Options, i)
                        if ddList:FindFirstChild(option) then
                            ddList:FindFirstChild(option):Destroy()
                        end
                        break
                    end
                end
                
                for i, v in pairs(self.Selected) do
                    if v == option then
                        table.remove(self.Selected, i)
                        break
                    end
                end
                
                updateDropdown()
            end
            
            function dropdown:Select(option)
                if self.MultiSelect then
                    local found = false
                    for i, v in pairs(self.Selected) do
                        if v == option then
                            table.remove(self.Selected, i)
                            found = true
                            break
                        end
                    end
                    
                    if not found then
                        table.insert(self.Selected, option)
                    end
                    
                    if ddList:FindFirstChild(option) then
                        ddList:FindFirstChild(option).Selected.Visible = not found
                    end
                else
                    self.Selected = {option}
                    for _, child in pairs(ddList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.Selected.Visible = child.Name == option
                        end
                    end
                end
                
                updateDropdown()
                self.Callback(self.MultiSelect and self.Selected or self.Selected[1])
            end
            
            function dropdown:Set(newOptions, clear)
                if clear then
                    for _, child in pairs(ddList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    self.Options = {}
                    self.Selected = {}
                end
                
                for _, option in pairs(newOptions) do
                    table.insert(self.Options, option)
                    createOption(option)
                end
            end
            
            function dropdown:SetTitle(newTitle, newDesc)
                self.Title = newTitle or self.Title
                self.Desc = newDesc or self.Desc
                ddLabel.Text = self.Title
                if self.Desc ~= "" then
                    ddFrame:FindFirstChild("Desc").Text = self.Desc
                end
            end
            
            table.insert(tab.Elements, dropdown)
            return dropdown
        end
        
        function tab:AddSlider(options)
            options = options or {}
            local sliderTitle = options.Title or "Slider"
            local sliderDesc = options.Desc or ""
            local sliderMin = options.Min or 0
            local sliderMax = options.Max or 100
            local sliderInc = options.Increase or 1
            local sliderCallback = options.Callback or function() end
            local sliderFlag = options.Flag or false
            local sliderDefault = options.Default or math.floor((sliderMin + sliderMax) / 2)
            
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Name = "Slider"
            sliderFrame.Size = UDim2.new(1, -20, 0, sliderDesc ~= "" and 50 or 30)
            sliderFrame.BackgroundTransparency = 1
            sliderFrame.ZIndex = 4
            
            local slider = Instance.new("Frame")
            slider.Name = "Slider"
            slider.Size = UDim2.new(1, 0, 0, 30)
            slider.Position = UDim2.new(0, 0, sliderDesc ~= "" and 1 or 0, sliderDesc ~= "" and -30 or 0)
            slider.BackgroundColor3 = self.CurrentTheme.Element
            slider.ZIndex = 5
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 5)
            sliderCorner.Parent = slider
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Name = "Label"
            sliderLabel.Text = sliderTitle
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextSize = 12
            sliderLabel.TextColor3 = self.CurrentTheme.Text
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Position = UDim2.new(0, 10, 0, 0)
            sliderLabel.Size = UDim2.new(0, 100, 1, 0)
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.ZIndex = 6
            sliderLabel.Parent = slider
            
            local sliderValue = Instance.new("TextLabel")
            sliderValue.Name = "Value"
            sliderValue.Text = tostring(sliderDefault)
            sliderValue.Font = Enum.Font.GothamBold
            sliderValue.TextSize = 12
            sliderValue.TextColor3 = self.CurrentTheme.Text
            sliderValue.BackgroundTransparency = 1
            sliderValue.Position = UDim2.new(1, -50, 0, 0)
            sliderValue.Size = UDim2.new(0, 40, 1, 0)
            sliderValue.TextXAlignment = Enum.TextXAlignment.Right
            sliderValue.ZIndex = 6
            sliderValue.Parent = slider
            
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Name = "Track"
            sliderTrack.Size = UDim2.new(0, 130, 0, 10)
            sliderTrack.Position = UDim2.new(1, -140, 0.5, 0)
            sliderTrack.AnchorPoint = Vector2.new(0, 0.5)
            sliderTrack.BackgroundColor3 = self.CurrentTheme.Slider
            sliderTrack.ZIndex = 6
            
            local sliderTrackCorner = Instance.new("UICorner")
            sliderTrackCorner.CornerRadius = UDim.new(1, 0)
            sliderTrackCorner.Parent = sliderTrack
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Name = "Fill"
            sliderFill.Size = UDim2.new(0, 65, 1, 0)
            sliderFill.BackgroundColor3 = self.CurrentTheme.SliderFill
            sliderFill.ZIndex = 7
            
            local sliderFillCorner = Instance.new("UICorner")
            sliderFillCorner.CornerRadius = UDim.new(1, 0)
            sliderFillCorner.Parent = sliderFill
            
            local sliderKnob = Instance.new("Frame")
            sliderKnob.Name = "Knob"
            sliderKnob.Size = UDim2.new(0, 16, 0, 16)
            sliderKnob.Position = UDim2.new(0.5, 0, 0.5, 0)
            sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
            sliderKnob.BackgroundColor3 = self.CurrentTheme.ToggleKnob
            sliderKnob.ZIndex = 8
            
            local sliderKnobCorner = Instance.new("UICorner")
            sliderKnobCorner.CornerRadius = UDim.new(1, 0)
            sliderKnobCorner.Parent = sliderKnob
            
            sliderFill.Parent = sliderTrack
            sliderKnob.Parent = sliderTrack
            sliderTrack.Parent = slider
            
            if sliderDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = sliderDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = sliderFrame
            end
            
            slider.Parent = sliderFrame
            sliderFrame.Parent = tabContent
            
            local value = math.clamp(sliderDefault, sliderMin, sliderMax)
            local dragging = false
            
            local function updateSlider()
                local percent = (value - sliderMin) / (sliderMax - sliderMin)
                utility:Tween(sliderFill, {Size = UDim2.new(percent, 0, 1, 0)})
                utility:Tween(sliderKnob, {Position = UDim2.new(percent, 0, 0.5, 0)})
                sliderValue.Text = tostring(value)
                sliderCallback(value)
            end
            
            sliderTrack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    
                    local percent = (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X
                    percent = math.clamp(percent, 0, 1)
                    value = math.floor(sliderMin + (sliderMax - sliderMin) * percent)
                    
                    -- Snap to increments
                    value = math.floor(value / sliderInc) * sliderInc
                    
                    updateSlider()
                end
            end)
            
            sliderTrack.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X
                    percent = math.clamp(percent, 0, 1)
                    value = math.floor(sliderMin + (sliderMax - sliderMin) * percent)
                    
                    -- Snap to increments
                    value = math.floor(value / sliderInc) * sliderInc
                    
                    updateSlider()
                end
            end)
            
            updateSlider()
            
            local sliderObj = {}
            sliderObj.Title = sliderTitle
            sliderObj.Desc = sliderDesc
            sliderObj.Frame = sliderFrame
            sliderObj.Slider = slider
            sliderObj.Value = value
            sliderObj.Min = sliderMin
            sliderObj.Max = sliderMax
            sliderObj.Increase = sliderInc
            sliderObj.Callback = sliderCallback
            
            function sliderObj:Visible(state)
                self.Frame.Visible = state
            end
            
            function sliderObj:Destroy()
                self.Frame:Destroy()
            end
            
            function sliderObj:Callback(newCallback)
                self.Callback = newCallback or self.Callback
            end
            
            function sliderObj:Set(newTitle, newDesc)
                self.Title = newTitle or self.Title
                self.Desc = newDesc or self.Desc
                sliderLabel.Text = self.Title
                if self.Desc ~= "" then
                    sliderFrame:FindFirstChild("Desc").Text = self.Desc
                end
            end
            
            function sliderObj:SetValue(newValue)
                value = math.clamp(newValue, sliderMin, sliderMax)
                updateSlider()
            end
            
            table.insert(tab.Elements, sliderObj)
            return sliderObj
        end
        
        function tab:AddTextBox(options)
            options = options or {}
            local tbTitle = options.Title or "Text Box"
            local tbDesc = options.Desc or ""
            local tbDefault = options.Default or ""
            local tbPlaceholder = options.PlaceholderText or "< Input >"
            local tbClear = options.ClearText or false
            local tbCallback = options.Callback or function() end
            
            local tbFrame = Instance.new("Frame")
            tbFrame.Name = "TextBox"
            tbFrame.Size = UDim2.new(1, -20, 0, tbDesc ~= "" and 50 or 30)
            tbFrame.BackgroundTransparency = 1
            tbFrame.ZIndex = 4
            
            local tb = Instance.new("TextBox")
            tb.Name = "TextBox"
            tb.Size = UDim2.new(1, 0, 0, 30)
            tb.Position = UDim2.new(0, 0, tbDesc ~= "" and 1 or 0, tbDesc ~= "" and -30 or 0)
            tb.BackgroundColor3 = self.CurrentTheme.Element
            tb.ClearTextOnFocus = tbClear
            tb.PlaceholderText = tbPlaceholder
            tb.Text = tbDefault
            tb.Font = Enum.Font.Gotham
            tb.TextSize = 12
            tb.TextColor3 = self.CurrentTheme.Text
            tb.ZIndex = 5
            
            local tbCorner = Instance.new("UICorner")
            tbCorner.CornerRadius = UDim.new(0, 5)
            tbCorner.Parent = tb
            
            local tbPadding = Instance.new("UIPadding")
            tbPadding.Name = "Padding"
            tbPadding.PaddingLeft = UDim.new(0, 10)
            tbPadding.PaddingRight = UDim.new(0, 10)
            tbPadding.Parent = tb
            
            if tbDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = tbDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = tbFrame
            end
            
            tb.Parent = tbFrame
            tbFrame.Parent = tabContent
            
            tb.FocusLost:Connect(function()
                tbCallback(tb.Text)
            end)
            
            local textbox = {}
            textbox.Title = tbTitle
            textbox.Desc = tbDesc
            textbox.Frame = tbFrame
            textbox.TextBox = tb
            textbox.Callback = tbCallback
            
            function textbox:Visible(state)
                self.Frame.Visible = state
            end
            
            function textbox:Destroy()
                self.Frame:Destroy()
            end
            
            function textbox:SetText(newText)
                self.TextBox.Text = newText or ""
            end
            
            table.insert(tab.Elements, textbox)
            return textbox
        end
        
        function tab:AddDiscordInvite(options)
            options = options or {}
            local diTitle = options.Title or "Discord"
            local diDesc = options.Desc or "Join our discord server"
            local diLogo = options.Logo or self:GetIcon("Discord")
            local diInvite = options.Invite or ""
            
            local diFrame = Instance.new("Frame")
            diFrame.Name = "DiscordInvite"
            diFrame.Size = UDim2.new(1, -20, 0, diDesc ~= "" and 80 or 60)
            diFrame.BackgroundTransparency = 1
            diFrame.ZIndex = 4
            
            local di = Instance.new("Frame")
            di.Name = "Invite"
            di.Size = UDim2.new(1, 0, 0, diDesc ~= "" and 60 or 40)
            di.Position = UDim2.new(0, 0, diDesc ~= "" and 1 or 0, diDesc ~= "" and -60 or 0)
            di.BackgroundColor3 = self.CurrentTheme.Element
            di.ZIndex = 5
            
            local diCorner = Instance.new("UICorner")
            diCorner.CornerRadius = UDim.new(0, 5)
            diCorner.Parent = di
            
            local diLogoFrame = Instance.new("Frame")
            diLogoFrame.Name = "Logo"
            diLogoFrame.Size = UDim2.new(0, 30, 0, 30)
            diLogoFrame.Position = UDim2.new(0, 10, 0.5, 0)
            diLogoFrame.AnchorPoint = Vector2.new(0, 0.5)
            diLogoFrame.BackgroundTransparency = 1
            diLogoFrame.ZIndex = 6
            diLogoFrame.Parent = di
            
            local diLogoImage = Instance.new("ImageLabel")
            diLogoImage.Name = "Image"
            diLogoImage.Image = diLogo
            diLogoImage.Size = UDim2.new(1, 0, 1, 0)
            diLogoImage.BackgroundTransparency = 1
            diLogoImage.ZIndex = 7
            diLogoImage.Parent = diLogoFrame
            
            local diTitleLabel = Instance.new("TextLabel")
            diTitleLabel.Name = "Title"
            diTitleLabel.Text = diTitle
            diTitleLabel.Font = Enum.Font.GothamBold
            diTitleLabel.TextSize = 14
            diTitleLabel.TextColor3 = self.CurrentTheme.Text
            diTitleLabel.BackgroundTransparency = 1
            diTitleLabel.Position = UDim2.new(0, 50, 0, 5)
            diTitleLabel.Size = UDim2.new(1, -60, 0, 20)
            diTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            diTitleLabel.ZIndex = 6
            diTitleLabel.Parent = di
            
            local diInviteLabel = Instance.new("TextLabel")
            diInviteLabel.Name = "Invite"
            diInviteLabel.Text = "discord.gg/xxxxxx"
            diInviteLabel.Font = Enum.Font.Gotham
            diInviteLabel.TextSize = 12
            diInviteLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            diInviteLabel.BackgroundTransparency = 1
            diInviteLabel.Position = UDim2.new(0, 50, 0, 25)
            diInviteLabel.Size = UDim2.new(1, -60, 0, 15)
            diInviteLabel.TextXAlignment = Enum.TextXAlignment.Left
            diInviteLabel.ZIndex = 6
            diInviteLabel.Parent = di
            
            local diCopyBtn = Instance.new("TextButton")
            diCopyBtn.Name = "CopyButton"
            diCopyBtn.Size = UDim2.new(0, 60, 0, 20)
            diCopyBtn.Position = UDim2.new(1, -70, 0.5, 0)
            diCopyBtn.AnchorPoint = Vector2.new(0, 0.5)
            diCopyBtn.BackgroundColor3 = self.CurrentTheme.Button
            diCopyBtn.AutoButtonColor = false
            diCopyBtn.Text = "COPY"
            diCopyBtn.Font = Enum.Font.GothamBold
            diCopyBtn.TextSize = 12
            diCopyBtn.TextColor3 = self.CurrentTheme.ButtonText
            diCopyBtn.ZIndex = 6
            diCopyBtn.Parent = di
            
            local diCopyCorner = Instance.new("UICorner")
            diCopyCorner.CornerRadius = UDim.new(0, 5)
            diCopyCorner.Parent = diCopyBtn
            
            if diDesc ~= "" then
                local descLabel = Instance.new("TextLabel")
                descLabel.Name = "Desc"
                descLabel.Text = diDesc
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextSize = 12
                descLabel.TextColor3 = self.CurrentTheme.Text
                descLabel.BackgroundTransparency = 1
                descLabel.Position = UDim2.new(0, 0, 0, 0)
                descLabel.Size = UDim2.new(1, 0, 0, 20)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.ZIndex = 5
                descLabel.Parent = diFrame
            end
            
            di.Parent = diFrame
            diFrame.Parent = tabContent
            
            diCopyBtn.MouseButton1Click:Connect(function()
                if diInvite ~= "" then
                    setclipboard(diInvite)
                    local originalText = diCopyBtn.Text
                    diCopyBtn.Text = "COPIED!"
                    wait(1)
                    diCopyBtn.Text = originalText
                end
            end)
            
            local discordInvite = {}
            discordInvite.Title = diTitle
            discordInvite.Desc = diDesc
            discordInvite.Frame = diFrame
            discordInvite.Invite = di
            discordInvite.Logo = diLogo
            discordInvite.InviteLink = diInvite
            
            function discordInvite:Visible(state)
                self.Frame.Visible = state
            end
            
            function discordInvite:Destroy()
                self.Frame:Destroy()
            end
            
            table.insert(tab.Elements, discordInvite)
            return discordInvite
        end
        
        tabButton.MouseButton1Click:Connect(function()
            window:SelectTab(tabName)
        end)
        
        table.insert(window.Tabs, tab)
        if #window.Tabs == 1 then
            window.CurrentTab = tab
        end
        
        return tab
    end
    
    function window:AddMinimizeButton(options)
        options = options or {}
        local corner = options.Corner or {}
        local stroke = options.Stroke or {}
        local button = options.Button or {}
        
        local btn = Instance.new("ImageButton")
        btn.Name = "MinimizeButton"
        btn.Size = UDim2.new(0, 16, 0, 16)
        btn.Position = UDim2.new(1, -50, 0.5, 0)
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.BackgroundColor3 = button.Color or self.CurrentTheme.MinimizeButton
        btn.Image = button.Image or ""
        btn.ScaleType = Enum.ScaleType.Fit
        btn.AutoButtonColor = false
        btn.ZIndex = 3
        btn.Parent = header
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = corner.CornerRadius or UDim.new(0.5, 0)
        btnCorner.Parent = btn
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.ApplyStrokeMode = stroke.ApplyStrokeMode or Enum.ApplyStrokeMode.Border
        btnStroke.Color = stroke.Color or Color3.fromRGB(60, 60, 80)
        btnStroke.Thickness = stroke.Thickness or 2
        btnStroke.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            self:Minimize()
        end)
    end
    
    function window:Dialog(options)
        options = options or {}
        local dlgTitle = options.Title or "Dialog"
        local dlgText = options.Text or "This is a dialog"
        local dlgOptions = options.Options or {}
        
        local dialogFrame = Instance.new("Frame")
        dialogFrame.Name = "Dialog"
        dialogFrame.Size = UDim2.new(0, 300, 0, 150)
        dialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        dialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        dialogFrame.BackgroundColor3 = self.CurrentTheme.Element
        dialogFrame.ZIndex = 20
        
        local dialogCorner = Instance.new("UICorner")
        dialogCorner.CornerRadius = UDim.new(0, 10)
        dialogCorner.Parent = dialogFrame
        
        local dialogStroke = Instance.new("UIStroke")
        dialogStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        dialogStroke.Color = Color3.fromRGB(60, 60, 80)
        dialogStroke.Thickness = 2
        dialogStroke.Parent = dialogFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Text = dlgTitle
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 16
        titleLabel.TextColor3 = self.CurrentTheme.Text
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0, 15, 0, 10)
        titleLabel.Size = UDim2.new(1, -30, 0, 20)
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = 21
        titleLabel.Parent = dialogFrame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Text"
        textLabel.Text = dlgText
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextSize = 14
        textLabel.TextColor3 = self.CurrentTheme.Text
        textLabel.TextWrapped = true
        textLabel.BackgroundTransparency = 1
        textLabel.Position = UDim2.new(0, 15, 0, 40)
        textLabel.Size = UDim2.new(1, -30, 0, 60)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.ZIndex = 21
        textLabel.Parent = dialogFrame
        
        local buttonsFrame = Instance.new("Frame")
        buttonsFrame.Name = "Buttons"
        buttonsFrame.Size = UDim2.new(1, -30, 0, 30)
        buttonsFrame.Position = UDim2.new(0, 15, 1, -40)
        buttonsFrame.BackgroundTransparency = 1
        buttonsFrame.ZIndex = 21
        buttonsFrame.Parent = dialogFrame
        
        local buttonsLayout = Instance.new("UIListLayout")
        buttonsLayout.Name = "Layout"
        buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
        buttonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        buttonsLayout.Padding = UDim.new(0, 10)
        buttonsLayout.Parent = buttonsFrame
        
        dialogFrame.Parent = mainFrame
        
        local dialog = {}
        dialog.Frame = dialogFrame
        dialog.Buttons = {}
        
        function dialog:Button(options)
            options = options or {}
            local btnTitle = options.Title or "Button"
            local btnCallback = options.Callback or function() end
            
            local btn = Instance.new("TextButton")
            btn.Name = "Button"
            btn.Size = UDim2.new(0, 80, 1, 0)
            btn.BackgroundColor3 = self.CurrentTheme.Button
            btn.AutoButtonColor = false
            btn.Text = btnTitle
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.TextColor3 = self.CurrentTheme.ButtonText
            btn.ZIndex = 22
            btn.Parent = buttonsFrame
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 5)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                btnCallback()
            end)
            
            table.insert(self.Buttons, btn)
            return btn
        end
        
        function dialog:Close()
            utility:Tween(dialogFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function()
                dialogFrame:Destroy()
            end)
        end
        
        for _, option in pairs(dlgOptions) do
            dialog:Button(option)
        end
        
        utility:Tween(dialogFrame, {Size = UDim2.new(0, 300, 0, 150)})
        
        return dialog
    end
    
    closeBtn.MouseButton1Click:Connect(function()
        window:CloseBtn()
    end)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        window:MinimizeBtn()
    end)
    
    return window
end

-- Initialize library
CLEITI6966_Library.CurrentTheme = themes.Default
CLEITI6966_Library.Scale = 1

return CLEITI6966_Library
