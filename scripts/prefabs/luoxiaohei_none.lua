local assets =
{
	Asset( "ANIM", "anim/luoxiaohei.zip" ),
	Asset( "ANIM", "anim/ghost_luoxiaohei_build.zip" ),
}

local skins =
{
	normal_skin = "luoxiaohei",
	ghost_skin = "ghost_luoxiaohei_build",
}

return CreatePrefabSkin("luoxiaohei_none",
{
	base_prefab = "luoxiaohei",
	type = "base",
	assets = assets,
	skins = skins,
	skin_tags = {"LUOXIAOHEI", "CHARACTER", "BASE"},
	build_name_override = "luoxiaohei",
	rarity = "Character",
})