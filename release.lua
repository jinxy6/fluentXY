--[[
  ______ _                  _    __   ____     __
 |  ____| |                | |   \ \ / /\ \   / /
 | |__  | |_   _  ___ _ __ | |_   \ V /  \ \_/ / 
 |  __| | | | | |/ _ \ '_ \| __|   > <    \   /  
 | |    | | |_| |  __/ | | | |_   / . \    | |   
 |_|    |_|\__,_|\___|_| |_|\__| /_/ \_\   |_|   

 FluentXY UI Library
 Customized for Kovak
]]

-- Global thread hooking removed because it breaks CoreGui / UI Library capabilities.

local cloneref = cloneref or function(o) return o end
local Lighting = cloneref(game:GetService("Lighting"))
local RunService = cloneref(game:GetService("RunService"))
local Players = cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local TextService = cloneref(game:GetService("TextService"))
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local httpService = cloneref(game:GetService("HttpService"))
local SoundService = cloneref(game:GetService("SoundService"))

local Mobile = (table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) ~= nil) or (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

local fischbypass

if game.GameId == 5750914919 then
	fischbypass = true
end

local RenderStepped = RunService.Heartbeat

local ProtectGui = protectgui or (syn and syn.protect_gui) or (Fluxus and Fluxus.protect_gui) or function() end

local Themes = {
	Names = {
		"Glass",
		"Dark",
		"Cyberpunk",
		"Catppuccin",
		"TokyoNight",
		"Obsidian",
		"Emerald",
		"Amethyst",
		"Sunset",
		"Aurora"
	},
	Glass = {
		Name = "Glass",
		Accent = Color3.fromRGB(0, 180, 255),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(120, 220, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 160, 255)),
		}),
		AcrylicMain = Color3.fromRGB(15, 18, 24),
		AcrylicBorder = Color3.fromRGB(120, 180, 255),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.3, Color3.fromRGB(130, 225, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 140, 255)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 48, 72)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 24, 38)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 14, 22)),
		}),
		AcrylicNoise = 0.96,
		TitleBarLine = Color3.fromRGB(55, 65, 80),
		Tab = Color3.fromRGB(140, 155, 175),
		Element = Color3.fromRGB(30, 36, 48),
		ElementBorder = Color3.fromRGB(50, 60, 80),
		InElementBorder = Color3.fromRGB(70, 85, 110),
		ElementTransparency = 0.72,
		ToggleSlider = Color3.fromRGB(140, 160, 185),
		ToggleToggled = Color3.fromRGB(0, 180, 255),
		SliderRail = Color3.fromRGB(45, 55, 75),
		DropdownFrame = Color3.fromRGB(24, 28, 38),
		DropdownHolder = Color3.fromRGB(18, 22, 30),
		DropdownBorder = Color3.fromRGB(50, 60, 80),
		DropdownOption = Color3.fromRGB(32, 38, 52),
		Keybind = Color3.fromRGB(35, 42, 58),
		Input = Color3.fromRGB(26, 32, 44),
		InputFocused = Color3.fromRGB(16, 20, 28),
		InputIndicator = Color3.fromRGB(90, 110, 140),
		InputIndicatorFocus = Color3.fromRGB(0, 180, 255),
		Dialog = Color3.fromRGB(20, 24, 32),
		DialogHolder = Color3.fromRGB(15, 18, 24),
		DialogHolderLine = Color3.fromRGB(35, 42, 55),
		DialogButton = Color3.fromRGB(28, 34, 46),
		DialogButtonBorder = Color3.fromRGB(55, 65, 85),
		DialogBorder = Color3.fromRGB(45, 55, 75),
		DialogInput = Color3.fromRGB(24, 28, 38),
		DialogInputLine = Color3.fromRGB(60, 75, 100),
		Text = Color3.fromRGB(245, 248, 255),
		SubText = Color3.fromRGB(150, 165, 185),
		Hover = Color3.fromRGB(45, 55, 75),
		HoverChange = 0.05,
	},
	Dark = {
		Name = "Dark",
		Accent = Color3.fromRGB(96, 205, 255),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 220, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(96, 205, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 140, 245)),
		}),
		AcrylicMain = Color3.fromRGB(24, 25, 29),
		AcrylicBorder = Color3.fromRGB(70, 85, 115),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 220, 255)),
			ColorSequenceKeypoint.new(0.35, Color3.fromRGB(96, 205, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 65, 95)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(36, 42, 54)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 28, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 17, 22)),
		}),
		AcrylicNoise = 0.94,
		TitleBarLine = Color3.fromRGB(48, 50, 60),
		Tab = Color3.fromRGB(150, 155, 170),
		Element = Color3.fromRGB(34, 36, 44),
		ElementBorder = Color3.fromRGB(46, 48, 58),
		InElementBorder = Color3.fromRGB(65, 68, 82),
		ElementTransparency = 0.82,
		ToggleSlider = Color3.fromRGB(130, 135, 150),
		ToggleToggled = Color3.fromRGB(42, 42, 42),
		SliderRail = Color3.fromRGB(50, 52, 64),
		DropdownFrame = Color3.fromRGB(36, 38, 48),
		DropdownHolder = Color3.fromRGB(28, 30, 36),
		DropdownBorder = Color3.fromRGB(48, 50, 62),
		DropdownOption = Color3.fromRGB(42, 44, 56),
		Keybind = Color3.fromRGB(42, 44, 56),
		Input = Color3.fromRGB(34, 36, 44),
		InputFocused = Color3.fromRGB(16, 17, 20),
		InputIndicator = Color3.fromRGB(110, 115, 130),
		Dialog = Color3.fromRGB(26, 28, 34),
		DialogHolder = Color3.fromRGB(20, 21, 25),
		DialogHolderLine = Color3.fromRGB(36, 38, 46),
		DialogButton = Color3.fromRGB(34, 36, 44),
		DialogButtonBorder = Color3.fromRGB(58, 60, 72),
		DialogBorder = Color3.fromRGB(50, 52, 64),
		DialogInput = Color3.fromRGB(30, 32, 38),
		DialogInputLine = Color3.fromRGB(70, 74, 90),
		Text = Color3.fromRGB(245, 246, 250),
		SubText = Color3.fromRGB(160, 165, 180),
		Hover = Color3.fromRGB(48, 50, 62),
		HoverChange = 0.05,
	},
	Cyberpunk = {
		Name = "Cyberpunk",
		Accent = Color3.fromRGB(255, 230, 0),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 240, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 230, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 128)),
		}),
		AcrylicMain = Color3.fromRGB(13, 10, 20),
		AcrylicBorder = Color3.fromRGB(255, 230, 0),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 240, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 230, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 128)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 18, 64)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 12, 34)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 8, 16)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(80, 40, 100),
		Tab = Color3.fromRGB(180, 150, 220),
		Element = Color3.fromRGB(26, 20, 38),
		ElementBorder = Color3.fromRGB(60, 40, 85),
		InElementBorder = Color3.fromRGB(110, 70, 150),
		ElementTransparency = 0.85,
		ToggleSlider = Color3.fromRGB(180, 140, 230),
		ToggleToggled = Color3.fromRGB(255, 230, 0),
		SliderRail = Color3.fromRGB(50, 35, 70),
		DropdownFrame = Color3.fromRGB(25, 18, 36),
		DropdownHolder = Color3.fromRGB(18, 12, 28),
		DropdownBorder = Color3.fromRGB(80, 50, 110),
		DropdownOption = Color3.fromRGB(35, 25, 50),
		Keybind = Color3.fromRGB(35, 25, 50),
		Input = Color3.fromRGB(28, 20, 40),
		InputFocused = Color3.fromRGB(15, 10, 22),
		InputIndicator = Color3.fromRGB(150, 100, 210),
		InputIndicatorFocus = Color3.fromRGB(255, 230, 0),
		Dialog = Color3.fromRGB(20, 14, 30),
		DialogHolder = Color3.fromRGB(15, 10, 22),
		DialogHolderLine = Color3.fromRGB(45, 30, 65),
		DialogButton = Color3.fromRGB(30, 20, 45),
		DialogButtonBorder = Color3.fromRGB(75, 45, 110),
		DialogBorder = Color3.fromRGB(70, 45, 100),
		DialogInput = Color3.fromRGB(26, 18, 38),
		DialogInputLine = Color3.fromRGB(120, 80, 170),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(190, 160, 220),
		Hover = Color3.fromRGB(45, 32, 65),
		HoverChange = 0.05,
	},
	Catppuccin = {
		Name = "Catppuccin",
		Accent = Color3.fromRGB(203, 166, 247),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 194, 231)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(203, 166, 247)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 190, 254)),
		}),
		AcrylicMain = Color3.fromRGB(24, 24, 37),
		AcrylicBorder = Color3.fromRGB(203, 166, 247),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(245, 194, 231)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(203, 166, 247)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 190, 254)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 35, 58)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 23, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 27)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(49, 50, 68),
		Tab = Color3.fromRGB(186, 194, 222),
		Element = Color3.fromRGB(30, 30, 46),
		ElementBorder = Color3.fromRGB(49, 50, 68),
		InElementBorder = Color3.fromRGB(69, 71, 90),
		ElementTransparency = 0.85,
		ToggleSlider = Color3.fromRGB(186, 194, 222),
		ToggleToggled = Color3.fromRGB(203, 166, 247),
		SliderRail = Color3.fromRGB(49, 50, 68),
		DropdownFrame = Color3.fromRGB(30, 30, 46),
		DropdownHolder = Color3.fromRGB(24, 24, 37),
		DropdownBorder = Color3.fromRGB(49, 50, 68),
		DropdownOption = Color3.fromRGB(36, 36, 54),
		Keybind = Color3.fromRGB(36, 36, 54),
		Input = Color3.fromRGB(30, 30, 46),
		InputFocused = Color3.fromRGB(17, 17, 27),
		InputIndicator = Color3.fromRGB(108, 112, 134),
		InputIndicatorFocus = Color3.fromRGB(203, 166, 247),
		Dialog = Color3.fromRGB(24, 24, 37),
		DialogHolder = Color3.fromRGB(17, 17, 27),
		DialogHolderLine = Color3.fromRGB(49, 50, 68),
		DialogButton = Color3.fromRGB(30, 30, 46),
		DialogButtonBorder = Color3.fromRGB(69, 71, 90),
		DialogBorder = Color3.fromRGB(58, 59, 78),
		DialogInput = Color3.fromRGB(30, 30, 46),
		DialogInputLine = Color3.fromRGB(88, 91, 112),
		Text = Color3.fromRGB(205, 214, 244),
		SubText = Color3.fromRGB(166, 173, 200),
		Hover = Color3.fromRGB(49, 50, 68),
		HoverChange = 0.05,
	},
	TokyoNight = {
		Name = "TokyoNight",
		Accent = Color3.fromRGB(122, 162, 247),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 154, 247)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(122, 162, 247)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 195, 222)),
		}),
		AcrylicMain = Color3.fromRGB(18, 19, 28),
		AcrylicBorder = Color3.fromRGB(122, 162, 247),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 154, 247)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(122, 162, 247)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(42, 195, 222)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 35, 54)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 23, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 23)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(35, 38, 54),
		Tab = Color3.fromRGB(169, 177, 214),
		Element = Color3.fromRGB(26, 27, 38),
		ElementBorder = Color3.fromRGB(41, 46, 66),
		InElementBorder = Color3.fromRGB(65, 72, 104),
		ElementTransparency = 0.85,
		ToggleSlider = Color3.fromRGB(169, 177, 214),
		ToggleToggled = Color3.fromRGB(122, 162, 247),
		SliderRail = Color3.fromRGB(41, 46, 66),
		DropdownFrame = Color3.fromRGB(26, 27, 38),
		DropdownHolder = Color3.fromRGB(18, 19, 28),
		DropdownBorder = Color3.fromRGB(41, 46, 66),
		DropdownOption = Color3.fromRGB(33, 34, 49),
		Keybind = Color3.fromRGB(33, 34, 49),
		Input = Color3.fromRGB(26, 27, 38),
		InputFocused = Color3.fromRGB(15, 15, 23),
		InputIndicator = Color3.fromRGB(86, 95, 137),
		InputIndicatorFocus = Color3.fromRGB(122, 162, 247),
		Dialog = Color3.fromRGB(18, 19, 28),
		DialogHolder = Color3.fromRGB(15, 15, 23),
		DialogHolderLine = Color3.fromRGB(35, 38, 54),
		DialogButton = Color3.fromRGB(26, 27, 38),
		DialogButtonBorder = Color3.fromRGB(56, 63, 92),
		DialogBorder = Color3.fromRGB(45, 50, 72),
		DialogInput = Color3.fromRGB(26, 27, 38),
		DialogInputLine = Color3.fromRGB(86, 95, 137),
		Text = Color3.fromRGB(192, 202, 245),
		SubText = Color3.fromRGB(120, 130, 170),
		Hover = Color3.fromRGB(41, 46, 66),
		HoverChange = 0.05,
	},
	Obsidian = {
		Name = "Obsidian",
		Accent = Color3.fromRGB(250, 250, 255),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(210, 215, 225)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 155, 165)),
		}),
		AcrylicMain = Color3.fromRGB(10, 10, 12),
		AcrylicBorder = Color3.fromRGB(50, 52, 60),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 165, 175)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(75, 80, 90)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 32, 36)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 23, 26)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 14, 16)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 10)),
		}),
		AcrylicNoise = 0.98,
		TitleBarLine = Color3.fromRGB(30, 32, 38),
		Tab = Color3.fromRGB(170, 175, 185),
		Element = Color3.fromRGB(18, 19, 22),
		ElementBorder = Color3.fromRGB(36, 38, 44),
		InElementBorder = Color3.fromRGB(55, 58, 68),
		ElementTransparency = 0.92,
		ToggleSlider = Color3.fromRGB(150, 155, 165),
		ToggleToggled = Color3.fromRGB(255, 255, 255),
		SliderRail = Color3.fromRGB(35, 36, 42),
		DropdownFrame = Color3.fromRGB(20, 21, 24),
		DropdownHolder = Color3.fromRGB(12, 13, 15),
		DropdownBorder = Color3.fromRGB(38, 40, 46),
		DropdownOption = Color3.fromRGB(28, 29, 34),
		Keybind = Color3.fromRGB(26, 27, 32),
		Input = Color3.fromRGB(20, 21, 25),
		InputFocused = Color3.fromRGB(10, 10, 12),
		InputIndicator = Color3.fromRGB(80, 85, 95),
		InputIndicatorFocus = Color3.fromRGB(255, 255, 255),
		Dialog = Color3.fromRGB(14, 15, 18),
		DialogHolder = Color3.fromRGB(10, 10, 12),
		DialogHolderLine = Color3.fromRGB(30, 32, 38),
		DialogButton = Color3.fromRGB(22, 23, 28),
		DialogButtonBorder = Color3.fromRGB(45, 48, 56),
		DialogBorder = Color3.fromRGB(38, 40, 48),
		DialogInput = Color3.fromRGB(20, 21, 25),
		DialogInputLine = Color3.fromRGB(60, 64, 75),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(160, 165, 175),
		Hover = Color3.fromRGB(34, 36, 42),
		HoverChange = 0.04,
	},
	Emerald = {
		Name = "Emerald",
		Accent = Color3.fromRGB(16, 215, 140),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 250, 185)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(16, 215, 140)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 160, 105)),
		}),
		AcrylicMain = Color3.fromRGB(12, 22, 18),
		AcrylicBorder = Color3.fromRGB(30, 100, 75),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 250, 185)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(16, 215, 140)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 55, 42)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 44, 34)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(14, 28, 22)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 16, 13)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(25, 55, 42),
		Tab = Color3.fromRGB(140, 200, 175),
		Element = Color3.fromRGB(18, 32, 26),
		ElementBorder = Color3.fromRGB(30, 60, 48),
		InElementBorder = Color3.fromRGB(45, 95, 75),
		ElementTransparency = 0.84,
		ToggleSlider = Color3.fromRGB(140, 200, 175),
		ToggleToggled = Color3.fromRGB(16, 215, 140),
		SliderRail = Color3.fromRGB(28, 52, 42),
		DropdownFrame = Color3.fromRGB(18, 32, 26),
		DropdownHolder = Color3.fromRGB(12, 22, 18),
		DropdownBorder = Color3.fromRGB(32, 65, 50),
		DropdownOption = Color3.fromRGB(24, 42, 34),
		Keybind = Color3.fromRGB(24, 42, 34),
		Input = Color3.fromRGB(18, 32, 26),
		InputFocused = Color3.fromRGB(10, 18, 14),
		InputIndicator = Color3.fromRGB(50, 110, 85),
		InputIndicatorFocus = Color3.fromRGB(16, 215, 140),
		Dialog = Color3.fromRGB(14, 25, 20),
		DialogHolder = Color3.fromRGB(10, 18, 14),
		DialogHolderLine = Color3.fromRGB(25, 55, 42),
		DialogButton = Color3.fromRGB(20, 36, 28),
		DialogButtonBorder = Color3.fromRGB(35, 75, 58),
		DialogBorder = Color3.fromRGB(30, 60, 48),
		DialogInput = Color3.fromRGB(18, 32, 26),
		DialogInputLine = Color3.fromRGB(45, 95, 75),
		Text = Color3.fromRGB(235, 255, 245),
		SubText = Color3.fromRGB(135, 185, 165),
		Hover = Color3.fromRGB(28, 52, 42),
		HoverChange = 0.05,
	},
	Amethyst = {
		Name = "Amethyst",
		Accent = Color3.fromRGB(175, 82, 222),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 120, 255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(175, 82, 222)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 45, 195)),
		}),
		AcrylicMain = Color3.fromRGB(20, 14, 28),
		AcrylicBorder = Color3.fromRGB(105, 55, 145),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 120, 255)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(175, 82, 222)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 25, 85)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 22, 58)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(24, 15, 36)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 9, 22)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(55, 30, 75),
		Tab = Color3.fromRGB(195, 165, 225),
		Element = Color3.fromRGB(28, 20, 40),
		ElementBorder = Color3.fromRGB(55, 38, 75),
		InElementBorder = Color3.fromRGB(85, 55, 120),
		ElementTransparency = 0.84,
		ToggleSlider = Color3.fromRGB(195, 165, 225),
		ToggleToggled = Color3.fromRGB(175, 82, 222),
		SliderRail = Color3.fromRGB(48, 30, 68),
		DropdownFrame = Color3.fromRGB(28, 20, 40),
		DropdownHolder = Color3.fromRGB(20, 14, 28),
		DropdownBorder = Color3.fromRGB(60, 40, 85),
		DropdownOption = Color3.fromRGB(36, 26, 52),
		Keybind = Color3.fromRGB(36, 26, 52),
		Input = Color3.fromRGB(28, 20, 40),
		InputFocused = Color3.fromRGB(16, 10, 24),
		InputIndicator = Color3.fromRGB(115, 75, 155),
		InputIndicatorFocus = Color3.fromRGB(175, 82, 222),
		Dialog = Color3.fromRGB(22, 15, 32),
		DialogHolder = Color3.fromRGB(16, 10, 24),
		DialogHolderLine = Color3.fromRGB(50, 28, 70),
		DialogButton = Color3.fromRGB(30, 22, 44),
		DialogButtonBorder = Color3.fromRGB(65, 42, 95),
		DialogBorder = Color3.fromRGB(55, 38, 75),
		DialogInput = Color3.fromRGB(28, 20, 40),
		DialogInputLine = Color3.fromRGB(85, 55, 120),
		Text = Color3.fromRGB(250, 240, 255),
		SubText = Color3.fromRGB(175, 150, 205),
		Hover = Color3.fromRGB(48, 32, 68),
		HoverChange = 0.05,
	},
	Sunset = {
		Name = "Sunset",
		Accent = Color3.fromRGB(255, 110, 80),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 185, 80)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 110, 80)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 45, 115)),
		}),
		AcrylicMain = Color3.fromRGB(26, 16, 20),
		AcrylicBorder = Color3.fromRGB(140, 65, 75),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 185, 80)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 110, 80)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 30, 55)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 25, 32)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 16, 22)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 10, 14)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(65, 35, 42),
		Tab = Color3.fromRGB(220, 165, 175),
		Element = Color3.fromRGB(36, 22, 28),
		ElementBorder = Color3.fromRGB(68, 40, 50),
		InElementBorder = Color3.fromRGB(110, 60, 75),
		ElementTransparency = 0.84,
		ToggleSlider = Color3.fromRGB(220, 165, 175),
		ToggleToggled = Color3.fromRGB(255, 110, 80),
		SliderRail = Color3.fromRGB(58, 32, 40),
		DropdownFrame = Color3.fromRGB(36, 22, 28),
		DropdownHolder = Color3.fromRGB(26, 16, 20),
		DropdownBorder = Color3.fromRGB(75, 42, 54),
		DropdownOption = Color3.fromRGB(46, 28, 36),
		Keybind = Color3.fromRGB(46, 28, 36),
		Input = Color3.fromRGB(36, 22, 28),
		InputFocused = Color3.fromRGB(20, 12, 16),
		InputIndicator = Color3.fromRGB(145, 80, 95),
		InputIndicatorFocus = Color3.fromRGB(255, 110, 80),
		Dialog = Color3.fromRGB(28, 18, 22),
		DialogHolder = Color3.fromRGB(20, 12, 16),
		DialogHolderLine = Color3.fromRGB(60, 32, 38),
		DialogButton = Color3.fromRGB(40, 24, 30),
		DialogButtonBorder = Color3.fromRGB(80, 45, 58),
		DialogBorder = Color3.fromRGB(68, 40, 50),
		DialogInput = Color3.fromRGB(36, 22, 28),
		DialogInputLine = Color3.fromRGB(110, 60, 75),
		Text = Color3.fromRGB(255, 245, 245),
		SubText = Color3.fromRGB(200, 160, 170),
		Hover = Color3.fromRGB(58, 32, 40),
		HoverChange = 0.05,
	},
	Aurora = {
		Name = "Aurora",
		Accent = Color3.fromRGB(30, 225, 200),
		AccentGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 255, 180)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 225, 200)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 140, 255)),
		}),
		AcrylicMain = Color3.fromRGB(10, 20, 24),
		AcrylicBorder = Color3.fromRGB(35, 95, 105),
		AcrylicBorderGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 255, 180)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(30, 225, 200)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 60, 95)),
		}),
		AcrylicGradient = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 38, 48)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 25, 32)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 15, 20)),
		}),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(25, 55, 65),
		Tab = Color3.fromRGB(145, 195, 205),
		Element = Color3.fromRGB(16, 28, 36),
		ElementBorder = Color3.fromRGB(28, 55, 70),
		InElementBorder = Color3.fromRGB(48, 90, 115),
		ElementTransparency = 0.84,
		ToggleSlider = Color3.fromRGB(145, 195, 205),
		ToggleToggled = Color3.fromRGB(30, 225, 200),
		SliderRail = Color3.fromRGB(25, 48, 60),
		DropdownFrame = Color3.fromRGB(16, 28, 36),
		DropdownHolder = Color3.fromRGB(10, 20, 24),
		DropdownBorder = Color3.fromRGB(32, 62, 78),
		DropdownOption = Color3.fromRGB(22, 38, 48),
		Keybind = Color3.fromRGB(22, 38, 48),
		Input = Color3.fromRGB(16, 28, 36),
		InputFocused = Color3.fromRGB(8, 16, 20),
		InputIndicator = Color3.fromRGB(50, 110, 130),
		InputIndicatorFocus = Color3.fromRGB(30, 225, 200),
		Dialog = Color3.fromRGB(12, 22, 28),
		DialogHolder = Color3.fromRGB(8, 16, 20),
		DialogHolderLine = Color3.fromRGB(25, 55, 65),
		DialogButton = Color3.fromRGB(18, 32, 42),
		DialogButtonBorder = Color3.fromRGB(35, 75, 95),
		DialogBorder = Color3.fromRGB(28, 55, 70),
		DialogInput = Color3.fromRGB(16, 28, 36),
		DialogInputLine = Color3.fromRGB(48, 90, 115),
		Text = Color3.fromRGB(240, 255, 255),
		SubText = Color3.fromRGB(140, 185, 195),
		Hover = Color3.fromRGB(26, 48, 62),
		HoverChange = 0.05,
	}
}

local Library = {
	Version = "1.2.2",

	OpenFrames = {},
	Options = {},
	Themes = Themes.Names,
	Windows = {},

	Window = nil,
	WindowFrame = nil,
	Unloaded = false,

	Creator = nil,

	DialogOpen = false,
	UseAcrylic = false,
	Acrylic = false,
	Transparency = true,
	MinimizeKeybind = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,

	Sound = false,
	PlaySound = function() end,
	SetSound = function() end,
}

local Icons
local Molto = nil

task.spawn(function()
	pcall(function()
		local src
		if isfile and isfile("molto_source.lua") then
			src = readfile("molto_source.lua")
		end
		if not (src and #src > 50) then
			local ok, res = pcall(function()
				return game:HttpGet("https://molto.pages.dev/source.lua")
			end)
			if ok and res and #res > 50 then
				src = res
				if writefile then
					pcall(writefile, "molto_source.lua", src)
				end
			end
		end
		if src and #src > 50 then
			local m = loadstring(src)()
			if m and m.SetProvider then
				m.SetProvider("lucide")
			end
			Molto = m
			Library.Molto = m
			Library.Icons = m
		end
	end)
end)

function Library:SetIconProvider(provider)
	if Library.Molto and Library.Molto.SetProvider then
		return pcall(Library.Molto.SetProvider, provider)
	end
	return false
end

function Library:GetIcon(Name, Provider)
	if not Name or Name == "" then return nil end
	local name = Name
	local prov = Provider
	if type(name) == "string" then
		local p, n = name:match("^([%w%-_]+)[:/]([%w%-_]+)$")
		if p and n then
			prov = p
			name = n
		end
	end
	if Library.Molto and Library.Molto.GetAsset then
		local ok, res = pcall(Library.Molto.GetAsset, name, prov)
		if ok and res then return res end
	end
	if Icons then
		if Icons["lucide-" .. tostring(name)] then return Icons["lucide-" .. tostring(name)] end
		if Icons[tostring(name)] then return Icons[tostring(name)] end
	end
	return nil
end

function Library:ApplyIcon(ImageLabel, IconName, Provider)
	if not ImageLabel or not IconName or IconName == "" then return end

	local name = IconName
	local prov = Provider

	if type(name) == "string" then
		if name:find("^rbxassetid://") or name:find("^http") or name:find("^%d+$") then
			ImageLabel.Image = name:find("^%d+$") and ("rbxassetid://" .. name) or name
			ImageLabel.ImageRectSize = Vector2.new(0, 0)
			ImageLabel.ImageRectOffset = Vector2.new(0, 0)
			return
		end

		local p, n = name:match("^([%w%-_]+)[:/]([%w%-_]+)$")
		if p and n then
			prov = p
			name = n
		end
	end

	local asset = nil
	if type(name) == "table" and name.Url then
		asset = name
	elseif Library.Molto and Library.Molto.GetAsset then
		local ok, res = pcall(Library.Molto.GetAsset, name, prov)
		if ok and res then asset = res end
	end

	if asset then
		ImageLabel.Image = asset.Url
		ImageLabel.ImageRectSize = asset.ImageRectSize
		ImageLabel.ImageRectOffset = asset.ImageRectOffset
	else
		local fallback = Icons and (Icons["lucide-" .. tostring(name)] or Icons[tostring(name)]) or tostring(name)
		ImageLabel.Image = fallback
		ImageLabel.ImageRectSize = Vector2.new(0, 0)
		ImageLabel.ImageRectOffset = Vector2.new(0, 0)
	end
end

Library.SetIcon = function(self, ImageLabel, IconName, Provider)
	Library:ApplyIcon(ImageLabel, IconName, Provider)
end

local function isMotor(value)
	local motorType = tostring(value):match("^Motor%((.+)%)$")

	if motorType then
		return true, motorType
	else
		return false
	end
end

local Connection = {}

Connection.__index = Connection

function Connection.new(signal, handler)
	return setmetatable({
		signal = signal,
		connected = true,
		_handler = handler,
	}, Connection)
end

function Connection:disconnect()
	if self.connected then
		self.connected = false

		for index, connection in pairs(self.signal._connections) do
			if connection == self then
				table.remove(self.signal._connections, index)
				return
			end
		end
	end
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
		_threads = {},
	}, Signal)
end

function Signal:fire(...)
	for _, connection in pairs(self._connections) do
		connection._handler(...)
	end

	for _, thread in pairs(self._threads) do
		coroutine.resume(thread, ...)
	end

	self._threads = {}
end

function Signal:connect(handler)
	local connection = Connection.new(self, handler)
	table.insert(self._connections, connection)
	return connection
end

function Signal:wait()
	table.insert(self._threads, coroutine.running())
	return coroutine.yield()
end

local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")

	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
	if complete then
		position = self._targetValue
		velocity = 0
	end

	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

local Instant = {}
Instant.__index = Instant

function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

local VELOCITY_THRESHOLD = 0.001
local POSITION_THRESHOLD = 0.001

local EPS = 0.0001

local Spring = {}
Spring.__index = Spring

function Spring.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_frequency = options.frequency or 4,
		_dampingRatio = options.dampingRatio or 1,
	}, Spring)
end

function Spring:step(state, dt)


	local d = self._dampingRatio
	local f = self._frequency * 2 * math.pi
	local g = self._targetValue
	local p0 = state.value
	local v0 = state.velocity or 0

	local offset = p0 - g
	local decay = math.exp(-d * f * dt)

	local p1, v1

	if d == 1 then
		p1 = (offset * (1 + f * dt) + v0 * dt) * decay + g
		v1 = (v0 * (1 - f * dt) - offset * (f * f * dt)) * decay
	elseif d < 1 then
		local c = math.sqrt(1 - d * d)

		local i = math.cos(f * c * dt)
		local j = math.sin(f * c * dt)



		local z
		if c > EPS then
			z = j / c
		else
			local a = dt * f
			z = a + ((a * a) * (c * c) * (c * c) / 20 - c * c) * (a * a * a) / 6
		end



		local y
		if f * c > EPS then
			y = j / (f * c)
		else
			local b = f * c
			y = dt + ((dt * dt) * (b * b) * (b * b) / 20 - b * b) * (dt * dt * dt) / 6
		end

		p1 = (offset * (i + d * z) + v0 * y) * decay + g
		v1 = (v0 * (i - z * d) - offset * (z * f)) * decay
	else
		local c = math.sqrt(d * d - 1)

		local r1 = -f * (d - c)
		local r2 = -f * (d + c)

		local co2 = (v0 - offset * r1) / (2 * f * c)
		local co1 = offset - co2

		local e1 = co1 * math.exp(r1 * dt)
		local e2 = co2 * math.exp(r2 * dt)

		p1 = e1 + e2 + g
		v1 = e1 * r1 + e2 * r2
	end

	local complete = math.abs(v1) < VELOCITY_THRESHOLD and math.abs(p1 - g) < POSITION_THRESHOLD

	return {
		complete = complete,
		value = complete and g or p1,
		velocity = v1,
	}
end

local noop = function() end

local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.Heartbeat:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end
BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

function BaseMotor:__tostring()
	return "Motor"
end

local SingleMotor = setmetatable({}, BaseMotor)
SingleMotor.__index = SingleMotor

function SingleMotor.new(initialValue, useImplicitConnections)
	assert(initialValue, "Missing argument #1: initialValue")
	assert(typeof(initialValue) == "number", "initialValue must be a number!")

	local self = setmetatable(BaseMotor.new(), SingleMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._goal = nil
	self._state = {
		complete = true,
		value = initialValue,
	}

	return self
end

function SingleMotor:step(deltaTime)
	if self._state.complete then
		return true
	end

	local newState = self._goal:step(self._state, deltaTime)

	self._state = newState
	self._onStep:fire(newState.value)

	if newState.complete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._onComplete:fire()
	end

	return newState.complete
end

function SingleMotor:getValue()
	return self._state.value
end

function SingleMotor:setGoal(goal)
	self._state.complete = false
	self._goal = goal

	self._onStart:fire()

	if self._useImplicitConnections then
		self:start()
	end
end

function SingleMotor:__tostring()
	return "Motor(Single)"
end

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(
		not initialValues.step,
		'initialValues contains disallowed property "step". Did you mean to put a table of values here?'
	)

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then

			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	assert(not goals.step, 'goals contains disallowed property "step". Did you mean to put a table of goals here?')

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

local Flipper = {
	SingleMotor = SingleMotor,
	GroupMotor = GroupMotor,

	Instant = Instant,
	Linear = Linear,
	Spring = Spring,

	isMotor = isMotor,
}

local Creator = {
	Registry = {},
	Signals = {},
	TransparencyMotors = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextSize = 14,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			Font = Enum.Font.SourceSans,
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		ImageLabel = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ImageButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
		},
		CanvasGroup = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
	},
}

local function ApplyCustomProps(Object, Props)
	if Props.ThemeTag then
		Creator.AddThemeObject(Object, Props.ThemeTag)
	end
end

function Creator.AddSignal(Signal, Function)
	local Connected = Signal:Connect(Function)
	table.insert(Creator.Signals, Connected)
	return Connected
end

function Creator.Disconnect()
	for Idx = #Creator.Signals, 1, -1 do
		local Connection = table.remove(Creator.Signals, Idx)
		if Connection.Disconnect then
			Connection:Disconnect()
		end
	end
end

Creator.Themes = Themes
Creator.Theme = Creator.Theme or "Dark"

function Creator.GetThemeProperty(Property)
	local Theme = Creator.Themes[Creator.Theme]
	if Theme then
		return Theme[Property]
	end
	return Creator.Themes.Dark[Property]
end

function Creator.UpdateTheme()
	if not Creator.Themes[Creator.Theme] then
		Creator.Theme = "Dark"
	end

	for Instance, Object in next, Creator.Registry do
		for Property, ColorIdx in next, Object.Properties do
			local themeValue = Creator.GetThemeProperty(ColorIdx)
			if themeValue then
				Instance[Property] = themeValue
			end
		end
	end

	local transparency = Creator.GetThemeProperty("ElementTransparency")
	if transparency then
		for _, Motor in next, Creator.TransparencyMotors do
			Motor:setGoal(Flipper.Instant.new(transparency))
		end
	end
end

function Creator.AddThemeObject(Object, Properties)
	local Idx = #Creator.Registry + 1
	local Data = {
		Object = Object,
		Properties = Properties,
		Idx = Idx,
	}

	Creator.Registry[Object] = Data
	
	pcall(function()
		local dConn
		dConn = Object.Destroying:Connect(function()
			Creator.Registry[Object] = nil
			pcall(function() dConn:Disconnect() end)
		end)
	end)
	
	for Property, ColorIdx in next, Data.Properties do
		local themeValue = Creator.GetThemeProperty(ColorIdx)
		if themeValue then
			Object[Property] = themeValue
		end
	end
	
	return Object
end

function Creator.OverrideTag(Object, Properties)
	Creator.Registry[Object].Properties = Properties
	
	for Property, ColorIdx in next, Properties do
		local themeValue = Creator.GetThemeProperty(ColorIdx)
		if themeValue then
			Object[Property] = themeValue
		end
	end
end

function Creator.GetThemeProperty(Property)
	if Themes[Library.Theme][Property] then
		return Themes[Library.Theme][Property]
	end
	return Themes["Dark"][Property]
end

local MiniMessageColors = {
	["black"] = "#000000",
	["dark_blue"] = "#0000AA",
	["dark_green"] = "#00AA00",
	["dark_aqua"] = "#00AAAA",
	["dark_red"] = "#AA0000",
	["dark_purple"] = "#AA00AA",
	["gold"] = "#FFAA00",
	["gray"] = "#AAAAAA",
	["grey"] = "#AAAAAA",
	["dark_gray"] = "#555555",
	["dark_grey"] = "#555555",
	["blue"] = "#5555FF",
	["green"] = "#55FF55",
	["aqua"] = "#55FFFF",
	["cyan"] = "#55FFFF",
	["red"] = "#FF5555",
	["light_purple"] = "#FF55FF",
	["magenta"] = "#FF55FF",
	["yellow"] = "#FFFF55",
	["white"] = "#FFFFFF",
	["reset"] = "#FFFFFF",
	["orange"] = "#FFAA00",
	["pink"] = "#FF55FF",
	["lime"] = "#55FF55",
	["brown"] = "#AA5500",
}

local function MiniMessageToRichText(text)
	if type(text) ~= "string" or text == "" then
		return text
	end
	
	if not text:match("<[^>]+>") then
		return text
	end
	
	local result = text
	result = result:gsub("<br>", "\n")
	result = result:gsub("<br/>", "\n")
	result = result:gsub("<br />", "\n")
	result = result:gsub("<nl>", "\n")
	result = result:gsub("<newline>", "\n")
	
	result = result:gsub("<reset>", "</font></b></i></u></s>")
	
	result = result:gsub("<obfuscated>(.-)</obfuscated>", "%1")
	result = result:gsub("<obfuscated>", "")
	result = result:gsub("</obfuscated>", "")
	
	local function hexToRgb(hex)
		hex = hex:gsub("#", "")
		local r = tonumber("0x" .. hex:sub(1, 2))
		local g = tonumber("0x" .. hex:sub(3, 4))
		local b = tonumber("0x" .. hex:sub(5, 6))
		return r, g, b
	end
	
	local function rgbToHex(r, g, b)
		return string.format("#%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))
	end
	
	local function interpolateColor(color1Hex, color2Hex, t)
		local r1, g1, b1 = hexToRgb(color1Hex)
		local r2, g2, b2 = hexToRgb(color2Hex)
		local r = r1 + (r2 - r1) * t
		local g = g1 + (g2 - g1) * t
		local b = b1 + (b2 - b1) * t
		return rgbToHex(r, g, b)
	end
	
	for i = 1, 10 do
		local newResult = result:gsub("<gradient:([^>]+)>(.-)</gradient>", function(colorsStr, content)
			local colors = {}
			
			for colorMatch in colorsStr:gmatch("(#%x%x%x%x%x%x)") do
				table.insert(colors, colorMatch)
			end
			
			if #colors == 0 then
				for colorMatch in colorsStr:gmatch("(%x%x%x%x%x%x)") do
					table.insert(colors, "#" .. colorMatch)
				end
			end
			
			if #colors < 2 then
				if #colors == 1 then
					return '<font color="' .. colors[1] .. '">' .. content .. '</font>'
				else
					return content
				end
			end
			
			local cleanText = content:gsub("<[^>]+>", "")
			local textLength = #cleanText
			
			if textLength == 0 then
				return content
			end
			
			if textLength == 1 then
				return '<font color="' .. colors[1] .. '">' .. content .. '</font>'
			end
			
			local parts = {}
			local pos = 1
			local charIndex = 0
			
			while pos <= #content do
				if content:sub(pos, pos) == "<" then
					local tagEnd = content:find(">", pos)
					if tagEnd then
						local tag = content:sub(pos, tagEnd)
						table.insert(parts, {type = "tag", value = tag})
						pos = tagEnd + 1
					else
						table.insert(parts, {type = "char", value = content:sub(pos, pos), index = charIndex})
						charIndex = charIndex + 1
						pos = pos + 1
					end
				else
					local char = content:sub(pos, pos)
					table.insert(parts, {type = "char", value = char, index = charIndex})
					charIndex = charIndex + 1
					pos = pos + 1
				end
			end
			
			local function getGradientColor(t)
				t = math.max(0, math.min(1, t))
				
				if #colors == 2 then
					return interpolateColor(colors[1], colors[2], t)
				end
				
				local numSegments = #colors - 1
				local segmentSize = 1 / numSegments
				
				local segmentIndex = math.floor(t / segmentSize)
				if segmentIndex >= numSegments then
					segmentIndex = numSegments - 1
					t = 1.0
				end
				
				local segmentStart = segmentIndex * segmentSize
				local segmentEnd = (segmentIndex + 1) * segmentSize
				
				local segmentT = 0
				if segmentEnd > segmentStart then
					segmentT = (t - segmentStart) / (segmentEnd - segmentStart)
				else
					segmentT = (t >= segmentEnd) and 1.0 or 0.0
				end
				
				segmentT = math.max(0, math.min(1, segmentT))
				
				local color1Index = segmentIndex + 1
				local color2Index = segmentIndex + 2
				
				if color1Index < 1 then color1Index = 1 end
				if color2Index > #colors then color2Index = #colors end
				if color1Index > #colors then color1Index = #colors end
				
				return interpolateColor(colors[color1Index], colors[color2Index], segmentT)
			end
			
			local gradientText = ""
			local currentSegment = ""
			local currentColor = nil
			local segments = {}
			
			for _, part in ipairs(parts) do
				if part.type == "tag" then
					if currentSegment ~= "" and currentColor ~= nil then
						table.insert(segments, {text = currentSegment, color = currentColor})
						currentSegment = ""
						currentColor = nil
					end
					table.insert(segments, {text = part.value, color = nil})
				else
					local t = part.index / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)
					
					if currentColor == charColor then
						currentSegment = currentSegment .. part.value
					else
						if currentSegment ~= "" and currentColor ~= nil then
							table.insert(segments, {text = currentSegment, color = currentColor})
						end
						currentSegment = part.value
						currentColor = charColor
					end
				end
			end
			
			if currentSegment ~= "" and currentColor ~= nil then
				table.insert(segments, {text = currentSegment, color = currentColor})
			end
			
			local hasTextSegments = false
			for _, segment in ipairs(segments) do
				if segment.text and segment.text ~= "" then
					hasTextSegments = true
					break
				end
			end
			
			if not hasTextSegments and textLength > 0 then
				local fallbackText = ""
				for i = 1, textLength do
					local t = (i - 1) / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)
					local char = cleanText:sub(i, i)
					fallbackText = fallbackText .. '<font color="' .. charColor .. '">' .. char .. '</font>'
				end
				return fallbackText
			end
			
			for _, segment in ipairs(segments) do
				if segment.color and segment.text and segment.text ~= "" then
					gradientText = gradientText .. '<font color="' .. segment.color .. '">' .. segment.text .. '</font>'
				elseif segment.text then
					gradientText = gradientText .. segment.text
				end
			end
			
			if gradientText == "" or gradientText == nil or not gradientText:match('<font color=') then
				local fallbackText = ""
				for i = 1, textLength do
					local t = (i - 1) / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)
					local char = cleanText:sub(i, i)
					fallbackText = fallbackText .. '<font color="' .. charColor .. '">' .. char .. '</font>'
				end
				return fallbackText
			end
			
			return gradientText
		end)
		if newResult == result then
			break
		end
		result = newResult
	end
	
	result = result:gsub("<color:(#%x%x%x%x%x%x)>(.-)</color>", '<font color="%1">%2</font>')
	result = result:gsub("<color:(#%x%x%x%x%x%x)>", '<font color="%1">')
	result = result:gsub("<color:(%x%x%x%x%x%x)>(.-)</color>", function(hex, content)
		return '<font color="#' .. hex .. '">' .. content .. '</font>'
	end)
	result = result:gsub("<color:(%x%x%x%x%x%x)>", function(hex)
		return '<font color="#' .. hex .. '">'
	end)
	result = result:gsub("</color>", "</font>")
	
	result = result:gsub("<(#%x%x%x%x%x%x)>(.-)</#%x%x%x%x%x%x>", '<font color="%1">%2</font>')
	result = result:gsub("<(#%x%x%x%x%x%x)>", '<font color="%1">')
	result = result:gsub("</(#%x%x%x%x%x%x)>", "</font>")
	
	local colorNames = {}
	for colorName, _ in pairs(MiniMessageColors) do
		table.insert(colorNames, colorName)
	end
	table.sort(colorNames, function(a, b) return #a > #b end)
	
	for _, colorName in ipairs(colorNames) do
		local hexColor = MiniMessageColors[colorName]
		result = result:gsub("<" .. colorName .. ">(.-)</" .. colorName .. ">", '<font color="' .. hexColor .. '">%1</font>')
		result = result:gsub("<" .. colorName .. ">", '<font color="' .. hexColor .. '">')
		result = result:gsub("</" .. colorName .. ">", "</font>")
	end
	
	result = result:gsub("<bold>(.-)</bold>", "<b>%1</b>")
	result = result:gsub("<bold>", "<b>")
	result = result:gsub("</bold>", "</b>")
	
	result = result:gsub("<italic>(.-)</italic>", "<i>%1</i>")
	result = result:gsub("<italic>", "<i>")
	result = result:gsub("</italic>", "</i>")
	
	result = result:gsub("<underline>(.-)</underline>", "<u>%1</u>")
	result = result:gsub("<underlined>(.-)</underlined>", "<u>%1</u>")
	result = result:gsub("<underline>", "<u>")
	result = result:gsub("<underlined>", "<u>")
	result = result:gsub("</underline>", "</u>")
	result = result:gsub("</underlined>", "</u>")
	
	result = result:gsub("<strikethrough>(.-)</strikethrough>", "<s>%1</s>")
	result = result:gsub("<strike>(.-)</strike>", "<s>%1</s>")
	result = result:gsub("<strikethrough>", "<s>")
	result = result:gsub("<strike>", "<s>")
	result = result:gsub("</strikethrough>", "</s>")
	result = result:gsub("</strike>", "</s>")
	
	result = result:gsub('<font color="[^"]+"></font>', "")
	
	result = result:gsub("</font></font>", "</font>")
	result = result:gsub("</b></b>", "</b>")
	result = result:gsub("</i></i>", "</i>")
	result = result:gsub("</u></u>", "</u>")
	result = result:gsub("</s></s>", "</s>")
	
	return result
end

local TextElements = {}
local TextElementConnections = {}

local function setupMiniMessageSupport(object, properties)
	if not (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")) then
		return
	end
	
	local richTextExplicitlySet = properties and properties.RichText ~= nil
	if not richTextExplicitlySet then
		object.RichText = true
	elseif properties.RichText == false then
		object.RichText = false
	end
	
	local lastText = object.Text or ""
	local isConverting = false
	
	local function convertTextIfNeeded(text)
		if not text or type(text) ~= "string" then
			return text
		end
		
		local hasRichTextTags = text:match('<font color="[^"]+">')
		
		if hasRichTextTags then
			return text
		end
		
		if text:match("<[^>]+>") then
		local hasMiniMessagePattern = 
			text:match("<%w+>") or
			text:match("<color:") or
			text:match("<#[%x%x%x%x%x%x]>") or
			text:match("<gradient:") or
			text:match("<reset>") or
			text:match("<obfuscated>") or
			text:match("</%w+>") or
			text:match("</color>")
			
			if hasMiniMessagePattern then
				if not object.RichText then
					object.RichText = true
				end
				return MiniMessageToRichText(text)
			end
		end
		
		return text
	end
	
	local connection = object:GetPropertyChangedSignal("Text"):Connect(function()
		if isConverting then
			return
		end
		
		local currentText = object.Text or ""
		
		if currentText ~= lastText then
			local converted = convertTextIfNeeded(currentText)
			if converted ~= currentText then
				isConverting = true
				object.Text = converted
				lastText = converted
				isConverting = false
			else
				lastText = currentText
			end
		end
	end)
	
	table.insert(TextElementConnections, connection)
	TextElements[object] = connection

	pcall(function()
		local dConn
		dConn = object.Destroying:Connect(function()
			pcall(function() connection:Disconnect() end)
			pcall(function() dConn:Disconnect() end)
			local cIdx = table.find(TextElementConnections, connection)
			if cIdx then
				table.remove(TextElementConnections, cIdx)
			end
			TextElements[object] = nil
		end)
	end)
	
	if object.Text then
		local converted = convertTextIfNeeded(object.Text)
		if converted ~= object.Text then
			object.Text = converted
			lastText = converted
		end
	end
end

function Creator.New(Name, Properties, Children)
	local Object = Instance.new(Name)

	for Name, Value in next, Creator.DefaultProperties[Name] or {} do
		Object[Name] = Value
	end

	local originalText = Properties and Properties.Text

	for Name, Value in next, Properties or {} do
		if Name ~= "ThemeTag" then
			Object[Name] = Value
		end
	end
	
	if originalText and type(originalText) == "string" and originalText:match("<[^>]+>") then
		Object.Text = MiniMessageToRichText(originalText)
		if Properties and Properties.RichText == nil then
			Object.RichText = true
		end
	end

	for _, Child in next, Children or {} do
		Child.Parent = Object
	end

	ApplyCustomProps(Object, Properties)
	
	setupMiniMessageSupport(Object, Properties)
	
	return Object
end

function Creator.SpringMotor(Initial, Instance, Prop, IgnoreDialogCheck, ResetOnThemeChange, SpringConfig)
	IgnoreDialogCheck = IgnoreDialogCheck or false
	ResetOnThemeChange = ResetOnThemeChange or false
	local springSettings = SpringConfig or { frequency = 10, dampingRatio = 0.85 }
	local Motor = Flipper.SingleMotor.new(Initial)
	Motor:onStep(function(value)
		Instance[Prop] = value
	end)

	if ResetOnThemeChange then
		table.insert(Creator.TransparencyMotors, Motor)
	end

	local function SetValue(Value, Ignore)
		Ignore = Ignore or false
		if not IgnoreDialogCheck then
			if not Ignore then
				if Prop == "BackgroundTransparency" and Library.DialogOpen then
					return
				end
			end
		end
		Motor:setGoal(Flipper.Spring.new(Value, springSettings))
	end

	return Motor, SetValue
end

Creator.TextElements = TextElements
Creator.TextElementConnections = TextElementConnections

Library.Creator = Creator

Library.MiniMessageToRichText = MiniMessageToRichText

local New = Creator.New

local safeRoots = {}
if gethui then pcall(function() table.insert(safeRoots, gethui()) end) end
pcall(function() table.insert(safeRoots, game:GetService("CoreGui")) end)
pcall(function() table.insert(safeRoots, LocalPlayer:WaitForChild("PlayerGui")) end)

for _, root in ipairs(safeRoots) do
    for _, child in ipairs(root:GetChildren()) do
        if child.Name == "FluentUI" or child.Name == "FluentMinimizer" or child.Name == "FluentBlur" then
            pcall(function() child:Destroy() end)
        end
    end
end
local cam = workspace.CurrentCamera
if cam then
    for _, child in ipairs(cam:GetChildren()) do
        if child.Name == "FluentBlur" then
            pcall(function() child:Destroy() end)
        end
    end
end

local safeParent = safeRoots[1] or game:GetService("CoreGui")

local GUI = New("ScreenGui", {
	Name = "FluentUI",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 999999,
	IgnoreGuiInset = true,
	Parent = safeParent,
})
Library.GUI = GUI
ProtectGui(GUI)

-- [[ TRUE GUI GHOSTING (DescendantAdded Spoof) ]] --
pcall(function()
    local bindable = Instance.new("BindableEvent")
    local connection = bindable.Event:Connect(function() end)
    local orig_connect = connection.Connect
    connection:Disconnect()
    bindable:Destroy()
    
    if hookfunction then
        hookfunction(orig_connect, function(signal, callback)
            if tostring(signal) == "DescendantAdded" or tostring(signal) == "ChildAdded" then
                local function SpoofedCallback(instance, ...)
                    if typeof(instance) == "Instance" and Library.GUI and (instance == Library.GUI or instance:IsDescendantOf(Library.GUI)) then
                        return -- Ghosted! The game script never sees the UI element.
                    end
                    return callback(instance, ...)
                end
                -- Safe stack hiding (only if native setstackhidden is supported; never demote thread identity to 1)
                local function HiddenSpoof(...)
                    if setstackhidden then
                        pcall(setstackhidden, 1, true)
                    end
                    return SpoofedCallback(...)
                end
                
                return orig_connect(signal, HiddenSpoof)
            end
            return orig_connect(signal, callback)
        end)
    end
end)
-- [[ END TRUE GUI GHOSTING ]] --

function Library:SafeCallback(Function, ...)
	if not Function then
		return
	end

	local Success, Event = pcall(Function, ...)
	if not Success then
		local _, i = Event:find(":%d+: ")

		if not i then
			return Library:Notify({
				Title = "Interface",
				Content = "Callback error",
				SubContent = Event,
				Duration = 5,
			})
		end

		return Library:Notify({
			Title = "Interface",
			Content = "Callback error",
			SubContent = Event:sub(i + 1),
			Duration = 5,
		})
	end
end--?
function Library:Round(Number, Factor)
	if Factor == 0 then
		return math.floor(Number)
	end
	Number = tostring(Number)
	return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
end

local function map(value, inMin, inMax, outMin, outMax)
	return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
end

local function viewportPointToWorld(location, distance)
	local unitRay = game:GetService("Workspace").CurrentCamera:ScreenPointToRay(location.X, location.Y)
	return unitRay.Origin + unitRay.Direction * distance
end

local function getOffset()
	local viewportSizeY = game:GetService("Workspace").CurrentCamera.ViewportSize.Y
	return map(viewportSizeY, 0, 2560, 8, 56)
end

local viewportPointToWorld, getOffset = unpack({ viewportPointToWorld, getOffset })

local ws = game:GetService("Workspace")
if ws.CurrentCamera then
	for _, child in ipairs(ws.CurrentCamera:GetChildren()) do
		if child.Name == "FluentBlur" then
			pcall(function() child:Destroy() end)
		end
	end
end
pcall(function()
	local lighting = game:GetService("Lighting")
	for _, child in ipairs(lighting:GetChildren()) do
		if child.Name == "FluentDepthOfField" then
			child:Destroy()
		end
	end
end)

local BlurFolder = Instance.new("Folder")
BlurFolder.Name = "FluentBlur"
Library.BlurFolder = BlurFolder
do
	local function attachToCurrentCamera()
		local cam = ws.CurrentCamera
		if cam and BlurFolder.Parent ~= cam then
			BlurFolder.Parent = cam
		end
	end
	attachToCurrentCamera()
	ws:GetPropertyChangedSignal("CurrentCamera"):Connect(attachToCurrentCamera)
end

local function createAcrylic()
	local Part = Creator.New("Part", {
		Name = "Body",
		Color = Color3.new(1, 1, 1),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
		CanCollide = false,
		Locked = true,
		CastShadow = false,
		Reflectance = 0,
		Transparency = 1,
	}, {
		Creator.New("SpecialMesh", {
			Name = "Mesh",
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	})

	return Part
end

function AcrylicBlur()
	local function createAcrylicBlur(distance)
		local cleanups = {}

		distance = distance or 0.001
		local positions = {
			topLeft = Vector2.new(),
			topRight = Vector2.new(),
			bottomRight = Vector2.new(),
		}
		local model = createAcrylic()
		model.CFrame = CFrame.new(0, -999999, 0)
		model.Parent = BlurFolder

		local function updatePositions(size, position)
			positions.topLeft = position
			positions.topRight = position + Vector2.new(size.X, 0)
			positions.bottomRight = position + size
		end

		local lastCamCFrame
		local lastTopLeft
		local lastBottomRight

		local function render()
			if Library.Unloaded or not Library.UseAcrylic or not Library.Acrylic or model.Transparency >= 1 or not model.Parent or (Library.Window and (Library.Window.Minimized or not Library.Window.Root or not Library.Window.Root.Visible)) then
				if model and model.Parent then
					model.Transparency = 1
					if model.CFrame.Y > -900000 then
						model.CFrame = CFrame.new(0, -999999, 0)
					end
				end
				return
			end

			local cam = game:GetService("Workspace").CurrentCamera
			if not cam then
				return
			end
			local camera = cam.CFrame

			local topLeft = positions.topLeft
			local topRight = positions.topRight
			local bottomRight = positions.bottomRight

			if lastCamCFrame and lastTopLeft and lastBottomRight
				and camera == lastCamCFrame
				and topLeft == lastTopLeft
				and bottomRight == lastBottomRight then
				return
			end

			lastCamCFrame = camera
			lastTopLeft = topLeft
			lastBottomRight = bottomRight

			local topLeft3D = viewportPointToWorld(topLeft, distance)
			local topRight3D = viewportPointToWorld(topRight, distance)
			local bottomRight3D = viewportPointToWorld(bottomRight, distance)

			local width = (topRight3D - topLeft3D).Magnitude
			local height = (topRight3D - bottomRight3D).Magnitude

			model.CFrame = CFrame.fromMatrix((topLeft3D + bottomRight3D) / 2, camera.XVector, camera.YVector, camera.ZVector)
			model.Mesh.Scale = Vector3.new(width, height, 0)
		end

		local function onChange(rbx)
			local size = rbx.AbsoluteSize
			local position = rbx.AbsolutePosition

			updatePositions(size, position)
			render()
		end

		local function renderOnChange()
			table.insert(cleanups, RunService.RenderStepped:Connect(render))
			render()
		end

		model.Destroying:Connect(function()
			for _, item in cleanups do
				pcall(function()
					item:Disconnect()
				end)
			end
			table.clear(cleanups)
		end)

		renderOnChange()

		return onChange, model
	end

	return function(distance)
		local Blur = {}
		local onChange, model = createAcrylicBlur(distance)

		local comp = Creator.New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
		})

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsolutePosition"), function()
			onChange(comp)
		end)

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsoluteSize"), function()
			onChange(comp)
		end)

		Blur.AddParent = function(Parent)
			Blur.Parent = Parent
			local function update()
				local isVis = Parent.Visible and (Library.Acrylic ~= false) and (Library.UseAcrylic ~= false)
				if Library.Window and Parent == Library.Window.Root and Library.Window.Minimized then
					isVis = false
				end
				Blur.SetVisibility(isVis)
			end
			update()
			Creator.AddSignal(Parent:GetPropertyChangedSignal("Visible"), update)
		end

		Blur.SetVisibility = function(Value)
			local actual = Value and (Library.Acrylic ~= false) and (Library.UseAcrylic ~= false)
			model.Transparency = actual and ((Library.Theme == "Glass") and 0.85 or 0.98) or 1
			if not actual then
				model.CFrame = CFrame.new(0, -999999, 0)
			end
		end

		Blur.Frame = comp
		Blur.Model = model

		return Blur
	end
end

function AcrylicPaint()
	local New = Creator.New
	local AcrylicBlur = AcrylicBlur()

	return function(props)
		local AcrylicPaint = {}

		AcrylicPaint.Frame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0.9,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
		}, {
			New("ImageLabel", {
				Image = "rbxassetid://8992230677",
				ScaleType = "Slice",
				SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, 120, 1, 116),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.7,
			}),

			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),

			New("Frame", {
				BackgroundTransparency = 0.45,
				Size = UDim2.fromScale(1, 1),
				Name = "Background",
				ThemeTag = {
					BackgroundColor3 = "AcrylicMain",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.4,
				Size = UDim2.fromScale(1, 1),
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),

				New("UIGradient", {
					Rotation = 90,
					ThemeTag = {
						Color = "AcrylicGradient",
					},
				}),
			}),

			New("ImageLabel", {
				Image = "rbxassetid://9968344105",
				ImageTransparency = 0.98,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("ImageLabel", {
				Image = "rbxassetid://9968344227",
				ImageTransparency = 0.9,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageTransparency = "AcrylicNoise",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			}),

			New("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
				New("UIStroke", {
					Transparency = 0.35,
					Thickness = 1.2,
					ThemeTag = {
						Color = "AcrylicBorder",
					},
				}, {
					New("UIGradient", {
						Rotation = 90,
						Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(0.35, Color3.fromRGB(180, 180, 180)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)),
						}),
						ThemeTag = {
							Color = "AcrylicBorderGradient",
						},
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0.15),
							NumberSequenceKeypoint.new(0.4, 0.35),
							NumberSequenceKeypoint.new(1, 0.65),
						}),
					}),
				}),
			}),
		})

		local Blur

		if Library.UseAcrylic then
			Blur = AcrylicBlur()
			Blur.Frame.Parent = AcrylicPaint.Frame
			AcrylicPaint.Model = Blur.Model
			AcrylicPaint.AddParent = Blur.AddParent
			AcrylicPaint.SetVisibility = Blur.SetVisibility
		end

		return AcrylicPaint
	end
end

local Acrylic = {
	AcrylicBlur = AcrylicBlur(),
	CreateAcrylic = createAcrylic,
	AcrylicPaint = AcrylicPaint(),
	Enable = function() end,
	Disable = function() end,
	Destroy = function() end,
}

function Acrylic.init()
	if Acrylic.BaseEffect and Acrylic.BaseEffect.Parent then
		return
	end

	pcall(function()
		local lighting = game:GetService("Lighting")
		for _, child in ipairs(lighting:GetChildren()) do
			if child:IsA("DepthOfFieldEffect") and (child.Name == "FluentDepthOfField" or (child.InFocusRadius <= 0.2 and child.NearIntensity >= 0.9)) then
				child:Destroy()
			end
		end
	end)

	local baseEffect = Instance.new("DepthOfFieldEffect")
	baseEffect.Name = "FluentDepthOfField"
	baseEffect.FarIntensity = 0
	baseEffect.InFocusRadius = 0.1
	baseEffect.NearIntensity = 1
	Acrylic.BaseEffect = baseEffect

	local depthOfFieldDefaults = {}

	function Acrylic.Enable()
		for _, effect in pairs(depthOfFieldDefaults) do
			pcall(function() effect.Enabled = false end)
		end
		baseEffect.Parent = game:GetService("Lighting")
	end

	function Acrylic.Disable()
		for effect, data in pairs(depthOfFieldDefaults) do
			pcall(function() effect.Enabled = data.enabled end)
		end
		baseEffect.Parent = nil
	end

	function Acrylic.Destroy()
		Acrylic.Disable()
		pcall(function() baseEffect:Destroy() end)
		Acrylic.BaseEffect = nil
		table.clear(depthOfFieldDefaults)
		pcall(function()
			local lighting = game:GetService("Lighting")
			for _, child in ipairs(lighting:GetChildren()) do
				if child:IsA("DepthOfFieldEffect") and (child.Name == "FluentDepthOfField" or (child.InFocusRadius <= 0.2 and child.NearIntensity >= 0.9)) then
					child:Destroy()
				end
			end
		end)
	end

	local function registerDefaults()
		local function register(object)
			if object:IsA("DepthOfFieldEffect") and object ~= baseEffect then
				if object.InFocusRadius <= 0.2 and object.NearIntensity >= 0.9 then
					pcall(function() object:Destroy() end)
				else
					depthOfFieldDefaults[object] = { enabled = object.Enabled }
				end
			end
		end

		for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
			register(child)
		end
	end

	registerDefaults()
end

local Components = {
	Assets = {
		Close = "rbxassetid://9886659671",
		Min = "rbxassetid://9886659276",
		Max = "rbxassetid://9886659406",
		Restore = "rbxassetid://9886659001",
	},
}

Components.Element = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Title, Desc, Parent, Hover, Options)
		local Element = {}
		local Options = Options or {}

		Element.TitleLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			Text = Title,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Element.Header = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 5),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
		})

		if Options and Options.Icon then
			Element.IconImage = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})
			Library:ApplyIcon(Element.IconImage, Options.Icon)
			Element.IconImage.Parent = Element.Header
		end

		Element.TitleLabel.Parent = Element.Header

		Element.DescLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Desc,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		Element.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(1, -28, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			New("UIPadding", {
				PaddingBottom = UDim.new(0, Mobile and 15 or 13),
				PaddingTop = UDim.new(0, Mobile and 15 or 13),
			}),
			Element.Header,
			Element.DescLabel,
		})

		Element.Border = New("UIStroke", {
			Transparency = 0.5,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(0, 0, 0),
			ThemeTag = {
				Color = "ElementBorder",
			},
		})

		local nextOrder = 1
		if Parent and typeof(Parent) == "Instance" then
			local count = (Parent:GetAttribute("ElementOrderCount") or 0) + 1
			pcall(function() Parent:SetAttribute("ElementOrderCount", count) end)
			nextOrder = count
		end

		Element.Frame = New("TextButton", {
			Visible = Options.Visible and Options.Visible or true,
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 0.89,
			BackgroundColor3 = Color3.fromRGB(130, 130, 130),
			Parent = Parent,
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = "",
			LayoutOrder = nextOrder,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			Element.Border,
			Element.LabelHolder,
		})

		function Element:SetTitle(Set)
			Element.TitleLabel.Text = Set
			local hasTitle = (Set ~= nil and Set ~= "")
			Element.Header.Visible = hasTitle

			if not hasTitle then
				if Element.IconImage then
					if not Element.DescRow then
						Element.DescRow = New("Frame", {
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 14),
							LayoutOrder = 2,
						}, {
							New("UIListLayout", {
								Padding = UDim.new(0, 5),
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							}),
						})
						Element.DescRow.Parent = Element.LabelHolder
					end

					if not Element.DescIconImage then
						Element.DescIconImage = New("ImageLabel", {
							Image = Element.IconImage.Image,
							Size = UDim2.fromOffset(16, 16),
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							ThemeTag = {
								ImageColor3 = "Text",
							},
						})
						Element.DescIconImage.Parent = Element.DescRow
					else
						Element.DescIconImage.Image = Element.IconImage.Image
						Element.DescIconImage.Parent = Element.DescRow
					end

					Element.DescLabel.Parent = Element.DescRow
					Element.DescLabel.LayoutOrder = 2
					Element.DescLabel.Size = UDim2.new(1, -24, 0, 14)
				else
					if Element.DescRow then
						Element.DescRow:Destroy()
						Element.DescRow = nil
						Element.DescIconImage = nil
					end
					Element.DescLabel.Parent = Element.LabelHolder
					Element.DescLabel.LayoutOrder = 2
					Element.DescLabel.Size = UDim2.new(1, 0, 0, 14)
				end
			else
				if Element.DescRow then
					Element.DescRow:Destroy()
					Element.DescRow = nil
					Element.DescIconImage = nil
				end
				Element.DescLabel.Parent = Element.LabelHolder
				Element.DescLabel.LayoutOrder = 2
				Element.DescLabel.Size = UDim2.new(1, 0, 0, 14)
			end
			if Library.Window and Library.Window.AllElements and Library.Window.AllElements[Element.Frame] then
				Library.Window.AllElements[Element.Frame].title = Set
			elseif Library.Windows and #Library.Windows > 0 then
				local currentWindow = Library.Windows[#Library.Windows]
				if currentWindow and currentWindow.AllElements and currentWindow.AllElements[Element.Frame] then
					currentWindow.AllElements[Element.Frame].title = Set
				end
			end
		end

		function Element:Visible(Bool)
			Element.Frame.Visible = Bool
		end

		function Element:SetDesc(Set)
			if Set == nil then
				Set = ""
			end
			if Set == "" then
				Element.DescLabel.Visible = false
			else
				Element.DescLabel.Visible = true
			end
			Element.DescLabel.Text = Set
			if Library.Window and Library.Window.AllElements and Library.Window.AllElements[Element.Frame] then
				Library.Window.AllElements[Element.Frame].description = Set
			elseif Library.Windows and #Library.Windows > 0 then
				local currentWindow = Library.Windows[#Library.Windows]
				if currentWindow and currentWindow.AllElements and currentWindow.AllElements[Element.Frame] then
					currentWindow.AllElements[Element.Frame].description = Set
				end
			end
		end

		function Element:GetTitle()
			return Element.TitleLabel.Text
		end

		function Element:GetDesc()
			return Element.DescLabel.Text
		end

		function Element:SetRightOffset(offset)
			Element.LabelHolder.Size = UDim2.new(1, -offset, 0, 0)
		end

		function Element:SetIcon(newIcon)
			if not Element.IconImage then
				Element.IconImage = New("ImageLabel", {
					Size = UDim2.fromOffset(16, 16),
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				})
				Element.IconImage.Parent = Element.Header
			end
			Library:ApplyIcon(Element.IconImage, newIcon)
			if Element.DescIconImage then
				Element.DescIconImage.Image = Element.IconImage.Image
				Element.DescIconImage.ImageRectSize = Element.IconImage.ImageRectSize
				Element.DescIconImage.ImageRectOffset = Element.IconImage.ImageRectOffset
			end
		end

		function Element:Destroy()
			Element.Frame:Destroy()
		end

		Element.Header.Visible = not (Title == nil or Title == "")

		Element:SetTitle(Title or "")
		Element:SetDesc(Desc)


		if Library.Window and Library.Window.RegisterElement then
			Library.Window.RegisterElement(Element.Frame, Title, "Element", Desc)
		elseif Library.Windows and #Library.Windows > 0 then
			local currentWindow = Library.Windows[#Library.Windows]
			if currentWindow and currentWindow.RegisterElement then
				currentWindow.RegisterElement(Element.Frame, Title, "Element", Desc)
			end
		end

		if Hover then
			local Themes = Library.Themes
			local Motor, SetTransparency = Creator.SpringMotor(
				Creator.GetThemeProperty("ElementTransparency"),
				Element.Frame,
				"BackgroundTransparency",
				false,
				true,
				{ frequency = 12, dampingRatio = 0.85 }
			)
			local StrokeMotor, SetStrokeTransparency = Creator.SpringMotor(
				0.5,
				Element.Border,
				"Transparency",
				false,
				false,
				{ frequency = 12, dampingRatio = 0.85 }
			)

			Creator.AddSignal(Element.Frame.MouseEnter, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
				SetStrokeTransparency(0.2)
			end)
			Creator.AddSignal(Element.Frame.MouseLeave, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency"))
				SetStrokeTransparency(0.5)
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Down, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") + Creator.GetThemeProperty("HoverChange"))
				SetStrokeTransparency(0.1)
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Up, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
				SetStrokeTransparency(0.2)
			end)
		end

		return Element
	end
end)()
Components.Section = (function()
	local New = Creator.New

	return function(Title, Parent, Icon, Collapsible, DefaultCollapsed)
		local Section = {}
		local isCollapsible = Collapsible == true
		local isCollapsed = isCollapsible and (DefaultCollapsed == true) or false

		Section.Layout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Section.Container = New("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.fromOffset(0, 24),
			BackgroundTransparency = 1,
			Visible = not isCollapsed,
		}, {
			Section.Layout,
		})

		local SectionTitleLabel = New("TextLabel", {
			RichText = true,
			Text = Title,
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 18,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.fromScale(0, 1),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local ChevronIcon = isCollapsible and New("ImageLabel", {
			Image = "rbxassetid://10709790948",
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, 0, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Rotation = isCollapsed and -90 or 0,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		}) or nil

		local SectionHeader = New("TextButton", {
			Size = UDim2.new(1, -16, 0, 18),
			Position = UDim2.fromOffset(0, 2),
			BackgroundTransparency = 1,
			Text = "",
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 5),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			(Icon and Icon ~= "") and (function()
				local img = New("ImageLabel", {
					Size = UDim2.fromOffset(16, 16),
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				})
				Library:ApplyIcon(img, Icon)
				return img
			end)() or nil,
			SectionTitleLabel,
			ChevronIcon,
		})

		local nextOrder = 1
		if Parent and typeof(Parent) == "Instance" then
			local count = (Parent:GetAttribute("ElementOrderCount") or 0) + 1
			pcall(function() Parent:SetAttribute("ElementOrderCount", count) end)
			nextOrder = count
		end

		Section.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 26),
			LayoutOrder = nextOrder,
			Parent = Parent,
		}, {
			SectionHeader,
			Section.Container,
		})

		local function updateSizes()
			if isCollapsed then
				Section.Container.Visible = false
				Section.Container.Size = UDim2.new(1, 0, 0, 0)
				Section.Root.Size = UDim2.new(1, 0, 0, 24)
			else
				Section.Container.Visible = true
				Section.Container.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y)
				Section.Root.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y + 25)
			end
		end

		Creator.AddSignal(Section.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), updateSizes)

		function Section:SetCollapsed(collapsed)
			if not isCollapsible then return end
			isCollapsed = collapsed
			if ChevronIcon then
				TweenService:Create(ChevronIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Rotation = isCollapsed and -90 or 0
				}):Play()
			end
			updateSizes()
		end

		function Section:Toggle()
			Section:SetCollapsed(not isCollapsed)
		end

		if isCollapsible then
			Creator.AddSignal(SectionHeader.MouseButton1Click, function()
				Section:Toggle()
			end)
		end

		updateSizes()

		if Library.Window and Library.Window.RegisterElement then
			Library.Window.RegisterElement(Section.Root, Title, "Section")
		elseif Library.Windows and #Library.Windows > 0 then
			local currentWindow = Library.Windows[#Library.Windows]
			if currentWindow and currentWindow.RegisterElement then
				currentWindow.RegisterElement(Section.Root, Title, "Section")
			end
		end

		return Section
	end
end)()
Components.Tab = (function()
	local New = Creator.New
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local Components = Components

	local TabModule = {
		Window = nil,
		Tabs = {},
		Containers = {},
		SelectedTab = 0,
		TabCount = 0,
		AnimationTask = nil,
		CurrentAnimationTab = 0,
	}

	function TabModule:Init(Window)
		TabModule.Window = Window
		return TabModule
	end

	function TabModule:GetCurrentTabPos()
		local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
		local TabPos = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y

		return TabPos - TabHolderPos
	end

	function TabModule:New(Title, Icon, Parent)
		local Window = TabModule.Window
		local Elements = Library.Elements

		TabModule.TabCount = TabModule.TabCount + 1
		local TabIndex = TabModule.TabCount

		local Tab = {
			Selected = false,
			Name = Title,
			Type = "Tab",
		}

		local hasIcon = (Icon ~= nil and Icon ~= "" and not fischbypass)

		local tabIconLabel = hasIcon and (function()
			local img = New("ImageLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 8, 0.5, 0),
				BackgroundTransparency = 1,
				ZIndex = 11,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})
			Library:ApplyIcon(img, Icon)
			return img
		end)() or nil

		Tab.IconImage = tabIconLabel

		Tab.Frame = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundTransparency = 0.92,
			Parent = Parent,
			ZIndex = 10,
			ThemeTag = {
				BackgroundColor3 = "Tab",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("TextLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = hasIcon and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
				Text = Title,
				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0,
				FontFace = Font.new(
					"rbxasset://fonts/families/GothamSSm.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				),
				TextSize = 12,
				TextXAlignment = "Left",
				TextYAlignment = "Center",
				Size = UDim2.new(1, -12, 1, 0),
				BackgroundTransparency = 1,
				ZIndex = 11,
				ThemeTag = {
					TextColor3 = "Text",
				},
			}),
			tabIconLabel,
		})

		local ContainerLayout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Tab.ContainerAnim = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			GroupTransparency = 0,
			Parent = Window.ContainerHolder,
			Visible = false,
			Position = UDim2.fromOffset(0, 0),
		})

		Tab.ContainerFrame = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = Tab.ContainerAnim,
			Visible = true,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollingEnabled = true,
		}, {
			ContainerLayout,
			New("UIPadding", {
				PaddingRight = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Tab.ContainerXMotor = Flipper.SingleMotor.new(0)
		Tab.ContainerTransparencyMotor = Flipper.SingleMotor.new(0)

		Tab.ContainerXMotor:onStep(function(Value)
			if Tab.ContainerAnim and Tab.ContainerAnim.Parent then
				Tab.ContainerAnim.Position = UDim2.fromOffset(Value, 0)
			end
		end)

		Tab.ContainerTransparencyMotor:onStep(function(Value)
			if Tab.ContainerAnim and Tab.ContainerAnim.Parent then
				Tab.ContainerAnim.GroupTransparency = Value
			end
		end)

		Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Tab.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
		end)

		Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(0.92, Tab.Frame, "BackgroundTransparency")

		Creator.AddSignal(Tab.Frame.MouseEnter, function()
			Tab.SetTransparency(Tab.Selected and 0.85 or 0.87)
		end)
		Creator.AddSignal(Tab.Frame.MouseLeave, function()
			Tab.SetTransparency(Tab.Selected and 0.89 or 0.92)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
			Tab.SetTransparency(0.92)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
			Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
			TabModule:SelectTab(TabIndex)
		end)

		TabModule.Containers[TabIndex] = Tab.ContainerAnim
		TabModule.Tabs[TabIndex] = Tab

		Tab.Container = Tab.ContainerFrame
		Tab.ScrollFrame = Tab.Container

		Tab.SubTabs = {}
		Tab.SubTabContainers = {}
		Tab.SelectedSubTab = 0
		Tab.SubTabCount = 0
		Tab.SubTabHolder = nil

		function Tab:AddSubTab(Title, Icon)
			self.SubTabCount = self.SubTabCount + 1
			local SubTabIndex = self.SubTabCount

			if not self.SubTabHolder then
				local SubTabListLayout = New("UIListLayout", {
					Padding = UDim.new(0, 6),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				})

				self.SubTabHolder = New("ScrollingFrame", {
					Size = UDim2.new(1, -20, 0, 40),
					Position = UDim2.fromOffset(1, 8),
					BackgroundTransparency = 1,
					Parent = self.ContainerFrame,
					ScrollingDirection = Enum.ScrollingDirection.X,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
					CanvasSize = UDim2.fromScale(0, 1),
					BorderSizePixel = 0,
				}, {
					SubTabListLayout,
					New("UIPadding", {
						PaddingLeft = UDim.new(0, 0),
						PaddingRight = UDim.new(0, 0),
						PaddingTop = UDim.new(0, 0),
						PaddingBottom = UDim.new(0, 0),
					}),
				})

				Creator.AddSignal(SubTabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					self.SubTabHolder.CanvasSize = UDim2.new(0, SubTabListLayout.AbsoluteContentSize.X, 0, 40)
				end)

				local SubTabContainerHolder = New("Frame", {
					Size = UDim2.new(1, -11, 1, -56),
					Position = UDim2.fromOffset(1, 48),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Parent = self.ContainerFrame,
				})

				self.SubTabContainerHolder = SubTabContainerHolder
			end

			local hasSubIcon = (Icon ~= nil and Icon ~= "" and not fischbypass)
			local subTabIconLabel = hasSubIcon and (function()
				local img = New("ImageLabel", {
					Size = UDim2.fromOffset(16, 16),
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				})
				Library:ApplyIcon(img, Icon)
				return img
			end)() or nil

			local SubTabButton = New("TextButton", {
				Size = UDim2.new(0, 0, 0, 32),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 0.92,
				Parent = self.SubTabHolder,
				Text = "",
				ThemeTag = {
					BackgroundColor3 = "Tab",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				New("UIStroke", {
					Transparency = 1,
					Thickness = 1,
					ThemeTag = {
						Color = "Accent",
					},
				}),
				New("UIListLayout", {
					Padding = UDim.new(0, 6),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
				}),
				New("UIPadding", {
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
				}),
				subTabIconLabel,
				New("TextLabel", {
					Text = Title,
					RichText = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextTransparency = 0,
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
					TextSize = 12,
					TextXAlignment = "Left",
					TextYAlignment = "Center",
					Size = UDim2.new(0, 0, 1, 0),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					LayoutOrder = 2,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}),
			})

			local SubTabContainerAnim = New("CanvasGroup", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				GroupTransparency = 0,
				Parent = self.SubTabContainerHolder,
				Visible = false,
				Position = UDim2.fromOffset(0, 0),
			})

			local SubTabContainer = New("ScrollingFrame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Parent = SubTabContainerAnim,
				Visible = true,
				BottomImage = "rbxassetid://6889812791",
				MidImage = "rbxassetid://6889812721",
				TopImage = "rbxassetid://6276641225",
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				ScrollBarImageTransparency = 0.95,
				ScrollBarThickness = 3,
				BorderSizePixel = 0,
				CanvasSize = UDim2.fromScale(0, 0),
				ScrollingDirection = Enum.ScrollingDirection.Y,
				ScrollingEnabled = true,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				New("UIPadding", {
					PaddingRight = UDim.new(0, 10),
					PaddingLeft = UDim.new(0, 1),
					PaddingTop = UDim.new(0, 1),
					PaddingBottom = UDim.new(0, 1),
				}),
			})

			local SubTabLayout = SubTabContainer:FindFirstChild("UIListLayout")
			Creator.AddSignal(SubTabLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SubTabContainer.CanvasSize = UDim2.new(0, 0, 0, SubTabLayout.AbsoluteContentSize.Y + 2)
			end)

			local SubTabXMotor = Flipper.SingleMotor.new(0)
			local SubTabTransparencyMotor = Flipper.SingleMotor.new(0)

			SubTabXMotor:onStep(function(Value)
				if SubTabContainerAnim and SubTabContainerAnim.Parent then
					SubTabContainerAnim.Position = UDim2.fromOffset(Value, 0)
				end
			end)

			SubTabTransparencyMotor:onStep(function(Value)
				if SubTabContainerAnim and SubTabContainerAnim.Parent then
					SubTabContainerAnim.GroupTransparency = Value
				end
			end)

			local SubTabMotor, SubTabSetTransparency = Creator.SpringMotor(0.92, SubTabButton, "BackgroundTransparency")
			local SubTabStroke = SubTabButton:FindFirstChild("UIStroke")

			local function UpdateSubTabAppearance()
				if self.SelectedSubTab == SubTabIndex then
					SubTabSetTransparency(0.75)
					if SubTabStroke then
						SubTabStroke.Transparency = 0
					end
				else
					SubTabSetTransparency(0.92)
					if SubTabStroke then
						SubTabStroke.Transparency = 1
					end
				end
			end

			Creator.AddSignal(SubTabButton.MouseEnter, function()
				if self.SelectedSubTab ~= SubTabIndex then
					SubTabSetTransparency(0.87)
				end
			end)

			Creator.AddSignal(SubTabButton.MouseLeave, function()
				UpdateSubTabAppearance()
			end)

			Creator.AddSignal(SubTabButton.MouseButton1Down, function()
				SubTabSetTransparency(0.92)
			end)

			Creator.AddSignal(SubTabButton.MouseButton1Up, function()
				UpdateSubTabAppearance()
			end)

			UpdateSubTabAppearance()

			Creator.AddSignal(SubTabButton.MouseButton1Click, function()
				self:SelectSubTab(SubTabIndex)
			end)

			local SubTab = {
				Type = "SubTab",
				Name = Title,
				Button = SubTabButton,
				Container = SubTabContainer,
				ContainerAnim = SubTabContainerAnim,
				XMotor = SubTabXMotor,
				TransparencyMotor = SubTabTransparencyMotor,
				SetTransparency = SubTabSetTransparency,
				Selected = false,
			}

			self.SubTabs[SubTabIndex] = SubTab
			self.SubTabContainers[SubTabIndex] = SubTabContainerAnim

			if self.SubTabCount == 1 then
				self:SelectSubTab(SubTabIndex)
			end

			function SubTab:AddSection(SectionTitle, SectionIcon, Collapsible, DefaultCollapsed)
				local Title = SectionTitle
				local Icon = SectionIcon
				local isCollapsible = Collapsible
				local defaultCollapsed = DefaultCollapsed

				if type(SectionTitle) == "table" then
					Title = SectionTitle.Title or "Section"
					Icon = SectionTitle.Icon or SectionIcon
					isCollapsible = SectionTitle.Collapsible
					defaultCollapsed = SectionTitle.Default
				end

				local Section = { Type = "Section" }

				if not fischbypass and Icon then 
					if Library:GetIcon(Icon) then
						Icon = Library:GetIcon(Icon)
					end
					if Icon == "" then Icon = nil end
				end

				local SectionFrame = Components.Section(Title, SubTab.Container, Icon, isCollapsible, defaultCollapsed)
				Section.Container = SectionFrame.Container
				Section.ScrollFrame = SubTab.Container
				Section.Frame = SectionFrame.Root
				Section.SetCollapsed = function(self, val) SectionFrame:SetCollapsed(val) end
				Section.Toggle = function(self) SectionFrame:Toggle() end
				Section.Collapse = function(self) SectionFrame:SetCollapsed(true) end
				Section.Expand = function(self) SectionFrame:SetCollapsed(false) end

				setmetatable(Section, Elements)
				return Section
			end

			setmetatable(SubTab, Elements)
			return SubTab
		end

		function Tab:SelectSubTab(SubTabIndex)
			if self.SelectedSubTab == SubTabIndex then
				return
			end

			local PreviousSubTab = self.SelectedSubTab
			local Direction = (PreviousSubTab > 0 and SubTabIndex > PreviousSubTab) and 1 or -1
			if PreviousSubTab == 0 then
				Direction = 0
			end

			local ContainerSize = self.SubTabContainerHolder and self.SubTabContainerHolder.AbsoluteSize.X or 500
			local SlideDistance = math.min(ContainerSize * 0.15, 60)

			self.SelectedSubTab = SubTabIndex

			for idx, SubTabObj in next, self.SubTabs do
				SubTabObj.Selected = (idx == SubTabIndex)
				local SubTabStroke = SubTabObj.Button:FindFirstChild("UIStroke")
				if idx == SubTabIndex then
					SubTabObj.SetTransparency(0.75)
					if SubTabStroke then
						SubTabStroke.Transparency = 0
					end
				else
					SubTabObj.SetTransparency(0.92)
					if SubTabStroke then
						SubTabStroke.Transparency = 1
					end
				end
			end

			if PreviousSubTab > 0 and PreviousSubTab ~= SubTabIndex and self.SubTabs[PreviousSubTab] and self.SubTabs[SubTabIndex] then
				local OldContainer = self.SubTabs[PreviousSubTab].ContainerAnim
				local NewContainer = self.SubTabs[SubTabIndex].ContainerAnim
				local OldSubTab = self.SubTabs[PreviousSubTab]
				local NewSubTab = self.SubTabs[SubTabIndex]

				for idx, Container in next, self.SubTabContainers do
					if Container and idx ~= PreviousSubTab and idx ~= SubTabIndex then
						Container.Visible = false
						Container.Position = UDim2.fromOffset(0, 0)
						Container.GroupTransparency = 0
						if self.SubTabs[idx] then
							pcall(function()
								self.SubTabs[idx].XMotor:setGoal(Instant(0))
								self.SubTabs[idx].TransparencyMotor:setGoal(Instant(0))
							end)
						end
					end
				end

				OldContainer.Visible = true
				OldContainer.Position = UDim2.fromOffset(0, 0)
				OldContainer.GroupTransparency = 0
				pcall(function()
					OldSubTab.XMotor:setGoal(Instant(0))
					OldSubTab.TransparencyMotor:setGoal(Instant(0))
				end)

				NewContainer.Visible = true
				NewContainer.Position = UDim2.fromOffset(Direction * SlideDistance, 0)
				NewContainer.GroupTransparency = 1
				pcall(function()
					NewSubTab.XMotor:setGoal(Instant(Direction * SlideDistance))
					NewSubTab.TransparencyMotor:setGoal(Instant(1))
				end)

				task.wait()

				pcall(function()
					OldSubTab.XMotor:setGoal(Spring(-Direction * SlideDistance, { frequency = 7.5, dampingRatio = 0.82 }))
					OldSubTab.TransparencyMotor:setGoal(Spring(1, { frequency = 7.5, dampingRatio = 0.82 }))
				end)

				pcall(function()
					NewSubTab.XMotor:setGoal(Spring(0, { frequency = 7.5, dampingRatio = 0.82 }))
					NewSubTab.TransparencyMotor:setGoal(Spring(0, { frequency = 7.5, dampingRatio = 0.82 }))
				end)

				task.spawn(function()
					task.wait(0.28)
					if self.SelectedSubTab == SubTabIndex and self.SubTabs[PreviousSubTab] then
						local OldContainer = self.SubTabs[PreviousSubTab].ContainerAnim
						local OldSubTab = self.SubTabs[PreviousSubTab]
						if OldContainer and OldContainer.Parent then
							OldContainer.Visible = false
							OldContainer.Position = UDim2.fromOffset(0, 0)
							OldContainer.GroupTransparency = 0
						end
						if OldSubTab and OldSubTab.XMotor and OldSubTab.TransparencyMotor then
							pcall(function()
								OldSubTab.XMotor:setGoal(Instant(0))
								OldSubTab.TransparencyMotor:setGoal(Instant(0))
							end)
						end
					end
				end)
			else
				for idx, Container in next, self.SubTabContainers do
					if Container then
						Container.Visible = (idx == SubTabIndex)
						Container.Position = UDim2.fromOffset(0, 0)
						Container.GroupTransparency = 0
						if self.SubTabs[idx] then
							pcall(function()
								self.SubTabs[idx].XMotor:setGoal(Instant(0))
								self.SubTabs[idx].TransparencyMotor:setGoal(Instant(0))
							end)
						end
					end
				end
			end
		end

		function Tab:AddSection(SectionTitle, SectionIcon, Collapsible, DefaultCollapsed)
			local Title = SectionTitle
			local Icon = SectionIcon
			local isCollapsible = Collapsible
			local defaultCollapsed = DefaultCollapsed

			if type(SectionTitle) == "table" then
				Title = SectionTitle.Title or "Section"
				Icon = SectionTitle.Icon or SectionIcon
				isCollapsible = SectionTitle.Collapsible
				defaultCollapsed = SectionTitle.Default
			end

			if self.SelectedSubTab > 0 and self.SubTabs[self.SelectedSubTab] then
				return self.SubTabs[self.SelectedSubTab]:AddSection(Title, Icon, isCollapsible, defaultCollapsed)
			end

			local Section = { Type = "Section" }

			if not fischbypass and Icon then 
				if Library:GetIcon(Icon) then
					Icon = Library:GetIcon(Icon)
				end
				if Icon == "" then Icon = nil end
			end

			local SectionFrame = Components.Section(Title, Tab.Container, Icon, isCollapsible, defaultCollapsed)
			Section.Container = SectionFrame.Container
			Section.ScrollFrame = Tab.Container
			Section.Frame = SectionFrame.Root
			Section.SetCollapsed = function(self, val) SectionFrame:SetCollapsed(val) end
			Section.Toggle = function(self) SectionFrame:Toggle() end
			Section.Collapse = function(self) SectionFrame:SetCollapsed(true) end
			Section.Expand = function(self) SectionFrame:SetCollapsed(false) end

			setmetatable(Section, Elements)
			return Section
		end

		setmetatable(Tab, Elements)
		return Tab
	end

	function TabModule:SelectTab(Tab)
		if TabModule.SelectedTab == Tab then
			return
		end
		
		if TabModule.AnimationTask then
			task.cancel(TabModule.AnimationTask)
			TabModule.AnimationTask = nil
		end

		local Window = TabModule.Window
		local PreviousTab = TabModule.SelectedTab
		
		local Direction = (PreviousTab > 0 and Tab > PreviousTab) and 1 or -1
		if PreviousTab == 0 then
			Direction = 0
		end
		
		local ContainerSize = Window.ContainerHolder and Window.ContainerHolder.AbsoluteSize.X or (Window.ContainerCanvas and Window.ContainerCanvas.AbsoluteSize.X or 500)
		local SlideDistance = math.min(ContainerSize * 0.15, 60)

		TabModule.SelectedTab = Tab
		TabModule.CurrentAnimationTab = Tab

		for _, TabObject in next, TabModule.Tabs do
			TabObject.SetTransparency(0.92)
			TabObject.Selected = false
		end
		TabModule.Tabs[Tab].SetTransparency(0.89)
		TabModule.Tabs[Tab].Selected = true

		Window.TabDisplay.Text = TabModule.Tabs[Tab].Name
		Window.SelectorPosMotor:setGoal(Spring(TabModule:GetCurrentTabPos(), { frequency = 12, dampingRatio = 0.85 }))

		if Window.UpdateElementVisibility and Window.SearchInput and Window.SearchInput.Text ~= "" then
			task.defer(function()
				Window.UpdateElementVisibility(Window.SearchInput.Text)
			end)
		end

		if PreviousTab > 0 and PreviousTab ~= Tab and TabModule.Tabs[PreviousTab] and TabModule.Tabs[Tab] then
			local OldContainer = TabModule.Tabs[PreviousTab].ContainerAnim
			local NewContainer = TabModule.Tabs[Tab].ContainerAnim
			local OldTab = TabModule.Tabs[PreviousTab]
			local NewTab = TabModule.Tabs[Tab]

			if not OldContainer or not NewContainer or not OldTab.ContainerXMotor or not OldTab.ContainerTransparencyMotor or not NewTab.ContainerXMotor or not NewTab.ContainerTransparencyMotor then
				for idx, Container in next, TabModule.Containers do
					if Container then
						Container.Visible = (idx == Tab)
						Container.Position = UDim2.fromOffset(0, 0)
						Container.GroupTransparency = 0
					end
				end
				return
			end

			for idx, Container in next, TabModule.Containers do
				if Container and idx ~= PreviousTab and idx ~= Tab then
					Container.Visible = false
					Container.Position = UDim2.fromOffset(0, 0)
					Container.GroupTransparency = 0
					if TabModule.Tabs[idx] and TabModule.Tabs[idx].ContainerXMotor and TabModule.Tabs[idx].ContainerTransparencyMotor then
						pcall(function()
							TabModule.Tabs[idx].ContainerXMotor:setGoal(Instant(0))
							TabModule.Tabs[idx].ContainerTransparencyMotor:setGoal(Instant(0))
						end)
					end
				end
			end

			local subtleSlide = math.clamp(Direction * 24, -30, 30)

			OldContainer.Visible = true
			OldContainer.Position = UDim2.fromOffset(0, 0)
			OldContainer.GroupTransparency = 0

			NewContainer.Visible = true
			NewContainer.Position = UDim2.fromOffset(subtleSlide, 0)
			NewContainer.GroupTransparency = 1
			pcall(function()
				NewTab.ContainerXMotor:setGoal(Instant(subtleSlide))
				NewTab.ContainerTransparencyMotor:setGoal(Instant(1))
			end)

			TabModule.AnimationTask = task.spawn(function()
				pcall(function()
					OldTab.ContainerXMotor:setGoal(Spring(-subtleSlide, { frequency = 12, dampingRatio = 0.88 }))
					OldTab.ContainerTransparencyMotor:setGoal(Spring(1, { frequency = 12, dampingRatio = 0.88 }))
					NewTab.ContainerXMotor:setGoal(Spring(0, { frequency = 12, dampingRatio = 0.88 }))
					NewTab.ContainerTransparencyMotor:setGoal(Spring(0, { frequency = 12, dampingRatio = 0.88 }))
				end)

				task.wait(0.2)
				if TabModule.CurrentAnimationTab == Tab and TabModule.Tabs[PreviousTab] then
					local oCont = TabModule.Tabs[PreviousTab].ContainerAnim
					local oTab = TabModule.Tabs[PreviousTab]
					if oCont and oCont.Parent then
						oCont.Visible = false
						oCont.Position = UDim2.fromOffset(0, 0)
						oCont.GroupTransparency = 0
					end
					if oTab and oTab.ContainerXMotor and oTab.ContainerTransparencyMotor then
						pcall(function()
							oTab.ContainerXMotor:setGoal(Instant(0))
							oTab.ContainerTransparencyMotor:setGoal(Instant(0))
						end)
					end
					TabModule.AnimationTask = nil
				end
			end)
		else
			for idx, Container in next, TabModule.Containers do
				if Container then
					Container.Visible = (idx == Tab)
					Container.Position = UDim2.fromOffset(0, 0)
					Container.GroupTransparency = 0
					if TabModule.Tabs[idx] and TabModule.Tabs[idx].ContainerXMotor and TabModule.Tabs[idx].ContainerTransparencyMotor then
						pcall(function()
							TabModule.Tabs[idx].ContainerXMotor:setGoal(Instant(0))
							TabModule.Tabs[idx].ContainerTransparencyMotor:setGoal(Instant(0))
						end)
					end
				end
			end
		end
	end

	return TabModule
end)()
Components.Button = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Theme, Parent, DialogCheck)
		DialogCheck = DialogCheck or false
		local Button = {}

		Button.Title = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Button.HoverFrame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Hover",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		Button.Frame = New("TextButton", {
			Size = UDim2.new(0, 0, 0, 32),
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = "DialogButton",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.65,
				ThemeTag = {
					Color = "DialogButtonBorder",
				},
			}),
			Button.HoverFrame,
			Button.Title,
		})
		local Motor, SetTransparency = Creator.SpringMotor(1, Button.HoverFrame, "BackgroundTransparency", DialogCheck)
		Creator.AddSignal(Button.Frame.MouseEnter, function()
			SetTransparency(0.97)
		end)
		Creator.AddSignal(Button.Frame.MouseLeave, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Down, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Up, function()
			SetTransparency(0.97)
		end)

		return Button
	end
end)()
Components.Dialog = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Dialog = {
		Window = nil,
	}

	function Dialog:Init(Window)
		Dialog.Window = Window
		return Dialog
	end

	function Dialog:Create()
		local NewDialog = {
			Buttons = 0,
		}

		NewDialog.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			Parent = Dialog.Window.Root,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewDialog.TintFrame, "BackgroundTransparency", true)
		NewDialog.Signals = {}
		NewDialog.Motors = { TintMotor }

		NewDialog.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -40, 1, -40),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewDialog.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 70),
			Position = UDim2.new(0, 0, 1, -70),
			ThemeTag = {
				BackgroundColor3 = "DialogHolder",
			},
		}, {
			New("Frame", {
				Size = UDim2.new(1, 0, 0, 1),
				ThemeTag = {
					BackgroundColor3 = "DialogHolderLine",
				},
			}),
			NewDialog.ButtonHolder,
		})

		NewDialog.Title = New("TextLabel", {
			FontFace = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			Text = "Dialog",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.fromOffset(20, 25),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewDialog.Scale = New("UIScale", {
			Scale = 1,
		})

		local ScaleMotor, Scale = Creator.SpringMotor(1.1, NewDialog.Scale, "Scale")
		table.insert(NewDialog.Motors, ScaleMotor)

		NewDialog.Root = New("CanvasGroup", {
			Size = UDim2.fromOffset(300, 165),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			GroupTransparency = 1,
			Parent = NewDialog.TintFrame,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			NewDialog.Scale,
			NewDialog.Title,
			NewDialog.ButtonHolderFrame,
		})

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewDialog.Root, "GroupTransparency")
		table.insert(NewDialog.Motors, RootMotor)

		function NewDialog:Open()
			Library.DialogOpen = true
			NewDialog.Scale.Scale = 1.1
			TintTransparency(0.75)
			RootTransparency(0)
			Scale(1)
		end

		function NewDialog:Close()
			if NewDialog.Closed then return end
			NewDialog.Closed = true
			Library.DialogOpen = false
			TintTransparency(1)
			RootTransparency(1)
			Scale(1.1)
			if NewDialog.Root and NewDialog.Root:FindFirstChild("UIStroke") then
				pcall(function() NewDialog.Root.UIStroke:Destroy() end)
			end
			for _, sig in ipairs(NewDialog.Signals or {}) do
				pcall(function() sig:Disconnect() end)
			end
			table.clear(NewDialog.Signals)
			task.delay(0.2, function()
				for _, motor in ipairs(NewDialog.Motors or {}) do
					pcall(function() motor:stop() end)
				end
				table.clear(NewDialog.Motors)
				if NewDialog.TintFrame then
					pcall(function() NewDialog.TintFrame:Destroy() end)
				end
			end)
		end

		NewDialog.TintFrame.Destroying:Connect(function()
			NewDialog:Close()
		end)

		function NewDialog:Button(Title, Callback)
			NewDialog.Buttons = NewDialog.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewDialog.ButtonHolder, true)
			Button.Title.Text = Title

			for _, Btn in next, NewDialog.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size =
						UDim2.new(1 / NewDialog.Buttons, -(((NewDialog.Buttons - 1) * 10) / NewDialog.Buttons), 0, 32)
				end
			end

			table.insert(NewDialog.Signals, Button.Frame.MouseButton1Click:Connect(function()
				Library:SafeCallback(Callback)
				pcall(function()
					NewDialog:Close()
				end)
			end))

			return Button
		end

		return NewDialog
	end

	return Dialog
end)()
Components.Notification = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Notification = {}

	function Notification:Init(GUI)
		Library.ActiveNotifications = Library.ActiveNotifications or {}

		Notification.Holder = New("Frame", {
			Position = UDim2.new(1, -30, 1, -30),
			Size = UDim2.new(0, 310, 1, -30),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Parent = GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				Padding = UDim.new(0, 20),
			}),
		})
	end

	function Notification:New(Config)
		Config.Title = Config.Title or "Title"
		Config.Content = Config.Content or "Content"
		Config.SubContent = Config.SubContent or ""
		Config.Duration = Config.Duration or nil
		local NewNotification = {
			Closed = false,
		}

		NewNotification.AcrylicPaint = Acrylic.AcrylicPaint()

		local hasIcon = (Config.Icon ~= nil and Config.Icon ~= "" and not fischbypass)
		local notifIcon = hasIcon and (function()
			local img = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 14, 0, 15),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Accent",
				},
			})
			Library:ApplyIcon(img, Config.Icon)
			return img
		end)() or nil

		NewNotification.Title = New("TextLabel", {
			Position = UDim2.new(0, hasIcon and 36 or 14, 0, 17),
			Text = Config.Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
			TextSize = 13,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, hasIcon and -48 or -26, 0, 12),
			TextWrapped = true,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.ContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.Content,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.SubContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.SubContent,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewNotification.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(14, 40),
			Size = UDim2.new(1, -28, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
			}),
			NewNotification.ContentLabel,
			NewNotification.SubContentLabel,
		})

		NewNotification.CloseButton = New("TextButton", {
			Text = "",
			Position = UDim2.new(1, -14, 0, 13),
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
		}, {
			New("ImageLabel", {
				Image = Components.Close,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		local ButtonsHolder
		NewNotification.Signals = {}
		local hasButtons = type(Config.Buttons) == "table" and #Config.Buttons > 0
		if hasButtons then
			local btnList = {
				New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 8),
				})
			}
			for idx, btnData in ipairs(Config.Buttons) do
				local btn = New("TextButton", {
					Text = btnData.Title or "Button",
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
					TextSize = 12,
					Size = UDim2.fromOffset(math.max(64, #tostring(btnData.Title or "") * 8 + 16), 26),
					BackgroundTransparency = 0.8,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AutoButtonColor = false,
					ThemeTag = {
						TextColor3 = "Text",
						BackgroundColor3 = "DialogButton",
					},
				}, {
					New("UICorner", { CornerRadius = UDim.new(0, 4) }),
					New("UIStroke", {
						Transparency = 0.6,
						ThemeTag = { Color = "DialogButtonBorder" },
					}),
				})
				table.insert(NewNotification.Signals, btn.MouseButton1Click:Connect(function()
					if btnData.Callback then
						pcall(btnData.Callback)
					end
					NewNotification:Close()
				end))
				table.insert(btnList, btn)
			end
			ButtonsHolder = New("Frame", {
				Size = UDim2.new(1, -28, 0, 26),
				Position = UDim2.new(0, 14, 1, -32),
				BackgroundTransparency = 1,
			}, btnList)
		end

		local ProgressBar = Config.Duration and New("Frame", {
			Size = UDim2.new(1, 0, 0, 2),
			Position = UDim2.new(0, 0, 1, -2),
			BackgroundTransparency = 0.35,
			BackgroundColor3 = Color3.fromRGB(96, 205, 255),
			BorderSizePixel = 0,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}) or nil

		local rootChildren = {
			NewNotification.AcrylicPaint.Frame,
			notifIcon,
			NewNotification.Title,
			NewNotification.CloseButton,
			NewNotification.LabelHolder,
			ButtonsHolder,
			ProgressBar,
		}

		NewNotification.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromScale(1, 0),
		}, rootChildren)

		if Config.Content == "" then
			NewNotification.ContentLabel.Visible = false
		end

		if Config.SubContent == "" then
			NewNotification.SubContentLabel.Visible = false
		end

		NewNotification.Holder = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 200),
			Parent = Notification.Holder,
		}, {
			NewNotification.Root,
		})

		local RootMotor = Flipper.GroupMotor.new({
			Scale = 1,
			Offset = 60,
		})

		RootMotor:onStep(function(Values)
			NewNotification.Root.Position = UDim2.new(Values.Scale, Values.Offset, 0, 0)
		end)

		table.insert(NewNotification.Signals, NewNotification.CloseButton.MouseButton1Click:Connect(function()
			NewNotification:Close()
		end))

		function NewNotification:ApplyTransparency()
			if Library.Theme == "Glass" and Library.UseAcrylic then
				local Value = Library.NotificationTransparency or 1

				local notifTransparency = 0.85 + (Value * 0.08)
				if Value > 1 then
					notifTransparency = 0.93 + ((Value - 1) * 0.04)
				end

				local notifBackgroundTransparency = 0.8 + (Value * 0.1)
				if Value > 1 then
					notifBackgroundTransparency = 0.9 + ((Value - 1) * 0.05)
				end

				if NewNotification.AcrylicPaint and NewNotification.AcrylicPaint.Model then
					NewNotification.AcrylicPaint.Model.Transparency = math.min(notifTransparency, 0.97)
				end
				if NewNotification.AcrylicPaint and NewNotification.AcrylicPaint.Frame and NewNotification.AcrylicPaint.Frame.Background then
					NewNotification.AcrylicPaint.Frame.Background.BackgroundTransparency = math.min(notifBackgroundTransparency, 0.95)
				end
			end
		end

		function NewNotification:Open()
			local ContentSize = NewNotification.LabelHolder.AbsoluteSize.Y
			local extraHeight = hasButtons and 38 or 0
			NewNotification.Holder.Size = UDim2.new(1, 0, 0, 58 + ContentSize + extraHeight)

			RootMotor:setGoal({
				Scale = Spring(0, { frequency = 7.5, dampingRatio = 0.82 }),
				Offset = Spring(0, { frequency = 7.5, dampingRatio = 0.82 }),
			})

			if ProgressBar and Config.Duration then
				TweenService:Create(ProgressBar, TweenInfo.new(Config.Duration, Enum.EasingStyle.Linear), {
					Size = UDim2.new(0, 0, 0, 2),
				}):Play()
			end

			task.defer(function()
				task.wait(0.1)
				NewNotification:ApplyTransparency()
			end)
		end

		function NewNotification:Close()
			if not NewNotification.Closed then
				NewNotification.Closed = true

				for _, sig in ipairs(NewNotification.Signals or {}) do
					pcall(function() sig:Disconnect() end)
				end
				table.clear(NewNotification.Signals)

				for i, notif in pairs(Library.ActiveNotifications or {}) do
					if notif == NewNotification then
						table.remove(Library.ActiveNotifications, i)
						break
					end
				end

				task.spawn(function()
					RootMotor:setGoal({
						Scale = Spring(1, { frequency = 7.5, dampingRatio = 0.85 }),
						Offset = Spring(60, { frequency = 7.5, dampingRatio = 0.85 }),
					})
					task.wait(0.25)
					pcall(function() RootMotor:stop() end)
					if Library.UseAcrylic and NewNotification.AcrylicPaint and NewNotification.AcrylicPaint.Model then
						pcall(function() NewNotification.AcrylicPaint.Model:Destroy() end)
					end
					if NewNotification.Holder then
						pcall(function() NewNotification.Holder:Destroy() end)
					end
				end)
			end
		end

		table.insert(Library.ActiveNotifications, NewNotification)

		NewNotification:Open()
		if Config.Duration then
			task.delay(Config.Duration, function()
				NewNotification:Close()
			end)
		end
		return NewNotification
	end

	return Notification
end)()
Components.Textbox = (function()
	local New = Creator.New

	return function(Parent, Acrylic)
		Acrylic = Acrylic or false
		local Textbox = {}

		Textbox.Input = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromOffset(10, 0),
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		Textbox.Container = New("Frame", {
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.new(0, 6, 0, 0),
			Size = UDim2.new(1, -12, 1, 0),
		}, {
			Textbox.Input,
		})

		Textbox.Indicator = New("Frame", {
			Size = UDim2.new(1, -4, 0, 1),
			Position = UDim2.new(0, 2, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = Acrylic and 0.5 or 0,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine",
			},
		})

		Textbox.Frame = New("Frame", {
			Size = UDim2.new(0, 0, 0, 30),
			BackgroundTransparency = Acrylic and 0.9 or 0,
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "Input" or "DialogInput",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = Acrylic and 0.5 or 0.65,
				ThemeTag = {
					Color = Acrylic and "InElementBorder" or "DialogButtonBorder",
				},
			}),
			Textbox.Indicator,
			Textbox.Container,
		})

		local function Update()
			local PADDING = 2
			local Reveal = Textbox.Container.AbsoluteSize.X

			if not Textbox.Input:IsFocused() or Textbox.Input.TextBounds.X <= Reveal - 2 * PADDING then
				Textbox.Input.Position = UDim2.new(0, PADDING, 0, 0)
			else
				local Cursor = Textbox.Input.CursorPosition
				if Cursor ~= -1 then
					local subtext = string.sub(Textbox.Input.Text, 1, Cursor - 1)
					local width = TextService:GetTextSize(
						subtext,
						Textbox.Input.TextSize,
						Textbox.Input.Font,
						Vector2.new(math.huge, math.huge)
					).X

					local CurrentCursorPos = Textbox.Input.Position.X.Offset + width
					if CurrentCursorPos < PADDING then
						Textbox.Input.Position = UDim2.fromOffset(PADDING - width, 0)
					elseif CurrentCursorPos > Reveal - PADDING - 1 then
						Textbox.Input.Position = UDim2.fromOffset(Reveal - width - PADDING - 1, 0)
					end
				end
			end
		end

		task.spawn(Update)

		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Update)
		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("CursorPosition"), Update)

		Creator.AddSignal(Textbox.Input.Focused, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -2, 0, 2)
			Textbox.Indicator.Position = UDim2.new(0, 1, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "InputFocused" or "DialogHolder" })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = "InputIndicatorFocus" })
		end)

		Creator.AddSignal(Textbox.Input.FocusLost, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -4, 0, 1)
			Textbox.Indicator.Position = UDim2.new(0, 2, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0.5
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "Input" or "DialogInput" })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine" })
		end)

		return Textbox
	end
end)()
Components.TitleBar = (function()
	local New = Creator.New
	local AddSignal = Creator.AddSignal

	local function parseColor(value)
		if typeof(value) == "Color3" then return value end
		if typeof(value) == "string" then
			local hex = value:gsub("#","")
			if #hex == 6 then
				local r = tonumber(hex:sub(1,2), 16) or 255
				local g = tonumber(hex:sub(3,4), 16) or 255
				local b = tonumber(hex:sub(5,6), 16) or 255
				return Color3.fromRGB(r,g,b)
			end
		end
		return Themes[Library.Theme].SubText or Color3.fromRGB(170,170,170)
	end

	return function(Config)
		local TitleBar = {}

		local function BarButton(Icon, Pos, Parent, Callback)
			local Button = {
				Callback = Callback or function() end,
			}

			Button.Frame = New("TextButton", {
				Size = UDim2.new(0, 34, 1, -8),
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				Parent = Parent,
				Position = Pos,
				Text = "",
				ThemeTag = {
					BackgroundColor3 = "Text",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 7),
				}),
				New("ImageLabel", {
					Image = Icon,
					Size = UDim2.fromOffset(16, 16),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Name = "Icon",
					ThemeTag = {
						ImageColor3 = "Text",
					},
				}),
			})

			local Motor, SetTransparency = Creator.SpringMotor(1, Button.Frame, "BackgroundTransparency")

			AddSignal(Button.Frame.MouseEnter, function()
				SetTransparency(0.94)
			end)
			AddSignal(Button.Frame.MouseLeave, function()
				SetTransparency(1, true)
			end)
			AddSignal(Button.Frame.MouseButton1Down, function()
				SetTransparency(0.96)
			end)
			AddSignal(Button.Frame.MouseButton1Up, function()
				SetTransparency(0.94)
			end)
			AddSignal(Button.Frame.MouseButton1Click, Button.Callback)

			Button.SetCallback = function(Func)
				Button.Callback = Func
			end

			return Button
		end

		TitleBar.Frame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 42),
			BackgroundTransparency = 1,
			Parent = Config.Parent,
		}, {
			New("Frame", {
				Size = UDim2.new(1, -16, 1, 0),
				Position = UDim2.new(0, 12, 0, 0),
				BackgroundTransparency = 1,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 5),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),

				(Config.Icon and Config.Icon ~= "") and (function()
					local img = New("ImageLabel", {
						Size = UDim2.fromOffset(20, 20),
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						ThemeTag = {
							ImageColor3 = "Text",
						},
					})
					Library:ApplyIcon(img, Config.Icon)
					return img
				end)() or nil,

				New("TextLabel", {
					RichText = true,
					Text = Config.Title,
					FontFace = Font.new(
						"rbxasset://fonts/families/GothamSSm.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					),
					TextSize = 12,
					TextXAlignment = "Left",
					TextYAlignment = "Center",
					Size = UDim2.fromScale(0, 1),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					LayoutOrder = Config.Icon and 2 or 1,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}),
				Config.SubTitle and New("TextLabel", {
					RichText = true,
					Text = Config.SubTitle,
					TextTransparency = 0.4,
					FontFace = Font.new(
						"rbxasset://fonts/families/GothamSSm.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					),
					TextSize = 12,
					TextXAlignment = "Left",
					TextYAlignment = "Center",
					Size = UDim2.fromScale(0, 1),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					LayoutOrder = Config.Icon and 3 or 2,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}) or nil,

			}),
			New("Frame", {
				BackgroundTransparency = 0.35,
				Size = UDim2.new(1, 0, 0, 1.5),
				Position = UDim2.new(0, 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			}, {
				New("UIGradient", {
					ThemeTag = {
						Color = "AccentGradient",
					},
				}),
			}),
		})
		TitleBar.CloseButton = BarButton(Components.Assets.Close, UDim2.new(1, -4, 0, 4), TitleBar.Frame, function()
			Library.Window:Dialog({
				Title = "Close",
				Content = "Are you sure you want to unload the interface?",
				Buttons = {
					{
						Title = "Yes",
						Callback = function()
							Library:Destroy()
						end,
					},
					{
						Title = "No",
					},
				},
			})
		end)
		TitleBar.MaxButton = BarButton(Components.Assets.Max, UDim2.new(1, -40, 0, 4), TitleBar.Frame, function()
			Config.Window.Maximize(not Config.Window.Maximized)
		end)
		local showMin = (Config.MinButton ~= false) and (Config.MinimizeButton ~= false) and (Config.Minimize ~= false)
		TitleBar.MinButton = BarButton(Components.Assets.Min, UDim2.new(1, -80, 0, 4), TitleBar.Frame, function()
			Library.Window:Minimize()
		end)
		if not showMin and TitleBar.MinButton and TitleBar.MinButton.Frame then
			TitleBar.MinButton.Frame.Visible = false
		end

		return TitleBar
	end
end)()
Components.Window = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	return function(Config)
		local Window = {
			Minimized = false,
			Maximized = false,
			Size = Config.Size,
			CurrentPos = 0,
			TabWidth = 0,
			Position = UDim2.fromOffset(0, 0),
			DropdownsOutsideWindow = Config.DropdownsOutsideWindow == true,
		}

		Library.Window = Window

		local Dragging, DragInput, MousePos, StartPos = false
		local Resizing, ResizePos = false
		local MinimizeNotif = false

		Window.AcrylicPaint = Acrylic.AcrylicPaint()

		local function CenterWindow()
			local vp = Camera.ViewportSize
			if vp.X > 50 and vp.Y > 50 then
				local isSmallScreen = Mobile or (vp.X < 640)
				local maxW = math.max(isSmallScreen and 280 or 320, vp.X - (isSmallScreen and 10 or 20))
				local maxH = math.max(isSmallScreen and 200 or 240, vp.Y - (isSmallScreen and 12 or 20))
				local curW = Window.Size.X.Offset
				local curH = Window.Size.Y.Offset
				if curW > maxW or curH > maxH or (isSmallScreen and curW >= vp.X - 6) then
					Window.Size = UDim2.fromOffset(math.min(curW, maxW), math.min(curH, maxH))
					if Window.Root then
						Window.Root.Size = Window.Size
					end
				end
			end
			local x = math.max(0, (vp.X - Window.Size.X.Offset) / 2)
			local y = math.max(0, (vp.Y - Window.Size.Y.Offset) / 2)
			Window.Position = UDim2.fromOffset(math.floor(x), math.floor(y))
			if Window.Root then
				Window.Root.Position = Window.Position
			end
		end

		local defaultTabWidth = Config.TabWidth or 160
		if (Mobile or (Camera.ViewportSize.X > 0 and Camera.ViewportSize.X < 640)) and defaultTabWidth > 130 then
			defaultTabWidth = 130
		end
		Window.TabWidth = defaultTabWidth

		local Selector = New("Frame", {
			Size = UDim2.fromOffset(4, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			Position = UDim2.fromOffset(0, (Window.TabHolderTop or 45) + 0),
			AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 1,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
			New("UIGradient", {
				Rotation = 90,
				ThemeTag = {
					Color = "AccentGradient",
				},
			}),
		})

		local ResizeRight = New("Frame", {
			Size = UDim2.new(0, 14, 1, -24),
			Position = UDim2.new(1, -7, 0, 0),
			BackgroundTransparency = 1,
			ZIndex = 50,
		})

		local ResizeBottom = New("Frame", {
			Size = UDim2.new(1, -28, 0, 14),
			Position = UDim2.new(0, 14, 1, -7),
			BackgroundTransparency = 1,
			ZIndex = 50,
		})

		local ResizeBottomRight = New("Frame", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -20, 1, -20),
			BackgroundTransparency = 1,
			ZIndex = 51,
		}, {
			New("ImageLabel", {
				Image = "rbxassetid://10709798362",
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.new(1, -3, 1, -3),
				AnchorPoint = Vector2.new(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 0.5,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})
		})

		local ResizeLeft = New("Frame", {
			Size = UDim2.new(0, 14, 1, -44),
			Position = UDim2.new(0, -7, 0, 34),
			BackgroundTransparency = 1,
			ZIndex = 50,
		})

		local ResizeBottomLeft = New("Frame", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(0, -6, 1, -20),
			BackgroundTransparency = 1,
			ZIndex = 51,
		})

		local SearchElements = {}
		local AllElements = {}

		local function UpdateElementVisibility(searchTerm)
			if not searchTerm then searchTerm = "" end
			
			local function normalizeText(text)
				if not text then return "" end
				text = tostring(text)
				text = string.gsub(text, "^%s+", "")
				text = string.gsub(text, "%s+$", "")
				text = string.gsub(text, "%s+", " ")
				return string.lower(text)
			end
			
			local function checkMatch(text, query)
				if query == "" then return true end
				local normalizedText = normalizeText(text)
				if normalizedText == "" then return false end
				local queryLower = normalizeText(query)
				if queryLower == "" then return true end
				
				for word in string.gmatch(queryLower, "%S+") do
					if not string.find(normalizedText, word, 1, true) then
						return false
					end
				end
				return true
			end
			
			local normalizedQuery = normalizeText(searchTerm)
			local TabMod = Window.TabModule
			
			if normalizedQuery == "" then
				for element, _ in pairs(AllElements) do
					if element and element.Parent then
						element.Visible = true
					end
				end
				if TabMod and TabMod.Tabs then
					for _, tabObj in pairs(TabMod.Tabs) do
						if tabObj and tabObj.Frame then
							tabObj.Frame.Visible = true
						end
					end
				end
				task.spawn(function()
					if not Window or not Window.ContainerHolder then return end
					for _, tabContainer in pairs(Window.ContainerHolder:GetChildren()) do
						local scroll = tabContainer:IsA("ScrollingFrame") and tabContainer or tabContainer:FindFirstChildWhichIsA("ScrollingFrame")
						if scroll then
							local containerLayout = scroll:FindFirstChild("UIListLayout")
							if containerLayout then
								scroll.CanvasSize = UDim2.new(0, 0, 0, containerLayout.AbsoluteContentSize.Y + 20)
							end
							for _, section in pairs(scroll:GetChildren()) do
								if section:IsA("Frame") and section:FindFirstChild("Container") then
									section.Visible = true
									local sCont = section:FindFirstChild("Container")
									local sLayout = sCont:FindFirstChild("UIListLayout")
									if sLayout then
										sCont.Size = UDim2.new(1, 0, 0, sLayout.AbsoluteContentSize.Y)
										section.Size = UDim2.new(1, 0, 0, sLayout.AbsoluteContentSize.Y + 25)
									end
								end
							end
						end
					end
				end)
				return
			end
			
			local matchedSectionFrames = {}
			local elementsInMatchedSections = {}
			local matchingTabIndices = {}
			local bestElement = nil
			local bestScore = -1
			local bestTabIdx = nil

			local function getTabIndex(obj)
				if not TabMod or not TabMod.Tabs then return nil end
				local p = obj
				while p do
					for idx, tabObj in pairs(TabMod.Tabs) do
						if tabObj and (p == tabObj.ContainerAnim or p == tabObj.Container or p == tabObj.ContainerFrame) then
							return idx
						end
					end
					p = p.Parent
				end
				return nil
			end

			local function scoreMatch(title, desc, query)
				local tLower = string.lower(title or "")
				local dLower = string.lower(desc or "")
				local qLower = string.lower(query)

				if tLower == qLower then
					return 1000
				elseif string.sub(tLower, 1, #qLower) == qLower then
					return 800
				elseif string.find(tLower, "%f[%a]" .. qLower) then
					return 600
				elseif string.find(tLower, qLower, 1, true) then
					return 400
				elseif checkMatch(tLower, qLower) then
					return 200
				elseif dLower ~= "" and string.find(dLower, qLower, 1, true) then
					return 100
				end
				return 10
			end

			for element, data in pairs(AllElements) do
				if element and element.Parent and data.type == "Section" then
					local title = tostring(data.title or "")
					if checkMatch(title, normalizedQuery) then
						matchedSectionFrames[element] = true
						local tIdx = data.tabIndex or getTabIndex(element)
						if tIdx then
							data.tabIndex = tIdx
							matchingTabIndices[tIdx] = true
						end
						local container = element:FindFirstChild("Container")
						if container then
							for _, child in pairs(container:GetChildren()) do
								if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
									elementsInMatchedSections[child] = true
								end
							end
						end
					end
				end
			end

			for element, data in pairs(AllElements) do
				if element and element.Parent and data.type ~= "Section" then
					local title = tostring(data.title or "")
					local desc = tostring(data.description or "")
					local isMatch = checkMatch(title, normalizedQuery)
						or (desc ~= "" and checkMatch(desc, normalizedQuery))
						or elementsInMatchedSections[element] == true

					if not isMatch and data.section and matchedSectionFrames[data.section] then
						isMatch = true
					end

					element.Visible = isMatch

					if isMatch then
						local tIdx = data.tabIndex or getTabIndex(element)
						if tIdx then
							data.tabIndex = tIdx
							matchingTabIndices[tIdx] = true
							local score = scoreMatch(title, desc, normalizedQuery)
							if score > bestScore or (score == bestScore and TabMod and tIdx == TabMod.SelectedTab) then
								bestScore = score
								bestElement = element
								bestTabIdx = tIdx
							end
						end
					end
				end
			end

			if not bestTabIdx then
				for element, data in pairs(AllElements) do
					if element and element.Parent and data.type == "Section" and matchedSectionFrames[element] then
						local tIdx = data.tabIndex or getTabIndex(element)
						if tIdx then
							bestTabIdx = tIdx
							bestElement = element
							break
						end
					end
				end
			end

			if TabMod and TabMod.Tabs then
				for idx, tabObj in pairs(TabMod.Tabs) do
					if tabObj and tabObj.Name and checkMatch(tabObj.Name, normalizedQuery) then
						matchingTabIndices[idx] = true
						if not bestTabIdx then
							bestTabIdx = idx
						end
					end
				end

				for idx, tabObj in pairs(TabMod.Tabs) do
					if tabObj and tabObj.Frame then
						local isTabVisible = matchingTabIndices[idx] == true
						tabObj.Frame.Visible = isTabVisible
					end
				end

				-- Automatically change tab to the matched feature
				if bestTabIdx and bestTabIdx ~= TabMod.SelectedTab then
					TabMod:SelectTab(bestTabIdx)
				end
			end

			for element, data in pairs(AllElements) do
				if element and element.Parent and data.type == "Section" then
					local sCont = element:FindFirstChild("Container")
					if sCont then
						local hasVis = false
						for _, child in pairs(sCont:GetChildren()) do
							if not child:IsA("UIListLayout") and not child:IsA("UIPadding") and child.Visible then
								hasVis = true
								break
							end
						end
						element.Visible = hasVis or matchedSectionFrames[element] == true
						if element.Visible and sCont:FindFirstChild("UIListLayout") then
							local sLayout = sCont:FindFirstChild("UIListLayout")
							sCont.Visible = true
							sCont.Size = UDim2.new(1, 0, 0, sLayout.AbsoluteContentSize.Y)
							element.Size = UDim2.new(1, 0, 0, sLayout.AbsoluteContentSize.Y + 25)
						end
					end
				end
			end

			local targetTabIdx = bestTabIdx or (TabMod and TabMod.SelectedTab)
			local scrollToElement = bestElement

			local function scrollToTarget()
				if not TabMod or not TabMod.Tabs or not targetTabIdx then return end
				local curTab = TabMod.Tabs[targetTabIdx]
				if not curTab then return end
				local scroll = curTab.Container or curTab.ContainerFrame
				if not scroll then return end

				local cLayout = scroll:FindFirstChild("UIListLayout")
				if cLayout then
					scroll.CanvasSize = UDim2.new(0, 0, 0, cLayout.AbsoluteContentSize.Y + 20)
				end

				if scrollToElement and scrollToElement.Parent then
					local elemY = scrollToElement.AbsolutePosition.Y
					local scrollY = scroll.AbsolutePosition.Y
					local targetY = math.max(0, elemY - scrollY + scroll.CanvasPosition.Y - 14)
					TweenService:Create(scroll, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						CanvasPosition = Vector2.new(0, targetY)
					}):Play()

					pcall(function()
						local origTrans = scrollToElement.BackgroundTransparency
						TweenService:Create(scrollToElement, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							BackgroundTransparency = 0.55
						}):Play()
						task.delay(0.7, function()
							if scrollToElement and scrollToElement.Parent then
								TweenService:Create(scrollToElement, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									BackgroundTransparency = origTrans
								}):Play()
							end
						end)
					end)
				end
			end

			task.delay(0.08, scrollToTarget)
		end

		local function RegisterElement(elementFrame, title, elementType, description)
			if elementFrame then
				local sectionFrame = nil
				local parent = elementFrame.Parent
				local tabContainer = nil
				
				while parent do
					if parent:FindFirstChild("Container") and not sectionFrame then
						local sectionContainer = parent:FindFirstChild("Container")
						if elementFrame.Parent == sectionContainer then
							sectionFrame = parent
						end
					end
					if parent.Parent == Window.ContainerHolder then
						tabContainer = parent
					end
					parent = parent.Parent
				end
				
				AllElements[elementFrame] = {
					title = tostring(title or ""),
					type = elementType or "Element",
					description = tostring(description or ""),
					section = sectionFrame,
					tabContainer = tabContainer,
				}
			end
		end

		Window.ShowSearch = (Config.Search == nil) and true or (Config.Search and true or false)

		local ImageAsset = Config.Image
		local hasImage = ImageAsset and type(ImageAsset) == "string" and ImageAsset ~= ""
		local imageSize = Window.TabWidth - 24
		local topOffset = 0

		local ImageFrame = hasImage and New("ImageLabel", {
			Size = UDim2.new(0, imageSize, 0, imageSize),
			Position = UDim2.new(0.5, 0, 0, topOffset),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Image = ImageAsset,
			ZIndex = 5,
			Visible = true,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		}) or nil

		Window.HasImage = hasImage
		Window.ImageFrame = ImageFrame
		Window.ImageSize = imageSize
		Window.TopOffset = topOffset

		local searchOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
		local tabHolderTop = Window.ShowSearch and 34 or 0
		local userInfoBottomPad = Config.UserInfo and 48 or 4
		Window.TabHolderTop = tabHolderTop

		Window.TabHolder = New("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, -(tabHolderTop + userInfoBottomPad)),
			Position = UDim2.new(0, 0, 0, tabHolderTop),
			BackgroundTransparency = 1,
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 4),
			}),
			New("UIPadding", {
				PaddingTop = UDim.new(0, 2),
				PaddingBottom = UDim.new(0, 4),
				PaddingLeft = UDim.new(0, 0),
				PaddingRight = UDim.new(0, 0),
			}),
		})

		local SearchFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 28),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 0.7,
			ZIndex = 10,
			Visible = Window.ShowSearch,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			ThemeTag = {
				BackgroundColor3 = "Element",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local SearchInput = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -36, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			PlaceholderText = "Search...",
			PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
			ClearTextOnFocus = false,
			Text = "",
			Parent = SearchFrame,
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		local SearchIcon = New("ImageLabel", {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -13, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = "rbxassetid://10734943674",
			Parent = SearchFrame,
			ImageTransparency = 0.3,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local SearchTextbox = {
			Input = SearchInput,
			Frame = SearchFrame,
		}

		local searchDebounce = nil
		Creator.AddSignal(SearchTextbox.Input:GetPropertyChangedSignal("Text"), function()
			local searchText = SearchTextbox.Input.Text or ""
			if searchDebounce then
				task.cancel(searchDebounce)
			end
			searchDebounce = task.delay(0.06, function()
				UpdateElementVisibility(searchText)
			end)
		end)

		Creator.AddSignal(SearchTextbox.Input.FocusLost, function(enterPressed)
			if enterPressed then
				UpdateElementVisibility(SearchTextbox.Input.Text or "")
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.Escape and SearchTextbox.Input:IsFocused() then
				SearchTextbox.Input.Text = ""
				SearchTextbox.Input:ReleaseFocus()
			end
		end)

		Window.SearchElements = SearchElements
		Window.AllElements = AllElements
		Window.RegisterElement = RegisterElement
		Window.UpdateElementVisibility = UpdateElementVisibility
		Window.SearchInput = SearchInput

		local imageSize = Window.TabWidth - 24
		local topOffset = Window.TopOffset or 25
		local imageOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
		local searchHeight = 28
		local totalOffset = (Window.ShowSearch and searchHeight or 0) + imageOffset

		local TabFrame = New("Frame", {
			Size = UDim2.new(0, Window.TabWidth, 1, -58),
			Position = UDim2.new(0, 12, 0, 48),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			ImageFrame,
			SearchFrame,
			Window.TabHolder,
			Selector,
		})

		Window.TabFrame = TabFrame

		Window.TabDisplay = New("TextLabel", {
			RichText = true,
			Text = "Tab",
			TextTransparency = 0,
			FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 28,
			TextXAlignment = "Left",
			TextYAlignment = "Center",
			Size = UDim2.new(1, -16, 0, 28),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 56),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Window.ContainerHolder = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		})

		Window.ContainerAnim = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerCanvas = New("Frame", {
			Size = UDim2.new(1, -Window.TabWidth - 32, 1, -102),
			Position = UDim2.fromOffset(Window.TabWidth + 26, 90),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			Window.ContainerAnim,
			Window.ContainerHolder
		})

		local backgroundTransparency = Config.BackgroundTransparency
		if backgroundTransparency == nil then
			backgroundTransparency = 0.5
		end
		Window.BackgroundTransparency = backgroundTransparency

		local backgroundImageTransparency = Config.BackgroundImageTransparency
		if backgroundImageTransparency == nil then
			backgroundImageTransparency = backgroundTransparency
		end
		Window.BackgroundImageTransparency = backgroundImageTransparency

		local rootChildren = {}
		
		if Config.BackgroundImage then
			local BackgroundImageFrame = New("ImageLabel", {
				Name = "BackgroundImage",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 1,
				Image = Config.BackgroundImage,
				ImageTransparency = math.max(0, math.min(1, backgroundImageTransparency)),
				ZIndex = 0,
				ScaleType = Enum.ScaleType.Stretch,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
			})
			Window.BackgroundImage = BackgroundImageFrame
			table.insert(rootChildren, BackgroundImageFrame)
			
			if Window.AcrylicPaint and Window.AcrylicPaint.Frame then
				if backgroundImageTransparency <= 0.1 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 1
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 1
					end
					local function makeTransparent(obj)
						if obj:IsA("Frame") then
							obj.BackgroundTransparency = 1
						elseif obj:IsA("ImageLabel") then
							obj.ImageTransparency = 1
						end
						for _, child in ipairs(obj:GetChildren()) do
							if not child:IsA("UICorner") and not child:IsA("UIGradient") and not child:IsA("UIStroke") and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
								makeTransparent(child)
							end
						end
					end
					makeTransparent(Window.AcrylicPaint.Frame)
				elseif backgroundImageTransparency < 0.3 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.99
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.99
					end
				else
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.98
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.98
					end
				end
			end
		end
		
		table.insert(rootChildren, Window.AcrylicPaint.Frame)
		table.insert(rootChildren, Window.TabDisplay)
		table.insert(rootChildren, Window.ContainerCanvas)
		table.insert(rootChildren, TabFrame)
		table.insert(rootChildren, ResizeRight)
		table.insert(rootChildren, ResizeBottom)
		table.insert(rootChildren, ResizeBottomRight)
		table.insert(rootChildren, ResizeLeft)
		table.insert(rootChildren, ResizeBottomLeft)

		Window.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = Window.Size,
			Position = Window.Position,
			Parent = Config.Parent,
			Visible = false,
		}, rootChildren)

		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
			Parent = Window.Root,
		})

		Window.Scale = New("UIScale", {
			Scale = 0.9,
			Parent = Window.Root,
		})

		CenterWindow()
		Creator.AddSignal(Camera:GetPropertyChangedSignal("ViewportSize"), function()
			CenterWindow()
		end)


		Window.TitleBar = Components.TitleBar({
			Title = Config.Title,
			SubTitle = Config.SubTitle,
			Icon = Config.Icon,
			Parent = Window.Root,
			Window = Window,
			UserInfoTitle = Config.UserInfoTitle,
			UserInfo = Config.UserInfo,
			UserInfoSubtitle = Config.UserInfoSubtitle,
			UserInfoSubtitleColor = Config.UserInfoSubtitleColor,
			MinButton = Config.MinButton,
			MinimizeButton = Config.MinimizeButton,
			Minimize = Config.Minimize,
		})

		if Config.UserInfo then
			local function parseColor(value)
				if typeof(value) == "Color3" then return value end
				return Themes[Library.Theme].SubText or Color3.fromRGB(170,170,170)
			end

			local userInfoHeight = 44
			Window.UserInfoHeight = userInfoHeight
			Window.UserInfoTop = Config.UserInfoTop
			local UserInfoSection = New("Frame", {
				Name = "UserInfoSection",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, userInfoHeight),
				Position = Config.UserInfoTop and UDim2.fromOffset(0, 0) or UDim2.new(0, 0, 1, -userInfoHeight),
				ZIndex = 15,
				Parent = TabFrame,
			})

			New("Frame", {
				Name = "UserInfoSeparator",
				BackgroundTransparency = 0.5,
				Size = UDim2.new(1, 0, 0, 1),
				Position = Config.UserInfoTop and UDim2.fromOffset(0, userInfoHeight + 2) or UDim2.new(0, 0, 1, -(userInfoHeight + 3)),
				ZIndex = 15,
				Parent = TabFrame,
				ThemeTag = {
					BackgroundColor3 = "TitleBarLine",
				},
			})

			local avatarSize = 28
			local Avatar = New("ImageLabel", {
				Name = "Avatar",
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(avatarSize, avatarSize),
				Position = UDim2.new(0, 4, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Image = "rbxassetid://0",
				Parent = UserInfoSection,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
				New("UIStroke", { Transparency = 0.7, Thickness = 1, ThemeTag = { Color = "ElementBorder" } }),
			})

			pcall(function()
				local Players = game:GetService("Players")
				local content, isReady = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
				if isReady and content then
					Avatar.Image = content
				end
			end)

			local titleText = tostring((Config.UserInfoTitle ~= nil and Config.UserInfoTitle) or (LocalPlayer.Name or "User"))
			local subtitleText = (Config.UserInfoSubtitle ~= nil) and tostring(Config.UserInfoSubtitle) or ""

			New("TextLabel", {
				Name = "UserName",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
				TextSize = 13,
				Text = titleText,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Size = UDim2.new(1, -(avatarSize + 14), 0, 16),
				Position = UDim2.new(0, avatarSize + 10, 0, 5),
				Parent = UserInfoSection,
				ThemeTag = { TextColor3 = "Text" },
			})

			New("TextLabel", {
				Name = "UserSubtitle",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextSize = 11,
				TextTransparency = 0.2,
				Text = subtitleText,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextColor3 = parseColor(Config.UserInfoSubtitleColor),
				Size = UDim2.new(1, -(avatarSize + 14), 0, 14),
				Position = UDim2.new(0, avatarSize + 10, 0, 23),
				Parent = UserInfoSection,
			})

			local tabTop = Window.ShowSearch and 34 or 0
			Window.TabHolder.Position = UDim2.new(0, 0, 0, tabTop)
			Window.TabHolder.Size = UDim2.new(1, 0, 1, -(tabTop + 48))
		end

		if Library.UseAcrylic then
			Window.AcrylicPaint.AddParent(Window.Root)
		end

		local SizeMotor = Flipper.GroupMotor.new({
			X = Window.Size.X.Offset,
			Y = Window.Size.Y.Offset,
		})

		local targetPosX = Window.Position.X.Offset
		local targetPosY = Window.Position.Y.Offset

		local PosMotor = Flipper.GroupMotor.new({
			X = targetPosX,
			Y = targetPosY,
		})

		local EntranceScaleMotor = Flipper.SingleMotor.new(0.9)
		EntranceScaleMotor:onStep(function(scaleVal)
			if Window.Scale then
				Window.Scale.Scale = scaleVal
			end
		end)

		local Loader = New("Frame", {
			Name = "FluentLoader",
			Size = UDim2.fromOffset(260, 68),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.44),
			BackgroundColor3 = Color3.fromRGB(18, 18, 22),
			BackgroundTransparency = 0,
			Parent = Config.Parent,
			ZIndex = 50,
			ThemeTag = {
				BackgroundColor3 = "AcrylicMain",
			},
		}, {
			New("ImageLabel", {
				Name = "LoaderShadow",
				Image = "rbxassetid://8992230677",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, 64, 1, 64),
				Position = UDim2.fromScale(0.5, 0.5),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.45,
				ZIndex = 49,
			}),
			New("UICorner", {
				CornerRadius = UDim.new(0, 14),
			}),
			New("UIStroke", {
				Thickness = 1.2,
				Transparency = 0.2,
				ThemeTag = {
					Color = "Accent",
				},
			}, {
				New("UIGradient", {
					Rotation = 45,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(76, 194, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 90, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(76, 194, 255)),
					}),
					ThemeTag = {
						Color = "AccentGradient",
					},
				}),
			}),
		})

		local LoaderScale = New("UIScale", {
			Scale = 0.85,
			Parent = Loader,
		})

		TweenService:Create(LoaderScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Scale = 1,
		}):Play()

		local LoaderIcon = New("ImageLabel", {
			Size = UDim2.fromOffset(22, 22),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 18, 0.5, -6),
			BackgroundTransparency = 1,
			ZIndex = 51,
			Parent = Loader,
			ThemeTag = {
				ImageColor3 = "Accent",
			},
		})
		Library:ApplyIcon(LoaderIcon, Config.Icon or "sparkles")

		local spinTween = TweenService:Create(LoaderIcon, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
			Rotation = 360,
		})
		spinTween:Play()

		local LoaderTitle = New("TextLabel", {
			Size = UDim2.new(1, -56, 0, 16),
			Position = UDim2.new(0, 48, 0, 14),
			BackgroundTransparency = 1,
			Text = Config.Title or "FluentXY",
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 13,
			TextColor3 = Color3.fromRGB(240, 240, 245),
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 51,
			Parent = Loader,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local LoaderStatus = New("TextLabel", {
			Size = UDim2.new(1, -56, 0, 14),
			Position = UDim2.new(0, 48, 0, 31),
			BackgroundTransparency = 1,
			Text = "Initializing modules...",
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextSize = 11,
			TextColor3 = Color3.fromRGB(150, 150, 160),
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 51,
			Parent = Loader,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local ProgressTrack = New("Frame", {
			Size = UDim2.new(1, -36, 0, 3),
			Position = UDim2.new(0, 18, 1, -12),
			BackgroundColor3 = Color3.fromRGB(35, 35, 42),
			BackgroundTransparency = 0.3,
			ZIndex = 51,
			Parent = Loader,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 2),
			}),
		})

		local ProgressFill = New("Frame", {
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			ZIndex = 52,
			Parent = ProgressTrack,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 2),
			}),
		})

		TweenService:Create(ProgressFill, TweenInfo.new(1.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 1, 0),
		}):Play()

		local startTime = os.clock()
		local EntrancePlayed = false

		task.delay(0.35, function()
			if LoaderStatus and LoaderStatus.Parent and not EntrancePlayed then
				LoaderStatus.Text = "Configuring interface..."
			end
		end)

		task.delay(0.75, function()
			if LoaderStatus and LoaderStatus.Parent and not EntrancePlayed then
				LoaderStatus.Text = "Loading components..."
			end
		end)

		task.delay(1.1, function()
			if LoaderStatus and LoaderStatus.Parent and not EntrancePlayed then
				LoaderStatus.Text = "Ready!"
				LoaderStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end)

		function Window:PlayEntrance()
			if EntrancePlayed then return end
			EntrancePlayed = true

			local elapsed = os.clock() - startTime
			if elapsed < 1.2 then
				task.wait(1.2 - elapsed)
			end

			local finalX = Window.Position.X.Offset
			local finalY = Window.Position.Y.Offset

			if Loader and Loader.Parent then
				pcall(function()
					spinTween:Cancel()
					local shadow = Loader:FindFirstChild("LoaderShadow")
					if shadow then
						TweenService:Create(shadow, TweenInfo.new(0.18), { ImageTransparency = 1 }):Play()
					end
					TweenService:Create(LoaderTitle, TweenInfo.new(0.15), { TextTransparency = 1 }):Play()
					TweenService:Create(LoaderStatus, TweenInfo.new(0.15), { TextTransparency = 1 }):Play()
					TweenService:Create(LoaderIcon, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
					TweenService:Create(ProgressTrack, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
					TweenService:Create(ProgressFill, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
				end)

				local morphTween = TweenService:Create(Loader, TweenInfo.new(0.38, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Size = Window.Size,
					Position = Window.Position,
					AnchorPoint = Vector2.new(0, 0),
					BackgroundTransparency = 0.88,
				})
				morphTween:Play()
				task.wait(0.2)
			end

			Window.Root.Visible = true
			if Library.UseAcrylic and Library.Acrylic then
				Acrylic.Enable()
				if Window.AcrylicPaint and Window.AcrylicPaint.Model then
					local targetTrans = (Library.Theme == "Glass") and 0.85 or 0.98
					Window.AcrylicPaint.Model.Transparency = targetTrans
				end
			end
			if Window.Scale then
				Window.Scale.Scale = 0.95
			end
			PosMotor:setGoal({
				X = Instant(finalX),
				Y = Instant(finalY),
			})

			EntranceScaleMotor:setGoal(Spring(1, { frequency = 8, dampingRatio = 0.8 }))

			if Loader and Loader.Parent then
				task.delay(0.25, function()
					if Loader and Loader.Parent then
						local fade = TweenService:Create(Loader, TweenInfo.new(0.2), { BackgroundTransparency = 1 })
						fade:Play()
						fade.Completed:Connect(function()
							Loader:Destroy()
						end)
					end
				end)
			end
		end

		task.delay(1.3, function()
			if not EntrancePlayed then
				Window:PlayEntrance()
			end
		end)

		_G.CDDrag = 0
		Window.SelectorPosMotor = Flipper.SingleMotor.new(17)
		Window.SelectorSizeMotor = Flipper.SingleMotor.new(0)
		Window.ContainerBackMotor = Flipper.SingleMotor.new(0)
		Window.ContainerPosMotor = Flipper.SingleMotor.new(94)
		Window.ContainerXMotor = Flipper.SingleMotor.new(0)

		SizeMotor:onStep(function(values)
			Window.Root.Size = UDim2.new(0, values.X, 0, values.Y)
			task.spawn(function()
				task.wait(0.01)
				if Window.UpdateTabHolderLayout then
					Window:UpdateTabHolderLayout()
				end
			end)
		end)

		PosMotor:onStep(function(values)
			Window.Root.Position = UDim2.new(0, values.X, 0, values.Y)
		end)

		local LastValue = 0
		local LastTime = 0
		Window.SelectorPosMotor:onStep(function(Value)
			local base = Window.TabHolderTop or (Window.ShowSearch and 34 or 0)
			local verticalInset = 16
			local selectorY = base + Value + verticalInset

			if Window.ShowSearch and selectorY < 32 then
				Selector.Visible = false
				return
			end

			if Window.UserInfoHeight then
				local tabFrameSize = Window.TabFrame and Window.TabFrame.Size.Y.Offset or 0
				local userInfoTop = Window.UserInfoTop and 0 or (tabFrameSize - Window.UserInfoHeight - 2)
				local userInfoBottom = userInfoTop + Window.UserInfoHeight
				
				if selectorY >= userInfoTop and selectorY <= userInfoBottom then
					Selector.Visible = false
					return
				end
			end

			Selector.Visible = true
			Selector.Position = UDim2.new(0, 0, 0, selectorY)
			local Now = tick()
			local DeltaTime = Now - LastTime

			if LastValue ~= nil then
				Window.SelectorSizeMotor:setGoal(Spring((math.abs(Value - LastValue) / (DeltaTime * 60)) + 16))
				LastValue = Value
			end
			LastTime = Now
		end)

		Window.SelectorSizeMotor:onStep(function(Value)
			Selector.Size = UDim2.new(0, 4, 0, Value)
		end)

		Window.ContainerBackMotor:onStep(function(Value)
			Window.ContainerAnim.GroupTransparency = Value
		end)

		local ContainerXValue = 0
		local ContainerYValue = 94

		local function UpdateContainerPosition()
			if Window.ContainerAnim then
				Window.ContainerAnim.Position = UDim2.fromOffset(ContainerXValue, ContainerYValue)
			end
		end

		Window.ContainerPosMotor:onStep(function(Value)
			ContainerYValue = Value
			UpdateContainerPosition()
		end)

		Window.ContainerXMotor:onStep(function(Value)
			ContainerXValue = Value
			UpdateContainerPosition()
		end)

		local OldSizeX
		local OldSizeY
		Window.Maximize = function(Value, NoPos, Instant)
			Window.Maximized = Value
			Window.TitleBar.MaxButton.Frame.Icon.Image = Value and Components.Assets.Restore or Components.Assets.Max

			if Value then
				OldSizeX = Window.Size.X.Offset
				OldSizeY = Window.Size.Y.Offset
			end
			local SizeX = Value and Camera.ViewportSize.X or OldSizeX
			local SizeY = Value and Camera.ViewportSize.Y or OldSizeY
			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(SizeX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(SizeY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(SizeX, SizeY)

			if not NoPos then
				PosMotor:setGoal({
					X = Spring(Value and 0 or Window.Position.X.Offset, { frequency = 6 }),
					Y = Spring(Value and 0 or Window.Position.Y.Offset, { frequency = 6 }),
				})
			end
		end

		Creator.AddSignal(Window.TitleBar.Frame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				MousePos = Input.Position
				StartPos = Window.Root.Position

				if Window.Maximized then
					StartPos = UDim2.fromOffset(
						Mouse.X - (Mouse.X * ((OldSizeX - 100) / Window.Root.AbsoluteSize.X)),
						Mouse.Y - (Mouse.Y * (OldSizeY / Window.Root.AbsoluteSize.Y))
					)
				end

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
						PosMotor:setGoal({
							X = Instant(Window.Position.X.Offset),
							Y = Instant(Window.Position.Y.Offset),
						})
					end
				end)
			end
		end)

		Creator.AddSignal(Window.TitleBar.Frame.InputChanged, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseMovement
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = Input
			end
		end)

		local ResizeDirection
		local ResizeStartSize
		local ResizeStartPos

		local function BindResizeHandle(Handle, Direction)
			Creator.AddSignal(Handle.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					Resizing = true
					ResizeDirection = Direction
					ResizePos = Input.Position
					ResizeStartSize = Window.Size
					ResizeStartPos = Window.Position
				end
			end)
		end

		BindResizeHandle(ResizeRight, "Right")
		BindResizeHandle(ResizeBottom, "Bottom")
		BindResizeHandle(ResizeBottomRight, "BottomRight")
		BindResizeHandle(ResizeLeft, "Left")
		BindResizeHandle(ResizeBottomLeft, "BottomLeft")

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				Window.Position = UDim2.fromOffset(StartPos.X.Offset + Delta.X, StartPos.Y.Offset + Delta.Y)
				Window.Root.Position = Window.Position

				if Window.Maximized then
					Window.Maximize(false, true, true)
				end
			end

			if
				(Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
				and Resizing
			then
				local Delta = Input.Position - ResizePos
				local StartSize = ResizeStartSize or Window.Size
				local StartWinPos = ResizeStartPos or Window.Position

				local minWidth = Mobile and 320 or 400
				local minHeight = Mobile and 240 or 320
				local vp = Camera.ViewportSize
				local maxWidth = math.max(minWidth, vp.X)
				local maxHeight = math.max(minHeight, vp.Y)

				local targetWidth = StartSize.X.Offset
				local targetHeight = StartSize.Y.Offset
				local targetPosX = StartWinPos.X.Offset
				local targetPosY = StartWinPos.Y.Offset

				if ResizeDirection == "Right" or ResizeDirection == "BottomRight" then
					targetWidth = math.clamp(StartSize.X.Offset + Delta.X, minWidth, maxWidth)
				elseif ResizeDirection == "Left" or ResizeDirection == "BottomLeft" then
					targetWidth = math.clamp(StartSize.X.Offset - Delta.X, minWidth, maxWidth)
					local deltaW = targetWidth - StartSize.X.Offset
					targetPosX = StartWinPos.X.Offset - deltaW
				end

				if ResizeDirection == "Bottom" or ResizeDirection == "BottomRight" or ResizeDirection == "BottomLeft" then
					targetHeight = math.clamp(StartSize.Y.Offset + Delta.Y, minHeight, maxHeight)
				end

				SizeMotor:setGoal({
					X = Flipper.Instant.new(targetWidth),
					Y = Flipper.Instant.new(targetHeight),
				})

				if targetPosX ~= Window.Position.X.Offset then
					Window.Position = UDim2.fromOffset(targetPosX, targetPosY)
					PosMotor:setGoal({
						X = Instant(targetPosX),
						Y = Instant(targetPosY),
					})
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if Resizing and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
				Resizing = false
				ResizeDirection = nil
				Window.Size = UDim2.fromOffset(SizeMotor:getValue().X, SizeMotor:getValue().Y)
				Window.Position = UDim2.fromOffset(PosMotor:getValue().X, PosMotor:getValue().Y)
			end
		end)

		Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			if Window.TabHolder and Window.TabHolder.UIListLayout then
				local padding = Window.TabHolder:FindFirstChild("UIPadding")
				local paddingTop = padding and padding.PaddingTop.Offset or 6
				local paddingBottom = padding and padding.PaddingBottom.Offset or 6
				local contentSize = Window.TabHolder.UIListLayout.AbsoluteContentSize.Y + paddingTop + paddingBottom
				if contentSize > 0 then
					Window.TabHolder.CanvasSize = UDim2.new(0, 0, 0, contentSize)
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if UserInputService:GetFocusedTextBox() then return end
			local matched = false
			if type(Library.MinimizeKeybind) == "table" and Library.MinimizeKeybind.Type == "Keybind" and Library.MinimizeKeybind.Value then
				if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
					matched = true
				end
			end
			if not matched and Library.MinimizeKey and Input.KeyCode == Library.MinimizeKey then
				matched = true
			end
			if matched then
				Window:Minimize()
			end
		end)

		function Window:ToggleSearch(forcedState)
			if forcedState ~= nil then
				Window.ShowSearch = forcedState
			else
				Window.ShowSearch = not Window.ShowSearch
			end
			SearchFrame.Visible = Window.ShowSearch
			local tabTop = Window.ShowSearch and 34 or 0
			local bottomPad = Config.UserInfo and 48 or 4
			Window.TabHolder.Position = UDim2.new(0, 0, 0, tabTop)
			Window.TabHolder.Size = UDim2.new(1, 0, 1, -(tabTop + bottomPad))
			Window.TabHolderTop = tabTop
		end

		function Window:Minimize()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized

			if Window.Minimized then
				if Window.AcrylicPaint and Window.AcrylicPaint.Model then
					Window.AcrylicPaint.Model.Transparency = 1
					Window.AcrylicPaint.Model.CFrame = CFrame.new(0, -999999, 0)
				end
				Acrylic.Disable()
			else
				if Library.UseAcrylic and Library.Acrylic then
					Acrylic.Enable()
					if Window.AcrylicPaint and Window.AcrylicPaint.Model then
						local targetTrans = (Library.Theme == "Glass") and 0.85 or 0.98
						Window.AcrylicPaint.Model.Transparency = targetTrans
					end
				end
			end

			for _, Option in next, Library.Options do
				if Option and Option.Type == "Dropdown" and Option.Opened then
					pcall(function()
						Option:Close()
					end)
				end
			end
			if not MinimizeNotif then
				MinimizeNotif = true
				local Key = Library.MinimizeKeybind and Library.MinimizeKeybind.Value or Library.MinimizeKey.Name
				if not Mobile then Library:Notify({
					Title = "Interface",
					Content = "Press " .. Key .. " to toggle the interface.",
					Duration = 6
					})
				else 
					Library:Notify({
						Title = "Interface",
						Content = "Tap to the button to toggle the interface.",
						Duration = 6
					})
				end
			end

			if Library.Minimizer then
				pcall(function()
					local mObj = Library.Minimizer
					local frame = (typeof(mObj) == "table" and mObj.Frame) or (typeof(mObj) == "Instance" and mObj)
					if frame and frame.Parent then
						local btn = frame:FindFirstChildWhichIsA("TextButton") or frame:FindFirstChild("MinimizeButton")
						if btn then
							local label = btn:FindFirstChild("StatusLabel") or btn:FindFirstChildWhichIsA("TextLabel")
							if label then
								label.Text = Window.Minimized and "Open" or "Close"
							end
							local img = btn:FindFirstChildWhichIsA("ImageLabel") or btn:FindFirstChild("Icon")
							if img then
								img.Visible = false
							end
						end
					end
				end)
			end
		end

		function Window:Destroy()
			pcall(function()
				Acrylic.Destroy()
			end)
			if Library.UseAcrylic and Window.AcrylicPaint and Window.AcrylicPaint.Model then
				pcall(function() Window.AcrylicPaint.Model:Destroy() end)
			end
			if Window.Root then
				Window.Root:Destroy()
			end
		end

		function Window:SetBackgroundImage(imageUrl, imageTransparency)
			if not Window.BackgroundImage then
				local imgTransparency = imageTransparency or Window.BackgroundImageTransparency or Window.BackgroundTransparency or 0.5
				local BackgroundImageFrame = New("ImageLabel", {
					Name = "BackgroundImage",
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(0, 0),
					BackgroundTransparency = 1,
					Image = imageUrl,
					ImageTransparency = math.max(0, math.min(1, imgTransparency)),
					ZIndex = 0,
					ScaleType = Enum.ScaleType.Stretch,
					Parent = Window.Root,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 8),
					}),
				})
				Window.BackgroundImage = BackgroundImageFrame
				if imageTransparency ~= nil then
					Window.BackgroundImageTransparency = imageTransparency
				end
			else
				Window.BackgroundImage.Image = imageUrl
				Window.BackgroundImage.ScaleType = Enum.ScaleType.Stretch
				if imageTransparency ~= nil then
					Window.BackgroundImageTransparency = imageTransparency
					Window.BackgroundImage.ImageTransparency = math.max(0, math.min(1, imageTransparency))
				end
			end
		end

		function Window:SetBackgroundTransparency(transparency)
			transparency = transparency or 0.5
			Window.BackgroundTransparency = transparency
		end

		function Window:SetBackgroundImageTransparency(transparency)
			transparency = transparency or 0.5
			Window.BackgroundImageTransparency = transparency
			if Window.BackgroundImage then
				Window.BackgroundImage.ImageTransparency = math.max(0, math.min(1, transparency))
			end
			if Window.AcrylicPaint and Window.AcrylicPaint.Frame then
				if transparency <= 0.1 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 1
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 1
					end
					local function makeTransparent(obj)
						if obj:IsA("Frame") then
							obj.BackgroundTransparency = 1
						elseif obj:IsA("ImageLabel") then
							obj.ImageTransparency = 1
						end
						for _, child in ipairs(obj:GetChildren()) do
							if not child:IsA("UICorner") and not child:IsA("UIGradient") and not child:IsA("UIStroke") and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
								makeTransparent(child)
							end
						end
					end
					makeTransparent(Window.AcrylicPaint.Frame)
				elseif transparency < 0.3 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.99
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.99
					end
				else
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.98
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.98
					end
				end
			end
		end

		local DialogModule = Components.Dialog:Init(Window)
		function Window:Dialog(Config)
			local Dialog = DialogModule:Create()
			Dialog.Title.Text = Config.Title

			local ContentHolder = New("ScrollingFrame", {
				BackgroundTransparency = 1,
				ScrollBarImageTransparency = 0.7,
				ScrollBarThickness = 4,
				BottomImage = "rbxassetid://6889812791",
				MidImage = "rbxassetid://6889812721",
				TopImage = "rbxassetid://6276641225",
				Position = UDim2.fromOffset(20, 60),
				Size = UDim2.new(1, -40, 1, -110),
				CanvasSize = UDim2.fromOffset(0, 0),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				Parent = Dialog.Root,
			})

			local Content = New("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = Config.Content,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextWrapped = true,
				Size = UDim2.new(1, -8, 0, 0),
				BackgroundTransparency = 1,
				Parent = ContentHolder,
				ThemeTag = { TextColor3 = "Text" },
			})

			New("UISizeConstraint", {
				MinSize = Vector2.new(300, 165),
				MaxSize = Vector2.new(620, math.huge),
				Parent = Dialog.Root,
			})

			local maxWidth = math.min(620, Window.Size.X.Offset - 120)
			local baseWidth = math.max(300, math.min(maxWidth, Content.TextBounds.X + 40))
			Dialog.Root.Size = UDim2.fromOffset(baseWidth, 165)
			ContentHolder.Size = UDim2.new(1, -40, 1, -110)
			task.defer(function()
				local contentHeight = Content.TextBounds.Y
				local desired = math.clamp(contentHeight + 110, 165, 420)
				Dialog.Root.Size = UDim2.fromOffset(baseWidth, desired)
				ContentHolder.CanvasSize = UDim2.fromOffset(0, contentHeight)
			end)

			for _, Button in next, Config.Buttons do
				Dialog:Button(Button.Title, Button.Callback)
			end

			Dialog:Open()
		end

		local TabModule = Components.Tab:Init(Window)
		Window.TabModule = TabModule
		function Window:AddTab(TabConfig)
			local tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Window.TabHolder)
			return tab
		end

		function Window:SelectTab(Tab)
			TabModule:SelectTab(Tab)
			if Window.PlayEntrance then
				task.spawn(function()
					Window:PlayEntrance()
				end)
			end
		end

		Creator.AddSignal(Window.TabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
			LastValue = TabModule:GetCurrentTabPos() + 16
			LastTime = 0
			Window.SelectorPosMotor:setGoal(Instant(TabModule:GetCurrentTabPos()))
		end)


		return Window
	end
end)()
local ElementsTable = {}
local AddSignal = Creator.AddSignal

ElementsTable.Button = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Button"

	function Element:New(Config)
		assert(Config.Title, "Button - Missing Title")
		Config.Callback = Config.Callback or function() end

		local ButtonFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)

		local ButtonIco = New("ImageLabel", {
			Image = "rbxassetid://10709791437",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundTransparency = 1,
			Parent = ButtonFrame.Frame,
			ThemeTag = {
				ImageColor3 = "Text",
			},
		})

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Down, function()
			TweenService:Create(ButtonIco, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(1, -6, 0.5, 0)
			}):Play()
		end)

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Up, function()
			TweenService:Create(ButtonIco, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = UDim2.new(1, -10, 0.5, 0)
			}):Play()
		end)

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Click, function()
			Library:SafeCallback(Config.Callback)
		end)

		return ButtonFrame
	end

	return Element
end)()
ElementsTable.Toggle = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Toggle"

	function Element:New(Idx, Config)
		assert(Config.Title, "Toggle - Missing Title")

		local Toggle = {
			Value = Config.Default or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Toggle",
		}

		local ToggleFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)
		ToggleFrame:SetRightOffset(65)

		Toggle.SetTitle = ToggleFrame.SetTitle
		Toggle.SetDesc = ToggleFrame.SetDesc
		Toggle.Visible = ToggleFrame.Visible
		Toggle.Elements = ToggleFrame

		local ToggleCircle = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(0, 2, 0.5, 0),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ImageTransparency = 0.5,
			ThemeTag = {
				ImageColor3 = "ToggleSlider",
			},
		})

		local ToggleBorder = New("UIStroke", {
			Transparency = 0.5,
			ThemeTag = {
				Color = "ToggleSlider",
			},
		})

		local ToggleSlider = New("Frame", {
			Size = UDim2.fromOffset(36, 18),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Parent = ToggleFrame.Frame,
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
			ToggleBorder,
			ToggleCircle,
		})

		function Toggle:OnChanged(Func)
			Toggle.Changed = Func
			Func(Toggle.Value)
		end

		function Toggle:SetValue(Value)
			Value = not not Value
			Toggle.Value = Value

			Creator.OverrideTag(ToggleBorder, { Color = Toggle.Value and "Accent" or "ToggleSlider" })
			Creator.OverrideTag(ToggleCircle, { ImageColor3 = Toggle.Value and "ToggleToggled" or "ToggleSlider" })
			TweenService:Create(
				ToggleCircle,
				TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
				{ Position = UDim2.new(0, Toggle.Value and 19 or 2, 0.5, 0) }
			):Play()
			TweenService:Create(
				ToggleSlider,
				TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ BackgroundTransparency = Toggle.Value and 0.45 or 1 }
			):Play()
			ToggleCircle.ImageTransparency = Toggle.Value and 0 or 0.5

			Library:SafeCallback(Toggle.Callback, Toggle.Value)
			Library:SafeCallback(Toggle.Changed, Toggle.Value)
		end

		function Toggle:Destroy()
			ToggleFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
			Toggle:SetValue(not Toggle.Value)
		end)

		Toggle:SetValue(Toggle.Value)

		Library.Options[Idx] = Toggle
		return Toggle
	end

	return Element
end)()
ElementsTable.Dropdown = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Dropdown"
	local New = Creator.New

	function Element:New(Idx, Config)

		local windowDropdownsOutside = false
		if Library.Window and Library.Window.DropdownsOutsideWindow ~= nil then
			windowDropdownsOutside = Library.Window.DropdownsOutsideWindow
		elseif Library.Windows and #Library.Windows > 0 then
			for i = #Library.Windows, 1, -1 do
				local window = Library.Windows[i]
				if window and window.DropdownsOutsideWindow ~= nil then
					windowDropdownsOutside = window.DropdownsOutsideWindow
					break
				end
			end
		end
		
		local Dropdown = {
			Values = Config.Values,
			Value = Config.Default,
			Multi = Config.Multi,
			Buttons = {},
			Opened = false,
			Type = "Dropdown",
			Callback = Config.Callback or function() end,
			Search = (Config.Search == nil) and (#(Config.Values or {}) >= 5) or (Config.Search == true),
			KeepSearch = Config.KeepSearch == true,
			OpenToRight = windowDropdownsOutside
		}

		if Dropdown.Multi then
			if type(Config.Default) == "table" and not Config.AllowNull then
				local initial = {}
				for k, v in pairs(Config.Default) do
					if type(k) == "string" and v == true then
						initial[k] = true
					elseif type(v) == "string" then
						initial[v] = true
					end
				end
				Dropdown.Value = initial
			else
				Dropdown.Value = {}
			end
		end

		local DropdownFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		DropdownFrame:SetRightOffset(185)

		Dropdown.SetTitle = DropdownFrame.SetTitle
		Dropdown.SetDesc = DropdownFrame.SetDesc
		Dropdown.Visible = DropdownFrame.Visible
		Dropdown.Elements = DropdownFrame
		
		local container = self.Container

		local DropdownDisplay = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			AutomaticSize = Enum.AutomaticSize.Y,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0.5, 0),
			Position = UDim2.new(0, 8, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local initialRotation = 180
		local openRotation = windowDropdownsOutside and -90 or 0
		local closeRotation = 180

		local DropdownIco = New("ImageLabel", {
			Image = "rbxassetid://10709790948",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -8, 0.5, 0),
			BackgroundTransparency = 1,
			Rotation = initialRotation,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local DropdownInner = New("TextButton", {
			Size = UDim2.fromOffset(160, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = DropdownFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "DropdownFrame",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			DropdownIco,
			DropdownDisplay,
		})

		local DropdownListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 3),
		})

		local DropdownScrollFrame = New("ScrollingFrame", {
			Size = UDim2.new(1, -5, 1, -10),
			Position = UDim2.fromOffset(5, 5),
			BackgroundTransparency = 1,
			BottomImage = "rbxassetid://6889812791",
			MidImage = "rbxassetid://6889812721",
			TopImage = "rbxassetid://6276641225",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.75,
			ScrollBarThickness = 5,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			DropdownListLayout,
		})

		local RecalculateCanvasSize, RecalculateListSize, RecalculateListPosition

		local SearchBar
		local SearchBox
		if Dropdown.Search then
			SearchBar = New("Frame", {
				Size = UDim2.new(1, -10, 0, 28),
				Position = UDim2.fromOffset(5, 5),
				BackgroundTransparency = 0.7,
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				ThemeTag = { BackgroundColor3 = "Element" },
				ZIndex = 24,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			})

			SearchBox = New("TextBox", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -36, 1, 0),
				Position = UDim2.new(0, 8, 0, 0),
				PlaceholderText = "Search...",
				PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
				ClearTextOnFocus = false,
				Text = "",
				Parent = SearchBar,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
				ZIndex = 24,
			})

			local SearchIcon = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(1, -13, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://10734943674",
				Parent = SearchBar,
				ImageTransparency = 0.3,
				ZIndex = 25,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			DropdownScrollFrame.Position = UDim2.fromOffset(5, 38)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -43)

			local filterToken = 0
			local function ApplyFilter()
				filterToken = filterToken + 1
				local myToken = filterToken
				task.spawn(function()
					task.wait(0.04)
					if myToken ~= filterToken then return end
					local text = (SearchBox.Text or ""):lower()
					for _, element in next, DropdownScrollFrame:GetChildren() do
						if not element:IsA("UIListLayout") then
							local value = element:FindFirstChild("ButtonLabel") and element.ButtonLabel.Text or ""
							element.Visible = text == "" or value:lower():find(text, 1, true) ~= nil
						end
					end
					task.wait()
					if RecalculateCanvasSize then RecalculateCanvasSize() end
					task.wait()
					if RecalculateListSize then RecalculateListSize() end
					task.wait()
					if RecalculateListPosition then RecalculateListPosition() end
				end)
			end

			Creator.AddSignal(SearchBox:GetPropertyChangedSignal("Text"), ApplyFilter)
		end

		local DropdownHolderFrame = New("Frame", {
			Size = UDim2.fromScale(1, 0.6),
			ThemeTag = {
				BackgroundColor3 = "DropdownHolder",
			},
		}, {
			SearchBar,
			DropdownScrollFrame,
			New("UICorner", {
				CornerRadius = UDim.new(0, 7),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "DropdownBorder",
				},
			}),
			New("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=5554236805",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(23, 23, 277, 277),
				Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
				Position = UDim2.fromOffset(-15, -15),
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.1,
			}),
		})

		local DropdownHolderCanvas = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(170, 300),
			Parent = Library.GUI,
			Visible = false,
		}, {
			DropdownHolderFrame,
			New("UISizeConstraint", {
				MinSize = Vector2.new(170, 0),
			}),
		})
		table.insert(Library.OpenFrames, DropdownHolderCanvas)

		local windowRoot = nil
		if Library.Window and Library.Window.Root then
			windowRoot = Library.Window.Root
		elseif Library.Windows and #Library.Windows > 0 then
			for i = #Library.Windows, 1, -1 do
				local window = Library.Windows[i]
				if window and window.Root then
					windowRoot = window.Root
					break
				end
			end
		end
		
		if not windowRoot and container then
			local parent = container.Parent
			while parent do
				if parent:IsA("Frame") then
					if parent:FindFirstChild("ContainerCanvas") or (parent.Name and parent:FindFirstChild("TitleBar")) then
						windowRoot = parent
						break
					end
				end
				if parent:IsA("ScreenGui") then
					break
				end
				parent = parent.Parent
			end
		end

		RecalculateListPosition = function()
			if not DropdownHolderCanvas or not DropdownInner then return end
			
			local dropdownX = DropdownInner.AbsolutePosition.X
			local dropdownY = DropdownInner.AbsolutePosition.Y
			local dropdownWidth = DropdownInner.AbsoluteSize.X
			local dropdownHeight = DropdownInner.AbsoluteSize.Y
			local canvasWidth = DropdownHolderCanvas.AbsoluteSize.X
			local canvasHeight = DropdownHolderCanvas.AbsoluteSize.Y
			local viewportHeight = Camera.ViewportSize.Y
			local viewportWidth = Camera.ViewportSize.X
			
			if not windowRoot then
				if Library.Window and Library.Window.Root then
					windowRoot = Library.Window.Root
				elseif Library.Windows and #Library.Windows > 0 then
					for i = #Library.Windows, 1, -1 do
						local window = Library.Windows[i]
						if window and window.Root then
							windowRoot = window.Root
							break
						end
					end
				end
				
				if not windowRoot and container then
					local parent = container.Parent
					while parent do
						if parent:IsA("Frame") then
							if parent:FindFirstChild("ContainerCanvas") or (parent.Name and parent:FindFirstChild("TitleBar")) then
								windowRoot = parent
								break
							end
						end
						if parent:IsA("ScreenGui") then
							break
						end
						parent = parent.Parent
					end
				end
			end
			
			local targetX = dropdownX - 1
			local useFixedY = false
			
			if windowRoot then
				local windowX = windowRoot.AbsolutePosition.X
				local windowWidth = windowRoot.AbsoluteSize.X
				local windowRight = windowX + windowWidth
				
				if Dropdown.OpenToRight then
					targetX = windowRight + 5
					if Dropdown.SavedY == nil then
						Dropdown.SavedY = dropdownY
					end
					useFixedY = true
				else
					local canvasRight = dropdownX + canvasWidth - 1
					if canvasRight > windowRight then
						targetX = math.max(windowX + 5, windowRight - canvasWidth - 5)
					end
					Dropdown.SavedY = nil
				end
			else
				local canvasRight = dropdownX + canvasWidth - 1
				if canvasRight > viewportWidth then
					if Dropdown.OpenToRight then
						targetX = viewportWidth + 5
						if Dropdown.SavedY == nil then
							Dropdown.SavedY = dropdownY
						end
						useFixedY = true
					else
						targetX = math.max(5, viewportWidth - canvasWidth - 5)
					end
					Dropdown.SavedY = nil
				end
			end
			
			local targetY
			if useFixedY and windowRoot then
				local windowY = windowRoot.AbsolutePosition.Y
				local windowHeight = windowRoot.AbsoluteSize.Y
				local windowCenterY = windowY + windowHeight / 2
				targetY = windowCenterY - canvasHeight / 2
				
				local windowTop = windowY
				local windowBottom = windowY + windowHeight
				local viewportTop = 0
				local viewportBottom = viewportHeight
				
				if targetY + canvasHeight > viewportBottom then
					targetY = viewportBottom - canvasHeight - 5
				end
				if targetY < viewportTop then
					targetY = viewportTop + 5
				end
				
				if targetY + canvasHeight > windowBottom then
					targetY = windowBottom - canvasHeight - 5
				end
				if targetY < windowTop then
					targetY = windowTop + 5
				end
			elseif useFixedY and Dropdown.SavedY then
				targetY = Dropdown.SavedY
				
				local spaceBelow = viewportHeight - (Dropdown.SavedY + dropdownHeight)
				local spaceAbove = Dropdown.SavedY
				
				if canvasHeight > spaceBelow and canvasHeight <= spaceAbove then
					targetY = Dropdown.SavedY - canvasHeight - 5
				elseif canvasHeight > spaceBelow and canvasHeight > spaceAbove then
					if spaceBelow > spaceAbove then
						targetY = Dropdown.SavedY + dropdownHeight + 5
					else
						targetY = math.max(5, Dropdown.SavedY - canvasHeight - 5)
					end
				else
					targetY = Dropdown.SavedY + dropdownHeight + 5
				end
			else
				local spaceBelow = viewportHeight - (dropdownY + dropdownHeight)
				local spaceAbove = dropdownY
				
				if canvasHeight <= spaceBelow then
					targetY = dropdownY + dropdownHeight + 5
				elseif canvasHeight <= spaceAbove then
					targetY = dropdownY - canvasHeight - 5
				else
					if spaceBelow > spaceAbove then
						targetY = dropdownY + dropdownHeight + 5
					else
						targetY = math.max(5, dropdownY - canvasHeight - 5)
					end
				end
			end
			
			DropdownHolderCanvas.Position = UDim2.fromOffset(targetX, targetY)
		end

		local ListSizeX = 0
		RecalculateListSize = function()
			if not DropdownHolderCanvas or not DropdownHolderFrame then return end
			
			local visibleCount = 0
			for _, element in next, DropdownScrollFrame:GetChildren() do
				if not element:IsA("UIListLayout") and element.Visible then
					visibleCount = visibleCount + 1
				end
			end
			
			local itemHeight = 32
			local padding = 3
			local searchHeight = Dropdown.Search and 38 or 0
			local innerMargins = 10
			local estimatedContent = (visibleCount > 0) and (visibleCount * itemHeight + (visibleCount - 1) * padding + innerMargins + searchHeight) or (innerMargins + searchHeight)
			local maxHeight = 392
			local targetHeight = math.min(estimatedContent, maxHeight)
			
			local canvasWidth = math.max(170, ListSizeX > 0 and (ListSizeX + 20) or 170)
			DropdownHolderCanvas.Size = UDim2.fromOffset(canvasWidth, targetHeight)
			
			local many = visibleCount > 10
			DropdownHolderFrame.Size = UDim2.fromScale(1, many and (targetHeight / math.max(targetHeight, 1)) or 1)
		end

		RecalculateCanvasSize = function()
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
		end

		RecalculateListPosition()
		RecalculateListSize()
		RecalculateCanvasSize()

		if Dropdown.OpenToRight then
			if windowRoot then
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsolutePosition"), function()
					if Dropdown.Opened then
						Dropdown.SavedY = nil
						RecalculateListPosition()
					end
				end)
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
			end
		else
			Creator.AddSignal(DropdownInner:GetPropertyChangedSignal("AbsolutePosition"), RecalculateListPosition)
			if windowRoot then
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsolutePosition"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
			end
		end
		Creator.AddSignal(DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			RecalculateCanvasSize()
			task.wait()
			RecalculateListSize()
			task.wait()
			RecalculateListPosition()
		end)

		Creator.AddSignal(DropdownInner.MouseButton1Click, function()
			if Dropdown.Opened then
				Dropdown:Close()
			else
				Dropdown:Open()
			end
		end)

		Creator.AddSignal(DropdownInner.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				if Dropdown.Opened then
					Dropdown:Close()
				else
					Dropdown:Open()
				end
			end
		end)

		Creator.AddSignal(DropdownDisplay:GetPropertyChangedSignal("Text"), function()
			for _, Element in next, DropdownScrollFrame:GetChildren() do
				if not Element:IsA("UIListLayout") then
					Element.Visible = true
				end
			end
			RecalculateListPosition()
			RecalculateListSize()
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				local mousePos = Input.UserInputType == Enum.UserInputType.MouseButton1 and Vector2.new(Mouse.X, Mouse.Y) or Input.Position
				local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
				local innerAbsPos, innerAbsSize = DropdownInner.AbsolutePosition, DropdownInner.AbsoluteSize
				
				local clickedInsideDropdown = mousePos.X >= AbsPos.X and mousePos.X <= AbsPos.X + AbsSize.X and mousePos.Y >= AbsPos.Y and mousePos.Y <= AbsPos.Y + AbsSize.Y
				local clickedInsideInner = mousePos.X >= innerAbsPos.X and mousePos.X <= innerAbsPos.X + innerAbsSize.X and mousePos.Y >= innerAbsPos.Y and mousePos.Y <= innerAbsPos.Y + innerAbsSize.Y
				
				if not clickedInsideDropdown and not clickedInsideInner then
					Dropdown:Close()
				end
			end
		end)

		local ScrollFrame = self.ScrollFrame
		function Dropdown:Open()
			if Dropdown.Opened then
				return
			end
			Dropdown.Opened = true
			if Dropdown.OpenToRight then
				Dropdown.SavedY = nil
			end
			for _, frame in ipairs(Library.OpenFrames) do
				if frame ~= DropdownHolderCanvas and frame.Visible then
					frame.Visible = false
				end
			end
			if SearchBox and not Dropdown.KeepSearch then
				SearchBox.Text = ""
			end
			DropdownHolderCanvas.Visible = true
			RecalculateListPosition()
			RecalculateListSize()
			RecalculateCanvasSize()
			task.wait()
			TweenService:Create(
				DropdownHolderFrame,
				TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = UDim2.fromScale(1, 1) }
			):Play()
			TweenService:Create(
				DropdownIco,
				TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
				{ Rotation = openRotation }
			):Play()
		end

		function Dropdown:Close()
			Dropdown.Opened = false
			if Dropdown.OpenToRight then
				Dropdown.SavedY = nil
			end
			DropdownHolderFrame.Size = UDim2.fromScale(1, 0.6)
			DropdownHolderCanvas.Visible = false
			TweenService:Create(
				DropdownIco,
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Rotation = closeRotation }
			):Play()
			Dropdown:Display()
			for _, element in next, DropdownScrollFrame:GetChildren() do
				if not element:IsA("UIListLayout") then
					element.Visible = true
				end
			end
		end

		function Dropdown:Display()
			local Values = Dropdown.Values
			local Str = ""

			local function displayValue(val)
				return (Dropdown.Displayer and Dropdown.Displayer(val)) or (type(val) == "table" and tostring(val.Name or val.Title or tostring(val))) or tostring(val)
			end

			if Config.Multi then
				for Idx, Value in next, Values do
					if Dropdown.Value[Value] then
						Str = Str .. displayValue(Value) .. ", "
					end
				end
				Str = Str:sub(1, #Str - 2)
			else
				Str = Dropdown.Value and displayValue(Dropdown.Value) or ""
			end

			DropdownDisplay.Text = (Str == "" and "--" or Str)
		end

		function Dropdown:GetActiveValues()
			if Config.Multi then
				local T = {}

				for Value, Bool in next, Dropdown.Value do
					table.insert(T, Value)
				end

				return T
			else
				return Dropdown.Value and 1 or 0
			end
		end

		function Dropdown:SetActiveValues(Value)
			Dropdown.Value = Value

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)

			Dropdown:BuildDropdownList()
		end

		function Dropdown:BuildDropdownList()
			local Values = Dropdown.Values
			local Buttons = {}

			if Dropdown._OptionSignals then
				for _, sig in ipairs(Dropdown._OptionSignals) do
					pcall(function() sig:Disconnect() end)
				end
				table.clear(Dropdown._OptionSignals)
			else
				Dropdown._OptionSignals = {}
			end

			if Dropdown._OptionMotors then
				for _, motor in ipairs(Dropdown._OptionMotors) do
					pcall(function() motor:stop() end)
				end
				table.clear(Dropdown._OptionMotors)
			else
				Dropdown._OptionMotors = {}
			end

			for _, Element in next, DropdownScrollFrame:GetChildren() do
				if not Element:IsA("UIListLayout") then
					Element:Destroy()
				end
			end

			local Count = 0

			for Idx, Value in next, Values do
				local Table = {}

				Count = Count + 1

				local ButtonSelector = New("Frame", {
					Size = UDim2.fromOffset(4, 14),
					BackgroundColor3 = Color3.fromRGB(76, 194, 255),
					Position = UDim2.fromOffset(-1, 16),
					AnchorPoint = Vector2.new(0, 0.5),
					ThemeTag = {
						BackgroundColor3 = "Accent",
					},
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 2),
					}),
				})

				local ButtonLabel = New("TextLabel", {
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					Text = (Dropdown.Displayer and Dropdown.Displayer(Value)) or (type(Value) == "table" and tostring(Value.Name or Value.Title or tostring(Value))) or tostring(Value),
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(10, 0),
					Name = "ButtonLabel",
					ThemeTag = {
						TextColor3 = "Text",
					},
				})

				local Button = New("TextButton", {
					Size = UDim2.new(1, -5, 0, 32),
					BackgroundTransparency = 1,
					ZIndex = 23,
					Text = "",
					Parent = DropdownScrollFrame,
					ThemeTag = {
						BackgroundColor3 = "DropdownOption",
					},
				}, {
					ButtonSelector,
					ButtonLabel,
					New("UICorner", {
						CornerRadius = UDim.new(0, 6),
					}),
				})

				local Selected

				if Config.Multi then
					Selected = Dropdown.Value[Value]
				else
					Selected = Dropdown.Value == Value
				end

				local BackMotor, SetBackTransparency = Creator.SpringMotor(1, Button, "BackgroundTransparency")
				local SelMotor, SetSelTransparency = Creator.SpringMotor(1, ButtonSelector, "BackgroundTransparency")
				local SelectorSizeMotor = Flipper.SingleMotor.new(6)

				table.insert(Dropdown._OptionMotors, BackMotor)
				table.insert(Dropdown._OptionMotors, SelMotor)
				table.insert(Dropdown._OptionMotors, SelectorSizeMotor)

				SelectorSizeMotor:onStep(function(value)
					ButtonSelector.Size = UDim2.new(0, 4, 0, value)
				end)

				table.insert(Dropdown._OptionSignals, Button.MouseEnter:Connect(function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end))
				table.insert(Dropdown._OptionSignals, Button.MouseLeave:Connect(function()
					SetBackTransparency(Selected and 0.89 or 1)
				end))
				table.insert(Dropdown._OptionSignals, Button.MouseButton1Down:Connect(function()
					SetBackTransparency(0.92)
				end))
				table.insert(Dropdown._OptionSignals, Button.MouseButton1Up:Connect(function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end))

				function Table:UpdateButton()
					if Config.Multi then
						Selected = Dropdown.Value[Value]
						if Selected then
							SetBackTransparency(0.89)
						end
					else
						Selected = Dropdown.Value == Value
						SetBackTransparency(Selected and 0.89 or 1)
					end

					SelectorSizeMotor:setGoal(Flipper.Spring.new(Selected and 14 or 6, { frequency = 6 }))
					SetSelTransparency(Selected and 0 or 1)
				end
				table.insert(Dropdown._OptionSignals, Button.Activated:Connect(function()
					local Try = not Selected

					if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
					else
						if Config.Multi then
							Selected = Try
							Dropdown.Value[Value] = Selected and true or nil
						else
							Selected = Try
							Dropdown.Value = Selected and Value or nil

							for _, OtherButton in next, Buttons do
								OtherButton:UpdateButton()
							end
						end

						Table:UpdateButton()

						Dropdown:Display()

						Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
						Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
					end
				end))

				Table:UpdateButton()
				Dropdown:Display()

				Buttons[Button] = Table
			end

			ListSizeX = 0
			for Button, Table in next, Buttons do
				if Button.ButtonLabel then
					local textSize = Button.ButtonLabel.TextBounds.X
					if textSize > ListSizeX then
						ListSizeX = textSize
					end
				end
			end
			ListSizeX = math.max(150, ListSizeX + 40)

			RecalculateCanvasSize()
			RecalculateListSize()
		end

		function Dropdown:SetValues(NewValues)
			if NewValues then
				Dropdown.Values = NewValues
			end

			Dropdown:BuildDropdownList()
		end

		function Dropdown:OnChanged(Func)
			Dropdown.Changed = Func
			Func(Dropdown.Value)
		end

		function Dropdown:SetValue(Val)
			if Dropdown.Multi then
				local nTable = {}

				for Value, Bool in next, Val do
					if table.find(Dropdown.Values, Value) then
						nTable[Value] = true
					end
				end

				Dropdown.Value = nTable
			else
				if not Val then
					Dropdown.Value = nil
				elseif table.find(Dropdown.Values, Val) then
					Dropdown.Value = Val
				end
			end

			Dropdown:BuildDropdownList()

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		end

		function Dropdown:Destroy()
			if Dropdown._OptionSignals then
				for _, sig in ipairs(Dropdown._OptionSignals) do
					pcall(function() sig:Disconnect() end)
				end
				table.clear(Dropdown._OptionSignals)
			end
			if Dropdown._OptionMotors then
				for _, motor in ipairs(Dropdown._OptionMotors) do
					pcall(function() motor:stop() end)
				end
				table.clear(Dropdown._OptionMotors)
			end
			for i, frame in ipairs(Library.OpenFrames or {}) do
				if frame == DropdownHolderCanvas then
					table.remove(Library.OpenFrames, i)
					break
				end
			end
			if DropdownHolderCanvas then
				pcall(function() DropdownHolderCanvas:Destroy() end)
			end
			DropdownFrame:Destroy()
			Library.Options[Idx] = nil
		end

		pcall(function()
			local target = DropdownFrame and (DropdownFrame.Frame or DropdownFrame)
			if target and typeof(target) == "Instance" and target.Destroying then
				target.Destroying:Connect(function()
					Dropdown:Destroy()
				end)
			end
		end)

		Dropdown:BuildDropdownList()
		Dropdown:Display()

		local Defaults = {}

		if type(Config.Default) == "string" then
			local Idx = table.find(Dropdown.Values, Config.Default)
			if Idx then
				table.insert(Defaults, Idx)
			end
		elseif type(Config.Default) == "table" then
			for _, Value in next, Config.Default do
				local Idx = table.find(Dropdown.Values, Value)
				if Idx then
					table.insert(Defaults, Idx)
				end
			end
		elseif type(Config.Default) == "number" and Dropdown.Values[Config.Default] ~= nil then
			table.insert(Defaults, Config.Default)
		end

		if next(Defaults) then
			for i = 1, #Defaults do
				local Index = Defaults[i]
				if Config.Multi then
					Dropdown.Value[Dropdown.Values[Index]] = true
				else
					Dropdown.Value = Dropdown.Values[Index]
				end

				if not Config.Multi then
					break
				end
			end

			Dropdown:BuildDropdownList()
			Dropdown:Display()
		end

		Library.Options[Idx] = Dropdown
		return Dropdown
	end

	return Element
end)()
ElementsTable.Paragraph = (function()
	local Paragraph = {}
	Paragraph.__index = Paragraph
	Paragraph.__type = "Paragraph"

	function Paragraph:New(Config)
		Config.Content = Config.Content or ""

		local Paragraph = Components.Element(Config.Title, Config.Content, Paragraph.Container, false, Config)
		Paragraph.Frame.BackgroundTransparency = 0.92
		Paragraph.Border.Transparency = 0.6

		Paragraph.SetTitle = Paragraph.SetTitle
		Paragraph.SetDesc = Paragraph.SetDesc
		Paragraph.Visible = Paragraph.Visible
		Paragraph.Elements = Paragraph

		return Paragraph
	end

	return Paragraph
end)()
ElementsTable.Slider = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Slider"

	function Element:New(Idx, Config)
		assert(Config.Title, "Slider - Missing Title.")
		assert(Config.Default, "Slider - Missing default value.")
		assert(Config.Min, "Slider - Missing minimum value.")
		assert(Config.Max, "Slider - Missing maximum value.")
		assert(Config.Rounding, "Slider - Missing rounding value.")

		local Slider = {
			Value = nil,
			Min = Config.Min,
			Max = Config.Max,
			Rounding = Config.Rounding,
			Callback = Config.Callback or function(Value) end,
			Type = "Slider",
		}

		local Dragging = false

		local SliderFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		SliderFrame:SetRightOffset(185)

		Slider.Elements = SliderFrame
		Slider.SetTitle = SliderFrame.SetTitle
		Slider.SetDesc = SliderFrame.SetDesc
		Slider.Visible = SliderFrame.Visible

		local SliderDot = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, -7, 0.5, 0),
			Size = UDim2.fromOffset(14, 14),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ThemeTag = {
				ImageColor3 = "Accent",
			},
		})

		local SliderRail = New("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(7, 0),
			Size = UDim2.new(1, -14, 1, 0),
		}, {
			SliderDot,
		})

		local SliderFill = New("Frame", {
			Size = UDim2.new(0, 0, 1, 0),
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
		})

		local SliderDisplay = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = "Value",
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Right,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 100, 0, 14),
			Position = UDim2.new(0, -4, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local SliderInput = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = "",
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Right,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.8,
			Size = UDim2.new(0, 0, 0, 14),
			Position = UDim2.new(0, -4, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			PlaceholderText = "Value",
			ClearTextOnFocus = false,
			Visible = true,
			TextWrapped = false,
			TextTransparency = 1,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "SubText",
				BackgroundColor3 = "Element",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 3),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(0, 0, 0),
				Transparency = 1,
				Thickness = 1,
			}),
		})

		local SliderInner = New("Frame", {
			Size = UDim2.new(1, 0, 0, 4),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundTransparency = 0.4,
			Parent = SliderFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "SliderRail",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
			New("UISizeConstraint", {
				MaxSize = Vector2.new(150, math.huge),
			}),
			SliderDisplay,
			SliderInput,
			SliderFill,
			SliderRail,
		})

		local isHovering = false
		local inputVisible = false
		local currentWidthTween = nil

		local function calculateInputWidth(text)
			local textSize = game:GetService("TextService"):GetTextSize(
				text or "0",
				12,
				Enum.Font.SourceSans,
				Vector2.new(1000, 14)
			)
			local padding = 8
			local minWidth = 25
			local maxWidth = 80
			return math.max(minWidth, math.min(maxWidth, textSize.X + padding))
		end

		local function updateInputWidth(text, animate)
			if currentWidthTween then
				currentWidthTween:Cancel()
				currentWidthTween = nil
			end

			local targetWidth = calculateInputWidth(text)
			local currentWidth = SliderInput.Size.X.Offset

			if animate and math.abs(targetWidth - currentWidth) > 0.5 then
				currentWidthTween = TweenService:Create(SliderInput, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, targetWidth, 0, 14)
				})
				currentWidthTween:Play()
				currentWidthTween.Completed:Connect(function()
					currentWidthTween = nil
				end)
			else
				SliderInput.Size = UDim2.new(0, targetWidth, 0, 14)
			end
		end

		Creator.AddSignal(SliderFrame.Frame.MouseEnter, function()
			isHovering = true
			TweenService:Create(SliderDot, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.fromOffset(17, 17)
			}):Play()
			if not SliderInput:IsFocused() then
				SliderDisplay.Visible = false
				SliderInput.Text = tostring(Slider.Value)

				updateInputWidth(tostring(Slider.Value), false)
				inputVisible = true

				local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

				TweenService:Create(SliderInput, tweenInfo, {
					TextTransparency = 0,
					BackgroundTransparency = 0.8
				}):Play()

				TweenService:Create(SliderInput.UIStroke, tweenInfo, {
					Transparency = 0.7
				}):Play()
			end
		end)

		Creator.AddSignal(SliderFrame.Frame.MouseLeave, function()
			isHovering = false
			TweenService:Create(SliderDot, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.fromOffset(14, 14)
			}):Play()
			if not SliderInput:IsFocused() and inputVisible then
				local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

				TweenService:Create(SliderInput, tweenInfo, {
					TextTransparency = 1,
					BackgroundTransparency = 1
				}):Play()

				TweenService:Create(SliderInput.UIStroke, tweenInfo, {
					Transparency = 1
				}):Play()

				task.wait(0.2)
				SliderDisplay.Visible = true
				inputVisible = false
			end
		end)

		Creator.AddSignal(SliderInput.Changed, function(property)
			if property == "Text" then
				local text = SliderInput.Text
				local cleanText = text:gsub("[^%d%.%-]", "")
				if cleanText:find("%-") and cleanText:find("%-") ~= 1 then
					cleanText = cleanText:gsub("%-", "")
				end
				local dotCount = 0
				cleanText = cleanText:gsub("%.", function()
					dotCount = dotCount + 1
					return dotCount == 1 and "." or ""
				end)

				if cleanText ~= text then
					SliderInput.Text = cleanText
					return
				end

				if inputVisible or SliderInput:IsFocused() then
					updateInputWidth(cleanText, true)
				end
			end
		end)

		Creator.AddSignal(SliderInput.FocusLost, function(enterPressed)
			local inputValue = tonumber(SliderInput.Text)
			if inputValue then
				Slider:SetValue(inputValue)
			else
				SliderInput.Text = tostring(Slider.Value)
				updateInputWidth(tostring(Slider.Value), true)
			end

			if not isHovering then
				local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

				TweenService:Create(SliderInput, tweenInfo, {
					TextTransparency = 1,
					BackgroundTransparency = 1
				}):Play()

				TweenService:Create(SliderInput.UIStroke, tweenInfo, {
					Transparency = 1
				}):Play()

				task.wait(0.2)
				SliderDisplay.Visible = true
				inputVisible = false
			end
		end)

		Creator.AddSignal(SliderInput.Focused, function()
			SliderInput.Text = tostring(Slider.Value)
			updateInputWidth(tostring(Slider.Value), false)
		end)

		Creator.AddSignal(SliderInput.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				Dragging = false
			end
		end)

		Creator.AddSignal(SliderDot.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
			end
		end)

		Creator.AddSignal(SliderDot.InputEnded, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = false
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Dragging then
				local position = nil
				if Input.UserInputType == Enum.UserInputType.MouseMovement then
					position = Input.Position
				elseif Input.UserInputType == Enum.UserInputType.Touch then
					position = Input.Position
				end

				if position then
					local SizeScale = math.clamp((position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
					Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
				end
			end
		end)

		Creator.AddSignal(SliderRail.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				local SizeScale = math.clamp((Input.Position.X - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
				Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
			end
		end)

		Creator.AddSignal(SliderRail.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = false
			end
		end)

		function Slider:OnChanged(Func)
			Slider.Changed = Func
			Func(Slider.Value)
		end

		function Slider:SetValue(Value)
			self.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Rounding)
			SliderDot.Position = UDim2.new((self.Value - Slider.Min) / (Slider.Max - Slider.Min), -7, 0.5, 0)
			SliderFill.Size = UDim2.fromScale((self.Value - Slider.Min) / (Slider.Max - Slider.Min), 1)
			SliderDisplay.Text = tostring(self.Value)

			if inputVisible or SliderInput:IsFocused() then
				SliderInput.Text = tostring(self.Value)
				updateInputWidth(tostring(self.Value), not SliderInput:IsFocused())
			end
			if not inputVisible and not SliderInput:IsFocused() then
				SliderInput.Text = tostring(self.Value)
			end

			Library:SafeCallback(Slider.Callback, self.Value)
			Library:SafeCallback(Slider.Changed, self.Value)
		end

		function Slider:Destroy()
			SliderFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Slider:SetValue(Config.Default)

		Library.Options[Idx] = Slider
		return Slider
	end

	return Element
end)()
ElementsTable.Keybind = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Keybind"

	function Element:New(Idx, Config)
		assert(Config.Title, "KeyBind - Missing Title")
		assert(Config.Default, "KeyBind - Missing default value.")

		local Keybind = {
			Value = Config.Default,
			Toggled = false,
			Mode = Config.Mode or "Toggle",
			Type = "Keybind",
			Callback = Config.Callback or function(Value) end,
			ChangedCallback = Config.ChangedCallback or function(New) end,
		}

		local Picking = false

		local KeybindFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)
		KeybindFrame:SetRightOffset(125)

		Keybind.SetTitle = KeybindFrame.SetTitle
		Keybind.SetDesc = KeybindFrame.SetDesc
		Keybind.Visible = KeybindFrame.Visible
		Keybind.Elements = KeybindFrame

		local KeybindDisplayLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = Config.Default,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(0, 0, 0, 14),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local KeybindDisplayFrame = New("TextButton", {
			Size = UDim2.fromOffset(0, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = KeybindFrame.Frame,
			AutomaticSize = Enum.AutomaticSize.X,
			ThemeTag = {
				BackgroundColor3 = "Keybind",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			KeybindDisplayLabel,
		})

		function Keybind:GetState()
			if UserInputService:GetFocusedTextBox() and Keybind.Mode ~= "Always" then
				return false
			end

			if Keybind.Mode == "Always" then
				return true
			elseif Keybind.Mode == "Hold" then
				if Keybind.Value == "None" then
					return false
				end

				local Key = Keybind.Value

				if Key == "MouseLeft" or Key == "MouseRight" then
					return Key == "MouseLeft" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						or Key == "MouseRight"
						and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				else
					return UserInputService:IsKeyDown(Enum.KeyCode[Keybind.Value])
				end
			else
				return Keybind.Toggled
			end
		end

		function Keybind:SetValue(Key, Mode)
			Key = Key or Keybind.Key
			Mode = Mode or Keybind.Mode

			KeybindDisplayLabel.Text = Key
			Keybind.Value = Key
			Keybind.Mode = Mode
		end

		function Keybind:OnClick(Callback)
			Keybind.Clicked = Callback
		end

		function Keybind:OnChanged(Callback)
			Keybind.Changed = Callback
			Callback(Keybind.Value)
		end

		function Keybind:DoClick()
			Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
			Library:SafeCallback(Keybind.Clicked, Keybind.Toggled)
		end

		function Keybind:Destroy()
			KeybindFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(KeybindDisplayFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Picking = true
				KeybindDisplayLabel.Text = "..."

				wait(0.2)

				local Event
				Event = UserInputService.InputBegan:Connect(function(Input)
					local Key

					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Key = Input.KeyCode.Name
					elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Key = "MouseLeft"
					elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
						Key = "MouseRight"
					end

					local EndedEvent
					EndedEvent = UserInputService.InputEnded:Connect(function(Input)
						if
							Input.KeyCode.Name == Key
							or Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Picking = false

							KeybindDisplayLabel.Text = Key
							Keybind.Value = Key

							Library:SafeCallback(Keybind.ChangedCallback, Input.KeyCode or Input.UserInputType)
							Library:SafeCallback(Keybind.Changed, Input.KeyCode or Input.UserInputType)

							Event:Disconnect()
							EndedEvent:Disconnect()
						end
					end)
				end)
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if not Picking and not UserInputService:GetFocusedTextBox() then
				if Keybind.Mode == "Toggle" then
					local Key = Keybind.Value

					if Key == "MouseLeft" or Key == "MouseRight" then
						if
							Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					elseif Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode.Name == Key then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					end
				end
			end
		end)

		Library.Options[Idx] = Keybind
		return Keybind
	end

	return Element
end)()
ElementsTable.Colorpicker = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Colorpicker"

	function Element:New(Idx, Config)
		assert(Config.Title, "Colorpicker - Missing Title")
		assert(Config.Default, "AddColorPicker: Missing default value.")

		local Colorpicker = {
			Value = Config.Default,
			Transparency = Config.Transparency or 0,
			Type = "Colorpicker",
			Title = type(Config.Title) == "string" and Config.Title or "Colorpicker",
			Callback = Config.Callback or function(Color) end,
		}

		function Colorpicker:SetHSVFromRGB(Color)
			local H, S, V = Color3.toHSV(Color)
			Colorpicker.Hue = H
			Colorpicker.Sat = S
			Colorpicker.Vib = V
		end

		Colorpicker:SetHSVFromRGB(Colorpicker.Value)

		local ColorpickerFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)
		ColorpickerFrame:SetRightOffset(65)

		Colorpicker.SetTitle = ColorpickerFrame.SetTitle
		Colorpicker.SetDesc = ColorpickerFrame.SetDesc
		Colorpicker.Visible = ColorpickerFrame.Visible
		Colorpicker.Elements = ColorpickerFrame

		local DisplayFrameColor = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Colorpicker.Value,
			Parent = ColorpickerFrame.Frame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local DisplayFrame = New("ImageLabel", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = ColorpickerFrame.Frame,
			Image = "http://www.roblox.com/asset/?id=14204231522",
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(40, 40),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			DisplayFrameColor,
		})

		local function CreateColorDialog()
			local Dialog = Components.Dialog:Create()
			Dialog.Title.Text = Colorpicker.Title
			Dialog.Root.Size = UDim2.fromOffset(430, 330)

			local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib
			local Transparency = Colorpicker.Transparency

			local function CreateInput()
				local Box = Components.Textbox()
				Box.Frame.Parent = Dialog.Root
				Box.Frame.Size = UDim2.new(0, 90, 0, 32)

				return Box
			end

			local function CreateInputLabel(Text, Pos)
				return New("TextLabel", {
					FontFace = Font.new(
						"rbxasset://fonts/families/GothamSSm.json",
						Enum.FontWeight.Medium,
						Enum.FontStyle.Normal
					),
					Text = Text,
					TextColor3 = Color3.fromRGB(240, 240, 240),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, 0, 0, 32),
					Position = Pos,
					BackgroundTransparency = 1,
					Parent = Dialog.Root,
					ThemeTag = {
						TextColor3 = "Text",
					},
				})
			end

			local function GetRGB()
				local Value = Color3.fromHSV(Hue, Sat, Vib)
				return { R = math.floor(Value.r * 255), G = math.floor(Value.g * 255), B = math.floor(Value.b * 255) }
			end

			local SatCursor = New("ImageLabel", {
				Size = UDim2.new(0, 18, 0, 18),
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=4805639000",
			})

			local SatVibMap = New("ImageLabel", {
				Size = UDim2.fromOffset(180, 160),
				Position = UDim2.fromOffset(20, 55),
				Image = "rbxassetid://4155801252",
				BackgroundColor3 = Colorpicker.Value,
				BackgroundTransparency = 0,
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				SatCursor,
			})

			local OldColorFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = Colorpicker.Transparency,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})
			local OldColorFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(112, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				OldColorFrame,
			})

			local DialogDisplayFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local DialogDisplayFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(20, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				DialogDisplayFrame,
			})

			local SequenceTable = {}

			for Color = 0, 1, 0.1 do
				table.insert(SequenceTable, ColorSequenceKeypoint.new(Color, Color3.fromHSV(Color, 1, 1)))
			end

			local HueSliderGradient = New("UIGradient", {
				Color = ColorSequence.new(SequenceTable),
				Rotation = 90,
			})

			local HueDragHolder = New("Frame", {
				Size = UDim2.new(1, 0, 1, -10),
				Position = UDim2.fromOffset(0, 5),
				BackgroundTransparency = 1,
			})

			local HueDrag = New("ImageLabel", {
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				Parent = HueDragHolder,
				ThemeTag = {
					ImageColor3 = "DialogInput",
				},
			})

			local HueSlider = New("Frame", {
				Size = UDim2.fromOffset(12, 190),
				Position = UDim2.fromOffset(210, 55),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				HueSliderGradient,
				HueDragHolder,
			})

			local HexInput = CreateInput()
			HexInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 55)
			CreateInputLabel("Hex", UDim2.fromOffset(Config.Transparency and 360 or 340, 55))

			local RedInput = CreateInput()
			RedInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 95)
			CreateInputLabel("Red", UDim2.fromOffset(Config.Transparency and 360 or 340, 95))

			local GreenInput = CreateInput()
			GreenInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 135)
			CreateInputLabel("Green", UDim2.fromOffset(Config.Transparency and 360 or 340, 135))

			local BlueInput = CreateInput()
			BlueInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 175)
			CreateInputLabel("Blue", UDim2.fromOffset(Config.Transparency and 360 or 340, 175))

			local AlphaInput
			if Config.Transparency then
				AlphaInput = CreateInput()
				AlphaInput.Frame.Position = UDim2.fromOffset(260, 215)
				CreateInputLabel("Alpha", UDim2.fromOffset(360, 215))
			end

			local TransparencySlider, TransparencyDrag, TransparencyColor
			if Config.Transparency then
				local TransparencyDragHolder = New("Frame", {
					Size = UDim2.new(1, 0, 1, -10),
					Position = UDim2.fromOffset(0, 5),
					BackgroundTransparency = 1,
				})

				TransparencyDrag = New("ImageLabel", {
					Size = UDim2.fromOffset(14, 14),
					Image = "http://www.roblox.com/asset/?id=12266946128",
					Parent = TransparencyDragHolder,
					ThemeTag = {
						ImageColor3 = "DialogInput",
					},
				})

				TransparencyColor = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UIGradient", {
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
						Rotation = 270,
					}),
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
				})

				TransparencySlider = New("Frame", {
					Size = UDim2.fromOffset(12, 190),
					Position = UDim2.fromOffset(230, 55),
					Parent = Dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
					New("ImageLabel", {
						Image = "http://www.roblox.com/asset/?id=14204231522",
						ImageTransparency = 0.45,
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Parent = Dialog.Root,
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(1, 0),
						}),
					}),
					TransparencyColor,
					TransparencyDragHolder,
				})
			end

			local function Display()
				SatVibMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
				HueDrag.Position = UDim2.new(0, -1, Hue, -6)
				SatCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
				DialogDisplayFrame.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)

				HexInput.Input.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
				RedInput.Input.Text = GetRGB()["R"]
				GreenInput.Input.Text = GetRGB()["G"]
				BlueInput.Input.Text = GetRGB()["B"]

				if Config.Transparency then
					TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
					DialogDisplayFrame.BackgroundTransparency = Transparency
					TransparencyDrag.Position = UDim2.new(0, -1, 1 - Transparency, -6)
					AlphaInput.Input.Text = Library:Round((1 - Transparency) * 100, 0) .. "%"
				end
			end

			table.insert(Dialog.Signals, HexInput.Input.FocusLost:Connect(function(Enter)
				if Enter then
					local Success, Result = pcall(Color3.fromHex, HexInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						Hue, Sat, Vib = Color3.toHSV(Result)
					end
				end
				Display()
			end))

			table.insert(Dialog.Signals, RedInput.Input.FocusLost:Connect(function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, RedInput.Input.Text, CurrentColor["G"], CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(RedInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end))

			table.insert(Dialog.Signals, GreenInput.Input.FocusLost:Connect(function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], GreenInput.Input.Text, CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(GreenInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end))

			table.insert(Dialog.Signals, BlueInput.Input.FocusLost:Connect(function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], CurrentColor["G"], BlueInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						if tonumber(BlueInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end))

			if Config.Transparency then
				table.insert(Dialog.Signals, AlphaInput.Input.FocusLost:Connect(function(Enter)
					if Enter then
						pcall(function()
							local Value = tonumber(AlphaInput.Input.Text)
							if Value >= 0 and Value <= 100 then
								Transparency = 1 - Value * 0.01
							end
						end)
					end
					Display()
				end))
			end

			table.insert(Dialog.Signals, SatVibMap.InputBegan:Connect(function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinX = SatVibMap.AbsolutePosition.X
						local MaxX = MinX + SatVibMap.AbsoluteSize.X
						local MouseX = math.clamp(Mouse.X, MinX, MaxX)

						local MinY = SatVibMap.AbsolutePosition.Y
						local MaxY = MinY + SatVibMap.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Sat = (MouseX - MinX) / (MaxX - MinX)
						Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end))

			table.insert(Dialog.Signals, HueSlider.InputBegan:Connect(function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinY = HueSlider.AbsolutePosition.Y
						local MaxY = MinY + HueSlider.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Hue = ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end))

			if Config.Transparency then
				table.insert(Dialog.Signals, TransparencySlider.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local MinY = TransparencySlider.AbsolutePosition.Y
							local MaxY = MinY + TransparencySlider.AbsoluteSize.Y
							local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

							Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))
							Display()

							RenderStepped:Wait()
						end
					end
				end))
			end

			Display()

			Dialog:Button("Done", function()
				Colorpicker:SetValue({ Hue, Sat, Vib }, Transparency)
			end)
			Dialog:Button("Cancel")
			Dialog:Open()
		end

		function Colorpicker:Display()
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)

			DisplayFrameColor.BackgroundColor3 = Colorpicker.Value
			DisplayFrameColor.BackgroundTransparency = Colorpicker.Transparency

			Element.Library:SafeCallback(Colorpicker.Callback, Colorpicker.Value, Colorpicker.Transparency)
			Element.Library:SafeCallback(Colorpicker.Changed, Colorpicker.Value, Colorpicker.Transparency)
		end

		function Colorpicker:SetValue(HSV, Transparency)
			local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])

			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:SetValueRGB(Color, Transparency)
			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:OnChanged(Func)
			Colorpicker.Changed = Func
			Func(Colorpicker.Value, Colorpicker.Transparency)
		end

		function Colorpicker:Destroy()
			ColorpickerFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ColorpickerFrame.Frame.MouseButton1Click, function()
			CreateColorDialog()
		end)

		Creator.AddSignal(ColorpickerFrame.Frame.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				CreateColorDialog()
			end
		end)

		Colorpicker:Display()

		Library.Options[Idx] = Colorpicker
		return Colorpicker
	end

	return Element
end)()
ElementsTable.Input = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Input"

	function Element:New(Idx, Config)
		assert(Config.Title, "Input - Missing Title")
		Config.Callback = Config.Callback or function() end

		local Input = {
			Value = Config.Default or "",
			Numeric = Config.Numeric or false,
			Finished = Config.Finished or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Input",
		}

		local InputFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		InputFrame:SetRightOffset(185)

		Input.SetTitle = InputFrame.SetTitle
		Input.SetDesc = InputFrame.SetDesc
		Input.Visible = InputFrame.Visible
		Input.Elements = InputFrame

		local Textbox = Components.Textbox(InputFrame.Frame, true)
		Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
		Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
		Textbox.Frame.Size = UDim2.fromOffset(160, 30)
		Textbox.Input.Text = Config.Default or ""
		Textbox.Input.PlaceholderText = Config.Placeholder or ""

		local Box = Textbox.Input

		function Input:SetValue(Text)
			if Config.MaxLength and #Text > Config.MaxLength then
				Text = Text:sub(1, Config.MaxLength)
			end

			if Input.Numeric then
				if (not tonumber(Text)) and Text:len() > 0 then
					Text = Input.Value
				end
			end

			Input.Value = Text
			Box.Text = Text

			Library:SafeCallback(Input.Callback, Input.Value)
			Library:SafeCallback(Input.Changed, Input.Value)
		end

		if Input.Finished then
			AddSignal(Box.FocusLost, function(enter)
				if not enter then
					return
				end
				Input:SetValue(Box.Text)
			end)
		else
			AddSignal(Box:GetPropertyChangedSignal("Text"), function()
				Input:SetValue(Box.Text)
			end)
		end

		function Input:OnChanged(Func)
			Input.Changed = Func
			Func(Input.Value)
		end

		function Input:Destroy()
			InputFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Library.Options[Idx] = Input
		return Input
	end

	return Element
end)()

ElementsTable.SearchBar = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "SearchBar"
	local New = Creator.New

	function Element:New(Idx, Config)
		Config = Config or {}
		local SearchBar = {
			Type = "SearchBar",
			Value = Config.Default or "",
			Placeholder = Config.Placeholder or Config.Title or "Search...",
			Callback = Config.Callback or function(text) end,
		}

		local SearchBarFrame = Components.Element("", "", self.Container, false, Config)
		SearchBar.SetTitle = SearchBarFrame.SetTitle
		SearchBar.SetDesc = SearchBarFrame.SetDesc
		SearchBar.Visible = SearchBarFrame.Visible
		SearchBar.Elements = SearchBarFrame

		local InputBox = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -38, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			PlaceholderText = SearchBar.Placeholder,
			PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
			ClearTextOnFocus = false,
			Text = SearchBar.Value,
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		local SearchIcon = New("ImageLabel", {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -12, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Image = "rbxassetid://10734943674",
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local BoxContainer = New("Frame", {
			Size = UDim2.new(1, 0, 0, 32),
			BackgroundTransparency = 0.85,
			BackgroundColor3 = Color3.fromRGB(40, 40, 48),
			Parent = SearchBarFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "Input",
			},
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			New("UIStroke", {
				Transparency = 0.6,
				ThemeTag = { Color = "ElementBorder" },
			}),
			InputBox,
			SearchIcon,
		})

		function SearchBar:SetValue(Text)
			InputBox.Text = Text
			SearchBar.Value = Text
			pcall(SearchBar.Callback, Text)
		end

		Creator.AddSignal(InputBox:GetPropertyChangedSignal("Text"), function()
			SearchBar.Value = InputBox.Text
			pcall(SearchBar.Callback, InputBox.Text)
		end)

		Library.Options[Idx] = SearchBar
		return SearchBar
	end

	return Element
end)()

local NotificationModule = Components.Notification
NotificationModule:Init(GUI)

local New = Creator.New

local Icons = {
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-anvil"] = "rbxassetid://77943964625400",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-container"] = "rbxassetid://17466205552",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-door-open"] = "rbxassetid://124179241653522",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-todo"] = "rbxassetid://17376008003",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-plane-landing"] = "rbxassetid://17376029914",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wheat"] = "rbxassetid://80877624162595",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
	["lucide-cat"] = "rbxassetid://16935650691",
	["lucide-message-circle-question"] = "rbxassetid://16970049192",
	["lucide-webhook"] = "rbxassetid://17320556264",
	["lucide-dumbbell"] = "rbxassetid://18273453053"
}

local Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

for _, ElementComponent in pairs(ElementsTable) do
	Elements["Add" .. ElementComponent.__type] = function(self, Idx, Config)
		ElementComponent.Container = self.Container
		ElementComponent.Type = self.Type
		ElementComponent.ScrollFrame = self.ScrollFrame
		ElementComponent.Library = Library

		return ElementComponent:New(Idx, Config)
	end
    
    -- Alias for backwards compatibility with older Fluent branches
    Elements[ElementComponent.__type] = Elements["Add" .. ElementComponent.__type]
end

Elements.AddColorPicker = Elements.AddColorpicker
Elements.ColorPicker = Elements.AddColorpicker
Elements.AddMultiDropdown = function(self, Idx, Config)
	Config = Config or {}
	Config.Multi = true
	return self:AddDropdown(Idx, Config)
end
Elements.MultiDropdown = Elements.AddMultiDropdown
Elements.AddSearch = Elements.AddSearchBar
Elements.Search = Elements.AddSearchBar

Library.Elements = Elements

if RunService:IsStudio() then
	makefolder = function(...) return ... end;
	makefile = function(...) return ... end;
	isfile = function(...) return ... end;
	isfolder = function(...) return ... end;
	readfile = function(...) return ... end;
	writefile = function(...) return ... end;
	listfiles = function (...) return {...} end;
end

local SaveManager = {} do



	SaveManager.Folder = "FluentSettings"


	SaveManager.Ignore = {}


	SaveManager.Parser = {


		Toggle = {


			Save = function(idx, object) 


				return { type = "Toggle", idx = idx, value = object.Value } 


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] then 


					SaveManager.Options[idx]:SetValue(data.value)


				end


			end,


		},


		Slider = {


			Save = function(idx, object)


				return { type = "Slider", idx = idx, value = tostring(object.Value) }


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] then 


					SaveManager.Options[idx]:SetValue(data.value)


				end


			end,


		},


		Dropdown = {


			Save = function(idx, object)


				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] then 


					SaveManager.Options[idx]:SetValue(data.value)


				end


			end,


		},


		Colorpicker = {


			Save = function(idx, object)


				return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] then 


					SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)


				end


			end,


		},


		Keybind = {


			Save = function(idx, object)


				return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] then 


					SaveManager.Options[idx]:SetValue(data.key, data.mode)


				end


			end,


		},





		Input = {


			Save = function(idx, object)


				return { type = "Input", idx = idx, text = object.Value }


			end,


			Load = function(idx, data)


				if SaveManager.Options[idx] and type(data.text) == "string" then


					SaveManager.Options[idx]:SetValue(data.text)


				end


			end,


		},


	}





	function SaveManager:SetIgnoreIndexes(list)


		for _, key in next, list do


			self.Ignore[key] = true


		end


	end


	function SaveManager:SetFolder(folder)


		self.Folder = folder;


		self:BuildFolderTree()


	end





	function SaveManager:Save(name)


		if (not name) then


			return false, "no config file is selected"


		end





		local fullPath = self.Folder .. "/" .. name .. ".json"





		local data = {


			objects = {}


		}








		for idx, option in next, SaveManager.Options do


			if self.Parser[option.Type] and not self.Ignore[idx] then


				table.insert(data.objects, self.Parser[option.Type].Save(idx, option))


			end


		end	





		local success, encoded = pcall(httpService.JSONEncode, httpService, data)


		if not success then


			return false, "failed to encode data"


		end





		writefile(fullPath, encoded)


		return true


	end





	if not RunService:IsStudio() then


		function SaveManager:Load(name)


			if (not name) then


				return false, "no config file is selected"


			end





			local file = self.Folder .. "/" .. name .. ".json"


			if not isfile(file) then return false, "Create Config Save File" end





			local success, decoded = pcall(httpService.JSONDecode, httpService, readfile(file))


			if not success then return false, "decode error" end





			for _, option in next, decoded.objects do


				if self.Parser[option.type] and not self.Ignore[option.idx] then


					task.spawn(function() self.Parser[option.type].Load(option.idx, option) end)


				end


			end





			Fluent.SettingLoaded = true





			return true, decoded


		end


	end





	SaveManager.IgnoreThemeSettings = function(self)


		self:SetIgnoreIndexes({ 


			"InterfaceTheme", "AcrylicToggle", "TransparentToggle", "MenuKeybind"


		})


	end





	function SaveManager:BuildFolderTree()


		local paths = {


			self.Folder,


			self.Folder .. "/"


		}





		for i = 1, #paths do


			local str = paths[i]


			if not isfolder(str) then


				makefolder(str)


			end


		end


	end





	function SaveManager:RefreshConfigList()


		local list = listfiles(self.Folder .. "/")





		local out = {}


		for i = 1, #list do


			local file = list[i]


			if file:sub(-5) == ".json" then


				local pos = file:find(".json", 1, true)


				local start = pos





				local char = file:sub(pos, pos)


				while char ~= "/" and char ~= "\\" and char ~= "" do


					pos = pos - 1


					char = file:sub(pos, pos)


				end





				if char == "/" or char == "\\" then


					local name = file:sub(pos + 1, start - 1)


					if name ~= "options" then


						table.insert(out, name)


					end


				end


			end


		end





		return out


	end





	function SaveManager:SetLibrary(library)


		self.Library = library


		self.Options = library.Options


	end





	if not RunService:IsStudio() then


		function SaveManager:LoadAutoloadConfig()


			if isfile(self.Folder .. "/autoload.txt") then


				local name = readfile(self.Folder .. "/autoload.txt")
			if not name or name:gsub(" ", "") == "" then return end





				local success, err = self:Load(name)


				if not success then


					return self.Library:Notify({


						Title = "Interface",


						Content = "Config loader",


						SubContent = "Failed to load autoload config: " .. err,


						Duration = 7


					})


				end





				self.Library:Notify({


					Title = "Interface",


					Content = "Config loader",


					SubContent = string.format("Auto loaded config %q", name),


					Duration = 7


				})


			end


		end


	end





	function SaveManager:ResetAutoloadConfig()
		local files = {
			self.Folder .. "/autoload.txt",
			self.Folder .. "/settings/autoload.txt"
		}
		local cleared = false
		for _, f in ipairs(files) do
			if isfile and isfile(f) then
				if delfile then
					pcall(delfile, f)
				else
					pcall(writefile, f, "")
				end
				cleared = true
			end
		end
		if self.AutoloadButton then
			self.AutoloadButton:SetDesc("Current autoload config: none")
		end
		if self.Library then
			self.Library:Notify({
				Title = "Interface",
				Content = "Config loader",
				SubContent = cleared and "Reset autoload configuration" or "No autoload configuration was set",
				Duration = 7
			})
		end
		return cleared
	end
	SaveManager.ClearAutoloadConfig = SaveManager.ResetAutoloadConfig
	function SaveManager:BuildConfigSection(tab)


		assert(self.Library, "Must set SaveManager.Library")





		local section = tab:AddSection("Configuration", "settings")





		section:AddInput("SaveManager_ConfigName",    { Title = "Config name" })


		section:AddDropdown("SaveManager_ConfigList", { Title = "Config list", Values = self:RefreshConfigList(), AllowNull = true })





		section:AddButton({
			Title = "Create config",
			Callback = function()
				task.spawn(function()
					local name = SaveManager.Options.SaveManager_ConfigName.Value

					if name:gsub(" ", "") == "" then 
						return self.Library:Notify({
							Title = "Interface",
							Content = "Config loader",
							SubContent = "Invalid config name (empty)",
							Duration = 7
						})
					end

					local success, err = self:Save(name)
					if not success then
						return self.Library:Notify({
							Title = "Interface",
							Content = "Config loader",
							SubContent = "Failed to save config: " .. tostring(err),
							Duration = 7
						})
					end

					self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = string.format("Created config %q", name),
						Duration = 7
					})

					SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
					SaveManager.Options.SaveManager_ConfigList:SetValue(nil)
				end)
			end
		})

		section:AddButton({Title = "Load config", Callback = function()
			task.spawn(function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value

				local success, err = self:Load(name)
				if not success then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Failed to load config: " .. tostring(err),
						Duration = 7
					})
				end

				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Loaded config %q", name),
					Duration = 7
				})
			end)
		end})

		section:AddButton({Title = "Save config", Callback = function()
			task.spawn(function()
				local name = SaveManager.Options.SaveManager_ConfigList.Value

				local success, err = self:Save(name)
				if not success then
					return self.Library:Notify({
						Title = "Interface",
						Content = "Config loader",
						SubContent = "Failed to overwrite config: " .. tostring(err),
						Duration = 7
					})
				end

				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = string.format("Overwrote config %q", name),
					Duration = 7
				})
			end)
		end})





		section:AddButton({Title = "Refresh list", Callback = function()


			SaveManager.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())


			SaveManager.Options.SaveManager_ConfigList:SetValue(nil)


		end})





		local AutoloadButton


		AutoloadButton = section:AddButton({Title = "Set as autoload", Description = "Current autoload config: none", Callback = function()


			local name = SaveManager.Options.SaveManager_ConfigList.Value


			writefile(self.Folder .. "/autoload.txt", name)


			AutoloadButton:SetDesc("Current autoload config: " .. name)


			self.Library:Notify({


				Title = "Interface",


				Content = "Config loader",


				SubContent = string.format("Set %q to auto load", name),


				Duration = 7


			})


		end})
		self.AutoloadButton = AutoloadButton
		section:AddButton({Title = "Reset autoload config", Description = "Removes the autoload config", Callback = function()
			if self.ResetAutoloadConfig then
				self:ResetAutoloadConfig()
			else
				pcall(function()
					if delfile then
						delfile(self.Folder .. "/autoload.txt")
					else
						writefile(self.Folder .. "/autoload.txt", "")
					end
				end)
				AutoloadButton:SetDesc("Current autoload config: none")
				self.Library:Notify({
					Title = "Interface",
					Content = "Config loader",
					SubContent = "Reset autoload configuration",
					Duration = 7
				})
			end
		end})






		if isfile(self.Folder .. "/autoload.txt") then


			local name = readfile(self.Folder .. "/autoload.txt")


			AutoloadButton:SetDesc("Current autoload config: " .. name)


		end





		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })


	end





	if not RunService:IsStudio() then


		SaveManager:BuildFolderTree()


	end


end





local InterfaceManager = {} do


	InterfaceManager.Folder = "FluentSettings"


	InterfaceManager.Settings = {


		Acrylic = true,


		Transparency = true,


		MenuKeybind = "M"


	}





	function InterfaceManager:SetTheme(name)


		InterfaceManager.Settings.Theme = name


	end





	function InterfaceManager:SetFolder(folder)


		self.Folder = folder;


		self:BuildFolderTree()


	end





	function InterfaceManager:SetLibrary(library)


		self.Library = library


	end





	function InterfaceManager:BuildFolderTree()


		local paths = {}





		local parts = self.Folder:split("/")


		for idx = 1, #parts do


			paths[#paths + 1] = table.concat(parts, "/", 1, idx)


		end





		table.insert(paths, self.Folder)


		table.insert(paths, self.Folder .. "/")





		for i = 1, #paths do


			local str = paths[i]


			if not isfolder(str) then


				makefolder(str)


			end


		end


	end





	function InterfaceManager:SaveSettings()


		writefile(self.Folder .. "/options.json", httpService:JSONEncode(InterfaceManager.Settings))


	end





	function InterfaceManager:LoadSettings()


		local path = self.Folder .. "/options.json"


		if isfile(path) then


			local data = readfile(path)





			if not RunService:IsStudio() then local success, decoded = pcall(httpService.JSONDecode, httpService, data) end





			if success then


				for i, v in next, decoded do


					InterfaceManager.Settings[i] = v


				end


			end


		end


	end


	function InterfaceManager:BuildInterfaceSection(tab)


		assert(self.Library, "Must set InterfaceManager.Library")


		local Library = self.Library


		local Settings = InterfaceManager.Settings





		InterfaceManager:LoadSettings()





		local section = tab:AddSection("Interface", "monitor")


		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {


			Title = "Theme",


			Description = "Changes the interface theme.",


			Values = Library.Themes,


			Default = self.Library.Theme,


			Callback = function(Value)


				Library:SetTheme(Value)


				Settings.Theme = Value


				InterfaceManager:SaveSettings()


			end


		})





		InterfaceTheme:SetValue(Settings.Theme)





		if Library.UseAcrylic and not Mobile then


			section:AddToggle("AcrylicToggle", {


				Title = "Acrylic",


				Description = "The blurred background requires graphic quality 8+",


				Default = Settings.Acrylic,


				Callback = function(Value)


					Library:ToggleAcrylic(Value)


					Settings.Acrylic = Value


					InterfaceManager:SaveSettings()


				end


			})


		elseif Mobile then


			Settings.Acrylic = false


		end





		section:AddSlider("WindowTransparency", {


			Title = "Window Transparency",


			Description = "Adjusts the window transparency.",


			Default = 1,


			Min = 0,


			Max = 3,


			Rounding = 1,


			Callback = function(Value)


				Library:SetWindowTransparency(Value)


			end


		})








		local MenuKeybind = section:AddKeybind("MenuKeybind", { Title = "Minimize Bind", Default = Library.MinimizeKey.Name or Settings.MenuKeybind })


		MenuKeybind:OnChanged(function()


			Settings.MenuKeybind = MenuKeybind.Value


			InterfaceManager:SaveSettings()


		end)


		Library.MinimizeKeybind = MenuKeybind


	end


end





Library.CreateWindow = function(self, Config)


	assert(Config.Title, "Window - Missing Title")





	if Library.Window then


		print("You cannot create more than one window.")


		return


	end





	Library.MinimizeKey = Config.MinimizeKey or Enum.KeyCode.LeftControl


	Library.UseAcrylic = Config.Acrylic or false


	Library.Acrylic = Config.Acrylic or false


	Library.Theme = Config.Theme or "Dark"
	Creator.Theme = Library.Theme
	Library.Sound = (Config.Sound == true)

	if Config.BackgroundImage == nil then
		Config.BackgroundImage = "rbxassetid://13196113628"
	end

	if Config.BackgroundTransparency == nil then
		Config.BackgroundTransparency = 0.5
	end





	if Config.Acrylic then


		Acrylic.init()


	end





	local Icon = Config.Icon


	if not fischbypass then 


		if Library:GetIcon(Icon) then


			Icon = Library:GetIcon(Icon)


		end





		if Icon == "" or Icon == nil then


			Icon = nil


		end


	end





	local Window = Components.Window({


		Parent = GUI,


		Size = Config.Size,


		Title = Config.Title,


		Icon = Icon,


		Image = Config.Image,


		BackgroundImage = Config.BackgroundImage,


		BackgroundTransparency = Config.BackgroundTransparency,


		BackgroundImageTransparency = Config.BackgroundImageTransparency,


		SubTitle = Config.SubTitle,


		TabWidth = Config.TabWidth,

		DropdownsOutsideWindow = Config.DropdownsOutsideWindow,


		Search = Config.Search,


		UserInfoTitle = Config.UserInfoTitle,


		UserInfo = Config.UserInfo,


		UserInfoTop = Config.UserInfoTop,


		UserInfoSubtitle = Config.UserInfoSubtitle,
		UserInfoSubtitleColor = Config.UserInfoSubtitleColor,
		MinButton = Config.MinButton,
		MinimizeButton = Config.MinimizeButton,
		Minimize = Config.Minimize,
	})





	Library.Window = Window


	table.insert(Library.Windows, Window)


	InterfaceManager:SetTheme(Config.Theme)


	Library:SetTheme(Config.Theme)





	return Window


end





function Library:CreateMinimizer(Config)


	Config = Config or {}


	local parentGui = Library.GUI or GUI
	local safeRoots = {}
	if gethui then pcall(function() table.insert(safeRoots, gethui()) end) end
	pcall(function() table.insert(safeRoots, game:GetService("CoreGui")) end)
	pcall(function() table.insert(safeRoots, game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")) end)

	for _, root in ipairs(safeRoots) do
		for _, child in ipairs(root:GetChildren()) do
			if child.Name == "FluentMinimizer" then
				pcall(function() child:Destroy() end)
			elseif child.Name == "FluentUI" and child ~= parentGui then
				pcall(function() child:Destroy() end)
			end
		end
		for _, desc in ipairs(root:GetDescendants()) do
			if desc.Name == "FluentMinimizer" and (not parentGui or not desc:IsDescendantOf(parentGui)) then
				pcall(function() desc:Destroy() end)
			end
		end
	end
	if parentGui then
		parentGui.DisplayOrder = 1000
		for _, child in ipairs(parentGui:GetChildren()) do
			if child.Name == "FluentMinimizer" then
				pcall(function() child:Destroy() end)
			end
		end
	end


	local isMobile = Mobile and true or false





	local iconAsset = "rbxassetid://10734897102"


	if type(Config.Icon) == "string" and Config.Icon ~= "" then


		pcall(function()


			local resolved = Library:GetIcon(Config.Icon)


			if resolved then


				iconAsset = resolved


			elseif string.match(Config.Icon, "^rbxassetid://%d+$") then


				iconAsset = Config.Icon


			end


		end)


	end





	local useAcrylic = (Config.Acrylic == true)





	local cornerRadius = tonumber(Config.Corner)


	local backgroundTransparency = (typeof(Config.Transparency) == "number") and math.clamp(Config.Transparency, 0, 1) or 0


	local draggableWhole = (Config.Draggable == true)





	local holder


	local function createButton(isDesktop)


		return New("TextButton", {


			Name = "MinimizeButton",


			Size = UDim2.new(1, 0, 1, 0),


			BorderSizePixel = 0,


			BackgroundTransparency = backgroundTransparency or 0,


			AutoButtonColor = true,


			ThemeTag = {


				BackgroundColor3 = "Element",


			},


		}, {


			New("UICorner", { CornerRadius = UDim.new(0, cornerRadius or (isDesktop and 14 or 12)) }),


			New("UIStroke", {


				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,


				Transparency = isDesktop and 0.6 or 0.7,


				Thickness = isDesktop and 2 or 1.5,


				ThemeTag = {


					Color = "ElementBorder",


				},


			}),


			New("TextLabel", {
				Name = "StatusLabel",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				ThemeTag = {
					TextColor3 = "Text",
				},
				Text = (Library.Window and Library.Window.Minimized) and "Open" or "Close",
			}),





		})


	end





	if isMobile then


		holder = New("Frame", {


			Name = "FluentMinimizer",


			Parent = parentGui,


			Size = Config.Size or UDim2.fromOffset(58, 28),


			Position = Config.Position or UDim2.new(0.45, 0, 0.025, 0),


			BackgroundTransparency = 1,


			ZIndex = 999999999,


			Visible = (Config.Visible == true),


		})


	else


		holder = New("Frame", {


			Name = "FluentMinimizer",


			Parent = parentGui,


			Size = Config.Size or UDim2.fromOffset(58, 28),


			Position = Config.Position or UDim2.new(0, 300, 0, 20),


			BackgroundTransparency = 1,


			ZIndex = 999999999,


			Visible = (Config.Visible == true),


		})


	end





	if useAcrylic then


		local miniAcrylic = Acrylic.AcrylicPaint()


		miniAcrylic.Frame.Parent = holder


		miniAcrylic.Frame.Size = UDim2.fromScale(1, 1)


		pcall(function() miniAcrylic.AddParent(holder) end)





		local desiredCorner = UDim.new(0, cornerRadius or 0)


		pcall(function()


			for _, descendant in ipairs(miniAcrylic.Frame:GetDescendants()) do


				if descendant.ClassName == "UICorner" then


					descendant.CornerRadius = desiredCorner


				elseif descendant.ClassName == "ImageLabel" then


					descendant.Size = UDim2.fromScale(1, 1)


					descendant.Position = UDim2.new(0.5, 0, 0.5, 0)


					descendant.AnchorPoint = Vector2.new(0.5, 0.5)


				end


			end


		end)


		self.MinimizerAcrylic = miniAcrylic


	end





	local btnInstance = createButton(not isMobile)


	btnInstance.Parent = holder


	btnInstance.ZIndex = (holder.ZIndex or 0) + 1





	local button = holder:FindFirstChildOfClass("TextButton")


	if button then


		local isDragging = false


		local dragStart, dragOffset





		if draggableWhole then


			Creator.AddSignal(button.InputBegan, function(Input)


				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then


					isDragging = true


					local pos = Input.Position


					dragStart = Vector2.new(pos.X, pos.Y)


					dragOffset = holder.Position


					local conn


					conn = Input.Changed:Connect(function()


						if Input.UserInputState == Enum.UserInputState.End then


							isDragging = false


							dragStart = nil


							dragOffset = nil


							conn:Disconnect()


						end


					end)


				end


			end)





			Creator.AddSignal(RunService.Heartbeat, function()


				if isDragging and dragStart and dragOffset and holder and holder.Parent then


					local mouse = LocalPlayer:GetMouse()


					local current = Vector2.new(mouse.X, mouse.Y)


					local delta = current - dragStart


					local newX = dragOffset.X.Offset + delta.X


					local newY = dragOffset.Y.Offset + delta.Y


					local viewport = workspace.Camera.ViewportSize


					local size = holder.AbsoluteSize


					if newX < 0 then newX = 0 end


					if newY < 0 then newY = 0 end


					if newX > viewport.X - size.X then newX = viewport.X - size.X end


					if newY > viewport.Y - size.Y then newY = viewport.Y - size.Y end


					holder.Position = UDim2.new(0, newX, 0, newY)


				end


			end)


		end





		local function syncStatusText()
			local label = button:FindFirstChild("StatusLabel") or button:FindFirstChildWhichIsA("TextLabel")
			if label and Library.Window then
				local isOpen = (Library.Window.Minimized == false) and (Library.Window.Root and Library.Window.Root.Visible ~= false)
				label.Text = isOpen and "Close" or "Open"
			end
		end
		if Library.Window and Library.Window.Root then
			AddSignal(Library.Window.Root:GetPropertyChangedSignal("Visible"), syncStatusText)
		end
		AddSignal(button.MouseButton1Click, function()


			task.wait(0.1)


			if not isDragging and Library.Window then
				Library.Window:Minimize()
			end
			local label = button:FindFirstChild("StatusLabel") or button:FindFirstChildWhichIsA("TextLabel")
			if label and Library.Window then
				local isOpen = (Library.Window.Minimized == false) and (Library.Window.Root and Library.Window.Root.Visible ~= false)
				label.Text = isOpen and "Close" or "Open"
			end


		end)


	end











	local minimizerObj = setmetatable({
		Frame = holder,
		SetVisible = function(self, val)
			holder.Visible = (val == true)
		end,
		Destroy = function(self)
			pcall(function() holder:Destroy() end)
			Library.Minimizer = nil
		end,
	}, {
		__index = function(tbl, key)
			if key == "Visible" then
				return holder.Visible
			end
			return holder[key]
		end,
		__newindex = function(tbl, key, val)
			if key == "Visible" then
				holder.Visible = (val == true)
				return
			end
			holder[key] = val
		end,
	})

	self.Minimizer = minimizerObj
	return minimizerObj


end





function Library:SetTheme(Value)
	if Library.Window and table.find(Library.Themes, Value) then
		Library.Theme = Value
		Creator.Theme = Value
		Creator.UpdateTheme()

		if Value == "Glass" then
			Library:SetWindowTransparency(0.9)
		end
	end
end

function Library:Destroy()
	Library.Unloaded = true

	pcall(function()
		Acrylic.Destroy()
	end)

	if Library.UseAcrylic and Library.Window and Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Model then
		pcall(function() Library.Window.AcrylicPaint.Model:Destroy() end)
	end

	if Library.BlurFolder then
		pcall(function() Library.BlurFolder:Destroy() end)
		Library.BlurFolder = nil
	end

	pcall(function()
		local cam = workspace.CurrentCamera
		if cam then
			for _, child in ipairs(cam:GetChildren()) do
				if child.Name == "FluentBlur" then
					child:Destroy()
				end
			end
		end
	end)

	if Library.Minimizer then
		pcall(function()
			local mObj = Library.Minimizer
			local frame = (typeof(mObj) == "table" and mObj.Frame) or (typeof(mObj) == "Instance" and mObj)
			if frame and frame.Parent then
				frame:Destroy()
			end
		end)
		Library.Minimizer = nil
	end

	Creator.Disconnect()

	if Creator.TextElementConnections then
		for _, conn in ipairs(Creator.TextElementConnections) do
			pcall(function() conn:Disconnect() end)
		end
		table.clear(Creator.TextElementConnections)
	end
	if Creator.TextElements then
		table.clear(Creator.TextElements)
	end

	if Creator.TransparencyMotors then
		for _, Motor in next, Creator.TransparencyMotors do
			if type(Motor) == "table" and Motor.stop then Motor:stop() end
		end
		table.clear(Creator.TransparencyMotors)
	end

	local function stopWindowMotors(win)
		if not win then return end
		if win.SizeMotor and win.SizeMotor.stop then pcall(function() win.SizeMotor:stop() end) end
		if win.PosMotor and win.PosMotor.stop then pcall(function() win.PosMotor:stop() end) end
		if win.SelectorPosMotor and win.SelectorPosMotor.stop then pcall(function() win.SelectorPosMotor:stop() end) end
		if win.SelectorSizeMotor and win.SelectorSizeMotor.stop then pcall(function() win.SelectorSizeMotor:stop() end) end
		if win.TabModule and win.TabModule.Tabs then
			for _, tab in pairs(win.TabModule.Tabs) do
				if tab.ContainerXMotor and tab.ContainerXMotor.stop then pcall(function() tab.ContainerXMotor:stop() end) end
				if tab.ContainerTransparencyMotor and tab.ContainerTransparencyMotor.stop then pcall(function() tab.ContainerTransparencyMotor:stop() end) end
				if tab.Motor and tab.Motor.stop then pcall(function() tab.Motor:stop() end) end
			end
		end
	end

	stopWindowMotors(Library.Window)
	if Library.Windows then
		for _, win in ipairs(Library.Windows) do
			stopWindowMotors(win)
		end
		table.clear(Library.Windows)
	end
	Library.Window = nil

	if Library.Options then
		table.clear(Library.Options)
	end
	if Library.Flags then
		table.clear(Library.Flags)
	end

	if type(Creator.Registry) == "table" then
		table.clear(Creator.Registry)
	end
	if Library.OpenFrames then
		for _, frame in ipairs(Library.OpenFrames) do
			if typeof(frame) == "Instance" and frame.Parent then
				pcall(function() frame:Destroy() end)
			end
		end
		table.clear(Library.OpenFrames)
	end
	if Library.ActiveNotifications then
		table.clear(Library.ActiveNotifications)
	end

	if Library.GUI then
		pcall(function() Library.GUI:Destroy() end)
		Library.GUI = nil
	end
end

function Library:ToggleAcrylic(Value)
	if Library.Window then
		Library.Acrylic = (Value == true)
		if Library.Acrylic then
			if Library.UseAcrylic then
				Acrylic.Enable()
				if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Model then
					local targetTrans = (Library.Theme == "Glass") and 0.85 or 0.98
					Library.Window.AcrylicPaint.Model.Transparency = targetTrans
				end
				if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Frame then
					local f = Library.Window.AcrylicPaint.Frame
					local bg = f:FindFirstChild("Background")
					if bg then
						bg.BackgroundTransparency = (Library.Theme == "Glass") and 0.5 or 0.45
						Creator.OverrideTag(bg, { BackgroundColor3 = "AcrylicMain" })
					end
					for _, child in ipairs(f:GetChildren()) do
						if child.Name ~= "Background" and child.Name ~= "UICorner" then
							if child:IsA("ImageLabel") or child:IsA("Frame") then
								child.Visible = true
							end
						end
					end
				end
			end
		else
			Acrylic.Disable()
			Library.Acrylic = false
			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Model then
				Library.Window.AcrylicPaint.Model.Transparency = 1
				Library.Window.AcrylicPaint.Model.CFrame = CFrame.new(0, -999999, 0)
			end
			if Library.BlurFolder then
				for _, child in ipairs(Library.BlurFolder:GetChildren()) do
					if child:IsA("BasePart") then
						child.Transparency = 1
						child.CFrame = CFrame.new(0, -999999, 0)
					end
				end
			end
			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Frame then
				local f = Library.Window.AcrylicPaint.Frame
				local bg = f:FindFirstChild("Background")
				if bg then
					bg.BackgroundTransparency = 0
					Creator.OverrideTag(bg, { BackgroundColor3 = "Background" })
				end
				for _, child in ipairs(f:GetChildren()) do
					if child.Name ~= "Background" and child.Name ~= "UICorner" then
						if child:IsA("ImageLabel") or child:IsA("Frame") then
							child.Visible = false
						end
					end
				end
			end
		end
	end
end

function Library:ToggleTransparency(Value)
	if Library.Window and Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Frame and Library.Window.AcrylicPaint.Frame:FindFirstChild("Background") then
		Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value and 0.35 or 0
	end
end

function Library:SetWindowTransparency(Value)
	if Library.Window and Library.UseAcrylic and Library.Acrylic then
		Value = math.clamp(Value, 0, 3)

		if Library.Theme == "Glass" then
			local glassTransparency = 0.8 + (Value * 0.05)
			if Value > 1 then
				glassTransparency = 0.85 + ((Value - 1) * 0.04)
			end
			if Value > 2 then
				glassTransparency = 0.93 + ((Value - 2) * 0.04)
			end

			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Model then
				if Library.Window.Root and (not Library.Window.Root.Visible or Library.Window.Minimized) then
					Library.Window.AcrylicPaint.Model.Transparency = 1
					Library.Window.AcrylicPaint.Model.CFrame = CFrame.new(0, -999999, 0)
				else
					Library.Window.AcrylicPaint.Model.Transparency = math.min(glassTransparency, 0.99)
				end
			end

			local backgroundTransparency = 0.7 + (Value * 0.08)
			if Value > 1 then
				backgroundTransparency = 0.78 + ((Value - 1) * 0.07)
			end
			if Value > 2 then
				backgroundTransparency = 0.85 + ((Value - 2) * 0.1)
			end

			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Frame and Library.Window.AcrylicPaint.Frame:FindFirstChild("Background") then
				Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = math.min(backgroundTransparency, 0.99)
			end

			Library.NotificationTransparency = Value

			for _, notification in pairs(Library.ActiveNotifications or {}) do
				if notification and notification.ApplyTransparency then
					notification:ApplyTransparency()
				end
			end
		else
			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Model then
				if Library.Window.Root and (not Library.Window.Root.Visible or Library.Window.Minimized) then
					Library.Window.AcrylicPaint.Model.Transparency = 1
					Library.Window.AcrylicPaint.Model.CFrame = CFrame.new(0, -999999, 0)
				else
					Library.Window.AcrylicPaint.Model.Transparency = 0.98
				end
			end
			if Library.Window.AcrylicPaint and Library.Window.AcrylicPaint.Frame and Library.Window.AcrylicPaint.Frame:FindFirstChild("Background") then
				Library.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = Value * 0.3
			end
		end
	end
end





function Library:Notify(Config)
	return NotificationModule:New(Config)
end





if getgenv then
	getgenv().Fluent = Library
else
	Fluent = Library
end

if RunService:IsStudio() then task.wait(0.01) end
return Library, SaveManager, InterfaceManager, Mobile

