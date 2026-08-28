
local function BuildFlareUI()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    local LocalPlayer = Players.LocalPlayer

    local FlareUI = {}
    FlareUI.__index = FlareUI

    local ASSET_VERSION = "v2"
    local ASSET_FOLDER = "FlareHub/assets"

    local AssetData = {
        flare_icon = "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",
        search = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAB7UlEQVR42u2Xz0ocQRDGq2dEMRB0/Ucg5iaYQ7x70oORIPgCQkIeIbl6EH0LQd/CS0ICelMRxIsIuSqas7ribtjdXy7fmMrobpbd3iWgBc1MV9dMfVX9VU2P2ZM8dgmtPATcPRdCoCtIgQD0eOfSp0DSaedpbj6gkdSziek80XUMWAH2gEvgCjgG1oE3+a2J7fwdcMYfuQGu3bwMfNY2pVHTDrx1jr4Ci8AIUACmgQ23vhplOxRJAIaBC718uYH9grJSBWbaBuGiX5Hz747xPQ5gCvRqbS2zBZK2KsOV3KGims90D/FEY0TkLAPjnkMtNRlgUEQrAoVGLHdk3QZqwGyz25A0sV4zs0qT+Mvqrk1Hfs8whIAiLZnZuZn1m9mEdEmDjD0zsykzq5rZz2y5XRKui1ibmvfmul8A+nT/XrbHD7XsVhvQa+CXiLWQJ56bv1KjqgBLURqSy8InRXarUnvpbJ4DH4FT2ZwAQ9G+DS4Tq67bFYEd1fu50//Qdd9VTRIDREayOeALUOJvOQI+AC+AA+n2YoNI3f04MKMxmeNCQc47A6JBI0odZzoHwlVAmp2EPCjHmXog4p4X/kFcD2IXGM0+Yt0GsSsQ39SgUuuGOBCDwJaqKHT8AFvv+B71v6BFECGEUHv6Ffvv5DdNjQ/G698EvQAAAABJRU5ErkJggg==",
        combat = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACgUlEQVR42tWXO2tUURSF1753kmCI+IwgmkYRJChYpPBFCh9IwMLKRkX9BWphYRHir1BIShvBwlJBEK0koCSoiK3xVRmMGtQkM5+F6+Jx0OjcmUl0w+HMPbNn7cfZe909UhMCBBD6nyWazECPpA5JHyNiYcm8BjLvN4FpYK+f80axsiZ9WSVpjbNQSpp1YEESXsviQDRbR1mZ1pNU8U5ynpfBqzRoPI+IqqQ5P1fsRM3n1USnbZW/ARgGHgBVvstz4CqwI8lSW4wfAV7yQz64DQv5Cpw3Q+atMp57P5QYug0cdTbWAbuB0eT7kbK88Euut5E3Br+0iP4QMOurGWzYCSCrW512YNjG7yTFJ6DDdCygy/vlQhfIrZPX4UajmXjoqA4nWRkAnjozZ5MAeoEZ18P6PxIJEBGBI7kmqcetlXmvSNovaVbS1oh4B3RLmpS0zTg1STsj4pkduSdpUNIjSe9NVgVjhqSLETEJZCkPdEk6toizVS+Z+3sNOC+p0++FQuZtaOA3WBsdQFQiomCzGUn7EnIq7imXNCapT9IWYCIiZoALkkZt/Iqkcd/tCkn9dvaEpLfOZi1x4HGSub+qgSsurLG6gusH9tSdnbTuk1I9X7eKCt4OzLmwhhb5fR8wZQdOJZ1UjxtliOicgT+71TYlOiuB08AL69wojLWaikcStvsE3AfuAq+T8+vA2pYPrAUYcBC4BXzhZ5kAztTrt/qllCefNwPjwDxwPMlSQ5E3NA9ERLVwIiJeAdPGmIqIGtAZEXNtnYg8bOCIi2G0y1E3PIiUngkjopaMZCSEtqRDac1r2abibmNUtJSStOQu4ACwum2t96//Oc2MUStbhN8AfTfMcaTnSRIAAAAASUVORK5CYII=",
        visuals = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACvUlEQVR42u2WTUhUURTH/+fNjNTkiBlIKSFUhhlFlBUthMigFm3aRrlrVUTQVmhTy1YRZG2Cdn1JGLSoldIywqAM+gDTIJQi0QrCmV+b8+D6euN8QLiZA8Mb7j33nP8953/OPVJDGrLKYvUeBJadNTP+KwAgkhRJQhJmVkoBFLnNUnK/bgDu2MysmFgvuMM4AvNpgJLnqgaQNAB0SjoiqV/SNkl7JOU8IpI0KWlK0pik52b2LkxVTSkK8wvsBG4BP1kuv4BFX1/gX3kKDCQiWb1zIAdcA5bc4CLwCDgP9APtQAFoBjYAB4BB4DYwHQAZBTqqAhE4bwXG3cA8MOQpSOrngHUp6wUHM+k2ZoC9FUEAEdAEjPjBF0B3sJ8FDNgMDANfHOAIcCgGFei3uF4MotPPW+rt/bcR+AR8ANYHN834/iZgKsEFgD/AUdfPANnA9n0/s99tRJVSkAe6YmOJ7013+Bjo9ltd9bW3HkELImqekrVpDaxaTsTfZuCr37oLuAO8BtqAl0AJ6AsBr9Q9JSlbrv69myVrNyMpL2lJ0oKkg5J6JK2R9M37Sr5cM5NUqun2IWECDox6uK84X7YAJ4EiMOvEC89FtTpsAx4AT4K9TMCBPncG8Ap4FhDyXKAfxUQELgP3gK2VqiDyG7x3gzcCIxaXGHAcmAgcTwMX3HFTmH/grHMDYHelKoj82wvMBb1gIEU3693vMNCSst8L3A1Ani5HznIgtgNjgYFx4CKwL+4PKd2vBzgDPAzSNAMcK+fcyoEws5KH/JSkS5J2BSo/JE04q2N290jqCHTmJF2XNGxms0Cm0tOcGgn/3wSc8IfmjT9MSVkCPjvZBoH2kMR1DSRpQ4UDa5W0w/tCLB8lfTez3wnHpZVmAauhI0Y+WBQr6GbcbrGaIaTmoTSo4WQpxbNiXcNpQxqyavIXnUPA5P/wpI8AAAAASUVORK5CYII=",
        movement = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAACeklEQVR42uWWvWtUQRTFz7z3TEQtTIIKgqilYCHGxEZMjNiJf0UaGxstJCCCnQZsxf9CRPEbO2MSLCysRBsRxI/Efs3+bM7Ey7q72c3upsnAMjPv3rfnvrn3nLnSdh+pl5eB0st6SoktjRxI7fYDBc5gwFXgEjDmfbEV4KXX9/k3FoHRgQYRj7gBvOb5LTAykHT4ywtgD3DPgF+Az17/8LwA7Itp6lcA+dinDLQKHAceeH8ReOb1c6AKDOlbzgvPs8CM168NOgHsBB4D58OJlX05iWaFZYAXDuBcN5SNo2hHNYNMpZTqMR1AFZ9JWrN/5XeS/a4DB1JKdMyOFlSbbaiFnI58AmdDcNlnzrY3gR1FNyKTwVeAC/nL/YV5fmmfae932FYBR03NrBMbUzT8SQb/BBxr4/80F2EL+1A4pUXgUE7Rf5cRUKaU1oBrkuYl1SR9lfRB0i5Jaw2XGJJOShqV9E7Sanie66smaUzSCUmVpJsppVsZS37YOD4GkCP+bTTGN7D/8XwaqCStF3AMoO4iWZa0JGlS0jdJlyV9lzQUXiy8vmvwK5LeSyp9Usn27DMpaUXSnWBvzVdgxDnDeR5u4f/EPqda2G/b/ivXSSdMKEIQC/6DV8Cwi6p0oZYNLChtzz4ztv0O4FVXygfsBR42kdeyhQ4MNZHt6a7AO+1wHFAOYCqkr+hEyttKsSRZPqMkR3k96B4w33g1+880ke2iQbZ7uo7nQvOxG3jk/Tgw30y2+92QHLa24wJc9nopVPt6vQykJTM7ssbXQ0v2s2Oq9doXAKMhiNySTWyq2nsIYj9wwzQ9syXg7Si62WNPPQaxrv09U23bjr9trb9czLA2SQAAAABJRU5ErkJggg==",
        client = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAABvUlEQVR42u3WvWsUURQF8DvZWbEyUUHRNLYiNqIoElAsrCxEsLdIei0FC2vttBC0srC1sRDETrDwLwhY2iSiIpHgx5r8LLyDj7DixJ0kLOxt3nzc986Z8+49byImMc6BCtVOAPcwtYFIb7vAS+A9mCmJbAs4LuApPmAFr3BtS7elAF/wJ37gS3H/EFOlSp3teY7nEmgN1zGLvbiMpXx3s5zTZdFVeJYgN4bknMF3vMd0Z1vRLJIF9xmr2J+kGmL9zHmdBOfaqlBvgstURPQjYj0iBhGh5Jnjao79zgsQNd7kF14aknMwO+IbZjttS/STxNUswCXMZQHuw5FC/nvNnK0wnqNYLDrhY3rB13y2UqozcicU7XcYj7LK28RznM659ajgp/CuMJ7HuILjOIvzqcxF3MVy5g6w8F8kCtc7mRLDExxrMfcAbhdqzG/cylZHbJrJ21zkQfG+bk7Dwgua67rIm08VBjjRmkSzCG4l+IvCDXstP2BXXjdKvPzbGTGM0XqOhyLiU0TcyX6uqqpa+xeBqqpExM8Eux8RyxExHRG7f3PahDdgZtSTLdeoYyyjCyvdsf/GSUxiEmMTvwC9qZDCrvk0XwAAAABJRU5ErkJggg==",
        settings = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAC2ElEQVR42tWXz2oUQRDGv5rMRtDE3c0foihEwZseAl5M/IOSm+AhLyB68C6e1PgCPoIivoCHQHKLIIIm6jF6UTwqKB6MxkRM1Pl5sJo0w8xudjYE0tDMdHp7qurrr+qrSLt5AAbYrg7Cuog+ldQv6beZre4YxECPPyeAr8CMr5MqNtKW8JgRHAnv0ahJakqqlzm/+RnLymwkbQ4L6DMzCiLE55+i82aGz6xVkEmJcQP2AY8kPQcaZpblnCCa8fnEHW4As8CkX2XS0b0DA8AS/8ci0IzIJ+CC7y0EwwE5oOlnAOaBNHBny074sw68CIaAUTeUuoNngRPucM33hiLji8BwpXoRIMtFczsPJVCL3z3iPGpWNQ2DEyPAzQj+SWAGWAZWgWfA1WhvDmhUSs+IA1ZEHuAam2MD+BGt75VlU7cFqcfv/bwb+gtcBw4526eAz743HcjqnMhPaxf9fidfPHt9f86N3Cgg7DiwDnwB6h3D7s8G8MFhXQG++/uEe78C/AQGgT3u0DvgiJ9/6Q6O++9ngcdOzHl/H4u5kXbgZyKp1yvfhq+PSzrqoiRJa1GJN0mXCr4zEguhFSDRn/u7+YeRtCDppKQpM5sDDktqmtkb4ICkt+7kMUmfJJ0uqLavzexbib60JKEBVxzij8CZaH/UUxHgYShWXUlwizS8H6XdK+AJsBatB+OewZ2Pp1UpRA0n3KSv7zgKYawBD4AB378FjHTTJ6iFsNSCTAOnPEMORuemC0px5Wo4nBOWIb/fWkGHFOAedeHChazecVWMKl+hsISK5nm+EggZaUWM2pIrZ6EiljEVSZmku5J+SbrsqZN4Y2LedPR52vZs+k5iZsvARUlPJb2XtO7pTDd6YAXknAcy4FzuOsJ+XzthSreQBcQNaklfSK6ZDSit5hvcTrvirA0we73SpUUddYh6yxWvQoqOeW/Y2Fb93xX/mkUcMUnZtsO8U+MfZCMOKiTdKGEAAAAASUVORK5CYII=",
    }

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

    local function makeScreenGui(name)
        local gui = new("ScreenGui", {
            Name = name,
            ResetOnSpawn = false,
            IgnoreGuiInset = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 100000,
        })

        local parent = resolveParent()
        if parent then
            gui.Parent = parent
        end

        return gui
    end

    function FlareUI:CreateLoader(options)
        options = options or {}

        local gui = makeScreenGui(options.Name or "FlareLoader")
        local group = new("CanvasGroup", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            GroupTransparency = 0,
        }, gui)

        local center = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.48),
            Size = UDim2.fromOffset(280, 230),
            BackgroundTransparency = 1,
        }, group)

        local rotator = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0, 67),
            Size = UDim2.fromOffset(112, 112),
            BackgroundTransparency = 1,
            Rotation = 0,
        }, center)

        local lineDefs = {
            {UDim2.fromOffset(42, 0), UDim2.fromOffset(70, 2), Theme.Accent},
            {UDim2.new(1, -2, 0, 42), UDim2.fromOffset(2, 70), Theme.Text},
            {UDim2.fromOffset(0, 110), UDim2.fromOffset(70, 2), Theme.Accent},
            {UDim2.fromOffset(0, 0), UDim2.fromOffset(2, 70), Theme.Text},
        }

        for _, def in ipairs(lineDefs) do
            new("Frame", {
                Position = def[1],
                Size = def[2],
                BackgroundColor3 = def[3],
                BorderSizePixel = 0,
            }, rotator)
        end

        local iconHolder = new("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0, 67),
            Size = UDim2.fromOffset(82, 82),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
        }, center)

        stroke(iconHolder, Theme.Accent, 1)

        local flareAsset = resolveAsset("flare_icon")
        local icon
        if flareAsset then
            icon = new("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(74, 74),
                BackgroundTransparency = 1,
                Image = flareAsset,
                ScaleType = Enum.ScaleType.Fit,
            }, iconHolder)
        else
            icon = new("TextLabel", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Text = "F",
                Font = Enum.Font.GothamBlack,
                TextSize = 38,
                TextColor3 = Theme.Accent,
            }, iconHolder)
        end

        local iconScale = new("UIScale", {Scale = 1}, iconHolder)

        local title = new("TextLabel", {
            Position = UDim2.fromOffset(0, 132),
            Size = UDim2.new(1, 0, 0, 26),
            BackgroundTransparency = 1,
            Text = options.Title or "FLARE HUB",
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Center,
        }, center)

        local status = new("TextLabel", {
            Position = UDim2.fromOffset(0, 158),
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1,
            Text = "STARTING CLIENT",
            Font = Enum.Font.GothamMedium,
            TextSize = 9,
            TextColor3 = Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Center,
        }, center)

        local rail = new("Frame", {
            Position = UDim2.new(0.5, -92, 0, 194),
            Size = UDim2.fromOffset(184, 2),
            BackgroundColor3 = Color3.fromRGB(36, 36, 36),
            BorderSizePixel = 0,
        }, center)

        local fill = new("Frame", {
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
        }, rail)

        local spinTween = TweenService:Create(
            rotator,
            TweenInfo.new(1.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
            {Rotation = 360}
        )
        spinTween:Play()

        local pulseTween = TweenService:Create(
            iconScale,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Scale = 1.06}
        )
        pulseTween:Play()

        local loader = {
            Gui = gui,
            Group = group,
            Status = status,
            Fill = fill,
            SpinTween = spinTween,
            PulseTween = pulseTween,
            Finished = false,
        }

        function loader:SetStage(text, progress)
            if self.Finished then return end
            if text then
                self.Status.Text = string.upper(tostring(text))
            end
            if progress ~= nil then
                local p = math.clamp(tonumber(progress) or 0, 0, 1)
                tween(self.Fill, {Size = UDim2.new(p, 0, 1, 0)}, 0.18)
            end
        end

        function loader:Finish()
            if self.Finished then return end
            self.Finished = true
            self.Status.Text = "READY"
            tween(self.Fill, {Size = UDim2.new(1, 0, 1, 0)}, 0.12)
            tween(iconScale, {Scale = 1.12}, 0.12, Enum.EasingStyle.Quad)
            task.delay(0.16, function()
                pcall(function()
                    self.SpinTween:Cancel()
                    self.PulseTween:Cancel()
                end)
                tween(self.Group, {GroupTransparency = 1}, 0.22, Enum.EasingStyle.Quad)
                task.delay(0.24, function()
                    if self.Gui then
                        self.Gui:Destroy()
                    end
                end)
            end)
        end

        return loader
    end

    local WindowMethods = {}
    WindowMethods.__index = WindowMethods

    local TabMethods = {}
    TabMethods.__index = TabMethods

    local SectionMethods = {}
    SectionMethods.__index = SectionMethods

    local function createIcon(parent, name, size, tint)
        local asset = resolveAsset(name)
        if asset then
            return new("ImageLabel", {
                Size = UDim2.fromOffset(size or 16, size or 16),
                BackgroundTransparency = 1,
                Image = asset,
                ImageColor3 = tint or Theme.Muted,
                ScaleType = Enum.ScaleType.Fit,
            }, parent)
        end

        return new("TextLabel", {
            Size = UDim2.fromOffset(size or 16, size or 16),
            BackgroundTransparency = 1,
            Text = string.upper(string.sub(name or "?", 1, 1)),
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = tint or Theme.Muted,
        }, parent)
    end

    local function normalizeSearchText(value)
        value = tostring(value or ""):lower()
        value = value:gsub("^%s+", ""):gsub("%s+$", "")
        return value
    end

    function FlareUI:CreateWindow(options)
        options = options or {}

        local gui = makeScreenGui(options.Name or "FlareHubUI")

        local mainGroup = new("CanvasGroup", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.52),
            Size = UDim2.fromOffset(options.Width or 620, options.Height or 440),
            BackgroundColor3 = Theme.Background,
            BorderSizePixel = 0,
            GroupTransparency = 1,
        }, gui)

        stroke(mainGroup, Theme.Border, 1)

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
            Size = UDim2.new(1, -40, 1, 0),
            BackgroundTransparency = 1,
            Text = options.Title or "FLARE HUB",
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, header)

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

        local navContainer = new("Frame", {
            Position = UDim2.fromOffset(8, 50),
            Size = UDim2.new(1, -16, 1, -58),
            BackgroundTransparency = 1,
        }, sidebar)

        new("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
        }, navContainer)

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
            Header = header,
            Sidebar = sidebar,
            NavContainer = navContainer,
            Content = content,
            SearchBox = searchBox,
            SearchFrame = searchFrame,
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
            Visible = true,
            Destroyed = false,
        }, WindowMethods)

        local dragging = false
        local dragStart
        local startPos

        table.insert(window.Connections, header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = mainGroup.Position
            end
        end))

        table.insert(window.Connections, UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                mainGroup.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end))

        table.insert(window.Connections, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end))

        table.insert(window.Connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            window:SetSearch(searchBox.Text)
        end))

        table.insert(window.Connections, UIS.InputChanged:Connect(function(input)
            if window.ActiveSliderDrag
                and input.UserInputType == Enum.UserInputType.MouseMovement
            then
                window.ActiveSliderDrag(input.Position.X)
            end
        end))

        table.insert(window.Connections, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                window.ActiveSliderDrag = nil
            end
        end))

        mainGroup.Position = UDim2.fromScale(0.5, 0.54)
        tween(mainGroup, {
            GroupTransparency = 0,
            Position = UDim2.fromScale(0.5, 0.5),
        }, 0.24, Enum.EasingStyle.Quart)

        return window
    end

    function WindowMethods:_registerEntry(entry)
        table.insert(self.Entries, entry)
    end

    function WindowMethods:_registerSection(section)
        table.insert(self.Sections, section)
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
            Visible = false,
        }, self.Content)

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

        self.CurrentTab = name

        for _, item in ipairs(self.TabOrder) do
            local selected = item == tab
            item.Page.Visible = selected
            item.Indicator.Visible = selected
            item.Label.TextColor3 = selected and Theme.Text or Theme.Muted
            if item.Icon:IsA("ImageLabel") or item.Icon:IsA("ImageButton") then
                item.Icon.ImageColor3 = selected and Theme.Accent or Theme.Muted
            elseif item.Icon:IsA("TextLabel") or item.Icon:IsA("TextButton") then
                item.Icon.TextColor3 = selected and Theme.Accent or Theme.Muted
            end
            item.Button.BackgroundColor3 = selected and Theme.Row or Theme.Background
        end
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
                        tab.Page.Visible = false
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
        self.Visible = value == true
        self.Main.Visible = self.Visible
    end

    function WindowMethods:ToggleVisible()
        self:SetVisible(not self.Visible)
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
        local row = new("Frame", {
            Size = UDim2.new(1, 0, 0, height or 44),
            BackgroundColor3 = Theme.Row,
            BorderSizePixel = 0,
        }, section.Tab.Page)

        stroke(row, Theme.Border, 1)

        local titleLabel = new("TextLabel", {
            Position = UDim2.fromOffset(12, description and 5 or 0),
            Size = UDim2.new(1, -112, description and 0 or 1, description and 18 or 0),
            BackgroundTransparency = 1,
            Text = title,
            Font = Enum.Font.GothamMedium,
            TextSize = 11,
            TextColor3 = Theme.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
        }, row)

        if description and description ~= "" then
            new("TextLabel", {
                Position = UDim2.fromOffset(12, 23),
                Size = UDim2.new(1, -112, 0, 15),
                BackgroundTransparency = 1,
                Text = description,
                Font = Enum.Font.Gotham,
                TextSize = 9,
                TextColor3 = Theme.Muted,
                TextXAlignment = Enum.TextXAlignment.Left,
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
        local row = makeRow(
            self,
            options.Description and 46 or 40,
            options.Name or "Toggle",
            options.Description,
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

        stroke(button, Color3.fromRGB(75, 75, 75), 1)

        local knob = new("Frame", {
            Position = UDim2.fromOffset(3, 3),
            Size = UDim2.fromOffset(16, 16),
            BackgroundColor3 = Theme.Muted,
            BorderSizePixel = 0,
        }, button)

        local control = {}

        local function render()
            button.BackgroundColor3 = value and Theme.AccentDim or Color3.fromRGB(18, 18, 18)
            knob.BackgroundColor3 = value and Theme.Accent or Theme.Muted
            knob.Position = value and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)
        end

        function control:Get()
            return value
        end

        function control:Set(nextValue, silent)
            nextValue = nextValue == true
            if value == nextValue and not silent then
                render()
                return
            end

            value = nextValue
            render()

            if not silent and options.Callback then
                task.spawn(options.Callback, value)
            end
        end

        button.MouseButton1Click:Connect(function()
            control:Set(not value)
        end)

        render()

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

        local row = makeRow(
            self,
            54,
            options.Name or "Slider",
            nil,
            options.Keywords
        )

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

        row.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local y = input.Position.Y
                if y >= rail.AbsolutePosition.Y - 8
                    and y <= rail.AbsolutePosition.Y + rail.AbsoluteSize.Y + 8
                then
                    dragging = true
                    section.Window.ActiveSliderDrag = setFromX
                    setFromX(input.Position.X)
                end
            end
        end)

        row.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                if section.Window.ActiveSliderDrag == setFromX then
                    section.Window.ActiveSliderDrag = nil
                end
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

    function SectionMethods:AddCycle(options)
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
            Size = UDim2.fromOffset(116, 26),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Font = Enum.Font.GothamMedium,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextStrokeTransparency = 1,
            AutoButtonColor = false,
        }, row)
        stroke(button, Theme.Border, 1)

        local control = {}

        local function current()
            return values[index]
        end

        local function render()
            button.Text = tostring(current() or "None")
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

        button.MouseButton1Click:Connect(function()
            if #values == 0 then return end
            index = index % #values + 1
            render()
            if options.Callback then
                task.spawn(options.Callback, current())
            end
        end)

        render()
        return control
    end

    function SectionMethods:AddInput(options)
        options = options or {}
        local value = tostring(options.Default or "")

        local row = makeRow(
            self,
            40,
            options.Name or "Input",
            nil,
            options.Keywords
        )

        local box = new("TextBox", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(132, 26),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Font = Enum.Font.Code,
            TextSize = 10,
            TextColor3 = Theme.Text,
            TextStrokeTransparency = 1,
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

        local row = makeRow(
            self,
            40,
            options.Name or "Action",
            nil,
            options.Keywords
        )

        local button = new("TextButton", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(92, 26),
            BackgroundColor3 = options.Danger and Color3.fromRGB(48, 10, 16) or Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Font = Enum.Font.GothamBold,
            TextSize = 9,
            TextColor3 = options.Danger and Theme.Danger or Theme.Text,
            TextStrokeTransparency = 1,
            Text = string.upper(options.ButtonText or "RUN"),
            AutoButtonColor = false,
        }, row)

        stroke(button, options.Danger and Theme.Danger or Theme.Border, 1)

        button.MouseButton1Click:Connect(function()
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
