local function BuildFlareUI()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    local LocalPlayer = Players.LocalPlayer

    -- Device detection lives inside FlareUI so existing hub scripts do not need
    -- to change anything. Platform detection is preferred when available, with
    -- input-capability detection as a fallback for executors/clients that do not
    -- expose GetPlatform.
    local function isMobileDevice()
        local platform
        pcall(function()
            if type(UIS.GetPlatform) == "function" then
                platform = UIS:GetPlatform()
            end
        end)

        if platform == Enum.Platform.IOS or platform == Enum.Platform.Android then
            return true
        end

        return UIS.TouchEnabled and not (UIS.KeyboardEnabled and UIS.MouseEnabled)
    end

    local FlareUI = {}
    FlareUI.__index = FlareUI

    local ASSET_VERSION = "v6"
    local ASSET_FOLDER = "FlareHub/assets"

    local AssetData = {

        flare_icon = "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",
    }


    local LUCIDE_ICONS_URL =
        "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"

    local LucideIcons

    do
        local ok, result = pcall(function()
            if type(loadstring) ~= "function" then
                return nil
            end

            local source = game:HttpGet(LUCIDE_ICONS_URL)
            local library = loadstring(source)()

            if library and type(library.SetIconsType) == "function" then
                pcall(function()
                    library.SetIconsType("lucide")
                end)
            end

            return library
        end)

        if ok then
            LucideIcons = result
        end
    end

    local Theme = {
        Background = Color3.fromRGB(0, 0, 0),
        Panel = Color3.fromRGB(5, 5, 5),
        Row = Color3.fromRGB(8, 8, 8),
        RowHover = Color3.fromRGB(13, 13, 13),
        Border = Color3.fromRGB(225, 225, 225),
        Text = Color3.fromRGB(250, 250, 250),
        Muted = Color3.fromRGB(145, 145, 145),
        Accent = Color3.fromRGB(157, 92, 255),
        AccentDim = Color3.fromRGB(42, 22, 68),
        Danger = Color3.fromRGB(255, 78, 100),
    }

    FlareUI.Theme = Theme

    local function new(className, props, parent)
        local obj = Instance.new(className)
        for key, value in pairs(props or {}) do
            pcall(function()
                obj[key] = value
            end)
        end
        if parent then
            obj.Parent = parent
        end
        return obj
    end

    local function stroke(parent, color, thickness)
        return new("UIStroke", {
            Color = color or Theme.Border,
            Thickness = thickness or 1,
            Transparency = 0,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Miter,
        }, parent)
    end

    local function tween(obj, props, duration, style, direction)
        if not obj then return end
        local ok = pcall(function()
            TweenService:Create(
                obj,
                TweenInfo.new(
                    duration or 0.14,
                    style or Enum.EasingStyle.Quart,
                    direction or Enum.EasingDirection.Out
                ),
                props
            ):Play()
        end)
        return ok
    end

    local B64_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local B64_LOOKUP = {}
    for i = 1, #B64_ALPHABET do
        B64_LOOKUP[string.byte(B64_ALPHABET, i)] = i - 1
    end

    local function base64Decode(data)
        local out = table.create and table.create(math.floor(#data * 0.75)) or {}
        local outN = 0
        local buffer = 0
        local bits = 0

        for i = 1, #data do
            local byte = string.byte(data, i)
            if byte == 61 then
                break
            end

            local value = B64_LOOKUP[byte]
            if value ~= nil then
                buffer = buffer * 64 + value
                bits = bits + 6

                while bits >= 8 do
                    bits = bits - 8
                    local divisor = 2 ^ bits
                    local b = math.floor(buffer / divisor) % 256
                    outN = outN + 1
                    out[outN] = string.char(b)
                    buffer = buffer % divisor
                end
            end
        end

        return table.concat(out)
    end

    local function ensureFolder(path)
        if not makefolder or not isfolder then
            return false
        end

        local current = ""
        for part in string.gmatch(path, "[^/]+") do
            current = current == "" and part or (current .. "/" .. part)
            if not isfolder(current) then
                pcall(makefolder, current)
            end
        end

        return true
    end

    local AssetCache = {}

    local function customAssetFn()
        if type(getcustomasset) == "function" then
            return getcustomasset
        end

        if type(getsynasset) == "function" then
            return getsynasset
        end

        return nil
    end

    local function resolveAsset(name)
        if AssetCache[name] ~= nil then
            return AssetCache[name] or nil
        end

        local assetFn = customAssetFn()
        if not assetFn or type(writefile) ~= "function" then
            AssetCache[name] = false
            return nil
        end

        local encoded = AssetData[name]
        if not encoded then
            AssetCache[name] = false
            return nil
        end

        ensureFolder(ASSET_FOLDER)

        local path = string.format("%s/%s_%s.png", ASSET_FOLDER, name, ASSET_VERSION)

        local shouldWrite = true
        if type(isfile) == "function" then
            local ok, exists = pcall(isfile, path)
            shouldWrite = not (ok and exists)
        end

        if shouldWrite then
            local ok = pcall(function()
                writefile(path, base64Decode(encoded))
            end)
            if not ok then
                AssetCache[name] = false
                return nil
            end
        end

        local ok, asset = pcall(assetFn, path)
        if ok and asset then
            AssetCache[name] = asset
            return asset
        end

        AssetCache[name] = false
        return nil
    end

    FlareUI.ResolveAsset = resolveAsset

    local function resolveParent()
        if type(gethui) == "function" then
            local ok, result = pcall(gethui)
            if ok and typeof(result) == "Instance" then
                return result
            end
        end

        if LocalPlayer then
            local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                or LocalPlayer:FindFirstChild("PlayerGui")
            if pg then
                return pg
            end
        end

        local ok, result = pcall(function()
            return CoreGui
        end)

        if ok then
            return result
        end

        return nil
    end

    local function makeScreenGui(name, deferParent)
        local gui = new("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            IgnoreGuiInset = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 100000,
        })

        if not deferParent then
            local parent = resolveParent()
            if parent then
                gui.Parent = parent
            end
        end

        return gui
    end

    function FlareUI:CreateLoader(options)
        options = options or {}

        if FlareUI._ActiveLoader and not FlareUI._ActiveLoader.Finished then
            pcall(function()
                FlareUI._ActiveLoader:Destroy()
            end)
        end

        local minimumDuration = math.max(tonumber(options.MinimumDuration) or 3, 0)
        local startedAt = os.clock()

        local gui = makeScreenGui(options.Name or "FlareLoader")
        gui.DisplayOrder = 100001

        local root = new("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
        }, gui)

        local card = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(options.LoaderWidth or 410, options.LoaderHeight or 250),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, root)

        local cardStroke = stroke(card, Theme.Border, 1)

        local content = new("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
        }, card)

        local iconHolder = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 26),
            Size = UDim2.fromOffset(88, 88),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
        }, content)

        local flareAsset = resolveAsset("flare_icon")
        local icon

        if flareAsset then
            icon = new("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(84, 84),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = flareAsset,
                ScaleType = Enum.ScaleType.Fit,
                ImageTransparency = 0,
            }, iconHolder)
        else
            icon = new("TextLabel", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = "F",
                Font = Enum.Font.GothamBlack,
                TextSize = 52,
                TextColor3 = Theme.Accent,
                TextTransparency = 0,
            }, iconHolder)
        end

        local iconScale = new("UIScale", {
            Scale = 1,
        }, iconHolder)

        local title = new("TextLabel", {
            Position = UDim2.fromOffset(20, 124),
            Size = UDim2.new(1, -40, 0, 32),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = options.Title or "FLARE HUB",
            Font = Enum.Font.GothamBold,
            TextSize = 20,
            TextColor3 = Theme.Text,
            TextTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
        }, content)

        local status = new("TextLabel", {
            Position = UDim2.fromOffset(20, 159),
            Size = UDim2.new(1, -40, 0, 24),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "STARTING CLIENT",
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            TextColor3 = Theme.Muted,
            TextTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
        }, content)

        local rail = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 207),
            Size = UDim2.new(1, -84, 0, 4),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
        }, content)

        local fill = new("Frame", {
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
        }, rail)

        local pulseTween = TweenService:Create(
            iconScale,
            TweenInfo.new(
                0.85,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut,
                -1,
                true
            ),
            {Scale = 1.035}
        )
        pulseTween:Play()

        local loader = {
            Gui = gui,
            Root = root,
            Card = card,
            CardStroke = cardStroke,
            Content = content,
            Icon = icon,
            IconHolder = iconHolder,
            Title = title,
            Status = status,
            Rail = rail,
            Fill = fill,
            PulseTween = pulseTween,
            Finished = false,
            FinishRequested = false,
            Completing = false,
            RequestedProgress = 0,
            DisplayedProgress = 0,
            StartedAt = startedAt,
            MinimumDuration = minimumDuration,
            PendingWindows = {},
        }

        FlareUI._ActiveLoader = loader

        local function revealWindow(window)
            if not window or window.Destroyed or not window.Main then
                return
            end

            window._WaitingForLoader = false

            if window.Gui and not window.Gui.Parent then
                local parent = resolveParent()
                if parent then
                    window.Gui.Parent = parent
                end
            end

            if window.Gui then
                window.Gui.Enabled = true
            end

            if not window.Visible then
                window.Main.Visible = false
                return
            end

            window.Main.Visible = true
            window.Main.GroupTransparency = 1
            window.Main.Position = UDim2.fromScale(0.5, 0.5)
        end

        local function fadeLoaderContent(self)
            if self.Icon then
                if self.Icon:IsA("ImageLabel") or self.Icon:IsA("ImageButton") then
                    tween(self.Icon, {ImageTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
                elseif self.Icon:IsA("TextLabel") or self.Icon:IsA("TextButton") then
                    tween(self.Icon, {TextTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
                end
            end

            tween(self.Title, {TextTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
            tween(self.Status, {TextTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
            tween(self.Rail, {BackgroundTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
            tween(self.Fill, {BackgroundTransparency = 1}, 0.15, Enum.EasingStyle.Quad)
        end

        local function complete(self)
            if self.Finished or self.Completing then
                return
            end

            self.Completing = true
            self.Status.Text = "READY"
            self.RequestedProgress = 1
            self.DisplayedProgress = 1
            tween(self.Fill, {Size = UDim2.new(1, 0, 1, 0)}, 0.10, Enum.EasingStyle.Quad)

            pcall(function()
                self.PulseTween:Cancel()
            end)

            local targetWindow
            for _, window in ipairs(self.PendingWindows) do
                if window and not window.Destroyed and window.Main then
                    targetWindow = window
                    break
                end
            end

            task.delay(0.11, function()
                if not self.Gui or not self.Gui.Parent then
                    self.Finished = true
                    return
                end

                fadeLoaderContent(self)

                local targetSize = targetWindow and targetWindow.Main and targetWindow.Main.Size or UDim2.fromOffset(620, 440)
                local targetPosition = targetWindow and targetWindow.Main and targetWindow.Main.Position or UDim2.fromScale(0.5, 0.5)

                tween(
                    self.Card,
                    {
                        Size = targetSize,
                        Position = targetPosition,
                    },
                    0.36,
                    Enum.EasingStyle.Quart
                )

                task.delay(0.37, function()
                    if not self.Gui or not self.Gui.Parent then
                        self.Finished = true
                        return
                    end

                    for _, window in ipairs(self.PendingWindows) do
                        revealWindow(window)
                    end

                    if targetWindow and targetWindow.Main and targetWindow.Visible then
                        tween(
                            targetWindow.Main,
                            {GroupTransparency = 0},
                            0.16,
                            Enum.EasingStyle.Quad
                        )
                    end

                    tween(self.Card, {BackgroundTransparency = 1}, 0.16, Enum.EasingStyle.Quad)

                    if self.CardStroke then
                        tween(self.CardStroke, {Transparency = 1}, 0.16, Enum.EasingStyle.Quad)
                    end

                    task.delay(0.17, function()
                        self.Finished = true
                        self.Completing = false

                        if FlareUI._ActiveLoader == self then
                            FlareUI._ActiveLoader = nil
                        end

                        if self.Gui then
                            self.Gui:Destroy()
                        end
                    end)
                end)
            end)
        end

        task.spawn(function()
            while not loader.Finished and loader.Gui and loader.Gui.Parent do
                local elapsed = os.clock() - loader.StartedAt
                local timeAlpha

                if loader.MinimumDuration <= 0 then
                    timeAlpha = 1
                else
                    timeAlpha = math.clamp(elapsed / loader.MinimumDuration, 0, 1)
                end

                local eased = 1 - ((1 - timeAlpha) ^ 2.15)
                local timedProgress = eased * 0.88
                local requested = math.min(loader.RequestedProgress or 0, 0.93)
                local target = math.max(timedProgress, requested)

                if loader.FinishRequested then
                    target = math.max(target, 0.94)
                end

                loader.DisplayedProgress =
                    loader.DisplayedProgress
                    + (target - loader.DisplayedProgress) * 0.13

                loader.Fill.Size = UDim2.new(loader.DisplayedProgress, 0, 1, 0)

                task.wait(1 / 30)
            end
        end)

        function loader:SetStage(text, progress)
            if self.Finished or self.Completing then
                return
            end

            if text then
                self.Status.Text = string.upper(tostring(text))
            end

            if progress ~= nil then
                self.RequestedProgress = math.clamp(tonumber(progress) or 0, 0, 1)
            end
        end

        function loader:RegisterWindow(window)
            if self.Finished or self.Completing or not window then
                return
            end

            for _, existing in ipairs(self.PendingWindows) do
                if existing == window then
                    return
                end
            end

            table.insert(self.PendingWindows, window)
        end

        function loader:Finish()
            if self.Finished or self.Completing or self.FinishRequested then
                return
            end

            self.FinishRequested = true
            self.Status.Text = "FINALIZING"
            self.RequestedProgress = math.max(self.RequestedProgress or 0, 0.94)

            local remaining = math.max(0, self.MinimumDuration - (os.clock() - self.StartedAt))

            task.delay(remaining, function()
                if not self.Finished and not self.Completing and self.FinishRequested then
                    complete(self)
                end
            end)
        end

        function loader:Destroy()
            if self.Finished then
                return
            end

            self.Finished = true
            self.Completing = false

            pcall(function()
                self.PulseTween:Cancel()
            end)

            if FlareUI._ActiveLoader == self then
                FlareUI._ActiveLoader = nil
            end

            for _, window in ipairs(self.PendingWindows) do
                revealWindow(window)
                if window and window.Main and window.Visible then
                    window.Main.GroupTransparency = 0
                end
            end

            if self.Gui then
                self.Gui:Destroy()
            end
        end

        return loader
    end

    local WindowMethods = {}
    WindowMethods.__index = WindowMethods

    local TabMethods = {}
    TabMethods.__index = TabMethods

    local SectionMethods = {}
    SectionMethods.__index = SectionMethods

    local FallbackIconGlyphs = {
        search = "⌕",
        settings = "⚙",
        gear = "⚙",
        x = "×",
        close = "×",
        minus = "−",
        plus = "+",
        home = "⌂",
        eye = "◉",
        fish = "≈",
        waves = "≋",
        wave = "≋",
        leaf = "❋",
        sword = "⚔",
        swords = "⚔",
        crosshair = "⊕",
        target = "⊕",
        move = "✥",
        zap = "⚡",
        bolt = "⚡",
        package = "▣",
        box = "▣",
        backpack = "▣",
        bag = "▣",
        cube = "▣",
        user = "◌",
        users = "◎",
        person = "◌",
        people = "◎",
        trophy = "★",
        star = "★",
        crown = "♛",
        shield = "⬒",
        shieldcheck = "⬒",
        anchor = "⚓",
        ship = "⚓",
        compass = "◈",
        globe = "◍",
        map = "◫",
        phone = "◫",
        monitor = "▤",
        gamepad = "✦",
        joystick = "✦",
        car = "◀",
        rabbit = "R",
        dinosaur = "D",
        bone = "B",
        pickaxe = "P",
        hammer = "H",
        skull = "☠",
        flame = "✦",
        fire = "✦",
        droplet = "◍",
        water = "◍",
        gem = "◆",
        diamond = "◆",
        coins = "$",
        coin = "$",
        wrench = "W",
        tool = "T",
        tools = "T",
        book = "▤",
        scroll = "S",
        list = "≡",
        menu = "≡",
    }

    local function fallbackIconText(name)
        name = tostring(name or "circle"):lower():gsub("[^a-z0-9%-_]", "")
        local compact = name:gsub("[-_]", "")
        if FallbackIconGlyphs[name] then
            return FallbackIconGlyphs[name]
        end
        if FallbackIconGlyphs[compact] then
            return FallbackIconGlyphs[compact]
        end

        local parts = {}
        for part in tostring(name):gmatch("[a-z0-9]+") do
            if #parts < 2 then
                parts[#parts + 1] = part:sub(1, 1):upper()
            end
        end

        if #parts == 0 then
            return "•"
        end
        return table.concat(parts)
    end

    local function createIcon(parent, name, size, tint)
        size = size or 16

        local iconData

        if LucideIcons and type(LucideIcons.Icon2) == "function" then
            local ok, result = pcall(
                LucideIcons.Icon2,
                name or "circle",
                "lucide"
            )

            if ok then
                iconData = result
            end
        end

        if iconData and iconData[1] and iconData[2] then
            return new("ImageLabel", {
                Size = UDim2.fromOffset(size, size),
                BackgroundTransparency = 1,
                Image = iconData[1],
                ImageRectSize = iconData[2].ImageRectSize,
                ImageRectOffset = iconData[2].ImageRectPosition,
                ImageColor3 = tint or Theme.Muted,
                ScaleType = Enum.ScaleType.Fit,
            }, parent)
        end


        return new("TextLabel", {
            Size = UDim2.fromOffset(size, size),
            BackgroundTransparency = 1,
            Text = fallbackIconText(name),
            Font = Enum.Font.GothamBold,
            TextSize = math.max(10, math.floor(size * 0.9)),
            TextColor3 = tint or Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
        }, parent)
    end

    local function normalizeSearchText(value)
        value = tostring(value or ""):lower()
        value = value:gsub("^%s+", ""):gsub("%s+$", "")
        return value
    end

    function FlareUI:CreateWindow(options)
        options = options or {}

        local mobile = isMobileDevice()
        local baseWidth = tonumber(options.Width) or 620
        local baseHeight = tonumber(options.Height) or 440
        local mobileScale = 1

        if mobile then
            local camera = workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
            local widthScale = math.max(0.1, (viewport.X - 24) / baseWidth)
            local heightScale = math.max(0.1, (viewport.Y - 92) / baseHeight)
            mobileScale = math.clamp(math.min(widthScale, heightScale, tonumber(options.MobileScale) or 0.76), 0.50, 0.76)
        end

        local activeLoader =
            FlareUI._ActiveLoader
            and not FlareUI._ActiveLoader.Finished
            and FlareUI._ActiveLoader
            or nil

        local gui = makeScreenGui(options.Name or "FlareHubUI", activeLoader ~= nil)

        if activeLoader then
            gui.Enabled = false
        end

        local mainGroup = new("CanvasGroup", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(baseWidth, baseHeight),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            GroupTransparency = activeLoader and 1 or 1,
            Visible = activeLoader == nil,
        }, gui)

        stroke(mainGroup, Theme.Border, 1)

        -- Subtle window scale used by SetVisible hide/show transitions.
        local mainScale = new("UIScale", {
            Scale = mobileScale,
        }, mainGroup)

        local header = new("Frame", {
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, mainGroup)

        new("Frame", {
            Position = UDim2.fromOffset(14, 13),
            Size = UDim2.fromOffset(2, 22),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, header)

        new("TextLabel", {
            Position = UDim2.fromOffset(25, 0),
            Size = UDim2.new(1, -112, 1, 0),
            BackgroundTransparency = 1,
            Text = options.Title or "FLARE HUB",
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, header)

        local minimizeButton = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -47, 0.5, 0),
            Size = UDim2.fromOffset(30, 28),
            BackgroundColor3 = Theme.Background,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
        }, header)

        local minimizeIcon = createIcon(minimizeButton, "minus", 15, Theme.Muted)
        minimizeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        minimizeIcon.Position = UDim2.fromScale(0.5, 0.5)

        local closeButton = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -13, 0.5, 0),
            Size = UDim2.fromOffset(30, 28),
            BackgroundColor3 = Theme.Background,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
        }, header)

        local closeIcon = createIcon(closeButton, "x", 15, Theme.Muted)
        closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        closeIcon.Position = UDim2.fromScale(0.5, 0.5)

        new("Frame", {
            Position = UDim2.new(0, 10, 1, -1),
            Size = UDim2.new(1, -20, 0, 1),
            BackgroundColor3 = Theme.Border,
            BorderSizePixel = 0,
        }, header)

        local sidebarWidth = options.SidebarWidth or 145

        local sidebar = new("Frame", {
            Position = UDim2.fromOffset(0, 48),
            Size = UDim2.new(0, sidebarWidth, 1, -48),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, mainGroup)

        new("Frame", {
            Position = UDim2.new(1, -1, 0, 0),
            Size = UDim2.new(0, 1, 1, 0),
            BackgroundColor3 = Theme.Border,
            BorderSizePixel = 0,
        }, sidebar)

        local searchFrame = new("Frame", {
            Position = UDim2.fromOffset(9, 10),
            Size = UDim2.new(1, -18, 0, 30),
            BackgroundColor3 = Theme.Row,
            BorderSizePixel = 0,
        }, sidebar)
        stroke(searchFrame, Color3.fromRGB(105, 105, 105), 1)

        local searchIcon = createIcon(searchFrame, "search", 14, Theme.Muted)
        searchIcon.Position = UDim2.fromOffset(9, 8)

        local searchBox = new("TextBox", {
            Position = UDim2.fromOffset(31, 0),
            Size = UDim2.new(1, -37, 1, 0),
            BackgroundTransparency = 1,
            Text = "",
            PlaceholderText = "Search...",
            PlaceholderColor3 = Color3.fromRGB(95, 95, 95),
            ClearTextOnFocus = false,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, searchFrame)

        local navContainer = new("ScrollingFrame", {
            Position = UDim2.fromOffset(8, 50),
            Size = UDim2.new(1, -16, 1, -154),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.fromOffset(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = Theme.Accent,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            ScrollingDirection = Enum.ScrollingDirection.Y,
        }, sidebar)

        new("UIPadding", {
            PaddingRight = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 3),
        }, navContainer)

        new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        }, navContainer)

        local profile = new("Frame", {
            Position = UDim2.new(0, 8, 1, -96),
            Size = UDim2.new(1, -16, 0, 88),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, sidebar)

        new("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            BorderSizePixel = 0,
        }, profile)

        local avatar = new("ImageLabel", {
            Position = UDim2.fromOffset(12, 14),
            Size = UDim2.fromOffset(38, 38),
            BackgroundColor3 = Theme.Row,
            BorderSizePixel = 0,
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150",
            ScaleType = Enum.ScaleType.Crop,
        }, profile)
        stroke(avatar, Color3.fromRGB(120, 120, 120), 1)

        new("TextLabel", {
            Position = UDim2.fromOffset(59, 11),
            Size = UDim2.new(1, -61, 0, 19),
            BackgroundTransparency = 1,
            Text = LocalPlayer.DisplayName,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, profile)

        new("TextLabel", {
            Position = UDim2.fromOffset(59, 29),
            Size = UDim2.new(1, -61, 0, 17),
            BackgroundTransparency = 1,
            Text = "@" .. LocalPlayer.Name,
            Font = Enum.Font.GothamMedium,
            TextSize = 9,
            TextColor3 = Theme.Muted,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, profile)

        new("TextLabel", {
            Position = UDim2.fromOffset(12, 59),
            Size = UDim2.new(1, -14, 0, 20),
            BackgroundTransparency = 1,
            Text = options.KeyStatusText or "Key expires: Never",
            Font = Enum.Font.GothamMedium,
            TextSize = 9,
            TextColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, profile)

        local content = new("Frame", {
            Position = UDim2.fromOffset(sidebarWidth, 48),
            Size = UDim2.new(1, -sidebarWidth, 1, -48),
            BackgroundTransparency = 1,
        }, mainGroup)

        local hud = new("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -18, 0, 18),
            Size = UDim2.fromOffset(170, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.14,
            BorderSizePixel = 0,
            Visible = false,
        }, gui)
        stroke(hud, Color3.fromRGB(185, 185, 185), 1)

        new("Frame", {
            Size = UDim2.new(0, 2, 1, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, hud)

        local hudContent = new("Frame", {
            Position = UDim2.fromOffset(8, 6),
            Size = UDim2.new(1, -14, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
        }, hud)

        new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2),
        }, hudContent)

        new("UIPadding", {
            PaddingBottom = UDim.new(0, 6),
        }, hud)

        local window = setmetatable({
            Gui = gui,
            Main = mainGroup,
            MainScale = mainScale,
            BaseScale = mobileScale,
            IsMobile = mobile,
            MobileToggle = nil,
            Header = header,
            Sidebar = sidebar,
            NavContainer = navContainer,
            Content = content,
            SearchBox = searchBox,
            SearchFrame = searchFrame,
            Profile = profile,
            MinimizeButton = minimizeButton,
            CloseButton = closeButton,
            MinimizeCallback = options.OnMinimize,
            CloseCallback = options.OnClose,
            Tabs = {},
            TabOrder = {},
            Entries = {},
            Sections = {},
            Connections = {},
            CurrentTab = nil,
            PreSearchTab = nil,
            SearchQuery = "",
            HUD = hud,
            HUDContent = hudContent,
            HUDItems = {},
            ActiveSliderDrag = nil,
            ActiveSliderRelease = nil,
            Visible = true,
            VisibilityToken = 0,
            Destroyed = false,
        }, WindowMethods)

        local dragging = false
        local dragStart
        local startPos
        local dragInput

        table.insert(window.Connections, header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch
            then
                dragging = true
                dragInput = input
                dragStart = input.Position
                startPos = mainGroup.Position
            end
        end))

        table.insert(window.Connections, UIS.InputChanged:Connect(function(input)
            local isMouseDrag = dragging and input.UserInputType == Enum.UserInputType.MouseMovement
            local isTouchDrag = dragging
                and dragInput
                and dragInput.UserInputType == Enum.UserInputType.Touch
                and input == dragInput

            if isMouseDrag or isTouchDrag then
                local delta = input.Position - dragStart
                mainGroup.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end

            if window.ActiveSliderDrag
                and input.UserInputType == Enum.UserInputType.MouseMovement
            then
                window.ActiveSliderDrag(input.Position.X)
            end
        end))

        table.insert(window.Connections, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput)
            then
                dragging = false
                dragInput = nil
            end
        end))

        -- Mobile gets a persistent floating Flare button. It is a sibling of the
        -- main window, so it remains tappable while the window is hidden.
        if mobile then
            local flareAsset = resolveAsset("flare_icon")
            local mobileButton

            if flareAsset then
                mobileButton = new("ImageButton", {
                    Name = "FlareMobileToggle",
                    Position = UDim2.fromOffset(16, 82),
                    Size = UDim2.fromOffset(48, 48),
                    BackgroundColor3 = Color3.fromRGB(7, 7, 7),
                    BackgroundTransparency = 0.08,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 1000,
                }, gui)

                local mobileIcon = new("ImageLabel", {
                    Name = "Icon",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromScale(0.82, 0.82),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Image = flareAsset,
                    ImageColor3 = Color3.new(1, 1, 1),
                    ScaleType = Enum.ScaleType.Fit,
                    ZIndex = 1001,
                }, mobileButton)

                new("UICorner", {CornerRadius = UDim.new(1, 0)}, mobileIcon)
            else
                mobileButton = new("TextButton", {
                    Name = "FlareMobileToggle",
                    Position = UDim2.fromOffset(16, 82),
                    Size = UDim2.fromOffset(48, 48),
                    BackgroundColor3 = Color3.fromRGB(7, 7, 7),
                    BackgroundTransparency = 0.08,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Text = "F",
                    Font = Enum.Font.GothamBlack,
                    TextSize = 24,
                    TextColor3 = Theme.Accent,
                    ZIndex = 1000,
                }, gui)
            end

            new("UICorner", {CornerRadius = UDim.new(1, 0)}, mobileButton)
            stroke(mobileButton, Theme.Border, 1)

            local buttonScale = new("UIScale", {Scale = 1}, mobileButton)
            local buttonDragging = false
            local buttonDragInput
            local buttonStart
            local buttonStartPos
            local moved = false

            table.insert(window.Connections, mobileButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                    or input.UserInputType == Enum.UserInputType.MouseButton1
                then
                    buttonDragging = true
                    buttonDragInput = input
                    buttonStart = input.Position
                    buttonStartPos = mobileButton.Position
                    moved = false
                    tween(buttonScale, {Scale = 0.92}, 0.08, Enum.EasingStyle.Quad)
                end
            end))

            table.insert(window.Connections, UIS.InputChanged:Connect(function(input)
                if not buttonDragging then return end

                local valid = input.UserInputType == Enum.UserInputType.MouseMovement
                    or (buttonDragInput
                        and buttonDragInput.UserInputType == Enum.UserInputType.Touch
                        and input == buttonDragInput)

                if not valid then return end

                local delta = input.Position - buttonStart
                if delta.Magnitude > 7 then
                    moved = true
                end

                local camera = workspace.CurrentCamera
                local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
                local x = math.clamp(buttonStartPos.X.Offset + delta.X, 8, math.max(8, viewport.X - 56))
                local y = math.clamp(buttonStartPos.Y.Offset + delta.Y, 8, math.max(8, viewport.Y - 56))
                mobileButton.Position = UDim2.fromOffset(x, y)
            end))

            table.insert(window.Connections, UIS.InputEnded:Connect(function(input)
                if not buttonDragging then return end
                if input.UserInputType ~= Enum.UserInputType.MouseButton1
                    and not (input.UserInputType == Enum.UserInputType.Touch and input == buttonDragInput)
                then
                    return
                end

                buttonDragging = false
                buttonDragInput = nil
                tween(buttonScale, {Scale = 1}, 0.16, Enum.EasingStyle.Back)

                if not moved and not window.Destroyed then
                    window:ToggleVisible()
                end
            end))

            window.MobileToggle = mobileButton
        end

        local function bindHeaderButton(button, icon, hoverColor, callbackName)
            table.insert(window.Connections, button.MouseEnter:Connect(function()
                if window.Destroyed then return end
                tween(button, {BackgroundTransparency = 0, BackgroundColor3 = hoverColor}, 0.10)
                if icon:IsA("ImageLabel") or icon:IsA("ImageButton") then
                    icon.ImageColor3 = Theme.Text
                end
            end))

            table.insert(window.Connections, button.MouseLeave:Connect(function()
                if window.Destroyed then return end
                tween(button, {BackgroundTransparency = 1}, 0.10)
                if icon:IsA("ImageLabel") or icon:IsA("ImageButton") then
                    icon.ImageColor3 = Theme.Muted
                end
            end))

            table.insert(window.Connections, button.MouseButton1Click:Connect(function()
                if window.Destroyed then return end
                local callback = window[callbackName]
                if type(callback) == "function" then
                    callback()
                elseif callbackName == "MinimizeCallback" then
                    window:SetVisible(false)
                end
            end))
        end

        bindHeaderButton(minimizeButton, minimizeIcon, Theme.RowHover, "MinimizeCallback")
        bindHeaderButton(closeButton, closeIcon, Color3.fromRGB(62, 18, 28), "CloseCallback")

        table.insert(window.Connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            window:SetSearch(searchBox.Text)
        end))

        table.insert(window.Connections, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if window.ActiveSliderRelease then
                    window.ActiveSliderRelease()
                else
                    window.ActiveSliderDrag = nil
                end
            end
        end))

        if activeLoader then
            window._WaitingForLoader = true
            activeLoader:RegisterWindow(window)
        else
            mainGroup.Visible = true
            mainGroup.Position = UDim2.fromScale(0.5, 0.54)
            tween(mainGroup, {
                GroupTransparency = 0,
                Position = UDim2.fromScale(0.5, 0.5),
            }, 0.24, Enum.EasingStyle.Quart)
        end

        return window
    end

    function WindowMethods:_registerEntry(entry)
        table.insert(self.Entries, entry)
    end

    function WindowMethods:_registerSection(section)
        table.insert(self.Sections, section)
    end

    function WindowMethods:SetMinimizeCallback(callback)
        self.MinimizeCallback = callback
    end

    function WindowMethods:SetCloseCallback(callback)
        self.CloseCallback = callback
    end

    function WindowMethods:AddTab(options)
        if type(options) == "string" then
            options = {Name = options}
        end
        options = options or {}

        local name = options.Name or ("Tab " .. tostring(#self.TabOrder + 1))
        local iconName = options.Icon or "settings"

        local button = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
        }, self.NavContainer)

        local indicator = new("Frame", {
            Position = UDim2.new(0, 0, 0.5, -9),
            Size = UDim2.fromOffset(2, 18),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Visible = false,
        }, button)

        local icon = createIcon(button, iconName, 16, Theme.Muted)
        icon.Position = UDim2.new(0, 11, 0.5, -8)

        local label = new("TextLabel", {
            Position = UDim2.fromOffset(36, 0),
            Size = UDim2.new(1, -58, 1, 0),
            BackgroundTransparency = 1,
            Text = string.upper(name),
            Font = Enum.Font.GothamMedium,
            TextSize = 9,
            TextColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, button)

        local count = new("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -8, 0.5, 0),
            Size = UDim2.fromOffset(20, 14),
            BackgroundTransparency = 1,
            Text = "",
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextColor3 = Theme.Accent,
            TextXAlignment = Enum.TextXAlignment.Right,
            Visible = false,
        }, button)

        local pageGroup = new("CanvasGroup", {
            Name = name .. "PageGroup",
            Position = UDim2.fromOffset(0, 0),
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            GroupTransparency = 1,
            Visible = false,
        }, self.Content)

        local page = new("ScrollingFrame", {
            Name = name,
            Position = UDim2.fromOffset(8, 8),
            Size = UDim2.new(1, -16, 1, -16),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.fromOffset(0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Visible = true,
        }, pageGroup)

        new("UIPadding", {
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 11),
            PaddingTop = UDim.new(0, 1),
            PaddingBottom = UDim.new(0, 6),
        }, page)

        new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 7),
        }, page)

        local tab = setmetatable({
            Window = self,
            Name = name,
            IconName = iconName,
            Button = button,
            Indicator = indicator,
            Icon = icon,
            Label = label,
            Count = count,
            Page = page,
            PageGroup = pageGroup,
            Sections = {},
            MatchCount = 0,
        }, TabMethods)

        self.Tabs[name] = tab
        table.insert(self.TabOrder, tab)

        table.insert(self.Connections, button.MouseButton1Click:Connect(function()
            if button.Visible then
                self:SelectTab(name)
            end
        end))

        if not self.CurrentTab then
            self:SelectTab(name)
        end

        return tab
    end

    function WindowMethods:SelectTab(name)
        local tab = self.Tabs[name]
        if not tab or not tab.Button.Visible then
            return
        end

        local previousName = self.CurrentTab
        local previous = previousName and self.Tabs[previousName] or nil
        self.CurrentTab = name

        for _, item in ipairs(self.TabOrder) do
            local selected = item == tab
            item.Indicator.Visible = selected
            item.Label.TextColor3 = selected and Theme.Text or Theme.Muted
            if item.Icon:IsA("ImageLabel") or item.Icon:IsA("ImageButton") then
                item.Icon.ImageColor3 = selected and Theme.Accent or Theme.Muted
            elseif item.Icon:IsA("TextLabel") or item.Icon:IsA("TextButton") then
                item.Icon.TextColor3 = selected and Theme.Accent or Theme.Muted
            end
            item.Button.BackgroundColor3 = selected and Theme.Row or Theme.Background
        end

        if previous == tab and tab.PageGroup.Visible then
            return
        end

        if previous and previous ~= tab then
            local oldGroup = previous.PageGroup
            tween(oldGroup, {
                GroupTransparency = 1,
                Position = UDim2.fromOffset(-8, 0),
            }, 0.10, Enum.EasingStyle.Quad)

            task.delay(0.105, function()
                if not self.Destroyed and self.CurrentTab ~= previous.Name then
                    oldGroup.Visible = false
                    oldGroup.Position = UDim2.fromOffset(0, 0)
                end
            end)
        end

        local group = tab.PageGroup
        group.Visible = true
        group.GroupTransparency = 1
        group.Position = UDim2.fromOffset(12, 0)
        tween(group, {
            GroupTransparency = 0,
            Position = UDim2.fromOffset(0, 0),
        }, 0.14, Enum.EasingStyle.Quart)
    end

    function WindowMethods:_firstVisibleTab()
        for _, tab in ipairs(self.TabOrder) do
            if tab.Button.Visible then
                return tab
            end
        end
        return nil
    end

    function WindowMethods:SetSearch(query)
        query = normalizeSearchText(query)

        if query ~= "" and self.SearchQuery == "" then
            self.PreSearchTab = self.CurrentTab
        end

        self.SearchQuery = query

        local searching = query ~= ""
        local tabCounts = {}
        local sectionCounts = {}

        for _, tab in ipairs(self.TabOrder) do
            tabCounts[tab] = 0
        end

        for _, section in ipairs(self.Sections) do
            sectionCounts[section] = 0
        end

        for _, entry in ipairs(self.Entries) do
            local matched = true
            if searching then
                matched = string.find(entry.SearchText, query, 1, true) ~= nil
            end

            entry.Row.Visible = matched

            if matched then
                tabCounts[entry.Tab] = (tabCounts[entry.Tab] or 0) + 1
                sectionCounts[entry.Section] = (sectionCounts[entry.Section] or 0) + 1
            end
        end

        for _, section in ipairs(self.Sections) do
            local visible = not searching or (sectionCounts[section] or 0) > 0
            section.Header.Visible = visible
        end

        for _, tab in ipairs(self.TabOrder) do
            local count = tabCounts[tab] or 0
            local visible = not searching or count > 0
            tab.Button.Visible = visible
            tab.Count.Visible = searching and visible
            tab.Count.Text = searching and tostring(count) or ""
        end

        if searching then
            local current = self.CurrentTab and self.Tabs[self.CurrentTab]
            if not current or not current.Button.Visible then
                local first = self:_firstVisibleTab()
                if first then
                    self:SelectTab(first.Name)
                else
                    for _, tab in ipairs(self.TabOrder) do
                        tab.PageGroup.Visible = false
                    end
                end
            else
                self:SelectTab(current.Name)
            end
        else
            local desired = self.PreSearchTab
            self.PreSearchTab = nil
            if desired and self.Tabs[desired] then
                self:SelectTab(desired)
            elseif self.CurrentTab and self.Tabs[self.CurrentTab] then
                self:SelectTab(self.CurrentTab)
            else
                local first = self:_firstVisibleTab()
                if first then
                    self:SelectTab(first.Name)
                end
            end
        end
    end

    function WindowMethods:SetVisible(value)
        local visible = value == true
        self.Visible = visible
        self.VisibilityToken = (self.VisibilityToken or 0) + 1
        local token = self.VisibilityToken

        if self._WaitingForLoader then
            self.Main.Visible = false
            return
        end

        if visible then
            -- Make the window exist before animating it back in.
            self.Main.Visible = true
            self.Main.GroupTransparency = 1

            if self.MainScale then
                local baseScale = self.BaseScale or 1
                self.MainScale.Scale = baseScale * 0.97
                tween(
                    self.MainScale,
                    {Scale = baseScale},
                    0.20,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.Out
                )
            end

            tween(
                self.Main,
                {GroupTransparency = 0},
                0.16,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            )
        else
            if not self.Main.Visible then
                return
            end

            tween(
                self.Main,
                {GroupTransparency = 1},
                0.13,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.In
            )

            if self.MainScale then
                local baseScale = self.BaseScale or 1
                tween(
                    self.MainScale,
                    {Scale = baseScale * 0.97},
                    0.13,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In
                )
            end

            task.delay(0.14, function()
                if self.Destroyed or self.VisibilityToken ~= token or self.Visible then
                    return
                end
                self.Main.Visible = false
            end)
        end
    end

    function WindowMethods:ToggleVisible()
        self:SetVisible(not self.Visible)
    end

    function WindowMethods:IsMobileClient()
        return self.IsMobile == true
    end

    function WindowMethods:SetActive(name, enabled)
        name = tostring(name or "")
        if name == "" then return end

        local item = self.HUDItems[name]

        if enabled and not item then
            item = new("TextLabel", {
                Size = UDim2.new(1, 0, 0, 16),
                BackgroundTransparency = 1,
                Text = string.upper(name),
                Font = Enum.Font.GothamMedium,
                TextSize = 10,
                TextColor3 = Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Right,
            }, self.HUDContent)
            self.HUDItems[name] = item
        elseif item then
            item.Visible = enabled == true
        end

        local any = false
        for _, label in pairs(self.HUDItems) do
            if label.Visible then
                any = true
                break
            end
        end

        self.HUD.Visible = any
    end

    function WindowMethods:Notify(text, duration)
        if self.Destroyed then return end

        local toast = new("Frame", {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -18, 1, -18),
            Size = UDim2.fromOffset(240, 42),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, self.Gui)

        stroke(toast, Theme.Border, 1)

        new("Frame", {
            Size = UDim2.new(0, 2, 1, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, toast)

        local label = new("TextLabel", {
            Position = UDim2.fromOffset(11, 0),
            Size = UDim2.new(1, -18, 1, 0),
            BackgroundTransparency = 1,
            Text = tostring(text),
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
        }, toast)

        task.delay(duration or 1.8, function()
            if toast.Parent then
                toast:Destroy()
            end
        end)
    end

    function WindowMethods:Confirm(options)
        if self.Destroyed then return end
        options = options or {}

        local shade = new("TextButton", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.28,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 90,
        }, self.Gui)

        local box = new("CanvasGroup", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.52),
            Size = UDim2.fromOffset(360, 174),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            GroupTransparency = 1,
            ZIndex = 91,
        }, shade)
        stroke(box, options.Danger and Theme.Danger or Theme.Border, 1)

        local alertIcon = createIcon(box, options.Danger and "triangle-alert" or "circle-help", 20, options.Danger and Theme.Danger or Theme.Accent)
        alertIcon.Position = UDim2.fromOffset(18, 18)
        alertIcon.ZIndex = 92

        new("TextLabel", {
            Position = UDim2.fromOffset(49, 13),
            Size = UDim2.new(1, -67, 0, 28),
            BackgroundTransparency = 1,
            Text = options.Title or "Are you sure?",
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 92,
        }, box)

        new("TextLabel", {
            Position = UDim2.fromOffset(18, 48),
            Size = UDim2.new(1, -36, 0, 62),
            BackgroundTransparency = 1,
            Text = options.Text or "This action cannot be undone.",
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Muted,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 92,
        }, box)

        local cancel = new("TextButton", {
            Position = UDim2.new(0, 18, 1, -47),
            Size = UDim2.new(0.5, -23, 0, 30),
            BackgroundColor3 = Theme.Row,
            BorderSizePixel = 0,
            Text = options.CancelText or "CANCEL",
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextColor3 = Theme.Text,
            AutoButtonColor = false,
            ZIndex = 92,
        }, box)
        stroke(cancel, Color3.fromRGB(110, 110, 110), 1)

        local confirm = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -18, 1, -47),
            Size = UDim2.new(0.5, -23, 0, 30),
            BackgroundColor3 = options.Danger and Color3.fromRGB(55, 13, 22) or Theme.AccentDim,
            BorderSizePixel = 0,
            Text = options.ConfirmText or "CONFIRM",
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextColor3 = options.Danger and Color3.fromRGB(255, 140, 155) or Theme.Text,
            AutoButtonColor = false,
            ZIndex = 92,
        }, box)
        stroke(confirm, options.Danger and Theme.Danger or Theme.Accent, 1)

        local closed = false
        local function closeModal()
            if closed then return end
            closed = true
            if shade.Parent then
                shade:Destroy()
            end
        end

        cancel.MouseButton1Click:Connect(closeModal)
        confirm.MouseButton1Click:Connect(function()
            if closed then return end
            local callback = options.Callback
            closeModal()
            if type(callback) == "function" then
                task.spawn(callback)
            end
        end)

        tween(box, {
            GroupTransparency = 0,
            Position = UDim2.fromScale(0.5, 0.5),
        }, 0.14, Enum.EasingStyle.Quart)

        return shade
    end

    function WindowMethods:Destroy()
        if self.Destroyed then return end
        self.Destroyed = true

        for _, connection in ipairs(self.Connections) do
            pcall(function()
                connection:Disconnect()
            end)
        end

        table.clear(self.Connections)

        if self.Gui then
            self.Gui:Destroy()
        end
    end

    function TabMethods:AddSection(name)
        local header = new("Frame", {
            Size = UDim2.new(1, 0, 0, 24),
            BackgroundTransparency = 1,
        }, self.Page)

        new("Frame", {
            Position = UDim2.new(0, 0, 0.5, -7),
            Size = UDim2.fromOffset(2, 14),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, header)

        new("TextLabel", {
            Position = UDim2.fromOffset(9, 0),
            Size = UDim2.new(1, -9, 1, 0),
            BackgroundTransparency = 1,
            Text = string.upper(name),
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, header)

        local section = setmetatable({
            Tab = self,
            Window = self.Window,
            Name = name,
            Header = header,
            Entries = {},
        }, SectionMethods)

        table.insert(self.Sections, section)
        self.Window:_registerSection(section)

        return section
    end

    local function makeRow(section, height, title, description, keywords)
        local hasDescription = description ~= nil and tostring(description) ~= ""

        local row = new("Frame", {
            Size = UDim2.new(1, 0, 0, height or 44),
            BackgroundColor3 = Theme.Row,
            BorderSizePixel = 0,
        }, section.Tab.Page)

        stroke(row, Theme.Border, 1)

        local titleLabel = new("TextLabel", {
            AnchorPoint = hasDescription and Vector2.new(0, 0) or Vector2.new(0, 0.5),
            Position = hasDescription and UDim2.fromOffset(12, 5) or UDim2.new(0, 12, 0.5, 1),
            Size = UDim2.new(1, -112, 0, hasDescription and 18 or 20),
            BackgroundTransparency = 1,
            Text = title,
            Font = Enum.Font.GothamMedium,
            TextSize = 11,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
        }, row)

        if hasDescription then
            new("TextLabel", {
                Position = UDim2.fromOffset(12, 23),
                Size = UDim2.new(1, -112, 0, 15),
                BackgroundTransparency = 1,
                Text = tostring(description),
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextColor3 = Theme.Muted,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center,
            }, row)
        end

        local terms = {
            title,
            description or "",
            section.Name,
            section.Tab.Name,
        }

        if keywords then
            if type(keywords) == "table" then
                for _, keyword in ipairs(keywords) do
                    table.insert(terms, tostring(keyword))
                end
            else
                table.insert(terms, tostring(keywords))
            end
        end

        local entry = {
            Row = row,
            Section = section,
            Tab = section.Tab,
            SearchText = string.lower(table.concat(terms, " ")),
        }

        table.insert(section.Entries, entry)
        section.Window:_registerEntry(entry)

        return row, titleLabel, entry
    end

    function SectionMethods:AddToggle(options)
        options = options or {}
        local hasDescription = options.Description ~= nil and tostring(options.Description) ~= ""
        local row = makeRow(
            self,
            hasDescription and 46 or 40,
            options.Name or "Toggle",
            hasDescription and options.Description or nil,
            options.Keywords
        )

        local value = options.Default == true

        local button = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(42, 22),
            BackgroundColor3 = Theme.AccentDim,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
        }, row)

        local buttonStroke = stroke(button, Color3.fromRGB(75, 75, 75), 1)

        local knob = new("Frame", {
            Position = UDim2.fromOffset(3, 3),
            Size = UDim2.fromOffset(16, 16),
            BackgroundColor3 = Theme.Muted,
            BorderSizePixel = 0,
        }, button)

        local knobScale = new("UIScale", {Scale = 1}, knob)
        local buttonScale = new("UIScale", {Scale = 1}, button)
        local control = {}
        local renderToken = 0

        local function render(animated)
            renderToken = renderToken + 1
            local token = renderToken
            local buttonColor = value and Theme.AccentDim or Color3.fromRGB(18, 18, 18)
            local knobColor = value and Theme.Accent or Theme.Muted
            local knobPosition = value and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)
            local strokeColor = value and Theme.Accent or Color3.fromRGB(75, 75, 75)

            if animated then
                tween(button, {BackgroundColor3 = buttonColor}, 0.22, Enum.EasingStyle.Sine)
                tween(buttonStroke, {Color = strokeColor}, 0.22, Enum.EasingStyle.Sine)
                tween(knob, {BackgroundColor3 = knobColor, Position = knobPosition}, 0.26, Enum.EasingStyle.Quint)
                tween(knobScale, {Scale = 0.72}, 0.08, Enum.EasingStyle.Quad)
                tween(buttonScale, {Scale = 0.96}, 0.08, Enum.EasingStyle.Quad)
                task.delay(0.08, function()
                    if token == renderToken and knobScale and knobScale.Parent then
                        tween(knobScale, {Scale = 1}, 0.18, Enum.EasingStyle.Back)
                        tween(buttonScale, {Scale = 1}, 0.18, Enum.EasingStyle.Back)
                    end
                end)
            else
                button.BackgroundColor3 = buttonColor
                buttonStroke.Color = strokeColor
                knob.BackgroundColor3 = knobColor
                knob.Position = knobPosition
                knobScale.Scale = 1
                buttonScale.Scale = 1
            end
        end

        function control:Get()
            return value
        end

        function control:Set(nextValue, silent)
            nextValue = nextValue == true
            if value == nextValue and not silent then
                render(true)
                return
            end

            value = nextValue
            render(not silent)

            if not silent and options.Callback then
                task.spawn(options.Callback, value)
            end
        end

        button.MouseButton1Click:Connect(function()
            control:Set(not value)
        end)

        render(false)

        if options.Callback and options.FireOnCreate then
            task.spawn(options.Callback, value)
        end

        return control
    end

    function SectionMethods:AddSlider(options)
        options = options or {}

        local minimum = tonumber(options.Min) or 0
        local maximum = tonumber(options.Max) or 100
        local step = tonumber(options.Step) or 1
        local value = math.clamp(tonumber(options.Default) or minimum, minimum, maximum)

        local row, titleLabel = makeRow(
            self,
            54,
            options.Name or "Slider",
            nil,
            options.Keywords
        )

        if titleLabel then
            titleLabel.AnchorPoint = Vector2.new(0, 0)
            titleLabel.Position = UDim2.fromOffset(12, 5)
            titleLabel.Size = UDim2.new(1, -112, 0, 18)
            titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        end

        local valueLabel = new("TextLabel", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -12, 0, 5),
            Size = UDim2.fromOffset(78, 18),
            BackgroundTransparency = 1,
            Font = Enum.Font.Code,
            TextSize = 10,
            TextColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Right,
        }, row)

        local rail = new("Frame", {
            Position = UDim2.new(0, 12, 1, -15),
            Size = UDim2.new(1, -24, 0, 3),
            BackgroundColor3 = Color3.fromRGB(38, 38, 38),
            BorderSizePixel = 0,
        }, row)

        local fill = new("Frame", {
            Size = UDim2.fromScale(0, 1),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, rail)

        local knob = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0, 0.5),
            Size = UDim2.fromOffset(7, 11),
            BackgroundColor3 = Theme.Text,
            BorderSizePixel = 0,
        }, rail)

        local dragging = false
        local control = {}
        local dragInput = nil

        local function quantize(n)
            n = math.clamp(n, minimum, maximum)
            if step > 0 then
                n = math.floor((n - minimum) / step + 0.5) * step + minimum
            end
            return math.clamp(n, minimum, maximum)
        end

        local function formatter(n)
            if options.Format then
                local ok, result = pcall(options.Format, n)
                if ok then return tostring(result) end
            end
            if step < 1 then
                return string.format("%.2f", n)
            end
            return tostring(math.floor(n + 0.5))
        end

        local function render()
            local alpha = maximum == minimum and 0 or ((value - minimum) / (maximum - minimum))
            fill.Size = UDim2.fromScale(alpha, 1)
            knob.Position = UDim2.fromScale(alpha, 0.5)
            valueLabel.Text = formatter(value)
        end

        function control:Get()
            return value
        end

        function control:Set(nextValue, silent)
            nextValue = quantize(tonumber(nextValue) or value)
            if nextValue == value and not silent then
                render()
                return
            end

            value = nextValue
            render()

            if not silent and options.Callback then
                task.spawn(options.Callback, value)
            end
        end

        local function setFromX(x)
            local alpha = math.clamp((x - rail.AbsolutePosition.X) / math.max(1, rail.AbsoluteSize.X), 0, 1)
            control:Set(minimum + (maximum - minimum) * alpha)
        end

        local hitbox = new("TextButton", {
            Position = UDim2.new(0, 7, 1, -31),
            Size = UDim2.new(1, -14, 0, 31),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            Active = true,
            ZIndex = 8,
        }, row)

        local function endDrag()
            if not dragging then return end
            dragging = false
            dragInput = nil
            if self.Window.ActiveSliderDrag == setFromX then
                self.Window.ActiveSliderDrag = nil
            end
            if self.Window.ActiveSliderRelease == endDrag then
                self.Window.ActiveSliderRelease = nil
            end
            tween(knob, {Size = UDim2.fromOffset(7, 11)}, 0.12, Enum.EasingStyle.Quad)
        end

        local function beginDrag(x, input)
            dragging = true
            dragInput = input
            self.Window.ActiveSliderDrag = setFromX
            self.Window.ActiveSliderRelease = endDrag
            setFromX(x)
            tween(knob, {Size = UDim2.fromOffset(9, 15)}, 0.10, Enum.EasingStyle.Quad)
        end

        hitbox.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                beginDrag(input.Position.X, input)
            elseif input.UserInputType == Enum.UserInputType.Touch then
                beginDrag(input.Position.X, input)
            end
        end)

        hitbox.InputChanged:Connect(function(input)
            if dragging
                and input.UserInputType == Enum.UserInputType.Touch
                and dragInput == input
            then
                setFromX(input.Position.X)
            end
        end)

        hitbox.InputEnded:Connect(function(input)
            if dragging
                and (
                    input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch
                )
            then
                endDrag()
            end
        end)

        render()
        return control
    end

    function SectionMethods:AddKeybind(options)
        options = options or {}
        local value = tostring(options.Default or "None")

        local row = makeRow(
            self,
            40,
            options.Name or "Keybind",
            nil,
            options.Keywords
        )

        local button = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(78, 26),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Font = Enum.Font.Code,
            TextSize = 12,
            TextColor3 = Theme.Text,
            TextStrokeTransparency = 1,
            Text = value,
            AutoButtonColor = false,
        }, row)

        stroke(button, Theme.Border, 1)

        local listening = false
        local connection
        local control = {}

        function control:Get()
            return value
        end

        function control:Set(nextValue, silent)
            value = tostring(nextValue or "None")
            button.Text = value
            button.TextColor3 = Theme.Text

            if not silent and options.Callback then
                task.spawn(options.Callback, value)
            end
        end

        local function stopListening()
            listening = false
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end

        button.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            button.Text = "..."
            button.TextColor3 = Theme.Accent

            connection = UIS.InputBegan:Connect(function(input, processed)
                if processed then return end

                local name
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    name = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    name = "MouseButton1"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    name = "MouseButton2"
                end

                if name then
                    stopListening()
                    control:Set(name)
                end
            end)
        end)

        return control
    end

    function SectionMethods:AddDropdown(options)
        options = options or {}
        local values = options.Values or {}
        local index = 1

        if options.Default ~= nil then
            for i, candidate in ipairs(values) do
                if candidate == options.Default then
                    index = i
                    break
                end
            end
        end

        local row = makeRow(
            self,
            40,
            options.Name or "Selection",
            nil,
            options.Keywords
        )

        local button = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(132, 26),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextStrokeTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Text = "",
            AutoButtonColor = false,
        }, row)
        local buttonStroke = stroke(button, Theme.Border, 1)

        local valueLabel = new("TextLabel", {
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -36, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 3,
        }, button)

        local chevron = createIcon(button, "chevron-down", 13, Theme.Muted)
        chevron.AnchorPoint = Vector2.new(0.5, 0.5)
        chevron.Position = UDim2.new(1, -13, 0.5, 0)
        chevron.ZIndex = 3

        local control = {}
        local popup
        local outsideConnection
        local followConnection
        local opened = false

        local function current()
            return values[index]
        end

        local function render()
            valueLabel.Text = tostring(current() or "None")
        end

        local function pointInside(guiObject, point)
            if not guiObject or not guiObject.Parent then return false end
            local pos = guiObject.AbsolutePosition
            local size = guiObject.AbsoluteSize
            return point.X >= pos.X and point.X <= pos.X + size.X
                and point.Y >= pos.Y and point.Y <= pos.Y + size.Y
        end

        local function closeDropdown()
            if not opened then return end
            opened = false

            if self.Window.ActiveDropdown == control then
                self.Window.ActiveDropdown = nil
            end

            if outsideConnection then
                outsideConnection:Disconnect()
                outsideConnection = nil
            end

            if followConnection then
                followConnection:Disconnect()
                followConnection = nil
            end

            tween(buttonStroke, {Color = Theme.Border}, 0.12, Enum.EasingStyle.Quad)
            tween(chevron, {Rotation = 0, ImageColor3 = Theme.Muted}, 0.14, Enum.EasingStyle.Quad)

            if popup then
                local oldPopup = popup
                popup = nil
                tween(oldPopup, {BackgroundTransparency = 1}, 0.10, Enum.EasingStyle.Quad)
                for _, child in ipairs(oldPopup:GetChildren()) do
                    if child:IsA("TextButton") then
                        tween(child, {TextTransparency = 1, BackgroundTransparency = 1}, 0.10, Enum.EasingStyle.Quad)
                    elseif child:IsA("UIStroke") then
                        tween(child, {Transparency = 1}, 0.10, Enum.EasingStyle.Quad)
                    end
                end
                task.delay(0.11, function()
                    if oldPopup and oldPopup.Parent then
                        oldPopup:Destroy()
                    end
                end)
            end
        end

        function control:Get()
            return current()
        end

        function control:Set(value, silent)
            for i, candidate in ipairs(values) do
                if candidate == value then
                    index = i
                    break
                end
            end
            render()
            if not silent and options.Callback then
                task.spawn(options.Callback, current())
            end
        end

        function control:SetValues(nextValues, preserveSelection)
            local previous = current()
            values = type(nextValues) == "table" and nextValues or {}
            index = 1

            if preserveSelection ~= false and previous ~= nil then
                for i, candidate in ipairs(values) do
                    if candidate == previous then
                        index = i
                        break
                    end
                end
            elseif options.Default ~= nil then
                for i, candidate in ipairs(values) do
                    if candidate == options.Default then
                        index = i
                        break
                    end
                end
            end

            closeDropdown()
            render()
        end

        function control:Close()
            closeDropdown()
        end

        local function openDropdown()
            if opened or #values == 0 then return end

            if self.Window.ActiveDropdown and self.Window.ActiveDropdown ~= control then
                pcall(function()
                    self.Window.ActiveDropdown:Close()
                end)
            end

            opened = true
            self.Window.ActiveDropdown = control
            tween(buttonStroke, {Color = Theme.Accent}, 0.12, Enum.EasingStyle.Quad)
            tween(chevron, {Rotation = 180, ImageColor3 = Theme.Accent}, 0.14, Enum.EasingStyle.Quad)

            local visibleCount = math.min(#values, tonumber(options.MaxVisible) or 6)
            local itemHeight = 28
            local popupHeight = visibleCount * itemHeight + 8

            popup = new("ScrollingFrame", {
                Size = UDim2.fromOffset(button.AbsoluteSize.X, popupHeight),
                BackgroundColor3 = Color3.fromRGB(7, 7, 7),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                CanvasSize = UDim2.fromOffset(0, #values * itemHeight + 8),
                AutomaticCanvasSize = Enum.AutomaticSize.None,
                ScrollBarThickness = #values > visibleCount and 2 or 0,
                ScrollBarImageColor3 = Theme.Accent,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ZIndex = 120,
                ClipsDescendants = true,
            }, self.Window.Gui)
            local popupStroke = stroke(popup, Theme.Border, 1)
            popupStroke.Transparency = 1

            new("UIPadding", {
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
            }, popup)

            local layout = new("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 0),
            }, popup)
            layout.Parent = popup

            local function updatePosition()
                if not popup or not popup.Parent or not row.Parent or not row.Visible or not self.Tab.Page.Visible then
                    closeDropdown()
                    return
                end

                local bPos = button.AbsolutePosition
                local bSize = button.AbsoluteSize
                local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
                local belowY = bPos.Y + bSize.Y + 5
                local aboveY = bPos.Y - popupHeight - 5
                local y = belowY + popupHeight <= viewport.Y - 6 and belowY or math.max(6, aboveY)
                popup.Position = UDim2.fromOffset(bPos.X, y)
                popup.Size = UDim2.fromOffset(bSize.X, popupHeight)
            end

            for i, candidate in ipairs(values) do
                local item = new("TextButton", {
                    Size = UDim2.new(1, 0, 0, itemHeight),
                    BackgroundColor3 = i == index and Color3.fromRGB(245, 245, 245) or Color3.fromRGB(7, 7, 7),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 10,
                    Text = tostring(candidate),
                    TextColor3 = i == index and Color3.fromRGB(0, 0, 0) or Theme.Text,
                    TextTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    AutoButtonColor = false,
                    ZIndex = 121,
                    LayoutOrder = i,
                }, popup)

                new("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                }, item)

                item.MouseEnter:Connect(function()
                    if i ~= index then
                        tween(item, {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(17, 17, 17)}, 0.10, Enum.EasingStyle.Quad)
                    end
                end)

                item.MouseLeave:Connect(function()
                    if i ~= index then
                        tween(item, {BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(7, 7, 7)}, 0.10, Enum.EasingStyle.Quad)
                    end
                end)

                item.MouseButton1Click:Connect(function()
                    index = i
                    render()
                    closeDropdown()
                    if options.Callback then
                        task.spawn(options.Callback, current())
                    end
                end)
            end

            updatePosition()
            tween(popup, {BackgroundTransparency = 0}, 0.12, Enum.EasingStyle.Quad)
            tween(popupStroke, {Transparency = 0}, 0.12, Enum.EasingStyle.Quad)

            for _, child in ipairs(popup:GetChildren()) do
                if child:IsA("TextButton") then
                    local selected = child.LayoutOrder == index
                    tween(child, {
                        TextTransparency = 0,
                        BackgroundTransparency = selected and 0 or 1,
                    }, 0.12, Enum.EasingStyle.Quad)
                end
            end

            followConnection = RunService.RenderStepped:Connect(updatePosition)

            task.defer(function()
                outsideConnection = UIS.InputBegan:Connect(function(input)
                    if not opened then return end
                    if input.UserInputType ~= Enum.UserInputType.MouseButton1
                        and input.UserInputType ~= Enum.UserInputType.Touch
                    then
                        return
                    end

                    local point = input.Position
                    if not pointInside(button, point) and not pointInside(popup, point) then
                        closeDropdown()
                    end
                end)
            end)
        end

        button.MouseButton1Click:Connect(function()
            if opened then
                closeDropdown()
            else
                openDropdown()
            end
        end)

        render()
        return control
    end

    SectionMethods.AddCycle = SectionMethods.AddDropdown

    function SectionMethods:AddInput(options)
        options = options or {}
        local value = tostring(options.Default or "")

        local row, titleLabel = makeRow(
            self,
            40,
            options.Name or "Input",
            nil,
            options.Keywords
        )

        -- Inputs reserve their own responsive right-hand column.  The old
        -- fixed 132px box could collide with the row label on wider text and
        -- allowed long placeholder strings to visually spill into it.
        local inputScale = math.clamp(tonumber(options.InputScale) or 0.48, 0.34, 0.62)
        if titleLabel then
            titleLabel.Size = UDim2.new(1 - inputScale, -28, 0, 20)
            titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
        end

        local box = new("TextBox", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.new(inputScale, -12, 0, 26),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Font = Enum.Font.Code,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextStrokeTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextWrapped = false,
            Text = value,
            PlaceholderText = options.Placeholder or "",
            PlaceholderColor3 = Theme.Muted,
            ClearTextOnFocus = false,
        }, row)
        stroke(box, Theme.Border, 1)

        local control = {}

        function control:Get()
            return value
        end

        function control:Set(nextValue, silent)
            value = tostring(nextValue or "")
            box.Text = value
            if not silent and options.Callback then
                task.spawn(options.Callback, value)
            end
        end

        box.FocusLost:Connect(function()
            value = box.Text
            if options.Numeric then
                local number = tonumber(value)
                if not number then
                    box.Text = tostring(options.Default or 0)
                    value = box.Text
                end
            end

            if options.Callback then
                task.spawn(options.Callback, value)
            end
        end)

        return control
    end

    function SectionMethods:AddButton(options)
        options = options or {}

        local row, titleLabel = makeRow(
            self,
            40,
            options.Name or "Action",
            nil,
            options.Keywords
        )

        if titleLabel then
            titleLabel:Destroy()
        end

        row.BackgroundColor3 = Theme.Background

        local danger = options.Danger == true
        local normalColor = Color3.fromRGB(245, 245, 245)
        local hoverColor = Color3.fromRGB(225, 225, 225)
        local pressColor = Color3.fromRGB(205, 205, 205)
        local dangerColor = Color3.fromRGB(48, 10, 16)
        local dangerHover = Color3.fromRGB(64, 12, 20)
        local dangerPress = Color3.fromRGB(78, 14, 24)

        local button = new("TextButton", {
            Position = UDim2.fromOffset(2, 2),
            Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = danger and dangerColor or normalColor,
            BorderSizePixel = 0,
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = danger and Theme.Danger or Color3.fromRGB(0, 0, 0),
            TextStrokeTransparency = 1,
            Text = tostring(options.ButtonText or options.Name or "Action"),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            AutoButtonColor = false,
        }, row)

        local buttonScale = new("UIScale", {Scale = 1}, button)
        local pressed = false

        button.MouseEnter:Connect(function()
            if not pressed then
                tween(button, {BackgroundColor3 = danger and dangerHover or hoverColor}, 0.10, Enum.EasingStyle.Quad)
            end
        end)

        button.MouseLeave:Connect(function()
            pressed = false
            tween(buttonScale, {Scale = 1}, 0.12, Enum.EasingStyle.Back)
            tween(button, {BackgroundColor3 = danger and dangerColor or normalColor}, 0.10, Enum.EasingStyle.Quad)
        end)

        button.MouseButton1Down:Connect(function()
            pressed = true
            tween(buttonScale, {Scale = 0.975}, 0.07, Enum.EasingStyle.Quad)
            tween(button, {BackgroundColor3 = danger and dangerPress or pressColor}, 0.07, Enum.EasingStyle.Quad)
        end)

        button.MouseButton1Up:Connect(function()
            pressed = false
            tween(buttonScale, {Scale = 1}, 0.16, Enum.EasingStyle.Back)
            tween(button, {BackgroundColor3 = danger and dangerHover or hoverColor}, 0.10, Enum.EasingStyle.Quad)
        end)

        button.MouseButton1Click:Connect(function()
            tween(buttonScale, {Scale = 0.965}, 0.06, Enum.EasingStyle.Quad)
            task.delay(0.06, function()
                if buttonScale and buttonScale.Parent then
                    tween(buttonScale, {Scale = 1}, 0.18, Enum.EasingStyle.Back)
                end
            end)

            if options.Callback then
                task.spawn(options.Callback)
            end
        end)

        return {
            Button = button
        }
    end

    return FlareUI
end

return BuildFlareUI()
