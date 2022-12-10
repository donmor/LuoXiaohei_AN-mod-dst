local function LIMBO(tbl)
	tbl["zhr"] = tbl["zh"]
	return ChooseTranslationTable(tbl)
end

name = "Luo Xiaohei"
version = "0.0.1-alpha"
description = LIMBO({
[[
Luo Xiaohei (罗小黑)

* Fan-made MOD of 'The Legend of Luo Xiaohei' and 'Arknights', may be different from the original
* Beginner in MOD crafting so there may be undiscovered bug
* Lots of modified APIs so be attention to compatibility
* Arknights characristic, can be OOC
Copyright of the character belongs to: 'HMCH' and 'Hypergryph'
Finally, Feel free to play as a cat (^=·ω·=^)

For more information please see Readme.md or https://steamcommunity.com/sharedfiles/filedetails/?id=<TBD>
]], ["zh"] = [[
Luo Xiaohei (罗小黑)

※本MOD为罗小黑战记/明日方舟二次创作内容
※MOD制作新手, 请注意潜在的bug
※大量API补丁, 请注意兼容性
※舟游设定，可能的OOC
本MOD人物版权归属：HMCH/鹰角
最后, 祝各位玩得愉快(^=·ω·=^)

更多信息请查看Readme.md或https://steamcommunity.com/sharedfiles/filedetails/?id=<TBD>
]]})

author = "donmor"
forumthread = ""
api_version_dst = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {
	"character",
}
bugtracker_config = {
	email = "donmor3000@hotmail.com",
	upload_client_log = true,
	upload_server_log = true,
}
-- local platform = folder_name and ((folder_name == "workshop-2576573801" and "STEAM") or (folder_name == "workshop-2199027653598532077" and "TGP" )) or nil
-- local platformshop = {
-- 	["STEAM"] = "workshop-2576514266",
-- 	["TGP"] = "workshop-2199027653598532076",
-- }
-- mod_dependencies = platform and {
-- 	{
-- 		workshop = platformshop[platform],
-- 		["libTimeStopper-mod-dst"] = false,
-- 		["libTimeStopper"] = true,
-- 	}
-- } or {
-- 	{
-- 		["libTimeStopper-mod-dst"] = false,
-- 		["libTimeStopper"] = true,
-- 	}
-- }
configuration_options =
{
	-- {
	-- 	name = "night_vision",
	-- 	label = LIMBO({"Night Vision", ["zh"] = "夜视"}),
	-- 	options =
	-- 	{
	-- 		{description = LIMBO({"Enable", ["zh"] = "开启"}), data = true, hover = LIMBO({"Night vision on", ["zh"] = "猫猫可以夜视"})},
	-- 		{description = LIMBO({"Disable", ["zh"] = "关闭"}), data = false, hover = LIMBO({"No night vision", ["zh"] = "关闭夜视功能"})},
	-- 	},
	-- 	default = false,
	-- },

	-- {
	-- 	name = "items_aura_advanced",
	-- 	label = LIMBO({"Items sanity control mode", ["zh"] = "道具理智增益模式"}),
	-- 	options =
	-- 	{
	-- 		{description = LIMBO({"Calm", ["zh"] = "镇定"}), data = true, hover = LIMBO({"Increase sanity but lower enlightenment", ["zh"] = "增加理智但降低启蒙"})},
	-- 		{description = LIMBO({"Increase", ["zh"] = "增辐"}), data = false, hover = LIMBO({"Increase either sanity or enlightenment", ["zh"] = "一直增加理智及启蒙"})},
	-- 	},
	-- 	default = false,
	-- },

	{
		name = "luoxiaohei_se",
		label = LIMBO({"SE", ["zh"] = "音效"}),
		options =
		{
			{description = LIMBO({"Off", ["zh"] = "关闭"}), data = 0},
			{description = LIMBO({"Low", ["zh"] = "低"}), data = 0.4},
			{description = LIMBO({"Med", ["zh"] = "中"}), data = 0.7},
			{description = LIMBO({"High", ["zh"] = "高"}), data = 1},
		},
		default = 1,
	},

	{
		name = "luoxiaohei_voice",
		label = LIMBO({"Voice SE", ["zh"] = "语音"}),
		options =
		{
			{description = LIMBO({"Off",["zh"] = "关闭"}), data = 0},
			{description = LIMBO({"Low", ["zh"] = "低"}), data = 0.4},
			{description = LIMBO({"Med", ["zh"] = "中"}), data = 0.7},
			{description = LIMBO({"High", ["zh"] = "高"}), data = 1},
		},
		default = 1,
	},
}
