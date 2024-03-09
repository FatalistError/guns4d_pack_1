
--556
minetest.register_craftitem("guns4d_pack_1:556", {
    description = "5.56x45mm FMJ",
    wield_scale = {x=.5, y=.5, z=.5},
    stack_max = 25,
    inventory_image = "556_standard.png"
})
Guns4d.ammo.register_bullet({
    itemstring = "guns4d_pack_1:556",
    range = 200,
    energy_dropoff = 4,
    energy = 1709,
    sharp_penetration = 13,
    blunt_penetration = 1200,
    raw_blunt_damage = 2,
    raw_sharp_damage = 5
})
--338 lupua
minetest.register_craftitem("guns4d_pack_1:338L", {
    description = ".338 lupua AP",
    wield_scale = {x=.5, y=.5, z=.5},
    stack_max = 25,
    inventory_image = "338_lupua.png"
})
Guns4d.ammo.register_bullet({
    itemstring = "guns4d_pack_1:338L",
    range = 350,
    energy_dropoff = 3,      --the dropoff of energy per meter. This will cause penetration dropoff for both blunt and sharp.
    energy = 2000,          --energy in joules, this is used for blunt->calculation based on blunt_penetration value. The higher this is, the more blunt_force will be generated from "blocked" sharp_penetration. 1j = 1MPa
    sharp_penetration = 20, --sharp penetration is in mmRHA. Setting this and blunt_penetration defines the ratio of how energy is distributed between the values.
    blunt_penetration = 1200, --blunt penetration is in Joules OR pascals (1 square meter). it is force or energy in MPa
    raw_blunt_damage = 5,       --the blunt damage at the blunt_penetration value. This means this is really setting the ratio of damage to blunt_penetration, meaning blocked sharp will do this amount of damage per the set blunt_penetration
    raw_sharp_damage = 6        --the sharp damage at the sharp_penetration value. Real damage will very if the target is armoured
})

--stanag
minetest.register_tool("guns4d_pack_1:stanag", {
    description = "STANAG mag (5.56x45mm)",
    inventory_image = "stanag_inv.png"
})
Guns4d.register_item("guns4d_pack_1:stanag", {
    mesh = "stanag.obj",
    collisionbox_size = 4,
    textures = {"stanag.png"}
})
Guns4d.ammo.register_magazine({
    itemstring = "guns4d_pack_1:stanag",
    capacity = 30,
    model = "stanag.obj",
    hot_eject = true, --lol
    accepted_bullets = {
        "guns4d_pack_1:556"
    },
})

--AWM
minetest.register_tool("guns4d_pack_1:awm_magazine", {
    description = "STANAG mag (5.56x45mm)",
    inventory_image = "awm_mag_inv.png"
})
Guns4d.register_item("guns4d_pack_1:awm_magazine", {
    mesh = "stanag.obj",
    collisionbox_size = 4,
    textures = {"stanag.png"}
})
Guns4d.ammo.register_magazine({
    itemstring = "guns4d_pack_1:awm_magazine",
    capacity = 7,
    model = "stanag.obj",
    hot_eject = true, --lol
    accepted_bullets = {
        "guns4d_pack_1:338L"
    },
})