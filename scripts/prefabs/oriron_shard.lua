local assets =
{
	Asset( "ANIM", "anim/oriron_shard.zip" ),
	Asset( "IMAGE", "images/inventoryimages/oriron_shard.tex" ),
	Asset( "ATLAS", "images/inventoryimages/oriron_shard.xml" ),
}

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("oriron_shard")
	inst.AnimState:SetBuild("oriron_shard")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetScale(1.5, 1.5, 1.5)

    inst:AddTag("metal")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/oriron_shard.xml"
	inst.components.inventoryitem.imagename = "oriron_shard"
    inst.components.inventoryitem:SetSinks(true)
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	return inst
end

return Prefab("oriron_shard", fn, assets)
