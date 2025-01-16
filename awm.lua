local forescope_scale = 5
local backscope_scale = 2
local awm_scope = Guns4d.sprite_scope:inherit({
    images = {
        reticle = {
            texture = "awm_reticle.png",
            scale = {x=forescope_scale,y=forescope_scale},
            movement_multiplier = 1,
            misalignment_opacity_threshold_angle = 3,
            misalignment_opacity_maximum_angle = 8,
        },
        fore = {
            texture = "awm_forescope.png",
            --projection_pos = {x=0,y=0,z=.1465*1.5}, --projection location relative to the gun.
            scale = {x=(151/32)*forescope_scale,y=(151/32)*forescope_scale}, --16x16 image, needs to be the same visible size as the reticle (which is 251x)
            projection_pos = {x=0,y=0,z=.1465*1.5}, --projection location relative to the gun.
        },
        border_fore = {
            texture = "awm_scope_border.png",
            --projection_pos = {x=0,y=0,z=.1465*1.5}, --projection location relative to the gun.
            scale = {x=151*forescope_scale,y=151*forescope_scale}, --7x7 image, needs to be 7 times the size of the reticle/forescope
            --projection_pos = {x=0,y=0,z=-.135*1.5}, --projection location relative to the gun.
        },

        back = {
            texture = "awm_backscope.png",
            scale = {x=(152/32)*backscope_scale,y=(152/32)*backscope_scale},
            projection_pos = {x=0,y=0,z=-.135*1.5}, --projection location relative to the gun.
            opacity_delay = .01,
            paxial = true,
        },
        border_back = {
            texture = "awm_scope_border.png",
            scale = {x=151*backscope_scale,y=151*backscope_scale},
            projection_pos = {x=0,y=0,z=-.135*1.5}, --projection location relative to the gun.
            opacity_delay = .01,
        }
        --mask = "blank.png",
    },
    --hide_gun=false
})
minetest.register_tool("guns4d_pack_1:awm", {
    description = "AWM sniper rifle (338 Lupua)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "awm_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:awm",
    itemstring = "guns4d_pack_1:awm",
    properties = {
        visuals = {
            flash_offset = vector.new(0, -.001, 0),
            scale = 1.5,
            backface_culling = false,
            mesh = "awm.b3d",
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                fire = {x=11, y=47},
                unload = {x=48, y=51},
                store = {x=51, y=67},
                load = {x=68, y=100},
                chamber = {x=17, y=37},
                unholster = {x=105, y=135}
            },
            textures = {
                "awm.png"
            },
        },
        inventory = {
            inventory_image_magless = "awm_inv_empty.png",
        },
        subclasses = {
            crosshair = Guns4d.dynamic_crosshair,
            sprite_scope = awm_scope,
        },
        firerateRPM = 60/1.1,
        hip = {
            offset = vector.new(-.22,.1,.4),
        },
        ads = {
            offset = vector.new(0,-.09,.465),
            horizontal_offset = .1,
            aim_time = .3
        },
        sway = {
            max_angle = {player_axial=1.1, gun_axial=.4},
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
        sounds = {
            fire = {
                {
                    sound = "ar_firing_far",
                    min_hear_distance = 0,
                    max_hear_distance = 600,
                    pitch = {
                        min = .95,
                        max = 1.05
                    },
                    gain = {
                        min = .9,
                        max = 1
                    },
                    attenuation_rate = .008
                },
                {
                    sound = "awm_firing",
                    max_hear_distance = 40, --far min_hear_distance is also this.
                    pitch = {
                        min = .8,
                        max = 1.05
                    },
                    gain = {
                        min = .3,
                        max = .4
                    },
                    attenuation_rate = .1
                    --split_audio_by_perspective = false,
                },
                {
                    delay = 13/24, --15 frames after start at 24 fps.
                    sound = "awm_cycling",
                    max_hear_distance = 10, --far min_hear_distance is also this.
                    pitch = {
                        min = .95,
                        max = 1.05
                    },
                    gain = .7,
                    attenuation_rate = .85
                },

            },
            rechamber = {
                sound = "awm_cycling",
                max_hear_distance = 10, --far min_hear_distance is also this.
                pitch = {
                    min = .95,
                    max = 1.05
                },
                gain = .7,
                attenuation_rate = .85
            },
        },
        recoil = {
            velocity_correction_factor = { --I dont remember what this actually does
                gun_axial = 4,
                player_axial = 3,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 5,
                player_axial = 3,
            },
            angular_velocity = {
                --gun_axial = {x=.7, y=.55},
                --player_axial = {x=2.5, y=2.5},
                gun_axial = {x=.7, y=.55},
                player_axial = {x=2, y=2.5},
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
        wag = {
            offset = {gun_axial={x=2.3,y=2.8}, player_axial={x=2,y=2}},
        },
        ammo = {
            magazine_only = true,
            accepted_bullets = {"guns4d_pack_1:338L"},
            accepted_magazines = {"guns4d_pack_1:awm_magazine"}
        },
        charging = { --how the gun "cocks"
            bolt_charge_mode = "no_catch", --"none"-chamber is always full, "catch"-when fired to dry bolt will not need to be charged after reload, "no_catch" bolt will always need to be charged after reload.
            require_charge_on_swap = true,
            draw_time = 1,
            draw_animation = "unholster",
            draw_sound = "rechamber"
        },
        reload = {
            {action="charge", time=18/24, anim="chamber", sounds = "rechamber"}, --this way if you accidentally cancel you can still cock it and your gun isnt softlocked.
            {action="unload_mag", time=.1, anim="unload", sounds = {sound="ar_mag_unload"}},
            {action="store", time=.5, anim="store", sounds = {sound="ar_mag_store"}},
            {action="load", time=.5, anim="load", sounds = {sound="ar_mag_load"}},
            {action="charge", time=18/24, anim="chamber", sounds = "rechamber"}
        },
    },
    consts = {
        DEFAULT_FPS = 24,
        ANIMATIONS_OFFSET_AIM = true,
        VERSION = {1, 3, 2}
    }
})