# FlareUI

FlareUI is a compact Roblox UI library built for people to use. 

## Loading the library

```lua
local FlareUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhwifmw/FlareUI/refs/heads/main/FlareUI.lua"))()
```

## Loader

Create a startup loader before building the main window:

```lua
local Loader = FlareUI:CreateLoader({
    Name = "FlareLoader",
    Title = "FLARE HUB | RIVALS",
})

Loader:SetStage("Starting client", 0.15)
Loader:SetStage("Loading systems", 0.55)
Loader:SetStage("Building interface", 0.85)
Loader:Finish()
```

### `FlareUI:CreateLoader(options)`

Supported options:

| Option | Type | Default | Purpose |
| --- | --- | --- | --- |
| `Name` | string | `"FlareLoader"` | ScreenGui name |
| `Title` | string | `"FLARE HUB"` | Loader title |

Returned loader methods:

```lua
Loader:SetStage(text, progress)
Loader:Finish()
```

`progress` is a number from `0` to `1`.

## Window

```lua
local Window = FlareUI:CreateWindow({
    Name = "MyFlareWindow",
    Title = "FLARE HUB | RIVALS",
    Width = 620,
    Height = 440,
    SidebarWidth = 145,
    KeyStatusText = "Key expires: Never",

    OnMinimize = function()
        print("minimized")
    end,

    OnClose = function()
        print("closed")
    end,
})
```

### Window options

| Option | Type | Default | Purpose |
| --- | --- | --- | --- |
| `Name` | string | `"FlareHubUI"` | ScreenGui name |
| `Title` | string | `"FLARE HUB"` | Header title |
| `Width` | number | `620` | Window width |
| `Height` | number | `440` | Window height |
| `SidebarWidth` | number | `145` | Sidebar width |
| `KeyStatusText` | string | `"Key expires: Never"` | Bottom-left profile status text |
| `OnMinimize` | function | nil | Called when the minus button is pressed |
| `OnClose` | function | nil | Called when the X button is pressed |

The bottom-left profile card automatically uses the current player's avatar, display name, and username.

The window is draggable by its header.

## Window methods

### Add a tab

```lua
local Visuals = Window:AddTab({
    Name = "Visuals",
    Icon = "eye",
})
```

You can also pass a string:

```lua
local Settings = Window:AddTab("Settings")
```

`Icon` accepts a Lucide icon name such as `crosshair`, `eye`, `settings`, `move-3d`, `user`, `shield`, or `search`.

### Select a tab

```lua
Window:SelectTab("Visuals")
```

### Search

The sidebar search box is built in. It filters controls live as the text changes. 
Tabs with no matching controls are hidden while searching, and matching result counts appear beside visible tabs.
You can also set the query yourself:

```lua
Window:SetSearch("bypass")
```

Clear it with:

```lua
Window:SetSearch("")
```

### Visibility

```lua
Window:SetVisible(false)
Window:SetVisible(true)
Window:ToggleVisible()
```

If no custom `OnMinimize` callback was supplied, the built-in minus button hides the window automatically.

### Change header callbacks

```lua
Window:SetMinimizeCallback(function()
    Window:SetVisible(false)
end)

Window:SetCloseCallback(function()
    print("close requested")
end)
```

### Active-feature HUD

```lua
Window:SetActive("ESP", true)
Window:SetActive("ESP", false)

Window:SetActive("Rage", true)
Window:SetActive("Silent Aim", true)
```

Enabled entries appear in the compact top-right active-feature list. The HUD hides itself automatically when no entries are active.

### Notification

```lua
Window:Notify("UI hidden - LeftControl to reopen", 2.5)
```

Signature:

```lua
Window:Notify(text, duration)
```

`duration` defaults to approximately 1.8 seconds.

### Confirmation dialog

```lua
Window:Confirm({
    Title = "Unload Flare Hub?",
    Text = "This will disable all active systems and unload the script.",
    ConfirmText = "UNLOAD",
    CancelText = "CANCEL",
    Danger = true,
    Callback = function()
        print("confirmed")
    end,
})
```

Supported fields:

| Option | Type | Purpose |
| --- | --- | --- |
| `Title` | string | Dialog title |
| `Text` | string | Dialog body |
| `ConfirmText` | string | Confirm button text |
| `CancelText` | string | Cancel button text |
| `Danger` | boolean | Uses danger styling |
| `Callback` | function | Runs after confirmation |

### Destroy the UI

```lua
Window:Destroy()
```

`Window:Destroy()` disconnects FlareUI's window connections and destroys its GUI. It does **not** automatically clean up gameplay hooks, render loops, ESP objects, or other systems created by your own script. Your script should disable those first, then call `Window:Destroy()`.

Example:

```lua
local function unload()
    Config.ESP = false
    Config.Rage = false

    -- disconnect your own connections
    -- remove your own drawings/highlights/hooks

    Window:Destroy()
end
```

## Tabs and sections

```lua
local Combat = Window:AddTab({
    Name = "Combat",
    Icon = "crosshair",
})

local Aim = Combat:AddSection("Aim")
local Weapons = Combat:AddSection("Weapon Bypasses")
```

Signature:

```lua
Tab:AddSection(name)
```

## Toggle

```lua
local ESP = Section:AddToggle({
    Name = "ESP",
    Description = "Master visual overlay switch",
    Default = false,
    Keywords = {"visual", "players"},
    FireOnCreate = false,
    Callback = function(enabled)
        print(enabled)
    end,
})
```

Options:

| Option | Type | Default |
| --- | --- | --- |
| `Name` | string | `"Toggle"` |
| `Description` | string | nil |
| `Default` | boolean | `false` |
| `Keywords` | string/table | nil |
| `FireOnCreate` | boolean | `false` |
| `Callback` | function | nil |

Returned control:

```lua
ESP:Get()
ESP:Set(true)
ESP:Set(false)
ESP:Set(true, true) -- silent: updates UI without firing Callback
```

## Slider

```lua
local Speed = Section:AddSlider({
    Name = "Speed",
    Min = 1,
    Max = 100,
    Step = 1,
    Default = 25,
    Keywords = {"movement", "walk"},
    Format = function(value)
        return tostring(value) .. "x"
    end,
    Callback = function(value)
        print(value)
    end,
})
```

Options:

| Option | Type | Default |
| --- | --- | --- |
| `Name` | string | `"Slider"` |
| `Min` | number | `0` |
| `Max` | number | `100` |
| `Step` | number | `1` |
| `Default` | number | `Min` |
| `Keywords` | string/table | nil |
| `Format` | function | automatic number formatting |
| `Callback` | function | nil |

Returned control:

```lua
Speed:Get()
Speed:Set(50)
Speed:Set(50, true)
```

## Keybind

```lua
local RageKey = Section:AddKeybind({
    Name = "Rage Key",
    Default = "G",
    Keywords = {"bind", "hotkey"},
    Callback = function(keyName)
        print("new bind:", keyName)
    end,
})
```

It accepts keyboard keys plus `MouseButton1` and `MouseButton2`.

Returned control:

```lua
RageKey:Get()
RageKey:Set("G")
RageKey:Set("LeftControl", true)
```

## Cycle selector

Use `AddCycle` for a compact click-to-cycle selection control.

```lua
local HitPart = Section:AddCycle({
    Name = "Hit Part",
    Values = {"Head", "Body", "Random"},
    Default = "Head",
    Keywords = {"aim", "target part"},
    Callback = function(value)
        print(value)
    end,
})
```

Returned control:

```lua
HitPart:Get()
HitPart:Set("Body")
HitPart:Set("Random", true)
```

## Input

```lua
local NameInput = Section:AddInput({
    Name = "Profile Name",
    Default = "Flare",
    Placeholder = "Enter text...",
    Numeric = false,
    Keywords = {"text", "input"},
    Callback = function(value)
        print(value)
    end,
})
```

For numeric-only validation:

```lua
local Level = Section:AddInput({
    Name = "Level",
    Default = 100,
    Placeholder = "Enter level...",
    Numeric = true,
    Callback = function(value)
        print(tonumber(value))
    end,
})
```

Returned control:

```lua
NameInput:Get()
NameInput:Set("New value")
NameInput:Set("New value", true)
```

## Button

```lua
Section:AddButton({
    Name = "Save Config",
    ButtonText = "SAVE",
    Keywords = {"config", "settings"},
    Callback = function()
        print("saved")
    end,
})
```

Danger button:

```lua
Section:AddButton({
    Name = "Unload Script",
    ButtonText = "UNLOAD",
    Danger = true,
    Callback = function()
        Window:Confirm({
            Title = "Unload script?",
            Text = "All active systems should be disabled before the UI is destroyed.",
            ConfirmText = "UNLOAD",
            Danger = true,
            Callback = unload,
        })
    end,
})
```

## Themes

The active theme table is exposed as:

```lua
FlareUI.Theme
```

Available fields in the current build:

```lua
FlareUI.Theme.Background
FlareUI.Theme.Panel
FlareUI.Theme.Row
FlareUI.Theme.RowHover
FlareUI.Theme.Border
FlareUI.Theme.Text
FlareUI.Theme.Muted
FlareUI.Theme.Accent
FlareUI.Theme.AccentDim
FlareUI.Theme.Danger
```

You can change these before creating a loader/window:

```lua
FlareUI.Theme.Accent = Color3.fromRGB(157, 92, 255)
FlareUI.Theme.Text = Color3.fromRGB(255, 255, 255)
```

## Full example

```lua
local FlareUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/fhwifmw/FlareUI/refs/heads/main/FlareUI.lua"))()

local Loader = FlareUI:CreateLoader({
    Title = "FLARE HUB | EXAMPLE",
})

Loader:SetStage("Starting", 0.2)

local Window

local function unload()
    if Window then
        Window:Destroy()
        Window = nil
    end
end

Window = FlareUI:CreateWindow({
    Title = "FLARE HUB | EXAMPLE",
    KeyStatusText = "Key expires: Never",
    OnMinimize = function()
        Window:SetVisible(false)
        Window:Notify("UI hidden - LeftControl to reopen", 2)
    end,
    OnClose = function()
        Window:Confirm({
            Title = "Unload script?",
            Text = "Are you sure you want to unload?",
            ConfirmText = "UNLOAD",
            Danger = true,
            Callback = unload,
        })
    end,
})

local Main = Window:AddTab({Name = "Main", Icon = "home"})
local Settings = Window:AddTab({Name = "Settings", Icon = "settings"})

local General = Main:AddSection("General")

local Enabled = General:AddToggle({
    Name = "Enabled",
    Default = false,
    Keywords = {"master", "toggle"},
    Callback = function(value)
        Window:SetActive("Enabled", value)
    end,
})

General:AddSlider({
    Name = "Amount",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,
    Callback = function(value)
        print(value)
    end,
})

General:AddKeybind({
    Name = "Toggle Key",
    Default = "G",
    Callback = function(key)
        print(key)
    end,
})

General:AddCycle({
    Name = "Mode",
    Values = {"Normal", "Fast", "Extreme"},
    Default = "Normal",
    Callback = function(mode)
        print(mode)
    end,
})

local Client = Settings:AddSection("Client")

Client:AddButton({
    Name = "Unload Script",
    ButtonText = "UNLOAD",
    Danger = true,
    Callback = function()
        Window:Confirm({
            Title = "Unload script?",
            Text = "This will close the interface.",
            ConfirmText = "UNLOAD",
            Danger = true,
            Callback = unload,
        })
    end,
})

Loader:SetStage("Ready", 1)
Loader:Finish()
```

## Note
- UI callbacks are spawned with `task.spawn`, so callback work does not directly block the control's click handler.
