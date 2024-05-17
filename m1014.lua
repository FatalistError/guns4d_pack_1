minetest.register_tool("guns4d_pack_1:m1014", {
    description = "m1014 (12 gauge)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "glock21_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:m1014",
    itemstring = "guns4d_pack_1:m1014",
    properties = {
        visuals = {
            root = "main",
            mesh = "benelli_m4.b3d",
            magazine = "mag",
            textures = {
                "benelli_m4.png"
            },
            backface_culling = false,
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                unload = {x=52, y=60},
                store = {x=61, y=75},
                load = {x=76, y=120},
                charge2 = {x=120, y=141},
                draw  = {x=16, y=51},
                fire = {x=2, y=10}
            },
        },
        sounds = {
            fire = {
                {
                    sound = "glock21_firing",
                    max_hear_distance = 16, --far min_hear_distance is also this.
                    pitch = {
                        min = .8,
                        max = 1.05
                    },
                    gain = {
                        min = .8,
                        max = .9
                    }
                },
                {
                    sound = "ar_firing_far",
                    min_hear_distance = 16,
                    max_hear_distance = 600,
                    pitch = {
                        min = .95,
                        max = 1.05
                    },
                    gain = {
                        min = .9,
                        max = 1
                    }
                }
            },
        },
        firemodes = {
            "single",
        },
        crosshair = Guns4d.dynamic_crosshair,
        inventory_image_magless = "glock21_inv_empty.png",
        firerateRPM = 600,
        hip = {
            offset = vector.new(-.2,.11,.65),
        },
        ads = {
            offset = vector.new(0,0,.511),
            horizontal_offset = .1,
            aim_time = .3
        },
        sway = {
            max_angle = {player_axial=4, gun_axial=.25},
            angular_velocity = {player_axial=1, gun_axial=.3},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 1,
                player_axial = 1
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 1,
                player_axial = 1
            }
        },
        flash_offset = vector.new(0, -.10787, .878),
        recoil = {
            velocity_correction_factor = {
                gun_axial = .5,
                player_axial = .1,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 6,
                player_axial = .6,
            },
            angular_velocity_max = {
                gun_axial = 10,
                player_axial = 10,
            },
            angular_velocity = {
                gun_axial = {x=1, y=.5},
                player_axial = {x=2, y=3},
            },
            bias = {
                gun_axial = {x=1, y=0},
                player_axial = {x=.5, y=0},
            },
            target_correction_max_rate = {
                gun_axial = 10,
                player_axial = 10,
            },
        },
        walking_offset = {gun_axial={x=.1,y=-.3}, player_axial={x=1,y=1}},
        ammo = {
            magazine_only = false,
            capacity = 7,
            accepted_bullets = {"guns4d_pack_1:12G"}, --first bullet default
        },
        reload = {
            {action="charge", time=.5, anim="charge2", sounds={sound="ar_charge", delay = 0, pitch=.8}}, --this way if you accidentally cancel you can still cock it and your gun isnt softlocked.
            {action="load_cartridge", time=.6, anim="load", sounds = {sound="ar_mag_load", delay = .25}},
            {action="charge", time=.6, anim="charge2", sounds={sound="ar_charge", delay = 0, pitch=.8}}
        },
        charging = { --how the gun "cocks"
            require_charge_on_swap = true,
            bolt_charge_mode = "no_catch", --"none"-chamber is always full, "catch"-when fired to dry bolt will not need to be charged after reload, "no_catch" bolt will always need to be charged after reload.
            draw_time = 1,
        },
    },
    --[[custom_construct = function(self)
        self.offsets.screen_offset = {
            player_axial = vector.new(),
            gun_axial = vector.new(),
        }
    end,]]
    consts = {
        HAS_BREATHING = true,
    }
})