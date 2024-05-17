minetest.register_tool("guns4d_pack_1:glock21", {
    description = "Glock (.45 ACP)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "glock21_inv.png"
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:glock21",
    itemstring = "guns4d_pack_1:glock21",
    properties = {
        visuals = {
            root = "glock21",
            mesh = "glock21.b3d",
            magazine = "mag",
            textures = {
                "glock21.png"
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
                fire = {x=1, y=14}
            },
        },
        sounds = {
            fire = {
                {
                    sound = "glock21_firing",
                    max_hear_distance = 25, --far min_hear_distance is also this.
                    pitch = {
                        min = .8,
                        max = 1.05
                    },
                    gain = {
                        min = .9,
                        max = 1
                    },
                    attenuation_rate = .004
                },
                {
                    sound = "ar_firing_far",
                    min_hear_distance = 25,
                    max_hear_distance = 250,
                    pitch = {
                        min = 1.1,
                        max = 1.2
                    },
                    gain = {
                        min = .35,
                        max = .4
                    },
                    attenuation_rate = .04
                }
            },
            charge = {sound="ar_charge", delay = 0, pitch=.8, max_hear_distance=8}
        },
        firemodes = {
            "single",
        },
        crosshair = Guns4d.dynamic_crosshair,
        inventory_image_magless = "glock21_inv_empty.png",
        firerateRPM = 1000,
        hip = {
            offset = vector.new(-.22,.1,.3),
        },
        ads = {
            offset = vector.new(0,0,.25),
            horizontal_offset = .1,
            aim_time = .3
        },
        sway = {
            max_angle = {player_axial=2, gun_axial=.35},
            angular_velocity = {player_axial=.6, gun_axial=.6},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 2,
                player_axial = 2
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 2,
                player_axial = 1
            }
        },
        flash_offset = vector.new(0, -.10787, .878),
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
                gun_axial = {x=.7, y=.8},
                player_axial = {x=.8, y=.8},
            },
            bias = {
                gun_axial = {x=.15, y=0},
                player_axial = {x=.6, y=0},
            },
            target_correction_max_rate = { --the cap for time_since_fire*target_correction_factor
                gun_axial = 40,
                player_axial = 40,
            },
        },
        walking_offset = {gun_axial={x=.1,y=-.3}, player_axial={x=1,y=1}},
        ammo = {
            magazine_only = true,
            accepted_bullets = {"guns4d_pack_1:45A"}, --first bullet default
            accepted_magazines = {"guns4d_pack_1:45mm_magazine_13"} --first magazine will be default
        },
        reload = {
            {action="charge", time=.5, anim="charge2", sounds="charge"}, --this way if you accidentally cancel you can still cock it and your gun isnt softlocked.
            {action="unload_mag", time=.3, anim="unload", sounds = {sound="ar_mag_unload"}},
            {action="store", time=.2, anim="store", sounds = {sound="ar_mag_store"}},
            {action="load", time=.6, anim="load", sounds = {sound="ar_mag_load", delay = .25}},
            {action="charge", time=.6, anim="charge2", sounds="charge"}
        },
        charging = { --how the gun "cocks"
            require_charge_on_swap = true,
            bolt_charge_mode = "catch", --"none"-chamber is always full, "catch"-when fired to dry bolt will not need to be charged after reload, "no_catch" bolt will always need to be charged after reload.
            draw_time = .8,
            draw_sound = "charge"
        },
    },
    --[[custom_construct = function(self)
        self.offsets.screen_offset = {
            player_axial = vector.new(),
            gun_axial = vector.new(),
        }
    end,]]
})
--[[local old_update = glock.update
glock.update = function(self, dt)
    if self.handler and self.handler.control_handler.ads then
        self.offsets.screen_offset.player_axial.x = -4*self.handler.ads_location
    else
        self.offsets.screen_offset.player_axial.x = 0
    end
    old_update(self,dt)
end]]