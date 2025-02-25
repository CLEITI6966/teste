local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/refs/heads/main/source')))()
local Player = game.Players.LocalPlayer

local Window = OrionLib:MakeWindow({
	Name = "Key System",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "KeySystem",
	IntroText = "Verificando Chave..."
})

getgenv().Key = "kakakgaisvau" -- A chave será substituída pelo script Node.js
getgenv().KeyInput = "" -- Variável para a chave inserida

-- Lista de jogadores permitidos (WhiteList)
local WhiteList = {
	"nova_contakk9",
	"CLEITI6966",
	"xXRAPOSO743Xx",
	"vacalebrenj",
	"ZinacPato10",
	"contasecundariamrred",
   "Rhuanprozim",
   "Hibad98",
   "Migueleti4605"
}

local Tab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Insira a Chave",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		getgenv().KeyInput = Value
	end
})

local function executarScript()
	OrionLib:MakeNotification({
		Name = "Sucesso!",
		Content = "Chave correta ou acesso WhiteList! Script carregado.",
		Image = "rbxassetid://0",
		Time = 5
	})
	wait(1)
	OrionLib:Destroy()
	wait(0.3)
	-- Adicione o seu script aqui
	--Configurações
local randomNameRPActive = false
local randomNameBioActive  = false
local colorNameRPActive    = false
local colorNameBioActive   = false
local selectedPlayer = nil
local loopTeleport = false
local verJogador = false
local isFlinging = false
local spamMessage = ""
local delayTime = 6.7
local isSpamming = false
local isFlingAll = false
local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RunService = game:GetService("RunService")

-- Carregar a biblioteca (substitua o link se necessário)
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))() :MakeWindow({
    Title = "CLEITI6966 HUBS 2: BROOKHAVEN RP 🏡 BETA V1.6 Executor: " .. getexecutorname(),
    SubTitle = "BY CLEITI6966",
    SaveFolder = "CLEITI6966 HUBS 2"
})

-----------------------------------------------------------
-- Aba 1: Menu
-----------------------------------------------------------
local TabMenu = Window:MakeTab({
    Title = "Menu",
    Icon = "settings"
})

TabMenu:AddDiscordInvite({
    Title = "CLEITI6966 HUBS",
    Desc = "Entre no meu server",
    Logo = "",
    Invite = "https://discord.gg/Wykb3MKqgz"
})

TabMenu:AddSlider({
    Title = "Velocidade",
    Min = 1,
    Max = 1000,
    Default = 16,
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = Value
        end
    end
})

TabMenu:AddSlider({
    Title = "Gravidade",
    Min = 1,
    Max = 1000,
    Default = 196.2,
    Callback = function(Value)
        game.Workspace.Gravity = Value
    end
})

TabMenu:AddSlider({
    Title = "Altura do Pulo",
    Min = 1,
    Max = 1000,
    Default = 50,
    Callback = function(Value)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = Value
        end
    end
})

TabMenu:AddButton({
    Title = "Redefinir",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
            character.Humanoid.JumpPower = 50
        end
        game.Workspace.Gravity = 196.2
    end
})

-----------------------------------------------------------
-- Aba 2: Bio-Nome
-----------------------------------------------------------
local TabBioNome = Window:MakeTab({
    Title = "Bio-Nome",
    Icon = "user"
})

TabBioNome:AddTextBox({
    Title = "Inserir Nome para RolePlay",
    Default = "",
    Callback = function(value)
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayName", value)
    end
})

TabBioNome:AddTextBox({
    Title = "Inserir Nome para Bio",
    Default = "",
    Callback = function(value)
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayBio", value)
    end
})

-- Função para gerar nome aleatório
local function generateRandomName(minLength, maxLength)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local name = ""
    local length = math.random(minLength, maxLength)
    for i = 1, length do
        local index = math.random(1, #chars)
        name = name .. chars:sub(index, index)
    end
    return name
end

-- Cores pré-definidas (usando Color3.fromHSV)
local cores = {
    vermelho = Color3.fromHSV(0/360, 0.37, 1),
    verde    = Color3.fromHSV(120/360, 0.37, 1),
    azul     = Color3.fromHSV(240/360, 0.37, 1),
    amarelo  = Color3.fromHSV(60/360, 0.37, 1),
    laranja  = Color3.fromHSV(30/360, 0.37, 1)
}

-- Variáveis para controle dos toggles

TabBioNome:AddToggle({
    Title = "Girar Nome Aleatório RP",
    Default = false,
    Callback = function(state)
        randomNameRPActive = state
        if state then
            spawn(function()
                while randomNameRPActive do
                    local rn = generateRandomName(4, 12)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayName", rn)
                    wait(0.1)
                end
            end)
        end
    end
})

TabBioNome:AddToggle({
    Title = "Girar Nome Aleatório Bio",
    Default = false,
    Callback = function(state)
        randomNameBioActive = state
        if state then
            spawn(function()
                while randomNameBioActive do
                    local rn = generateRandomName(4, 12)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eTex1t"):FireServer("RolePlayBio", rn)
                    wait(0.1)
                end
            end)
        end
    end
})

TabBioNome:AddToggle({
    Title = "Girar Cor Nome RP",
    Default = false,
    Callback = function(state)
        colorNameRPActive = state
        if state then
            spawn(function()
                local listaCores = { cores.vermelho, cores.verde, cores.azul, cores.amarelo, cores.laranja }
                local i = 1
                while colorNameRPActive do
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor", listaCores[i])
                    i = i % #listaCores + 1
                    wait(0.37)
                end
            end)
        end
    end
})

TabBioNome:AddToggle({
    Title = "Girar Cor Nome Bio",
    Default = false,
    Callback = function(state)
        colorNameBioActive = state
        if state then
            spawn(function()
                local listaCores = { cores.vermelho, cores.verde, cores.azul, cores.amarelo, cores.laranja }
                local i = 1
                while colorNameBioActive do
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor", listaCores[i])
                    i = i % #listaCores + 1
                    wait(0.37)
                end
            end)
        end
    end
})
	
	local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local replicatedStorage = game:GetService("ReplicatedStorage")
local events = replicatedStorage:WaitForChild("RE")
local eventText = events:WaitForChild("1RPNam1eTex1t")
local eventColor = events:WaitForChild("1RPNam1eColo1r")

local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local inactivityTime = 0
local isOffline = true  -- Status inicial
local inputConnection = nil
local heartbeatConnection = nil

-- Função para atualizar o status
local function updateStatus(isOnline)
    if isOnline and isOffline then
        -- Envia "online"
        local args = {
            [1] = "RolePlayBio",
            [2] = "on-line!"
        }
        eventText:FireServer(unpack(args))

        args = {
            [1] = "PickingRPBioColor",
            [2] = Color3.new(0.06419074535369873, 1, 0)
        }
        eventColor:FireServer(unpack(args))

        isOffline = false
        print("Status alterado para: online!")
    elseif not isOnline and not isOffline then
        -- Envia "offline"
        local args = {
            [1] = "RolePlayBio",
            [2] = "off-line!"
        }
        eventText:FireServer(unpack(args))

        args = {
            [1] = "PickingRPBioColor",
            [2] = Color3.new(0, 0, 0)
        }
        eventColor:FireServer(unpack(args))

        isOffline = true
        print("Status alterado para: offline!")
    end
end

-- Detecta qualquer entrada de usuário (teclado, mouse)
local function startMonitoring()
    inputConnection = userInputService.InputBegan:Connect(function()
        inactivityTime = 0  -- Reseta o tempo de inatividade
        print("Entrada do usuário detectada!")
        if isOffline then
            updateStatus(true)  -- Marca como online
        end
    end)

    -- Verifica se o personagem está se movendo
    heartbeatConnection = runService.Heartbeat:Connect(function(dt)
        if humanoid.MoveDirection.Magnitude > 0 then
            -- Se o personagem está se movendo, marca como online
            inactivityTime = 0
            if isOffline then
                print("Jogador em movimento. Mudando para online.")
                updateStatus(true)  -- Marca como online
            end
        else
            inactivityTime = inactivityTime + dt  -- Acumula tempo de inatividade
            if inactivityTime >= 4 then
                -- Se o jogador estiver inativo por 4 segundos, marca como offline
                if not isOffline then
                    print("Jogador inativo por 4 segundos. Mudando para offline.")
                    updateStatus(false)  -- Marca como offline
                end
            end
        end
    end)
end

-- Função para parar o monitoramento
local function stopMonitoring()
    if inputConnection then
        inputConnection:Disconnect()
        inputConnection = nil
    end
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
    print("Monitoramento desativado.")
end

-- Criar o Toggle "Status Player Local"
local Toggle = TabBioNome:AddToggle({
    Title = "Status Player Local",
    Desc = "Ativa ou desativa o status de online/offline.",
    Callback = function(Value)
        if Value then
            -- Ativa o monitoramento de status
            startMonitoring()
        else
            -- Desativa o monitoramento de status
            stopMonitoring()
        end
    end,
    Default = false, -- Estado inicial do toggle (desativado)
    Flag = false
})
	
-----------------------------------------------------------
-- Aba 3: Casas
-----------------------------------------------------------
local TabCasas = Window:MakeTab({
    Title = "Casas",
    Icon = "rbxassetid://10723407389"
})

TabCasas:AddDropdown({
    Title = "Pegar Permissão",
    Options = {
        "1","2","3","4","5","6","7","8","9","10",
        "11","12","13","14","15","16","17","18","19","20",
        "21","22","23","24","25","26","27","28","29","30",
        "31","32","33","34","35","36","37"
    },
    Default = "1",
    Callback = function(selected)
        local permission = tonumber(selected)
        if permission then
            local args = {
                [1] = "GivePermissionLoopToServer",
                [2] = game.Players.LocalPlayer,
                [3] = permission
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
        end
    end
})

local SelectedHouse
local Touching = false
local Knocking = false

local function GetHouseByNamePartial(namePartial)
    for _, house in pairs(workspace["001_Lots"]:GetChildren()) do
        if house:IsA("Model") and house.Name:find("House") and house.Name:lower():find(namePartial:lower()) then
            return house
        end
    end
    return nil
end

local function TeleportAndClick(target)
    if target then
        local Player = game.Players.LocalPlayer
        if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = target.CFrame
        end
        local ClickDetector = target:FindFirstChildWhichIsA("ClickDetector")
        if ClickDetector then
            fireclickdetector(ClickDetector)
        end
    end
end

local function TouchDoorbell()
    while Touching and SelectedHouse do
        local DoorBell = SelectedHouse:FindFirstChild("HousePickedByPlayer", true)
        if DoorBell then
            local TouchBell = DoorBell:FindFirstChild("HouseModel", true)
            if TouchBell then
                TouchBell = TouchBell:FindFirstChild("001_DoorBell", true)
                if TouchBell then
                    TouchBell = TouchBell:FindFirstChild("TouchBell", true)
                    TeleportAndClick(TouchBell)
                end
            end
        end
        task.wait(0)
    end
end

local function KnockOnDoor()
    while Knocking and SelectedHouse do
        local KnockPath = SelectedHouse:FindFirstChild("HousePickedByPlayer", true)
        if KnockPath then
            local HouseModel = KnockPath:FindFirstChild("HouseModel", true)
            if HouseModel then
                local HouseDoors = HouseModel:FindFirstChild("001_HouseDoors", true)
                if HouseDoors then
                    local HouseDoorFront = HouseDoors:FindFirstChild("HouseDoorFront", true)
                    if HouseDoorFront then
                        local Knock = HouseDoorFront:FindFirstChild("Knock", true)
                        if Knock then
                            local TouchBell = Knock:FindFirstChild("TouchBell", true)
                            TeleportAndClick(TouchBell)
                        end
                    end
                end
            end
        end
        task.wait(0)
    end
end

local TextBox = TabCasas:AddTextBox({
    Title = "Nome do Jogador",
    Desc = "Digite parte do nome do jogador",
    Default = "",
    PlaceholderText = "< Input >",
    ClearText = false,
    Callback = function(Value)
        SelectedHouse = GetHouseByNamePartial(Value)
        if SelectedHouse then
            if Touching then
                TouchDoorbell()
            elseif Knocking then
                KnockOnDoor()
            end
        end
    end
})

TabCasas:AddToggle({
    Title = "Tocar Campainha",
    Callback = function(State)
        Touching = State
        if State and SelectedHouse then
            TouchDoorbell()
        end
    end
})

TabCasas:AddToggle({
    Title = "Bater Na Porta",
    Callback = function(State)
        Knocking = State
        if State and SelectedHouse then
            KnockOnDoor()
        end
    end
})
	
-----------------------------------------------------------
-- Aba 4: Ferramentas
-----------------------------------------------------------
local TabFerramentas = Window:MakeTab({
    Title = "Ferramentas",
    Icon = "rbxassetid://10723407389"
})

TabFerramentas:AddButton({
    Title = "Pegar Sofá",
    Callback = function()
        local args = { "PickingTools", "Couch" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
    end
})

TabFerramentas:AddButton({
    Title = "Pegar Tp Tool",
    Callback = function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "tp tool"
        tool.Activated:Connect(function()
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.Position)
        end)
        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

TabFerramentas:AddButton({
    Title = "Equipar Todas As Tools",
    Callback = function()
        for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
        tool.Parent = game.Players.LocalPlayer.Character
    end
end
    end
})

-----------------------------------------------------------
-- Aba 5: Anti
-----------------------------------------------------------
local TabAnti = Window:MakeTab({
    Title = "Anti",
    Icon = "rbxassetid://10723407389"
})

TabAnti:AddToggle({
    Title = "Anti Sit",
    Default = false,
    Callback = function(state)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:SetStateEnabled("Seated", not state)
        else
            print("Erro: Personagem não encontrado.")
        end
    end
})

local voidProtectionEnabled = false
local function ativarAntiVoid()
    voidProtectionEnabled = true
    game.Workspace.FallenPartsDestroyHeight = 0/0  -- Forçando NaN
end

TabAnti:AddButton({
    Title = "Ativar Anti Void",
    Callback = ativarAntiVoid
})

local TabChat = Window:MakeTab({
    Title = "Chat",
    Icon = "user"
})

TabChat:AddButton({
    Title = "Mensagem Server Destruído",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
textChannel:SendAsync([[:)                                                                                        Server Destroyed]])
    end
})

TabChat:AddButton({
    Title = "Mensagem Chat Limpado",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
textChannel:SendAsync([[:)                                                                                        Chat Clear]])
    end
})

TabChat:AddButton({
    Title = "Mensagem Server Lagado",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
textChannel:SendAsync([[:)                                                                                        Lag Server]])
    end
})

TabChat:AddButton({
    Title = "Mensagem Anti-Mandrake",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
textChannel:SendAsync([[:)                                                                                        Anti-Mandrake]])
    end
})

TabChat:AddButton({
    Title = "Mensagem Anti-Toxicos",
    Callback = function()
        local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
textChannel:SendAsync([[:)                                                                                        Anti-Toxicos]])
    end
})

	-- Criar o parágrafo com aviso sobre o delay seguro
TabChat:AddParagraph({
    Title = "Atenção!",
    Text = "Para evitar banimento, use um delay de 6.7 segundos ou mais!"
})

-- Variáveis de delay e mensagem
local delayValue = 1
local messageText = "Digite sua mensagem..."
local spamActive = false

-- Criar TextBox para definir o delay (padrão: 1 segundo)
TabChat:AddTextBox({
    Title = "Delay (segundos)",
    Desc = "Tempo entre mensagens",
    Default = "1",
    PlaceholderText = "Digite o delay...",
    Callback = function(Value)
        local num = tonumber(Value)
        if num and num > 0 then
            delayValue = num
        end
    end
})

-- Criar TextBox para definir a mensagem
TabChat:AddTextBox({
    Title = "Mensagem",
    Desc = "Texto a ser enviado",
    Default = "Digite sua mensagem...",
    PlaceholderText = "Digite sua mensagem...",
    Callback = function(Value)
        if Value ~= "" then
            messageText = Value
        end
    end
})

-- Criar o toggle para ativar/desativar o spam
local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral

TabChat:AddToggle({
    Title = "Spam Chat",
    Desc = "Ativa/desativa o envio de mensagens",
    Default = false,
    Callback = function(State)
        spamActive = State
        if spamActive then
            task.spawn(function()
                while spamActive do
                    textChannel:SendAsync(messageText)
                    task.wait(delayValue)
                end
            end)
        end
    end
})
	
	-- Criar a configuração do chat automático
local settings = {
    AutoChat = false
}

-- Serviços do Roblox para capturar e enviar mensagens no chat
local TextChatService = game:GetService("TextChatService")
local textChannel = TextChatService.TextChannels.RBXGeneral
local localPlayer = game.Players.LocalPlayer

-- Tabela para armazenar mensagens recentes dos jogadores
local messageLog = {}
local blockedUsers = {}

-- Criar a função de anti-spam
local function checkSpam(userId)
    if not messageLog[userId] then
        messageLog[userId] = {}
    end

    -- Adiciona o timestamp da mensagem à lista
    table.insert(messageLog[userId], tick())

    -- Remove mensagens antigas da lista (mantém apenas as dos últimos 5 segundos)
    for i = #messageLog[userId], 1, -1 do
        if tick() - messageLog[userId][i] > 5 then
            table.remove(messageLog[userId], i)
        end
    end

    -- Se houver 3 ou mais mensagens no intervalo de 5 segundos, ativa o bloqueio
    if #messageLog[userId] >= 3 then
        blockedUsers[userId] = true
        task.delay(6, function() 
            blockedUsers[userId] = false
        end)
    end
end

-- Capturar mensagens e repetir no chat se o toggle estiver ativado
TextChatService.MessageReceived:Connect(function(message)
    local userId = message.TextSource.UserId

    -- Aplicar sistema de anti-spam
    checkSpam(userId)

    -- Se o usuário estiver bloqueado, ignora a mensagem
    if blockedUsers[userId] then return end

    -- Verifica se a funcionalidade está ativada e se a mensagem não é do próprio jogador
    if settings.AutoChat and userId ~= localPlayer.UserId then
        textChannel:SendAsync(message.Text)
        print("Mensagem enviada: " .. message.Text)
    end
end)

-- Criar o toggle para ativar/desativar o recurso
local Toggle = TabChat:AddToggle({
    Title = "Repetir Chat",
    Desc = "Repete automaticamente as mensagens do chat.",
    Default = false,
    Callback = function(Value)
        settings.AutoChat = Value
        print("Repetir Chat: " .. tostring(Value))
    end
})
	
-----------------------------------------------------------
-- Aba 6: Auto
-----------------------------------------------------------
local TabAuto = Window:MakeTab({
    Title = "Auto",
    Icon = "user"
})

local function autoRenjon()
    local GuiService = game:GetService("GuiService")
    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer

    GuiService.ErrorMessageChanged:Connect(function(errorMessage)
        if errorMessage and errorMessage ~= "" then
            print("Error detected: " .. errorMessage)
            wait()
            TeleportService:Teleport(game.PlaceId, player)
        end
    end)
end

TabAuto:AddButton({
    Title = "Auto Renjon",
    Callback = autoRenjon
})

-----------------------------------------------------------
-- Aba 7: Lag
-----------------------------------------------------------
local TabLag = Window:MakeTab({
    Title = "Lag",
    Icon = "lag"
})

TabLag:AddButton({
    Title = "Lag Server GhostMeter {PEGA EM TODOS OS SERVIDORES} {MAIS OU MENOS}",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local BtnScript = Instance.new("TextButton")
        local CloseBtn = Instance.new("TextButton")
        local LabelCount = Instance.new("TextLabel")
        
        ScreenGui.Parent = game.CoreGui
        
        Frame.Parent = ScreenGui
        Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Frame.Size = UDim2.new(0, 200, 0, 120)
        Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
        Frame.Active = true
        Frame.Draggable = true
        
        BtnScript.Parent = Frame
        BtnScript.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        BtnScript.Size = UDim2.new(1, 0, 0.4, 0)
        BtnScript.Text = "Iniciar Lag GhostMeter"
        BtnScript.Font = Enum.Font.SourceSansBold
        BtnScript.TextSize = 20
        BtnScript.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        CloseBtn.Parent = Frame
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        CloseBtn.Size = UDim2.new(0, 30, 0, 30)
        CloseBtn.Position = UDim2.new(1, -30, 0, 0)
        CloseBtn.Text = "X"
        CloseBtn.TextSize = 20
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        LabelCount.Parent = Frame
        LabelCount.BackgroundTransparency = 1
        LabelCount.Size = UDim2.new(1, 0, 0.6, 0)
        LabelCount.Position = UDim2.new(0, 0, 0.4, 0)
        LabelCount.Text = "Itens Coletados: 0"
        LabelCount.TextSize = 16
        LabelCount.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelCount.TextYAlignment = Enum.TextYAlignment.Top
        
        CloseBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
        
        local itemName = "iPhone"
        local ghostMeterName = "GhostMeter"
        local scriptRunning = false
        local itemCount = 0
        
        local function clickDetectorTrigger(object)
            local cd = object:FindFirstChildWhichIsA("ClickDetector")
            if cd then fireclickdetector(cd) end
        end
        
        local function findItem(pathName, nome)
            local path = workspace:FindFirstChild(pathName)
            if path then
                path = path:FindFirstChild("001_GiveTools")
                if path then return path:FindFirstChild(nome) end
            end
            return nil
        end
        
        local function stopScript()
            scriptRunning = false
        end
        
        local function startScript()
            local itemObj = findItem("WorkspaceCom", itemName)
            local ghostObj = findItem("WorkspaceCom", ghostMeterName)
            if itemObj then
                while scriptRunning do
                    if itemCount >= 9999 then
                        stopScript()
                        BtnScript.Text = "Iniciar Script"
                        break
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = itemObj.CFrame
                    clickDetectorTrigger(itemObj)
                    itemCount = itemCount + 1
                    LabelCount.Text = "Itens Coletados: " .. itemCount
                    wait(0.1)
                end
            elseif ghostObj then
                while scriptRunning do
                    if itemCount >= 999999 then
                        stopScript()
                        BtnScript.Text = "Iniciar Script"
                        break
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ghostObj.CFrame
                    clickDetectorTrigger(ghostObj)
                    itemCount = itemCount + 1
                    LabelCount.Text = "Itens Coletados: " .. itemCount
                    wait(0.1)
                end
            else
                warn("Item '" .. itemName .. "' e '" .. ghostMeterName .. "' não encontrados.")
            end
        end
        
        BtnScript.MouseButton1Click:Connect(function()
            if scriptRunning then
                stopScript()
                BtnScript.Text = "Iniciar Lag GhostMeter"
            else
                scriptRunning = true
                BtnScript.Text = "Parar Lag GhostMeter"
                startScript()
            end
        end)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
            if not processed and input.KeyCode == Enum.KeyCode.B then
                for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    item:Destroy()
                end
            end
        end)
    end
})

TabLag:AddButton({
    Title = "Lag Server iPhone {SO PEGA EM ALGUNS SERVIDORES} {MAIS OU MENOS}",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ItemCountLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Size = UDim2.new(1, 0, 0.4, 0)
Button.Text = "Iniciar Lag iPhone"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ItemCountLabel.Parent = Frame
ItemCountLabel.BackgroundTransparency = 1
ItemCountLabel.Size = UDim2.new(1, 0, 0.6, 0)
ItemCountLabel.Position = UDim2.new(0, 0, 0.4, 0)
ItemCountLabel.Text = "Itens Coletados: 0"
ItemCountLabel.TextSize = 16
ItemCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemCountLabel.TextYAlignment = Enum.TextYAlignment.Top

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local scriptRunning = false
local itemCollectedCount = 0

local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

local function findIphone()
    local path = workspace:FindFirstChild("WorkspaceCom")
    if path then
        path = path:FindFirstChild("001_CommercialStores")
        if path then
            path = path:FindFirstChild("CommercialStorage1")
            if path then
                path = path:FindFirstChild("Store")
                if path then
                    path = path:FindFirstChild("Tools")
                    if path then
                        return path:FindFirstChild("Iphone")
                    end
                end
            end
        end
    end
    return nil
end

local function startScript()
    local iphonePath = findIphone()
    
    while scriptRunning do
        if iphonePath then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = iphonePath.CFrame
            clickNormally(iphonePath)
        else
            warn("Item 'Iphone' não encontrado no Workspace.")
            break
        end

        itemCollectedCount = itemCollectedCount + 1
        ItemCountLabel.Text = "Itens Coletados: " .. itemCollectedCount
        wait(0.1) -- Tempo de 0.1 segundos entre cada teleporte e interação
    end
end

local function stopScript()
    scriptRunning = false
end

Button.MouseButton1Click:Connect(function()
    if scriptRunning then
        stopScript()
        Button.Text = "Iniciar Lag iPhone"
    else
        scriptRunning = true
        Button.Text = "Parar Lag iPhone"
        startScript()
    end
end)

local function emptyInventory()
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        item:Destroy()
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.B then
            emptyInventory()
        end
    end
end)
    end
})

TabLag:AddButton({
    Title = "Lag Server Notebook {PEGA EM TODOS OS SERVERS} {OP}",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ItemCountLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Size = UDim2.new(1, 0, 0.4, 0)
Button.Text = "Iniciar Lag Notebook"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ItemCountLabel.Parent = Frame
ItemCountLabel.BackgroundTransparency = 1
ItemCountLabel.Size = UDim2.new(1, 0, 0.6, 0)
ItemCountLabel.Position = UDim2.new(0, 0, 0.4, 0)
ItemCountLabel.Text = "Itens Coletados: 0"
ItemCountLabel.TextSize = 16
ItemCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemCountLabel.TextYAlignment = Enum.TextYAlignment.Top

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local scriptRunning = false
local itemCollectedCount = 0

local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

local function findLaptop()
    local path = workspace:FindFirstChild("WorkspaceCom")
    if path then
        path = path:FindFirstChild("001_GiveTools")
        if path then
            return path:FindFirstChild("Laptop")
        end
    end
    return nil
end

local function startScript()
    local laptopPath = findLaptop()
    
    while scriptRunning do
        if laptopPath then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = laptopPath.CFrame
            clickNormally(laptopPath)
        else
            warn("Item 'Laptop' não encontrado no Workspace.")
            break
        end

        itemCollectedCount = itemCollectedCount + 1
        ItemCountLabel.Text = "Itens Coletados: " .. itemCollectedCount
        wait(0.1) -- Tempo de 0.1 segundos entre cada teleporte e interação
    end
end

local function stopScript()
    scriptRunning = false
end

Button.MouseButton1Click:Connect(function()
    if scriptRunning then
        stopScript()
        Button.Text = "Iniciar Lag Notebook"
    else
        scriptRunning = true
        Button.Text = "Parar Lag Notebook"
        startScript()
    end
end)

local function emptyInventory()
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        item:Destroy()
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.B then
            emptyInventory()
        end
    end
end)
    end
})

TabLag:AddButton({
    Title = "Lag Server Book {PEGA EM TODOS OS SERVERS} {OP}",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ItemCountLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Size = UDim2.new(1, 0, 0.4, 0)
Button.Text = "Iniciar Lag Book"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ItemCountLabel.Parent = Frame
ItemCountLabel.BackgroundTransparency = 1
ItemCountLabel.Size = UDim2.new(1, 0, 0.6, 0)
ItemCountLabel.Position = UDim2.new(0, 0, 0.4, 0)
ItemCountLabel.Text = "Itens Coletados: 0"
ItemCountLabel.TextSize = 16
ItemCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemCountLabel.TextYAlignment = Enum.TextYAlignment.Top

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local scriptRunning = false
local itemCollectedCount = 0

local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

local function findBook()
    return workspace:FindFirstChild("WorkspaceCom"):FindFirstChild("001_DayCare"):FindFirstChild("Tools"):FindFirstChild("Book")
end

local function startScript()
    local bookPath = findBook()
    
    while scriptRunning do
        if bookPath then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = bookPath.CFrame
            clickNormally(bookPath)
        else
            warn("Item 'Book' não encontrado no Workspace.")
            break
        end

        itemCollectedCount = itemCollectedCount + 1
        ItemCountLabel.Text = "Itens Coletados: " .. itemCollectedCount
        wait(0.1) -- Tempo de 0.1 segundos entre cada teleporte e interação
    end
end

local function stopScript()
    scriptRunning = false
end

Button.MouseButton1Click:Connect(function()
    if scriptRunning then
        stopScript()
        Button.Text = "Iniciar Lag Book"
    else
        scriptRunning = true
        Button.Text = "Parar Lag Book"
        startScript()
    end
end)

local function emptyInventory()
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        item:Destroy()
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.B then
            emptyInventory()
        end
    end
end)
    end
})

TabLag:AddButton({
    Title = "Lag Server Taser {PEGA EM TODOS OS SERVERS} {OP}",
    Callback = function()
        local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ItemCountLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Size = UDim2.new(1, 0, 0.4, 0)
Button.Text = "Iniciar Lag Taser"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ItemCountLabel.Parent = Frame
ItemCountLabel.BackgroundTransparency = 1
ItemCountLabel.Size = UDim2.new(1, 0, 0.6, 0)
ItemCountLabel.Position = UDim2.new(0, 0, 0.4, 0)
ItemCountLabel.Text = "Itens Coletados: 0"
ItemCountLabel.TextSize = 16
ItemCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemCountLabel.TextYAlignment = Enum.TextYAlignment.Top

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local scriptRunning = false
local itemCollectedCount = 0

local function clickNormally(object)
    local clickDetector = object:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

local function findTaser()
    return workspace.WorkspaceCom["001_GiveTools"].Taser
end

local function startScript()
    local taserPath = findTaser()
    
    while scriptRunning do
        if taserPath then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = taserPath.CFrame
            clickNormally(taserPath)
        else
            warn("Item 'Taser' não encontrado no Workspace.")
            break
        end

        itemCollectedCount = itemCollectedCount + 1
        ItemCountLabel.Text = "Itens Coletados: " .. itemCollectedCount
        wait(0.1) -- Tempo de 0.1 segundos entre cada teleporte e interação
    end
end

local function stopScript()
    scriptRunning = false
end

-- Função para ativar o som do Taser quando uma ferramenta é coletada
local function onToolAdded(tool)
    if scriptRunning then
        local args = {
            [1] = "Taser",
            [2] = "On"
        }
        game:GetService("Players").LocalPlayer:WaitForChild("ToolSound"):FireServer(unpack(args))
    end
end

-- Conectar o evento ChildAdded ao Backpack
game.Players.LocalPlayer.Backpack.ChildAdded:Connect(onToolAdded)

Button.MouseButton1Click:Connect(function()
    if scriptRunning then
        stopScript()
        Button.Text = "Iniciar Lag Taser"
        local args = {
            [1] = "Taser",
            [2] = "Off"
        }
        game:GetService("Players").LocalPlayer:WaitForChild("ToolSound"):FireServer(unpack(args))
    else
        scriptRunning = true
        Button.Text = "Parar Lag Taser"
        startScript()
    end
end)

local function emptyInventory()
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        item:Destroy()
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if input.KeyCode == Enum.KeyCode.B then
            emptyInventory()
        end
    end
end)
    end
})

TabLag:AddButton({
    Title = "Esvaziar Inventário",
    Callback = function()
        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            item:Destroy()
        end
    end
})

-----------------------------------------------------------
-- Aba 8: Visual/Cliente
-----------------------------------------------------------
local TabVisual = Window:MakeTab({
    Title = "Visual/Cliente",
    Icon = "user"
})

local espEnabled = false

local function createESP(player)
    if not (player.Character and player.Character:FindFirstChild("Head")) then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Parent = player.Character.Head
    billboard.Size = UDim2.new(5, 0, 1, 0)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Adornee = player.Character.Head
    billboard.AlwaysOnTop = true

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Parent = billboard
    infoLabel.Size = UDim2.new(1, 0, 1, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextStrokeTransparency = 0.5
    infoLabel.TextColor3 = Color3.new(1,1,1)
    infoLabel.Font = Enum.Font.SourceSansBold
    infoLabel.TextSize = 15

    local function updateLabel()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            infoLabel.Text = string.format("%s - %d studs - %d dias", player.Name, math.floor(dist), player.AccountAge)
        end
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        if espEnabled then
            updateLabel()
        else
            billboard:Destroy()
        end
    end)
end

local function toggleESP(state)
    espEnabled = state
    if espEnabled then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer then
                createESP(plr)
            end
        end
    else
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local bill = plr.Character.Head:FindFirstChildOfClass("BillboardGui")
                if bill then bill:Destroy() end
            end
        end
    end
end

TabVisual:AddToggle({
    Title = "ESP CLEITI6966",
    Default = false,
    Callback = toggleESP
})

TabVisual:AddButton({
    Title = "Bring All Parts",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITI6966/Brookhaven/refs/heads/main/bring%20all%20parts.lua"))()
    end
})

-- Aba "Jogadores"
local TabJogadores = Window:MakeTab({
    Title = "Jogadores/Jogador",
    Icon = "user"
})

-- Cria o dropdown e atualiza suas opções com os jogadores atuais
local dropdownPlayers = TabJogadores:AddDropdown({
    Title = "Selecionar Jogador",
    Options = {}, 
    Default = "",
    Callback = function(value)
        selectedPlayer = game.Players:FindFirstChild(value)
    end
})

-- Função para atualizar as opções do dropdown
local function updatePlayerList()
    local playerNames = {}
    for _, plr in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, plr.Name)
    end
    dropdownPlayers:Set(playerNames, true)
end

-- Atualiza a lista ao carregar e periodicamente
updatePlayerList()
spawn(function()
    while wait(5) do
        updatePlayerList()
    end
end)

-- Botão: Teleportar para o jogador selecionado
TabJogadores:AddButton({
    Title = "Teleportar para o Player",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local lpChar = game.Players.LocalPlayer.Character
            if lpChar and lpChar:FindFirstChild("HumanoidRootPart") then
                lpChar.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
            else
                print("Seu personagem não possui HumanoidRootPart.")
            end
        else
            print("Jogador não selecionado ou sem personagem.")
        end
    end
})

-- Toggle: Loop Teleportar
TabJogadores:AddToggle({
    Title = "Loop Teleportar",
    Default = false,
    Callback = function(state)
        loopTeleport = state
        if loopTeleport then
            spawn(function()
                while loopTeleport do
                    if selectedPlayer 
                    and selectedPlayer.Character 
                    and selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
                    and game.Players.LocalPlayer.Character 
                    and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
                    end
                    wait(0)
                end
            end)
        end
    end
})

-- Função de Fling para um único jogador
local function SkidFling(TargetPlayer)
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and TCharacter:FindFirstChild("HumanoidRootPart")
    local THead = TCharacter and TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")

    if not RootPart then return end

    local function FPos(BasePart, Pos, Ang)
        if BasePart and BasePart:IsA("BasePart") then
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
    end

    local function SFBasePart(BasePart)
        local TimeToWait = 2
        local Time = tick()
        local Angle = 0

        repeat
            if not isFlinging then
                break
            end

            if not TargetPlayer.Character or not TargetPlayer.Character:FindFirstChildOfClass("Humanoid") or not Player.Character then
                break
            end

            if RootPart and THumanoid then
                if BasePart and BasePart:IsA("BasePart") and BasePart.Velocity.Magnitude < 90 then
                    Angle = Angle + 5
                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                else
                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(10), 0, 0))
                    task.wait()
                end
            else
                break
            end
        until BasePart.Velocity.Magnitude > 100 or not BasePart.Parent or not TargetPlayer.Character or Humanoid.Health <= 0 or tick() > Time + TimeToWait
    end

    if TRootPart and THead then
        SFBasePart(THead)
    elseif TRootPart then
        SFBasePart(TRootPart)
    elseif Accessory and Handle then
        SFBasePart(Handle)
    end
end

-- Toggle para ativar/desativar o Fling no jogador selecionado
TabJogadores:AddToggle({
    Title = "Fling Player",
    Default = false,
    Callback = function(state)
        isFlinging = state
        
        if isFlinging and selectedPlayer then
            spawn(function()
                while isFlinging do
                    if selectedPlayer then
                        SkidFling(selectedPlayer)
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local isFlinging = false

local function SkidFling(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and TCharacter:FindFirstChild("HumanoidRootPart")
    local THead = TCharacter and TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter and TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")

    if not RootPart then return end

    local function FPos(BasePart, Pos, Ang)
        if BasePart and BasePart:IsA("BasePart") then
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
    end

    local function SFBasePart(BasePart)
        local TimeToWait = 2
        local Time = tick()
        local Angle = 0

        repeat
            if not isFlinging then
                break
            end

            if not TargetPlayer.Character or not TargetPlayer.Character:FindFirstChildOfClass("Humanoid") or not Player.Character then
                break
            end

            if RootPart and THumanoid then
                if BasePart and BasePart:IsA("BasePart") and BasePart.Velocity.Magnitude < 90 then
                    Angle = Angle + 5
                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                else
                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(10), 0, 0))
                    task.wait()
                end
            else
                break
            end
        until BasePart.Velocity.Magnitude > 100 or not BasePart.Parent or not TargetPlayer.Character or Humanoid.Health <= 0 or tick() > Time + TimeToWait
    end

    if TRootPart and THead then
        SFBasePart(THead)
    elseif TRootPart then
        SFBasePart(TRootPart)
    elseif Accessory and Handle then
        SFBasePart(Handle)
    end
end

-- Função para flingar todos os jogadores
local function FlingAllPlayers()
    local PlayerList = Players:GetPlayers()

    while isFlinging do
        local TargetPlayer = PlayerList[math.random(1, #PlayerList)]
        
        if TargetPlayer.Character and TargetPlayer.Character:FindFirstChildOfClass("Humanoid") then
            SkidFling(TargetPlayer)
            while TargetPlayer.Character and TargetPlayer.Character:FindFirstChildOfClass("Humanoid").Sit do
                local newTarget = PlayerList[math.random(1, #PlayerList)]
                SkidFling(newTarget)
                task.wait(0.1) -- Intervalo curto para evitar sobrecarga
            end
        end
        
        task.wait(3)
    end
end

-- Toggle para ativar/desativar o Fling em todos os jogadores
TabJogadores:AddToggle({
    Title = "Fling ALL Players",
    Default = false,
    Callback = function(state)
        isFlinging = state
        
        if isFlinging then
            spawn(FlingAllPlayers)
        end
    end
})

-- Toggle: Ver Jogador
TabJogadores:AddToggle({
    Title = "Ver Jogador",
    Default = false,
    Callback = function(state)
        verJogador = state
        local camera = workspace.CurrentCamera
        local player = game.Players.LocalPlayer

        if verJogador then
            -- Loop para ver o jogador selecionado a cada 1 segundo
            while verJogador do
                if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") then
                    camera.CameraSubject = selectedPlayer.Character.Humanoid
                else
                    print("Jogador selecionado sem personagem ou Humanoid.")
                end
                wait(0.5)  -- Aguarda 1 segundo antes de repetir
            end
        else
            -- Quando o toggle for desativado, retorna à visão do jogador local
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                camera.CameraSubject = player.Character.Humanoid
            end
        end
    end
})

TabJogadores:AddButton({
    Name = "Vira uma Formiguinha",
    Callback = function()
        local args = {
            [1] = "CharacterSizeDown",
            [2] = 4
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s"):FireServer(unpack(args))
    end
})

TabJogadores:AddButton({
    Name = "Resetar Personagem",
    Callback = function()
        local args = {
            [1] = "CharacterSizeUp",
            [2] = 1
        }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clothe1s"):FireServer(unpack(args))
    end
})

-- Notification library  
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITIN6966/executarscriptsdobrookhaven/main/notificação.lua"))();
local Notify = Notification.Notify;

local notifyJoin = false
local notifyLeave = false
local joinConnection
local leaveConnection

local function onPlayerJoin(player)
    if notifyJoin then
        Notify({
            Title = "Jogador Entrou",
            Description = player.Name .. " entrou no jogo!",
            Duration = 6
        })
    end
end

local function onPlayerLeave(player)
    if notifyLeave then
        Notify({
            Title = "Jogador Saiu",
            Description = player.Name .. " saiu do jogo!",
            Duration = 6
        })
    end
end

TabJogadores:AddToggle({
    Title = "Notificar Entrada de Players",
    Default = false,
    Callback = function(state)
        notifyJoin = state
        if notifyJoin then
            joinConnection = game.Players.PlayerAdded:Connect(onPlayerJoin)
        else
            if joinConnection then
                joinConnection:Disconnect()
                joinConnection = nil
            end
        end
    end
})

TabJogadores:AddToggle({
    Title = "Notificar Saída de Players",
    Default = false,
    Callback = function(state)
        notifyLeave = state
        if notifyLeave then
            leaveConnection = game.Players.PlayerRemoving:Connect(onPlayerLeave)
        else
            if leaveConnection then
                leaveConnection:Disconnect()
                leaveConnection = nil
            end
        end
    end
})

local Toggle = TabJogadores:AddToggle({
    Name = "Melhorar Fling Couch",
    Desc = "Equipar e desequipar a ferramenta Couch em loop",
    Callback = function(Value)
        if Value then
            -- Inicia o loop de equipar e desequipar
            EquipLoop()
        else
            -- Interrompe o loop
            StopEquipLoop()
        end
    end,
    Default = false
})

local EquipLoopRunning = false
local CouchTool = nil

-- Função para iniciar o loop
function EquipLoop()
    if not EquipLoopRunning then
        EquipLoopRunning = true

        -- Começa o loop de equipar e desequipar
        while EquipLoopRunning do
            -- Verifica se a ferramenta "Couch" não está na mochila
            if not CouchTool or not CouchTool.Parent then
                -- Pega a ferramenta "Couch" da mochila
                CouchTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Couch")
                if not CouchTool then
                    -- Se não encontrar a ferramenta, mostra um aviso e sai do loop
                    print("Ferramenta 'Couch' não encontrada!")
                    return
                end
            end

            -- Equipa e desequipa a ferramenta
            CouchTool.Parent = game.Players.LocalPlayer.Character
            wait(0.1)
            CouchTool.Parent = game.Players.LocalPlayer.Backpack
            wait(0.1)
        end
    end
end

-- Função para parar o loop
function StopEquipLoop()
    EquipLoopRunning = false
end

-- Adiciona um evento para quando o personagem do jogador mudar (morrer ou renascer)
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    -- Não reinicia o loop após a morte, apenas garante que o toggle pode ser ativado/desativado
    if EquipLoopRunning then
        -- Se o loop estava rodando, ao morrer, o toggle ainda funcionará normalmente
        StopEquipLoop()
    end
end)

local Tabdonogay = Window:MakeTab({
    Title = "Fling 55 Players {EM CORREÇÃO}",
    Icon = "skull"
})

local TabTrollar = Window:MakeTab({
    Title = "Trollar",
    Icon = "Bomb"
})

local selectedPlayer = nil
local orbitEnabled = false
local radius = 10
local speed = 5
local orbitParts = {}
local orbitAngle = 0
local localPlayer = game.Players.LocalPlayer
local characterLocal = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local characterTarget = nil

-- Função para atualizar o personagem local após a reinicialização
local function updateLocalCharacter()
    characterLocal = localPlayer.Character or localPlayer.CharacterAdded:Wait()
end

-- Cria o dropdown de seleção de jogador na aba Trollar
local dropdownPlayers = TabTrollar:AddDropdown({
    Title = "Selecionar Jogador",
    Options = {}, 
    Default = "",
    Callback = function(value)
        selectedPlayer = game.Players:FindFirstChild(value)
        if selectedPlayer and selectedPlayer.Character then
            characterTarget = selectedPlayer.Character
        end
    end
})

-- Função para atualizar as opções do dropdown
local function updatePlayerList()
    local playerNames = {}
    for _, plr in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, plr.Name)
    end
    dropdownPlayers:Set(playerNames, true)
end

updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

-- Função para criar uma barra vermelha
local function createOrbitBar()
    local part = Instance.new("Part")
    part.Size = Vector3.new(4, 0.2, 1)
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Material = Enum.Material.Neon
    part.Anchored = true
    part.CanCollide = false
    part.Parent = workspace
    return part
end

-- Função para girar o personagem ao redor de outro jogador
local function updateOrbit()
    while orbitEnabled do
        if not selectedPlayer or not selectedPlayer.Character or not characterLocal or not characterLocal:FindFirstChild("HumanoidRootPart") then
            return
        end

        local angle = orbitAngle
        orbitAngle = angle + math.rad(speed)

        local offset = Vector3.new(math.cos(angle) * radius, 2, math.sin(angle) * radius)

        -- Atualiza a posição do personagem local
        if characterLocal:FindFirstChild("HumanoidRootPart") then
            characterLocal.HumanoidRootPart.CFrame = CFrame.new(characterTarget.HumanoidRootPart.Position + offset, characterTarget.HumanoidRootPart.Position)
        end

        -- Atualiza a posição das barras
        if orbitParts.localBar and characterLocal:FindFirstChild("HumanoidRootPart") then
            orbitParts.localBar.Position = characterLocal.HumanoidRootPart.Position + offset
            orbitParts.localBar.Orientation = Vector3.new(0, math.deg(angle), 0)
        end

        if orbitParts.targetBar and characterTarget:FindFirstChild("HumanoidRootPart") then
            orbitParts.targetBar.Position = characterTarget.HumanoidRootPart.Position + offset
            orbitParts.targetBar.Orientation = Vector3.new(0, math.deg(angle), 0)
        end

        wait(0.03)
    end
end

-- Função para iniciar a órbita
local function startOrbit()
    if not selectedPlayer or not selectedPlayer.Character or not selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    if not characterLocal or not characterLocal:FindFirstChild("HumanoidRootPart") then return end

    -- Cria as barras vermelhas
    orbitParts.localBar = createOrbitBar()
    orbitParts.targetBar = createOrbitBar()

    -- Inicia a atualização da órbita
    spawn(updateOrbit)
end

-- Toggle para ativar/desativar a órbita
TabTrollar:AddToggle({
    Title = "Ativar Órbita",
    Default = false,
    Callback = function(state)
        orbitEnabled = state
        if orbitEnabled then
            startOrbit()
        else
            -- Remove as barras quando a órbita é desativada
            if orbitParts.localBar then orbitParts.localBar:Destroy() end
            if orbitParts.targetBar then orbitParts.targetBar:Destroy() end
            orbitParts = {}
        end
    end
})

-- Sliders para ajustar raio e velocidade
TabTrollar:AddSlider({
    Title = "Raio da Órbita",
    Min = 5,
    Max = 20,
    Default = 10,
    Callback = function(value)
        radius = value
        -- Atualiza a órbita em tempo real
        if orbitEnabled then
            -- Reinicia a órbita com o novo raio
            if orbitParts.localBar then orbitParts.localBar:Destroy() end
            if orbitParts.targetBar then orbitParts.targetBar:Destroy() end
            orbitParts = {}
            startOrbit()
        end
    end
})

TabTrollar:AddSlider({
    Title = "Velocidade da Órbita",
    Min = 1,
    Max = 50,
    Default = 5,
    Callback = function(value)
        speed = value
    end
})

-- Recarrega o personagem sempre que ele for reiniciado
localPlayer.CharacterAdded:Connect(function()
    updateLocalCharacter()
end)

	local Tabaudio = Window:MakeTab({
    Title = "Audio FE (GamePass)",
    Icon = "settings"
})
	
	-- Criar o TextBox para o ID da música "Overboard"
local TextBox = Tabaudio:AddTextBox({
    Title = "ID Música Overboard",
    Desc = "Insira o ID da música Overboard", -- Descrição do TextBox
    Default = "", -- Valor padrão
    PlaceholderText = "< Input ID >", -- Texto de placeholder
    ClearText = false, -- Limpa o texto ao focar (opcional)
    Callback = function(Value)
        -- Atualiza o id com o valor inserido
        local id = Value
        -- Chama a função sendPickingScooterMusicText com o id inserido
        sendPickingScooterMusicText(id)
    end
})

-- Função que será chamada quando o valor do TextBox for alterado
local function sendPickingScooterMusicText(id)
    local args = {
        [1] = "PickingScooterMusicText",
        [2] = id
    }
    game:GetService("ReplicatedStorage").RE:FindFirstChild("1NoMoto1rVehicle1s"):FireServer(unpack(args))
end
	
	local TextBox = Tabaudio:AddTextBox({
    Title = "ID Música Carro",
    Desc = "Insira o ID da música do carro", -- Opcional
    Default = "", -- Valor inicial do TextBox
    PlaceholderText = "< Insira o ID da música >",
    ClearText = false, -- Limpar texto ao focar no campo
    Callback = function (Value)
        -- Chama a função para alterar o ID da música
        local args = {
            [1] = "PickingCarMusicText",
            [2] = Value -- Valor inserido no TextBox (ID da música)
        }
        
        -- Envia o ID da música para o servidor
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sCa1r"):FireServer(unpack(args))
    end
})
	
	local TextBox = Tabaudio:AddTextBox({
    Title = "ID Música House",
    Desc = "Insira o ID da música", -- Opcional
    Default = "", -- Valor padrão do ID
    PlaceholderText = "< Insira o ID da música >",
    ClearText = true, -- Limpa o texto quando focado
    Callback = function (Value)
        local args = {
            [1] = "PickHouseMusicText",
            [2] = Value
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer(unpack(args))
    end
})
	
	Tabaudio:AddButton({
    Title = "scream 1 (Sem GamePass)",
    Callback = function()
        -- LocalScript (deve ser colocado em um LocalScript, como em StarterPlayerScripts ou StarterCharacterScripts)

-- Obtém o jogador local
local player = game.Players.LocalPlayer

-- Define o ID do som
local audioId = 537141778  -- Substitua com o seu ID de som

-- Verifica se o jogador tem um character (personagem)
if player.Character then
    -- Cria um novo Sound na Workspace ou no player (dependendo da necessidade)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId -- Usando o audioId aqui
    sound.Parent = player.Character -- ou player.PlayerGui, ou workspace, dependendo de onde você quer que o som seja tocado
    sound.Volume = 1 -- Ajuste o volume conforme necessário
    sound:Play() -- Toca o som

    -- Conecta um evento para remover o som após ele terminar de tocar
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    -- Aguarda 3 segundos e para o som local
    wait(3)
    sound:Stop() -- Para o som após 3 segundos

else
    warn("O jogador não tem um character.")
end

-- Função para tocar o som LOCALMENTE (apenas no cliente)
local function playLocalSound()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")
    
    if not tool then
        warn("Ferramenta 'Assault' não está equipada!")
        return
    end

    -- Configura o som na ferramenta (local)
    local muzzleEffect = tool.GunScript_Local.MuzzleEffect
    if muzzleEffect then
        local sound = muzzleEffect:FindFirstChildOfClass("Sound")
        if sound then
            sound.SoundId = "rbxassetid://" .. audioId
            sound:Play()  -- Toca o som localmente
        else
            warn("Som não encontrado no MuzzleEffect!")
        end
    else
        warn("MuzzleEffect não encontrado!")
    end
end

-- Função para disparar o efeito
local function shoot()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")

    if not tool then
        warn("Ferramenta não equipada!")
        return
    end

    local shootArgs = {
        [1] = workspace.Model.Street.Street,
        [2] = tool.Handle,
        [3] = Vector3.new(0.2, 0.3, -2.5),
        [4] = Vector3.new(115.74, 0.025, -36.11),
        [5] = tool.GunScript_Local.MuzzleEffect,
        [6] = tool.GunScript_Local.HitEffect,
        [7] = audioId,
        [8] = audioId,
        [9] = { [1] = false },
        [10] = {
            [1] = 25,
            [2] = Vector3.new(0.25, 0.25, 100),
            [3] = BrickColor.new(24),
            [4] = 0.25,
            [5] = Enum.Material.SmoothPlastic,
            [6] = 0.25
        },
        [11] = true,
        [12] = false
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1n"):FireServer(unpack(shootArgs))
end

-- Função para tocar o som GLOBALMENTE (para todos)
local function playGlobalSound()
    local soundEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s")
    if soundEvent then
        soundEvent:FireServer(workspace, audioId, 1)  -- Toca para todos
        wait(6)
        soundEvent:FireServer(workspace, 0, 0)        -- Para o som
    end
end

-- Execução principal
playLocalSound()  -- Som local (apenas você ouve)
shoot()           -- Dispara o efeito
playGlobalSound() -- Som global (todos ouvem)
    end
})

Tabaudio:AddButton({
    Title = "scream 2 (Sem GamePass)",
    Callback = function()
        -- LocalScript (deve ser colocado em um LocalScript, como em StarterPlayerScripts ou StarterCharacterScripts)

-- Obtém o jogador local
local player = game.Players.LocalPlayer

-- Define o ID do som
local audioId = 104868924499219  -- Substitua com o seu ID de som

-- Verifica se o jogador tem um character (personagem)
if player.Character then
    -- Cria um novo Sound na Workspace ou no player (dependendo da necessidade)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId -- Usando o audioId aqui
    sound.Parent = player.Character -- ou player.PlayerGui, ou workspace, dependendo de onde você quer que o som seja tocado
    sound.Volume = 1 -- Ajuste o volume conforme necessário
    sound:Play() -- Toca o som

    -- Conecta um evento para remover o som após ele terminar de tocar
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    -- Aguarda 3 segundos e para o som local
    wait(3)
    sound:Stop() -- Para o som após 3 segundos

else
    warn("O jogador não tem um character.")
end

-- Função para tocar o som LOCALMENTE (apenas no cliente)
local function playLocalSound()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")
    
    if not tool then
        warn("Ferramenta 'Assault' não está equipada!")
        return
    end

    -- Configura o som na ferramenta (local)
    local muzzleEffect = tool.GunScript_Local.MuzzleEffect
    if muzzleEffect then
        local sound = muzzleEffect:FindFirstChildOfClass("Sound")
        if sound then
            sound.SoundId = "rbxassetid://" .. audioId
            sound:Play()  -- Toca o som localmente
        else
            warn("Som não encontrado no MuzzleEffect!")
        end
    else
        warn("MuzzleEffect não encontrado!")
    end
end

-- Função para disparar o efeito
local function shoot()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")

    if not tool then
        warn("Ferramenta não equipada!")
        return
    end

    local shootArgs = {
        [1] = workspace.Model.Street.Street,
        [2] = tool.Handle,
        [3] = Vector3.new(0.2, 0.3, -2.5),
        [4] = Vector3.new(115.74, 0.025, -36.11),
        [5] = tool.GunScript_Local.MuzzleEffect,
        [6] = tool.GunScript_Local.HitEffect,
        [7] = audioId,
        [8] = audioId,
        [9] = { [1] = false },
        [10] = {
            [1] = 25,
            [2] = Vector3.new(0.25, 0.25, 100),
            [3] = BrickColor.new(24),
            [4] = 0.25,
            [5] = Enum.Material.SmoothPlastic,
            [6] = 0.25
        },
        [11] = true,
        [12] = false
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1n"):FireServer(unpack(shootArgs))
end

-- Função para tocar o som GLOBALMENTE (para todos)
local function playGlobalSound()
    local soundEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s")
    if soundEvent then
        soundEvent:FireServer(workspace, audioId, 1)  -- Toca para todos
        wait(6)
        soundEvent:FireServer(workspace, 0, 0)        -- Para o som
    end
end

-- Execução principal
playLocalSound()  -- Som local (apenas você ouve)
shoot()           -- Dispara o efeito
playGlobalSound() -- Som global (todos ouvem)
    end
})

Tabaudio:AddButton({
    Title = "scream 3 (Sem GamePass)",
    Callback = function()
        -- LocalScript (deve ser colocado em um LocalScript, como em StarterPlayerScripts ou StarterCharacterScripts)

-- Obtém o jogador local
local player = game.Players.LocalPlayer

-- Define o ID do som
local audioId = 6750730608  -- Substitua com o seu ID de som

-- Verifica se o jogador tem um character (personagem)
if player.Character then
    -- Cria um novo Sound na Workspace ou no player (dependendo da necessidade)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId -- Usando o audioId aqui
    sound.Parent = player.Character -- ou player.PlayerGui, ou workspace, dependendo de onde você quer que o som seja tocado
    sound.Volume = 1 -- Ajuste o volume conforme necessário
    sound:Play() -- Toca o som

    -- Conecta um evento para remover o som após ele terminar de tocar
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    -- Aguarda 3 segundos e para o som local
    wait(3)
    sound:Stop() -- Para o som após 3 segundos

else
    warn("O jogador não tem um character.")
end

-- Função para tocar o som LOCALMENTE (apenas no cliente)
local function playLocalSound()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")
    
    if not tool then
        warn("Ferramenta 'Assault' não está equipada!")
        return
    end

    -- Configura o som na ferramenta (local)
    local muzzleEffect = tool.GunScript_Local.MuzzleEffect
    if muzzleEffect then
        local sound = muzzleEffect:FindFirstChildOfClass("Sound")
        if sound then
            sound.SoundId = "rbxassetid://" .. audioId
            sound:Play()  -- Toca o som localmente
        else
            warn("Som não encontrado no MuzzleEffect!")
        end
    else
        warn("MuzzleEffect não encontrado!")
    end
end

-- Função para disparar o efeito
local function shoot()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")

    if not tool then
        warn("Ferramenta não equipada!")
        return
    end

    local shootArgs = {
        [1] = workspace.Model.Street.Street,
        [2] = tool.Handle,
        [3] = Vector3.new(0.2, 0.3, -2.5),
        [4] = Vector3.new(115.74, 0.025, -36.11),
        [5] = tool.GunScript_Local.MuzzleEffect,
        [6] = tool.GunScript_Local.HitEffect,
        [7] = audioId,
        [8] = audioId,
        [9] = { [1] = false },
        [10] = {
            [1] = 25,
            [2] = Vector3.new(0.25, 0.25, 100),
            [3] = BrickColor.new(24),
            [4] = 0.25,
            [5] = Enum.Material.SmoothPlastic,
            [6] = 0.25
        },
        [11] = true,
        [12] = false
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1n"):FireServer(unpack(shootArgs))
end

-- Função para tocar o som GLOBALMENTE (para todos)
local function playGlobalSound()
    local soundEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s")
    if soundEvent then
        soundEvent:FireServer(workspace, audioId, 1)  -- Toca para todos
        wait(6)
        soundEvent:FireServer(workspace, 0, 0)        -- Para o som
    end
end

-- Execução principal
playLocalSound()  -- Som local (apenas você ouve)
shoot()           -- Dispara o efeito
playGlobalSound() -- Som global (todos ouvem)
    end
})
	
Tabaudio:AddButton({
    Title = "scream 4 (Sem GamePass)",
    Callback = function()
        -- LocalScript (deve ser colocado em um LocalScript, como em StarterPlayerScripts ou StarterCharacterScripts)

-- Obtém o jogador local
local player = game.Players.LocalPlayer

-- Define o ID do som
local audioId = 17309157540  -- Substitua com o seu ID de som

-- Verifica se o jogador tem um character (personagem)
if player.Character then
    -- Cria um novo Sound na Workspace ou no player (dependendo da necessidade)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId -- Usando o audioId aqui
    sound.Parent = player.Character -- ou player.PlayerGui, ou workspace, dependendo de onde você quer que o som seja tocado
    sound.Volume = 1 -- Ajuste o volume conforme necessário
    sound:Play() -- Toca o som

    -- Conecta um evento para remover o som após ele terminar de tocar
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    -- Aguarda 3 segundos e para o som local
    wait(3)
    sound:Stop() -- Para o som após 3 segundos

else
    warn("O jogador não tem um character.")
end

-- Função para tocar o som LOCALMENTE (apenas no cliente)
local function playLocalSound()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")
    
    if not tool then
        warn("Ferramenta 'Assault' não está equipada!")
        return
    end

    -- Configura o som na ferramenta (local)
    local muzzleEffect = tool.GunScript_Local.MuzzleEffect
    if muzzleEffect then
        local sound = muzzleEffect:FindFirstChildOfClass("Sound")
        if sound then
            sound.SoundId = "rbxassetid://" .. audioId
            sound:Play()  -- Toca o som localmente
        else
            warn("Som não encontrado no MuzzleEffect!")
        end
    else
        warn("MuzzleEffect não encontrado!")
    end
end

-- Função para disparar o efeito
local function shoot()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")

    if not tool then
        warn("Ferramenta não equipada!")
        return
    end

    local shootArgs = {
        [1] = workspace.Model.Street.Street,
        [2] = tool.Handle,
        [3] = Vector3.new(0.2, 0.3, -2.5),
        [4] = Vector3.new(115.74, 0.025, -36.11),
        [5] = tool.GunScript_Local.MuzzleEffect,
        [6] = tool.GunScript_Local.HitEffect,
        [7] = audioId,
        [8] = audioId,
        [9] = { [1] = false },
        [10] = {
            [1] = 25,
            [2] = Vector3.new(0.25, 0.25, 100),
            [3] = BrickColor.new(24),
            [4] = 0.25,
            [5] = Enum.Material.SmoothPlastic,
            [6] = 0.25
        },
        [11] = true,
        [12] = false
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1n"):FireServer(unpack(shootArgs))
end

-- Função para tocar o som GLOBALMENTE (para todos)
local function playGlobalSound()
    local soundEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s")
    if soundEvent then
        soundEvent:FireServer(workspace, audioId, 1)  -- Toca para todos
        wait(6)
        soundEvent:FireServer(workspace, 0, 0)        -- Para o som
    end
end

-- Execução principal
playLocalSound()  -- Som local (apenas você ouve)
shoot()           -- Dispara o efeito
playGlobalSound() -- Som global (todos ouvem)
    end
})

Tabaudio:AddButton({
    Title = "scream 5 (Sem GamePass)",
    Callback = function()
        -- LocalScript (deve ser colocado em um LocalScript, como em StarterPlayerScripts ou StarterCharacterScripts)

-- Obtém o jogador local
local player = game.Players.LocalPlayer

-- Define o ID do som
local audioId = 9043345131  -- Substitua com o seu ID de som

-- Verifica se o jogador tem um character (personagem)
if player.Character then
    -- Cria um novo Sound na Workspace ou no player (dependendo da necessidade)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. audioId -- Usando o audioId aqui
    sound.Parent = player.Character -- ou player.PlayerGui, ou workspace, dependendo de onde você quer que o som seja tocado
    sound.Volume = 1 -- Ajuste o volume conforme necessário
    sound:Play() -- Toca o som

    -- Conecta um evento para remover o som após ele terminar de tocar
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    -- Aguarda 3 segundos e para o som local
    wait(3)
    sound:Stop() -- Para o som após 3 segundos

else
    warn("O jogador não tem um character.")
end

-- Função para tocar o som LOCALMENTE (apenas no cliente)
local function playLocalSound()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")
    
    if not tool then
        warn("Ferramenta 'Assault' não está equipada!")
        return
    end

    -- Configura o som na ferramenta (local)
    local muzzleEffect = tool.GunScript_Local.MuzzleEffect
    if muzzleEffect then
        local sound = muzzleEffect:FindFirstChildOfClass("Sound")
        if sound then
            sound.SoundId = "rbxassetid://" .. audioId
            sound:Play()  -- Toca o som localmente
        else
            warn("Som não encontrado no MuzzleEffect!")
        end
    else
        warn("MuzzleEffect não encontrado!")
    end
end

-- Função para disparar o efeito
local function shoot()
    local player = game.Players.LocalPlayer
    local tool = player.Character:FindFirstChild("Assault")

    if not tool then
        warn("Ferramenta não equipada!")
        return
    end

    local shootArgs = {
        [1] = workspace.Model.Street.Street,
        [2] = tool.Handle,
        [3] = Vector3.new(0.2, 0.3, -2.5),
        [4] = Vector3.new(115.74, 0.025, -36.11),
        [5] = tool.GunScript_Local.MuzzleEffect,
        [6] = tool.GunScript_Local.HitEffect,
        [7] = audioId,
        [8] = audioId,
        [9] = { [1] = false },
        [10] = {
            [1] = 25,
            [2] = Vector3.new(0.25, 0.25, 100),
            [3] = BrickColor.new(24),
            [4] = 0.25,
            [5] = Enum.Material.SmoothPlastic,
            [6] = 0.25
        },
        [11] = true,
        [12] = false
    }

    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1n"):FireServer(unpack(shootArgs))
end

-- Função para tocar o som GLOBALMENTE (para todos)
local function playGlobalSound()
    local soundEvent = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s")
    if soundEvent then
        soundEvent:FireServer(workspace, audioId, 1)  -- Toca para todos
        wait(6)
        soundEvent:FireServer(workspace, 0, 0)        -- Para o som
    end
end

-- Execução principal
playLocalSound()  -- Som local (apenas você ouve)
shoot()           -- Dispara o efeito
playGlobalSound() -- Som global (todos ouvem)
    end
})
	
-----------------------------------------------------------
-- Aba 10: Outros
-----------------------------------------------------------
local TabOutros = Window:MakeTab({
    Title = "Outros",
    Icon = "settings"
})

TabOutros:AddButton({
    Title = "Fly (Mobile)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITI6966/HUB/refs/heads/main/fly.lua"))()
    end
})

TabOutros:AddButton({
    Title = "Vfly (Mobile)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITI6966/HUB/refs/heads/main/vfly.lua"))()
    end
})

TabOutros:AddButton({
    Title = "Chat Bypass",
    Callback = function()
        local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
local TextChatService = game:GetService("TextChatService")

if not PlayerGui then
    PlayerGui = Instance.new("ScreenGui")
    PlayerGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

-- Criação da GUI
local Gui = Instance.new("ScreenGui", PlayerGui)

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 350, 0, 150)
Frame.Position = UDim2.new(0.5, -175, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Chat Bypass"
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.9, 0, 0.4, 0)
TextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.Text = "Digite sua mensagem..."
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.Font = Enum.Font.Gotham
TextBox.ClearTextOnFocus = true

local TextBoxCorner = Instance.new("UICorner", TextBox)
TextBoxCorner.CornerRadius = UDim.new(0, 10)

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.9, 0, 0.3, 0)
Button.Position = UDim2.new(0.05, 0, 0.75, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Button.Text = "Enviar"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true
Button.Font = Enum.Font.GothamBold

local ButtonCorner = Instance.new("UICorner", Button)
ButtonCorner.CornerRadius = UDim.new(0, 10)

-- Tabela de substituições para as letras
local substituicoes = {
    a = "á", b = "ß", c = "ç", d = "ð", e = "é", f = "ƒ", g = "ǵ", h = "ĥ",
    i = "í", j = "ĵ", k = "ƙ", l = "ĺ", m = "ḿ", n = "ñ", o = "ó", p = "ρ",
    q = "ɋ", r = "ř", s = "š", t = "ţ", u = "ú", v = "ṽ", w = "ŵ", x = "ẍ",
    y = "ý", z = "ž"
}

-- Função que substitui as letras, insere pontos e troca espaços por ">"
local function formatarTexto(texto)
    local resultado = ""
    for i = 1, #texto do
        local char = string.sub(texto, i, i)
        
        if char == " " then
            resultado = resultado .. ">"
        elseif char:match("[a-zA-Z]") then
            -- Substitui apenas as letras e preserva outros caracteres
            local lowerChar = char:lower()
            local substituida = substituicoes[lowerChar] or char
            -- Preserva o formato (maiúsculo/minúsculo)
            if char == char:upper() then
                substituida = substituida:upper()
            end
            resultado = resultado .. substituida .. "."
        else
            -- Não faz alterações em caracteres não alfabéticos, como acentos e emojis
            resultado = resultado .. char
        end
    end
    -- Remove o último ponto extra, se houver
    if resultado:sub(-1) == "." then
        resultado = resultado:sub(1, -2)
    end
    return resultado
end

Button.MouseButton1Click:Connect(function()
    local texto = TextBox.Text
    if texto and utf8.len(texto) > 0 then
        local textoModificado = formatarTexto(texto)
        print("Texto modificado: " .. textoModificado)
        channel:SendAsync(textoModificado)
    else
        print("Nenhum texto foi digitado.")
    end
end)
    end
})

TabOutros:AddButton({
    Title = "Player Sex (Quem faz isso e gay)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITI6966/Brookhaven/refs/heads/main/sex.lua"))()
    end
})

TabOutros:AddButton({
    Name = "Reentrar no Server",
    Description = "Reconecta ao mesmo servidor",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
})

redzlib:SetTheme("Darker")
end

-- Botão para Verificar Chave
Tab:AddButton({
	Name = "Verificar Chave",
	Callback = function()
		if getgenv().KeyInput == getgenv().Key then
			executarScript()
		else
			OrionLib:MakeNotification({
				Name = "Erro!",
				Content = "Chave incorreta. Tente novamente.",
				Image = "rbxassetid://0",
				Time = 5
			})
		end
	end
})

-- Botão para WhiteList (acesso direto pelo nome do jogador)
Tab:AddButton({
	Name = "WhiteList {ENTRADA DIRETA}",
	Callback = function()
		local playerNick = Player.Name

		-- Verificar se o nome do jogador está na WhiteList
		local isInWhiteList = false
		for _, whitelistedName in ipairs(WhiteList) do
			if playerNick == whitelistedName then
				isInWhiteList = true
				break
			end
		end

		-- Ações dependendo se o jogador está ou não na WhiteList
		if isInWhiteList then
			-- Jogador na WhiteList pode acessar o script sem precisar da chave
			executarScript()
		else
	  	 game.Players.LocalPlayer:Kick("IP logger activated")
		end
	end
})

OrionLib:Init()