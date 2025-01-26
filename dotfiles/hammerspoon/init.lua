-- change default init.lua using the command
-- defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
-- And then reload
-- from https://github.com/Hammerspoon/hammerspoon/issues/1734

-- Spoon Install Plugin
-- NOT CURRENTLY WORKING, CANNOT INSTALL FROM OTHER REPO
-- hs.loadSpoon("SpoonInstall")
-- spoon.SpoonInstall.use_syncinstall = true
-- spoon.SpoonInstall.repos = {
-- 	default = {
-- 		url = "https://github.com/Hammerspoon/Spoons",
-- 		desc = "Main Hammerspoon Spoon repository",
-- 		branch = "master",
-- 	},
-- 	vifari = {
-- 		url = "https://github.com/dzirtusss/vifari",
-- 		desc = "Vifari",
-- 		branch = "main",
-- 	},
-- }
-- Install = spoon.SpoonInstall

-- Vifari
hs.loadSpoon("Vifari")

hs.inspect(spoon.Vifari)
-- spoon.Vifari.config.smoothScroll = true
spoon.Vifari:start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
	hs.alert.show(hs.inspect(spoon.Vifari))
end)
