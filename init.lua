

minetest.register_tool("guns4d_pack_1:stanag", {
    description = "STANAG mag (5.56x45mm)",
    stack_max = 5,
    inventory_image = "stanag.png"
})
Guns4d.ammo.register_magazine({
    itemstring = "guns4d_pack_1:stanag",
    capacity = 30,
    hot_eject = true, --lol
    accepted_bullets = {
        "guns4d_pack_1:556"
    },
})

minetest.register_craftitem("guns4d_pack_1:556", {
    description = "standard 5.56x45mm round",
    wield_scale = {x=.5, y=.5, z=.5},
    stack_max = 25,
    inventory_image = "556_standard.png"
})
Guns4d.ammo.register_bullet({
    itemstring = "guns4d_pack_1:556",
    range = 400,
    energy_dropoff = 4,      --the dropoff of energy per meter. This will cause penetration dropoff for both blunt and sharp.
    energy = 1709,          --energy in joules, this is used for blunt->calculation based on blunt_penetration value.
    sharp_penetration = 15, --sharp penetration is in mmRHA
    blunt_penetration = 1200, --blunt penetration is in Joules OR pascals (1 square meter).
    raw_blunt_damage = 2,       --the blunt damage at the blunt_penetration value. 1MPa = 2/500 of damage, note that sharp pen will convert to blunt (though lower).
    raw_sharp_damage = 5        --the sharp damage at the sharp_penetration value. Sharp pen will likely not be at this value.
})

minetest.register_tool("guns4d_pack_1:m4", {
    description = "M4 carbine (5.56x45mm)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "m4a1_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:m4",
    itemstring = "guns4d_pack_1:m4",
    properties = {
        visuals = {
            mesh = "m4.b3d",
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                unload = {x=2, y=33},
                load = {x=34, y=74},
                fire = {x=1, y=6}
            },
        },
        crosshair = Guns4d.dynamic_crosshair,
        --sprite_scope = Guns4d.sprite_scope,
        firerateRPM = 1000,
        hip = {
            offset = vector.new(-.22,.1,.3),
        },
        ads = {
            offset = vector.new(0,0,.3),
            horizontal_offset = .1,
            aim_time = .3
        },
        textures = {
            "m4.png"
        },
        sway = {
            max_angle = {player_axial=1, gun_axial=.15},
            angular_velocity = {player_axial=.1, gun_axial=.1},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 4,
                player_axial = 6
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 2,
                player_axial = 1
            }
        },
        flash_offset = vector.new(0, -.086, .56),
        recoil = {
            velocity_correction_factor = {
                gun_axial = 1,
                player_axial = 1,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 5,
                player_axial = 10,
            },
            angular_velocity_max = {
                gun_axial = 2,
                player_axial = 2,
            },
            angular_velocity = {
                gun_axial = {x=.4, y=.4},
                player_axial = {x=.5, y=.5},
            },
            bias = {
                gun_axial = {x=1, y=0},
                player_axial = {x=.4, y=0},
            },
            target_correction_max_rate = { --the cap for time_since_fire*target_correction_factor
                gun_axial = 100,
                player_axial = 100,
            },
        },
        walking_offset = {gun_axial={x=.1,y=-.3}, player_axial={x=1,y=1}},
        ammo = {
            magazine_only = true,
            accepted_bullets = {"guns4d_pack_1:556"},
            accepted_magazines = {"guns4d_pack_1:stanag"}
        },
        reload = {
            {type="unload", time=.5, anim="unload", interupt="to_ground", hold = true},
            {type="load", time=1, anim="load"}
        },
    },
    consts = {
        HAS_BREATHING = true,
    }
})
local scope_scale = 5
local awm_scope = Guns4d.sprite_scope:inherit({
    images = {
        reticle = {
            texture = "awm_reticle.png",
            scale = {x=scope_scale,y=scope_scale},
            movement_multiplier = 1,
            misalignment_opacity_threshold_angle = 3,
            misalignment_opacity_maximum_angle = 8,
        },
        fore = {
            texture = "awm_forescope.png",
            scale = {x=(151/32)*scope_scale,y=(151/32)*scope_scale}, --16x16 image, needs to be the same visible size as the reticle (which is 251x)
            movement_multiplier = 1,
        },
        --[[back = {
            texture = "awm_backscope.png",
            scale = {x=(151/32)*scope_scale,y=(151/32)*scope_scale},
            movement_multiplier = -1,
            opacity_delay = 2,
            paxial = true,
        },]]
        border_fore = {
            texture = "awm_scope_border.png",
            scale = {x=151*scope_scale,y=151*scope_scale}, --7x7 image, needs to be 7 times the size of the reticle/forescope
            movement_multiplier = 1,
        },
        border_back = {
            texture = "awm_scope_border.png",
            scale = {x=151*scope_scale*1.2,y=151*scope_scale*1.2},
            movement_multiplier = -1,
            opacity_delay = 2,
            paxial = true,
        }
        --mask = "blank.png",
    },
})
minetest.register_tool("guns4d_pack_1:awm", {
    description = "AWM sniper rifle (5.56x45mm)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "awm_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:awm",
    itemstring = "guns4d_pack_1:awm",
    properties = {
        visuals = {
            backface_culling = false,
            mesh = "awm.b3d",
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                unload = {x=2, y=33},
                load = {x=34, y=74},
                fire = {x=11, y=53}
            },
        },
        crosshair = Guns4d.dynamic_crosshair,
        sprite_scope = awm_scope,
        firerateRPM = 60,
        hip = {
            offset = vector.new(-.22,.1,.4),
        },
        ads = {
            offset = vector.new(0,0,.465),
            horizontal_offset = .1,
            aim_time = .3
        },
        textures = {
            "awm.png"
        },
        sway = {
            max_angle = {player_axial=1.1, gun_axial=.1},
            angular_velocity = {player_axial=.1, gun_axial=.1},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 4,
                player_axial = 6
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 2,
                player_axial = 1
            }
        },
        flash_offset = vector.new(0, -.086, .56),
        recoil = {
            velocity_correction_factor = { --I dont remember what this actually does
                gun_axial = 1,
                player_axial = 1,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 5,
                player_axial = 1,
            },
            angular_velocity_max = { --not an auto weapon, so it doesnt matter
                gun_axial = 1000,
                player_axial = 1000,
            },
            angular_velocity = {
                gun_axial = {x=4, y=1},
                player_axial = {x=3.5, y=4},
            },
            bias = {
                gun_axial = {x=1, y=0},
                player_axial = {x=1, y=0},
            },
            target_correction_max_rate = { --the cap for time_since_fire*target_correction_factor
                gun_axial = 5,
                player_axial = 5,
            },
        },
        walking_offset = {gun_axial={x=.5,y=-.5}, player_axial={x=1,y=1}},
        ammo = {
            magazine_only = true,
            accepted_bullets = {"guns4d_pack_1:556"},
            accepted_magazines = {"guns4d_pack_1:stanag"}
        },
        reload = {
            {type="unload", time=.5, anim="unload", interupt="to_ground", hold = true},
            {type="load", time=1, anim="load"}
        },
    },
    consts = {
        HAS_BREATHING = true,
        KEYFRAME_SAMPLE_PRECISION = .5, -- has to be more precise for the bolt cycle animation
        DEFAULT_FPS = 40,
        ANIMATIONS_OFFSET_AIM = true,
    }
})