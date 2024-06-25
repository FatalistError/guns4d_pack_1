
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
    energy = 1700,
    sharp_penetration = 13,
    blunt_penetration = 1000,
    raw_blunt_damage = 3,
    raw_sharp_damage = 4
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
    sharp_penetration = 20, --sharp penetration is in mmRHA.
    blunt_penetration = 1200, --blunt penetration is in Joules OR pascals (1 square meter). it is force or energy in MPa, this defines the ratio of energy which goes to blunt penetration aswell.
    raw_blunt_damage = 5,       --the blunt damage at the blunt_penetration value. This means this is really setting the ratio of damage to blunt_penetration, meaning blocked sharp will do this amount of damage per the set blunt_penetration
    raw_sharp_damage = 7        --the sharp damage at the sharp_penetration value. Real damage will very if the target is armoured
})
minetest.register_craftitem("guns4d_pack_1:45A", {
    description = ".45 ACP",
    wield_scale = {x=.5, y=.5, z=.5},
    stack_max = 30,
    inventory_image = "45A.png"
})
Guns4d.ammo.register_bullet({
    itemstring = "guns4d_pack_1:45A",
    range = 200,
    energy_dropoff = 7,
    energy = 900,
    sharp_penetration = 4,
    blunt_penetration = 700,
    --pellets = 20, was for testing the system.
    raw_blunt_damage = 3,
    raw_sharp_damage = 2
})
minetest.register_craftitem("guns4d_pack_1:12G", {
    description = "12 Gauge Buckshot",
    wield_scale = {x=.5, y=.5, z=.5},
    stack_max = 15,
    inventory_image = "12G.png"
})
Guns4d.ammo.register_bullet({
    itemstring = "guns4d_pack_1:12G",
    range = 80,
    energy_dropoff = 5,
    energy = 400,
    sharp_penetration = 2,
    blunt_penetration = 20,
    pellets = 8,
    spread_deviation = .6, --deviation of the standard distribution
    spread = 3, --defaults to 1 if pellets present but spread not defined.
    raw_blunt_damage = 1.2,
    raw_sharp_damage = .4
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
    accepted_bullets = {
        "guns4d_pack_1:556"
    },
})

--AWM
minetest.register_tool("guns4d_pack_1:awm_magazine", {
    description = "AWM mag (.338 Lupua)",
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
    accepted_bullets = {
        "guns4d_pack_1:338L"
    },
})

--glock21
minetest.register_tool("guns4d_pack_1:45mm_magazine_13", {
    description = "13 round glock mag (.45 ACP)",
    inventory_image = "glock_mag_inv.png"
})
Guns4d.register_item("guns4d_pack_1:45mm_magazine_13", {
    mesh = "stanag.obj",
    collisionbox_size = 4,
    textures = {"stanag.png"}
})
Guns4d.ammo.register_magazine({
    itemstring = "guns4d_pack_1:45mm_magazine_13",
    capacity = 13,
    accepted_bullets = {
        "guns4d_pack_1:45A"
    },
})