minetest.register_tool("guns4d_pack_1:m4", {
    description = "M4 carbine (5.56x45mm)",
    wield_scale = {x=.5, y=.5, z=.5},
    inventory_image = "m4_inv.png"
})
Guns4d.part_handler.register_attachment({
    itemstring = "default:steel_ingot",
    textures = {"m4.png"},
    mod = function(props)
        --props.visuals.textures[1] = "blank.png"
        --[[props.recoil.angular_velocity = {
            gun_axial = {x=0,y=0},
            player_axial = {x=0,y=0}
        }]]
        props.visuals.attached_objects.carry_handle = nil
        props.ads.offset = {x=0,y=.0035,z=.3}
        props.visuals.attached_objects.holographic_551 = {
            mesh = "holographic.obj",
            textures = {
                "holographic.png"
            },
            rotation = {x=0,y=180,z=0},
            offset = {x=0,y=.012,z=.03},
            scale = 1.2
        }
        props.subclasses["reflector_551"] = Guns4d.Reflector_sight:inherit({
            --gun = gun,
            name = "guns4d:reflector_551",
            offset = props.ads.offset.z+.012,
            scale = .15,
            texture = "holo.png",
            deviation_tolerance = {
                width = .02812*props.visuals.scale*1.2,
                height = .01953*props.visuals.scale*1.2,
                deadzone = .006
            },
        })
        local ga = props.recoil.angular_velocity.gun_axial
        local pa = props.recoil.angular_velocity.player_axial
        local x,y = ga.x, ga.y
        ga.x = x*.4
        ga.y = y*.4
        pa.x = pa.x + x*2
        pa.y = pa.y + y*1.5
    end
})
Guns4d.gun:inherit({
    name = "guns4d_pack_1:m4",
    itemstring = "guns4d_pack_1:m4",
    properties = {
        inventory = {
            render_size = 2,
            render_image = "m4_ortho.png",
            part_slots = {
                underbarrel = {
                    formspec_offset = {x=2, y=0},
                    slots = 1,
                    rail = "picatinny", --only attachments fit for this type will be usable.
                    allowed = {
                        "guns4d_pack_1:carry_handle_and_irons",
                        "default:steel_ingot"
                    },
                },
                reciever = {
                    description = "reciever mount",
                    formspec_offset = {x=-1.5, y=2.5},
                    slots = 1,
                    allowed = {
                        "guns4d_pack_1:carry_handle_and_irons",
                        "default:steel_ingot"
                    }
                },
                heatshield = {
                    description = "heatshield",
                    slots = 1,
                    formspec_offset = {x=1.8, y=1.35},
                }
            },
            inventory_image_magless = "m4_inv_empty.png",
        },
        visuals = {
            flash_offset = vector.new(0, -.11, 0),

            scale = 1.5,
            backface_culling = false,
            mesh = "m4.b3d",
            animations = {
                empty = {x=0,y=0},
                loaded = {x=1,y=1},
                unload = {x=8, y=19},
                store = {x=20, y=30},
                load = {x=31, y=50},
                draw  = {x=61, y=76},
                charge = {x=50, y=60},
                fire = {x=75, y=85}
            },
            textures = {
                "m4.png"
            },
            multi_jointed_player = {
                player_rotation_offset = 12,
                chest_offset = 35,
                leftward_strafe_limit = 60,
                roll_arm_right = 25,
                roll_arm_left = 0,
            },
            attached_objects = {
                carry_handle = {
                    mesh = "m4_carry_handle.obj",
                    textures = {
                        "m4.png"
                    },
                    rotation = {x=0,y=180,z=0}
                },
            }
        },
        subclasses = {
            crosshair = Guns4d.dynamic_crosshair,
        },
        --[[item = {
            collisionbox = ((not Guns4d.config.realistic_items) and {-.1,-.4,-.1,   .1,.05,.1}) or {-.1,-.05,-.1,   .1,.15,.1},
            selectionbox = {-.1,-.1,-.1,   .1,.1,.1}
        },]]
        sounds = {
            fire = {
                {
                    sound = "ar_firing",
                    max_hear_distance = 35, --far min_hear_distance is also this.
                    pitch = {
                        min = .8,
                        max = .9
                    },
                    gain = {
                        min = .5,
                        max = .6
                    },
                    attenuation_rate = .1
                },
                {
                    sound = "ar_firing_far",
                    min_hear_distance = 35,
                    max_hear_distance = 400,
                    split_audio_by_perspective = false,
                    pitch = {
                        min = .95,
                        max = 1.05
                    },
                    gain = {
                        min = .25,
                        max = .3
                    },
                    attenuation_rate = .03
                }
            },
            draw = {
                max_hear_distance = 8,
                sound="ar_charge",
            }
        },
        firemodes = {
            "single",
            "burst",
            "auto"
        },
        firerateRPM = 850,
        hip = {
            offset = vector.new(-.22,.1,.3),
        },
        ads = {
            offset = vector.new(0,0,.3),
            horizontal_offset = .1,
            aim_time = .6
        },
        sway = {
            max_angle = {player_axial=1, gun_axial=.25},
            angular_velocity = {player_axial=.1, gun_axial=.2},
            hipfire_velocity_multiplier = { --same as above but for velocity.
                gun_axial = 4,
                player_axial = 6
            },
            hipfire_angle_multiplier = { --same as above but for velocity.
                gun_axial = 2,
                player_axial = 1
            }
        },
        recoil = {
            velocity_correction_factor = { --velocity correction factor is currently very broken.
                gun_axial = 2,
                player_axial = 1.75,
            },
            target_correction_factor = { --angular correction rate per second: time_since_fire*target_correction_factor
                gun_axial = 5,
                player_axial = 10,
            },
            angular_velocity_max = {
                gun_axial = .2,
                player_axial = 1,
            },
            angular_velocity = {
                gun_axial = {x=.045, y=.11},
                player_axial = {x=.25, y=.25},
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
        wag = {
            offset = {gun_axial={x=.3,y=-.8}, player_axial={x=4,y=4}},
        },
        ammo = {
            magazine_only = true,
            accepted_rounds = {"guns4d_pack_1:556"},
            accepted_magazines = {"guns4d_pack_1:stanag"},
            initial_mag = "guns4d_pack_1:stanag"
        },
        reload = {
            {action="charge", time=.5, anim="charge", sounds={sound="ar_charge", delay = .2}}, --this way if you accidentally cancel you can still cock it and your gun isnt softlocked.
            {action="unload_mag", time=.25, anim="unload", sounds = {sound="ar_mag_unload"}},
            {action="store", time=.5, anim="store", sounds = {sound="ar_mag_store"}},
            {action="load", time=.5, anim="load", sounds = {sound="ar_mag_load", delay = .25}},
            {action="charge", time=.5, anim="charge", sounds={sound="ar_charge", delay = .2}}
        },
        charging = { --how the gun "cocks"
            require_charge_on_swap = true,
            bolt_charge_mode = "catch", --"none"-chamber is always full, "catch"-when fired to dry bolt will not need to be charged after reload, "no_catch" bolt will always need to be charged after reload.
            draw_time = 1,
        },
    },
    consts = {
        HAS_BREATHING = true,
        ROOT_BONE = "m4",
        VERSION = {1, 3, 0}
    }
})
