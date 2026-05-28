return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    -- ['bandage'] = {
    --     label = 'Bandage',
    --     weight = 115,
    -- },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        stack = false,
        consume = 0,
        client = {
            add = function(total)
                if total > 0 then
                    pcall(function() return exports.npwd:setPhoneDisabled(false) end)
                end
            end,

            remove = function(total)
                if total < 1 then
                    pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                end
            end
        }
    },

    ['mustard'] = {
        label = 'Mustard',
        weight = 500,
        client = {
            status = { hunger = 25000, thirst = 25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
            usetime = 2500,
            notification = 'You... drank mustard'
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
    },

    ['driver_license'] = {
        label = 'Drivers License',
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        allowArmed = true,
        consume = 0,
        client = {
            event = 'mm_radio:client:use'
        }
    },

    ['jammer'] = {
        label = 'Radio Jammer',
        weight = 10000,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:usejammer'
        }
    },

    ['radiocell'] = {
        label = 'AAA Cells',
        weight = 1000,
        stack = true,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:recharge'
        }
    },

    ['diamond_ring'] = {
        label = 'Diamond',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
    },

    ['beer'] = {
        label = 'Beer',
        weight = 200,
    },

    ['sandwich'] = {
        label = 'Sandwich',
        weight = 200,
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 200,
    },

    -- ab_medic items
        ["medical_kit"] = {
            label = "Kit Médical",
            weight = 3000,
            stack = false,
            close = true,
            description = "Pour soigner toute les blessures et réanimer quelqu'un d'inconscient.",
            consume = 0,
            client = {
                image = "medical_kit.png",
                export = 'qbx_Ab_Medic_for_PSRP.medical_kit'
            }    
        },
        ["bandage"] = {
            label = "Bandage",
            weight = 500,
            stack = true,
            close = false,
            description = "Pour soigner les petites blessures.",
            consume = 0,
            client = {
                image = "bandage.png",
                export = 'qbx_Ab_Medic_for_PSRP.bandage'
            }    
        },
        ["stethoscope"] = {
            label = "Stéthoscope",
            weight = 1000,
            stack = false,
            close = false,
            description = "Pour examiner un patient.",
            consume = 0,
            client = {
                image = "stethoscope.png",
                export = 'qbx_Ab_Medic_for_PSRP.Stéthoscope'
            }    
        },

    -- ab_weed_items
        ["os_weed"] = {
            label = "Pochon de weed",
            weight = 300,
            stack = true,
            close = false,
            consume = 0,
            client = {
                image = "weed_pochon.png",
                export = 'qbx_Ab_Weed_for_PSRP.os_weed'
            },
            buttons = {
                {
                    label = 'Rouler des joints',
                    action = function(slot)
                        --print('roule un join')
                        local paperhere = exports.ox_inventory:GetItemCount("os_rollpaper")
                        local cighere = exports.ox_inventory:GetItemCount("cigarette")
                        src = source
                        
                        --print (json.encode(paperhere))
                    
                        if paperhere > 0 then
                            --print ("paper present")
                            if cighere > 0 then 
                                --print ("cig present")
                                -- Appel au serveur pour retirer les items et ajouter un joint
                                TriggerServerEvent('qbx_Ab_Weed:craftJoin', slot)
                                --TriggerServerEvent('qbx_Ab_Garbages:server:addTrash', 'Pochon_empty')
                            else
                                --print ("cig absent")
                                exports.qbx_core:Notify("il faut une cigarette", 'error', 7000)
                            end
                        else
                            --print ("paper absent")
                            exports.qbx_core:Notify("il faut du papier à rouler", 'error', 7000)
                        end
                    end
                },
            }         
        },
        ["os_rollpaper"] = {
            label = "Papier à rouler",
            weight = 100,
            stack = true,
            close = false,
            consume = 0,
            client = {
                image = "weed_papier.png",
                export = 'qbx_Ab_Weed_for_PSRP.os_rollpaper'
            },       
        },
        ["os_joint"] = {
            label = "Joint",
            weight = 200,
            stack = true,
            close = true,
            client = {
                image = "joint.png",
                export = 'qbx_Ab_Weed_for_PSRP.os_joint'
            },       
        },
        ["cig_pack"] = {
            label = "Paquet de cigarette",
            weight = 500,
            stack = true,
            close = false,
            consume = 0,
            client = {
                image = "cig_pack.png",
                export = 'qbx_Ab_Weed_for_PSRP.cig_pack'
            },
            buttons = {
                {
                    label = 'Ouvrir le paquet',
                    action = function(slot)
                        src = source

                        TriggerServerEvent('qbx_Ab_Weed:openCigPack', slot)

                    end
                },
            }         
        },
        ['cigarette'] = {
            label = "Cigarette",
            weight = 25,
            stack = true,
            close = true,
            client = {
                image = "cigarette.png",
                export = 'qbx_Ab_Weed_for_PSRP.cigarette'
            },       
        },
        ['cigare'] = {
            label = "cigare",
            weight = 100,
            stack = true,
            close = true,
            client = {
                image = "cigare.png",
                export = 'qbx_Ab_Weed_for_PSRP.cigare'
            },       
        },
        ["water_can"] = {
            label = "Arrosoir",
            weight = 800,
            stack = false,
            close = false,
            consume = 0,
            description = "Un Arrosoir vide.",
            client = {
                image = "water_can.png",
                export = 'qbx_Ab_Weed_for_PSRP.water_can'
            },       
        },
        ["water_can_full"] = {
            label = "Arrosoir plein d'eau",
            weight = 5000,
            stack = false,
            close = false,
            consume = 0,
            description = "Un Arrosoir plein d'eau.",
            client = {
                image = "water_can_full.png",
                export = 'qbx_Ab_Weed_for_PSRP.water_can_full'
            },       
        },

    -- Abesses doc image 

        ["docimage_brochureVT"] = {
            label = "Brochure VT",
            weight = 100,
            stack = false,
            close = true,
            description = "La brochure du Vinewood Tour",
            consume = 0,
            client = {
                image = "paperprint.png",
                export = 'qbx_Ab_ImagesDoc.docimage_brochureVT'
            }        
        },

}
