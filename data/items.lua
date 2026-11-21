return {

    -- Currency

    ["casinochips"] = {
        label = "Casino Chips",
        weight = 0,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 1000000,
        description = "Chips used for casino table games",
    },

    ["money"] = {
        label = "Money",
        description = "Cash used for purchases.",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 999999999,
    },

    ["black_money"] = {
        label = "Dirty Money",
        description = "Illegally obtained cash.",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 100000,
    },

    -- IDs & Licenses

    ["id_card"] = {
        label = "ID Card",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "Identity card needed to identify yourself",
    },

    ["license_driver"] = {
        label = "Driver License",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "Needed to drive a vehicle",
    },

    ["license_weapon"] = {
        label = "Weapon License",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "Needed to buy a weapon",
    },

    ["license_lawyer"] = {
        label = "Lawyer Pass",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "Identifies a licensed lawyer",
    },

    ["license_pilot"] = {
        label = "Pilot License",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "Needed to fly an aircraft",
    },

    ["license_hunting"] = {
        label = "Hunting License",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "License to legally hunt wildlife",
    },

    ["police_badge"] = {
        label = "Police Badge",
        weight = 100,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "Official law enforcement badge.",
        server = {
            export = "rm-smallresources.useBadge",
        },
    },

    ["ems_badge"] = {
        label = "LSMC Badge",
        weight = 100,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "Official Los Santos Medical Center badge.",
        server = {
            export = "rm-smallresources.useBadge",
        },
    },

    ["gov_badge"] = {
        label = "Government Badge",
        weight = 100,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "Official City of Los Santos government badge.",
        server = {
            export = "rm-smallresources.useBadge",
        },
    },

    ["license_fishing"] = {
        label = "Fishing License",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        description = "License to legally fish in designated areas",
    },

    -- Documents & Papers

    ["chopshop_contract"] = {
        label = "Chopshop Contract",
        description = "",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        client = {
            image = "fleeca_employee_document.png",
        }
    },

    ["chop_tire"] = {
        label = "Chopped Tire",
        description = "A tire removed from a chopped vehicle.",
        weight = 2250,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 8,
        close = true,
    },

    ["chop_door"] = {
        label = "Chopped Door",
        description = "A vehicle door stripped for parts.",
        weight = 4000,
        width = 2,
        height = 2,
        stack = true,
        stackSize = 6,
        close = true,
    },

    ["chop_hood"] = {
        label = "Chopped Hood",
        description = "A bonnet removed from a chopped vehicle.",
        weight = 4500,
        width = 2,
        height = 2,
        stack = true,
        stackSize = 4,
        close = true,
    },

    ["chop_trunk"] = {
        label = "Chopped Trunk",
        description = "A trunk lid removed from a chopped vehicle.",
        weight = 4500,
        width = 2,
        height = 1,
        stack = true,
        stackSize = 4,
        close = true,
    },

    ["document"] = {
        label = "Document",
        description = "A written official record.",
        weight = 0,
        width = 1,
        height = 1,
        stack = true, -- copies of one print stack (same printId metadata); different documents never do
        close = true,
        client = {
            image = "document.png",
            export = "rm-phone.useDocument", -- printed page from the laptop Documents app
        },
    },

    ["rental_papers"] = {
        label = "Rental Papers",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Documents given renting a vehicle",
    },

    ["vehicle_mods_order"] = {
        label = "Mechanic Order",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "A mechanic work order for vehicle upgrades.",
        client = {
            export = "rm-customs.useModsOrder",
        },
    },

    ["fleeca_employee_document"] = {
        label = "Fleeca Employee Document",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = true,
    },

    ["store_safe_note"] = {
        label = "Safe Code Note",
        weight = 10,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "A scribbled note with a store's safe combination.",
        client = {
            image = "fleeca_employee_document.png",
        }
    },

    ["jewelry_document"] = {
        label = "Jewelry Store Document",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        client = {
            image = "fleeca_employee_document.png",
        }
    },

    -- Gang Economy

    ["gang_coins"] = {
        label = "Gang Coins",
        description = "Pooled currency deposited toward the gang's next level.",
        weight = 0,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 500,
        close = true,
    },

    -- Jewelry

    ["goldbar"] = {
        label = "Gold Bar",
        description = "A solid bar of refined gold.",
        weight = 1000,
        width = 2,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["earring_gold"] = {
        label = "Gold Earring",
        description = "A gold earring.",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["diamond_necklace"] = {
        label = "Diamond Necklace",
        description = "A necklace set with diamonds.",
        weight = 40,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["diamond"] = {
        label = "Cut Diamond",
        description = "A loose, flawless cut diamond in a Humane Labs evidence case.",
        weight = 20,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["humane_painting"] = {
        label = "Rolled Canvas",
        description = "An old master, cut from its frame and rolled up. Someone will pay well and ask nothing.",
        weight = 800,
        width = 2,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
    },

    ["goldchain"] = {
        label = "Gold Chain",
        description = "A gold chain.",
        weight = 45,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["silverchain"] = {
        label = "Silver Chain",
        description = "A silver chain.",
        weight = 35,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["sapphire_necklace"] = {
        label = "Sapphire Necklace",
        description = "A necklace set with sapphires.",
        weight = 40,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    -- Metal detector finds (prospecting) - low/mid-value pawnshop junk,
    -- kept separate from the heist-grade jewelry above so a casual detector
    -- find never pays out like a jewelry-store score.

    ["old_coin"] = {
        label = "Old Coin",
        description = "A weathered coin dug up from the dirt.",
        weight = 5,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 30,
    },

    ["pocket_watch"] = {
        label = "Pocket Watch",
        description = "A tarnished pocket watch. Still ticking.",
        weight = 20,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["tarnished_ring"] = {
        label = "Tarnished Ring",
        description = "An old ring, worn but worth something to the right buyer.",
        weight = 10,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["antique_relic"] = {
        label = "Antique Relic",
        description = "A rare relic from a bygone era.",
        weight = 60,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
    },

    ["ruby_necklace"] = {
        label = "Ruby Necklace",
        description = "A necklace set with rubies.",
        weight = 40,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ----

    ["paleto_document"] = {
        label = "Paleto Security Document",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        client = {
            image = "fleeca_employee_document.png",
        }
    },

    ["rig_manifest"] = {
        label = "Rig Supply Manifest",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Supply manifest of an offshore rig: tanks full, payroll on board. The way in.",
        client = {
            image = "fleeca_employee_document.png",
        }
    },

    -- Food

    ['chicken_taco'] = {
        label = 'Chicken Taco',
        weight = 220,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A warm chicken taco.',
    },

    ['club_sandwich'] = {
        label = 'Club Sandwich',
        weight = 280,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A stacked club sandwich.',
    },

    ['chocolate_muffin'] = {
        label = 'Chocolate Muffin',
        weight = 220,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A sweet chocolate muffin.',
    },

    -- Drinks

    ['strite_can'] = {
        label = 'Strite Can',
        weight = 350,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A cold can of Strite.',
    },

    ['mocha_large'] = {
        label = 'Mocha Large',
        weight = 350,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A large mocha.',
    },

    ["water_bottle"] = {
        label = 'Water Bottle',
        weight = 550,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A bottle of water.',
    },

    -- Alcohol

    ['bootbeer_can'] = {
        label = 'Boot Beer Can',
        weight = 350,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A can of Boot Beer.',
    },

    ['vodka'] = {
        label = 'Russian Vodka',
        weight = 700,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = 'A bottle of strong vodka.',
    },

    -- Medical & Usables

    ['stress_pills'] = {
        label = 'Calmex Stress Pills',
        description = 'A dose of Calmex tablets to help take the edge off.',
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        consume = 1,
        client = {
            image = 'stress_pills.png',
            label = 'Taking stress pills...',
            usetime = 3000,
            cancel = true,
            anim = { dict = 'mp_suicide', clip = 'pill', flag = 48 }, -- upper body, non-looping
            disable = { move = true, car = true, combat = true },
        },
        server = { export = 'rm-medical.useStressPills' },
    },

    ['magnesium'] = {
        label = 'Magnesium',
        description = 'Magnesium tablets from the pharmacy. Takes all your stress away, but you feel heavy and sleepy for a bit.',
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        consume = 1,
        client = {
            image = 'magnesium.png',
            label = 'Taking magnesium...',
            usetime = 3000,
            cancel = true,
            anim = { dict = 'mp_suicide', clip = 'pill', flag = 48 },
            disable = { move = true, car = true, combat = true },
        },
        server = { export = 'rm-medical.useMagnesium' },
    },

    ["bandage"] = {
        label = "Bandage",
        description = "Used to treat minor wounds.",
        width = 1,
        height = 1,
        stackSize = 15,
        weight = 80,
        consume = 0,
        client = {
            export = 'rm-medical.useHealItemExport',
        },
    },

    ["firstaid"] = {
        label = "First Aid",
        weight = 700,
        stack = true,
        close = true,
        width = 1,
        height = 1,
        stackSize = 15,
        description = "",
        consume = 0,
        client = {
            image = "firstaid.png",
            export = 'rm-medical.useHealItemExport',
        },
    },

    -- EMS treatment supplies (rm-medical patient assessment, not self-use)
    ["gauze"] = {
        label = "Gauze",
        description = "Packs deep cuts and heavy torso bleeding.",
        weight = 50,
        stack = true,
        close = true,
        stackSize = 20,
    },

    ["tourniquet"] = {
        label = "Tourniquet",
        description = "Stops heavy bleeding on an arm or leg.",
        weight = 150,
        stack = true,
        close = true,
        stackSize = 10,
    },

    ["splint"] = {
        label = "Splint",
        description = "Immobilises a broken arm or leg.",
        weight = 400,
        stack = true,
        close = true,
        stackSize = 10,
    },

    ["suture_kit"] = {
        label = "Suture Kit",
        description = "Closes gunshot wounds once the bleeding is under control.",
        weight = 250,
        stack = true,
        close = true,
        stackSize = 10,
    },

    ["oxy"] = {
        label = "Oxy",
        weight = 15,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Oxy is a medication used to relieve pain and discomfort, often used in medical settings.",
        client = {
            export = "rm-drugs.useDrug", -- slow heal (rm-illegal drugsystem/config/effects.lua -> oxy)
        },
    },

    -- gaymish indes removed pagiadma nav bilde utt

    -- ["sigma_pseudo"] = {
    --     weight = 0,
    --     width = 1,
    --     height = 1,
    --     stackSize = 15,
    --     label = "Sigma Pseudo",
    --     weight = 120,
    --     metadata = {
    --    --     },
    --     stack = true,
    --     consume = 1,
    --     close = true,
    --     description = "An unstable synthetic narcotic with dangerous delayed toxicity.",
    --     client = {
    --         event = "troll:client:SigmaPseudo",
    --         anim = {
    --             dict = "mp_suicide",
    --             clip = "pill",
    --             flag = 49,
    --         },
    --         disable = { move = false, car = false, combat = true },
    --         usetime = 3000,
    --     },
    -- },

    -- ["antidote"] = {
    --     label = "Poison Antidote",
    --     weight = 20,
    --     width = 1,
    --     height = 1,
    --     stackSize = 15,
    --     metadata = {
    --    --     },
    --     stack = true,
    --     consume = 1,
    --     close = true,
    --     description = "Emergency antidote that counters synthetic narcotic toxicity and visual effects.",
    --     client = {
    --         event = "troll:client:Antidote",
    --         anim = {
    --             dict = "mp_suicide",
    --             clip = "pill",
    --             flag = 49,
    --         },
    --         disable = { move = false, car = false, combat = true },
    --         usetime = 3000,
    --     },
    -- },

    ["adrenaline"] = {
        label = "Adrenaline Shot",
        weight = 30,
        width = 1,
        height = 1,
        stackSize = 15,
        consume = 0,
        stack = true,
        close = true,
        description = "For a friend in need.",
        client = { image = "adrenaline.png" },
    },


    ["wheelchair"] = {
        label = "Wheelchair",
        weight = 12000,
        width = 2,
        height = 3,
        stack = false,
        close = true,
        description = "Folded hospital wheelchair. Use it to unfold it in front of you, anyone can sit in and drive it. Fold it back with the target.",
        client = {
            export = "rm-medical.useWheelchair",
        },
    },

    ["walking_stick"] = {
        label = "Walking Stick",
        weight = 800,
        width = 1,
        height = 3,
        stack = false,
        close = true,
        description = "Hospital walking stick. Use it to walk with it, use it again to put it away.",
        client = {
            export = "rm-medical.useWalkingStick",
        },
    },

    ["darkgreen_stim"] = {
        label = "HL-MB4-62",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "HumaneLabs Metabolism-62 (Un-Common). Locks hunger drain and tops up below 20%. Blocks sprint.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["aqua_stim"] = {
        label = "M-DO3-TS",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Military Dolphin stimulant (Rare). Faster/longer swimming. Slows running on land.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["lightred_stim"] = {
        label = "M-PO1-TS",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description =
        "Military POWER stimulant (Common). Punch strength and stamina. Light body degeneration while active.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["green_stim"] = {
        label = "HL-BR2-TS",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "HumaneLabs BodyRegeneration (Rare). +1 HP/sec. Cannot run properly while regenerating.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["purple_stim"] = {
        label = "M-RC1-32",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Military RecoilControl-32 (Rare). Recoil x0.65. Aftershock recoil x1.25 for 20 min.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["pink_stim"] = {
        label = "HL-SR6-73",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "HumaneLabs SuperRacer-73 (Un-Common). Driving traction x1.15. Delayed blurry vision after.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["yellow_stim"] = {
        label = "M-SS9",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Military SuperSoldier-9 (Un-Common). Sprint speed x1.115 and stamina x1.15 for 2.5 min. Aching legs block sprinting after.",
        client = {
            export = "rm-medical.useStim",
        },
    },

    ["cosmetics"] = {
        label = "Cosmetic Kit",
        weight = 300,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A kit for all kind of cosmetics for vehicles.",
    },

    ['lightarmor'] = {
        label = 'Light Armor',
        weight = 3000,
        width = 2,
        height = 2,
        stackSize = 5,
        stack = true,
        close = true,
        description = 'Light ballistic vest. Restores some armor.',
        client = {
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d',
                flag = 49,
            },
            usetime = 3500,
            cancel = true,
            disable = { combat = true, move = false, car = false, steer = true },
        },
    },

    ['heavyarmor'] = {
        label = 'Heavy Armor',
        weight = 6000,
        width = 2,
        height = 2,
        stackSize = 5,
        stack = true,
        close = true,
        description = 'Heavy ballistic vest. Restores 75% armor.',
        client = {
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d',
                flag = 49,
            },
            usetime = 5500,
            cancel = true,
            disable = { combat = true, move = false, car = false, steer = true },
        },
    },

    ['armor'] = {
        label = '[PD] Body Armor',
        weight = 5000,
        width = 2,
        height = 2,
        stackSize = 5,
        stack = true,
        close = true,
        description = 'Police body armor. Restores full armor.',
        client = {
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d',
                flag = 49,
            },
            usetime = 4000,
            cancel = true,
            disable = { combat = true, move = false, car = false, steer = true },
        },
    },

    ["yogamat_pro"] = {
        label = "ProLaps Yoga Mat",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "A Limited Edition ProLaps Yogamat.",
        client = {
            image = "yogamat_pro.png",
        }
    },

    ["yogamat_blue"] = {
        label = "Blue Yoga Mat",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Did somebody say Yoga?",
        client = {
            image = "yogamat_blue.png",
        }
    },

    ["yogamat_black"] = {
        label = "Black Yoga Mat",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Did somebody say Yoga?",
        client = {
            image = "yogamat_black.png",
        }
    },

    ["yogamat_red"] = {
        label = "Red Yoga Mat",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Did somebody say Yoga?",
        client = {
            image = "yogamat_red.png",
        }
    },

    -- Drugs

    ["ammonia"] = {
        label = "Ammonia",
        description = "Chemical used for drug production.",
        weight = 500,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["sodium_benzoate"] = {
        label = "Sodium benzoate",
        description = "Chemical used for drug production.",
        weight = 200,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["meth_tray"] = {
        label = "Meth tray",
        description = "An illegal processed substance.",
        weight = 300,
        width = 2,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["fuel_pump"] = {
        label = "Fuel Pump",
        description = "Stripped from a chopped car. Drain it at the fuel extraction spot to get Fuel Extract.",
        weight = 3000,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useAtStation", -- works at the meth extraction station (rm-illegal/drugsystem/client/stations.lua)
        },
    },

    ["fuel_extract"] = {
        label = "Fuel Extract",
        description = "Chemical drained from a fuel pump. Cook it with a Lithium Battery at the meth lab.",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["meth_solution"] = {
        label = "Meth Solution",
        description = "Cooked meth, still liquid. Finish it with Acid Solution to break it into crystal.",
        weight = 400,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["acid_solution"] = {
        label = "Acid Solution",
        description = "Chemical used to finish meth into crystal.",
        weight = 400,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["meth"] = {
        label = "Meth",
        description = "Meth crystal. Bag it with a Plastic Bag at a bagging station.",
        weight = 250,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["meth_bag"] = {
        label = "Bag of Meth",
        description = "Use it or sell it - walk up to a local and pick \"Sell drugs\".",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useDrug",
        },
    },

    ["plastic_bag"] = {
        label = "Plastic Bag",
        description = "Used at bagging stations to package drugs for selling.",
        weight = 10,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["coke_seed"] = {
        label = "Coca Seed",
        description = "Use it to plant a coca bush in the ground. Needs Fertilizer and a Water Bottle.",
        weight = 5,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useSeed", -- starts pot placement + planting scene (rm-illegal/drugsystem/client/planting.lua)
        },
    },

    ["coke_leaf"] = {
        label = "Coca Leaf",
        description = "Soak the leaves with a Petrol Can at a Soak Barrel to make Coca Paste.",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["petrol_can"] = {
        label = "Petrol Can",
        description = "Used at the Soak Barrel to break coca leaves down into paste.",
        weight = 4000,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["coke_paste"] = {
        label = "Coca Paste",
        description = "Refine it at a Refining Station to get Cocaine.",
        weight = 200,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["coke"] = {
        label = "Cocaine",
        description = "Pure cocaine. Bag it or press it into a brick at a processing station.",
        weight = 250,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["coke_bag"] = {
        label = "Bag of Coke",
        description = "Use it or sell it - walk up to a local and pick \"Sell drugs\".",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useDrug",
        },
    },

    ["coke_brick"] = {
        label = "Coke Brick",
        description = "Pressed cocaine. Use it with 3 plastic bags to break it into 3 bags of coke.",
        weight = 1000,
        width = 2,
        height = 1,
        stackSize = 15,
        stack = true,
        client = {
            export = 'rm-drugs.breakBrick',
        },
    },

    ["weed_seed"] = {
        label = "OG Kush Seed",
        description = "Use it to plant OG Kush. Needs a Flower Pot, Fertilizer and a Water Bottle.",
        weight = 2,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useSeed", -- starts pot placement + planting scene (rm-illegal/drugsystem/client/planting.lua)
        },
    },


    ["weed_pot"] = {
        label = "Flower Pot",
        description = "Use it to plant a seed. You also need Fertilizer and a Water Bottle on you.",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.usePot", -- pick a seed, place the pot, pour fertilizer/seeds/water
        },
    },

    ["trowel"] = {
        label = "Trowel",
        description = "Small tool for gardening.",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
    },

    ["weed_bud"] = {
        label = "OG Kush Bud",
        description = "Fresh OG Kush. Bag it with a Plastic Bag or press it into a brick at a processing station.",
        weight = 15,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["weed_brick"] = {
        label = "OG Kush Brick",
        description = "Pressed OG Kush. Use it with 6 plastic bags to break it into 6 bags of weed.",
        weight = 450,
        width = 2,
        height = 1,
        stackSize = 15,
        stack = true,
        client = {
            export = 'rm-drugs.breakBrick',
        },
    },

    ["grow_tent"] = {
        label = "Grow Tent",
        description = "Portable grow tent with a violet LED light. Plants inside grow faster.",
        weight = 8000,
        width = 2,
        height = 2,
        stackSize = 2,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.usePlaceTent", -- aim & place it, then target it -> Plant inside
        },
    },

    ["packing_table"] = {
        label = "Packing Table",
        description = "Folding work table with a scale and tray. Place it to bag drugs and roll joints.",
        weight = 15000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        client = {
            image = "packing_table.png",
            export = "rm-drugs.usePlaceTable", -- aim & place it, then target it to bag / pack up
        },
    },

    ["shroom_tub"] = {
        label = "Mushroom Grow Tub",
        description = "Plastic tub to grow mushrooms in. Needs spores, substrate and water.",
        weight = 1500,
        width = 2,
        height = 1,
        stackSize = 4,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.usePot", -- place the tub, then pour substrate / spray spores / mist
        },
    },

    ["shroom_spores"] = {
        label = "Golden Teacher Spores",
        description = "A spore syringe. Grows magic mushrooms in a grow tub.",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useSeed",
        },
    },

    ["shroom_substrate"] = {
        label = "Mushroom Substrate",
        description = "Sterilised grain and coco coir. Food for mushrooms.",
        weight = 800,
        width = 1,
        height = 1,
        stackSize = 10,
        stack = true,
    },

    ["shroom"] = {
        label = "Magic Mushroom",
        description = "Freshly picked. Dry them at a Drying Rack before bagging.",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 50,
        stack = true,
    },

    ["shroom_dried"] = {
        label = "Dried Mushrooms",
        description = "Dried magic mushrooms. Bag them with a Plastic Bag at a bagging station.",
        weight = 10,
        width = 1,
        height = 1,
        stackSize = 50,
        stack = true,
    },

    ["shroom_bag"] = {
        label = "Bag of Shrooms",
        description = "Use it or sell it - walk up to a local and pick \"Sell drugs\".",
        weight = 30,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useDrug",
        },
    },



    ["cookie_dough"] = {
        label = "Cookie dough",
        description = "Useful cookie dough.",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["weed_bag"] = {
        label = "Bag of Weed",
        description = "Ready to sell. Walk up to a local and pick \"Sell drugs\".",
        weight = 15,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["weed_papers"] = {
        label = "Weed papers",
        description = "An illegal processed substance.",
        weight = 5,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["syringe"] = {
        label = "Syringe",
        description = "Useful syringe.",
        weight = 30,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["ergot_fungus"] = {
        label = "Ergot fungus",
        description = "Chemical used for drug production.",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["safrole_oil"] = {
        label = "Safrole oil",
        description = "Chemical used for drug production.",
        weight = 400,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["chocolate_chips"] = {
        label = "Chocolate chips",
        description = "Useful chocolate chips.",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["crack_bag"] = {
        label = "Crack bag",
        description = "A packaged illegal substance.",
        weight = 15,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["pipe"] = {
        label = "Pipe",
        description = "Useful pipe.",
        weight = 100,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["npp_chemical"] = {
        label = "NPP chemical",
        description = "Chemical used for drug production.",
        weight = 300,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["aniline_solution"] = {
        label = "Aniline solution",
        description = "Chemical used for drug production.",
        weight = 400,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["fentanyl_bag"] = {
        label = "Fentanyl bag",
        description = "A packaged illegal substance.",
        weight = 10,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["light1"] = {
        label = "Portable Lamp",
        description = "Portable light source.",
        weight = 300,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["light2"] = {
        label = "Portable Lamp",
        description = "Portable light source.",
        weight = 300,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["fertilizer"] = {
        label = "Fertilizer",
        description = "Plant food. Add it to a growing plant to make it grow faster.",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["water_can"] = {
        label = "Watering can",
        description = "Used for watering plants.",
        weight = 1500,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["joint"] = {
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        label = "Joint",
        description = "Rolled cannabis cigarette.",
        weight = 2,
        stack = true,
        close = true,
        client = {
            export = "rm-drugs.useDrug",
        },
    },

    ["cigarette"] = {
        label = "Cigarette",
        weight = 5,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A cigarette to help you relax. Requires a lighter.",
        client = {
            export = "rm-hud.useCigarette",
        },
    },

    ["lighter"] = {
        label = "Lighter",
        weight = 30,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Used to light cigarettes.",
        client = {
            export = "rm-hud.useLighter",
        },
    },

    ["snus"] = {
        label = "Snus",
        weight = 50, -- a full tin (was 15)
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0.2, -- 5 uses (20% durability each)
        description = "A snus to help you relax. Good for about 5 uses.",
        client = {
            export = "rm-hud.useSnus",
        },
    },

    ["hydrogen_peroxide"] = {
        label = "Hydrogen Peroxide",
        description = "Chemical used for drug production.",
        weight = 400,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    -- Electronics

    ["phone"] = {
        label = "Phone",
        description = "Portable communication device.",
        weight = 180,
        width = 1,
        height = 1,
        stackSize = 15,
        allowArmed = true,
        client = {
            image = "phone.png",
            export = "rm-phone.usePhone",
        },
        server = {
            export = "rm-phone.usePhone",
        },
        consume = 0,
        stack = false,
    },

    ["radio"] = {
        label = "Radio",
        weight = 250,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "Portable radio.",
        model = "prop_cs_hand_radio", -- this for model
        client = {
            event = "mm_radio:client:use", -- this server runs mm_radio (atleastv4 had the radio inside pma-voice)
        },
    },

    ["burner_phone"] = {
        label = "Burner phone",
        description = "A useful electronic device.",
        weight = 150,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
    },

    ["megaphone"] = {
        label = "Megaphone",
        height = 1,
        width = 2,
        weight = 800,
        stack = false,
        close = true,
        description = "A usable megaphone",
        client = {
            export = "rm-smallresources.useMegaphone",
        },
    },

    ["magic_wand"] = {
        label = "Magic Wand",
        weight = 150,
        width = 1,
        height = 2,
        stack = false,
        close = true,
        description = "Carved wand with a glowing crystal. Use it to take it out, then open your spellbook (J).",
        client = {
            image = "magic_wand.png",
            export = "rm-smallresources.useWand",
        },
    },

    ["circuit_board"] = {
        label = "Circuit Board",
        weight = 80,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Electronic circuit board.",
    },

    ["lithium_battery"] = {
        label = "Lithium Battery",
        weight = 100,
        width = 2,
        height = 2,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Needed to cook meth.",
    },

    ["electronickit"] = { -- 5 uses: rm-heists RemovePlayerItem wears it down (metadata.durability)
        label = "Electronic Kit",
        weight = 0,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "An electronic kit for hacking systems. Good for 5 jobs.",
    },

    ["blackhat_toolkit"] = { -- bankomats tik tgd mosh vel kkur
        label = "BlackHat Toolkit",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A portable device used for hacking systems.",
    },

    ["card_gruppe6"] = {
        label = "Gruppe6 Card",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
        description = "Fleet tracker dongle keyed to Gruppe Sechs jogger routes.",
    },
    ["card_humanlabs"] = {
        label = "Humane Labs Card",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
        description = "Stolen routing key for Humane Labs cargo vans.",
    },
    ["card_digitalden"] = {
        label = "Digital Den Card",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
        description = "Tracker firmware for Digital Den delivery joggers.",
    },
    ["card_bobcat"] = {
        label = "Bobcat Card",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
        description = "Encrypted Bobcat security convoy locator.",
    },
    ["card_freight"] = {
        label = "Freight Rail Card",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        close = true,
        description = "Rail network access card. Use it at a fleet terminal to find a parked freight train carrying locked containers.",
    },

    ["shadowlink_adapter"] = {
        label = "ShadowLink Adapter",
        weight = 60,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "An advanced adapter for secure connections.",
    },

    ["omnihack_core"] = {
        label = "OmniHack Core",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 5,
        durability = 100,
        stack = true,
        close = true,
        description = "A powerful core module for hacking operations.",
    },

    ["usb_damaged"] = {
        label = "Usb (Damaged)",
        weight = 15,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A universal usb device for data transfer.",
    },

    ["vrs"] = {
        label = "VRS",
        weight = 200,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "An advanced relay tool designed to spoof secure authorization checks.",
    },

    ["level_zero"] = {
        label = "Keycard Level 0",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 0 security areas.",
    },

    ["level_one"] = {
        label = "Keycard Level 1",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 1 security areas.",
    },

    ["level_two"] = {
        label = "Keycard Level 2",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 2 security areas.",
    },

    ["level_three"] = {
        label = "Keycard Level 3",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 3 security areas.",
    },

    ["level_four"] = {
        label = "Keycard Level 4",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 4 security areas.",
    },

    ["level_five"] = {
        label = "Keycard Level 5",
        weight = 0,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Access card for level 5 security areas.",
    },

    ["laptop"] = {
        stackSize = 15,
        label = "Facade Laptop",
        description = "A high-tech gadget that is always up to something",
        weight = 1200,
        width = 2,
        height = 1,
        stack = false,
        close = false,
        consume = 0,
        client = {
            image = "laptop.png",
        },
        server = {
            export = "rm-laptop.useLaptop",
        },
        buttons = {
            {
                label = "Open storage",
                action = function(slot)
                    TriggerServerEvent("ox_inventory:openItemStorage", slot, "laptop")
                end,
            },
        },
    },

    ["metal_detector"] = {
        weight = 0,
        label = "Metal Detector",
        description = "A device used to detect metal objects underground.",
        durability = 0.01,
        weight = 500,
        width = 1,
        height = 3,
        stackSize = 15,
        stack = true,
        close = true,
    },

    ["gps_device"] = {
        label = "GPS Device",
        weight = 150,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "A GPS Device that allows to view the map at all times",
    },

    ["empbomb"] = {
        label = "EMP Bomb",
        description = "Disables nearby electronic systems.",
        weight = 800,
        width = 1,
        height = 2,
        durability = 100,
        stack = false,
        close = true,
        consume = 0,
        client = { export = "rm-smallresources.useEmpBomb" },
    },

    ["car_battery"] = {
        label = "Car Battery",
        weight = 14000,
        width = 2,
        height = 3,
        stack = false,
        description = "A car battery, can be charged with stolen electricity. Sell it to the electricity fence.",
    },

    ["hacking_device"] = {
        label = "Hacking Device",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Used to bypass windmill security while stealing electricity",
    },

    ["electronic_components"] = {
        label = "Electronic Components",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Circuit boards and wiring, used to repair electrical equipment",
    },

    ["shadow_module"] = {
        label = "Shadow Module",
        weight = 30,
        width = 1,
        height = 1,
        stack = false,
        description = "Install in a radio's storage to stay hidden from channel member lists.",
    },

    ["wires"] = {
        label = "Wires",
        weight = 100,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Copper wiring for radios, batteries and electronics.",
    },

    ["electronic_parts"] = {
        label = "Electronic Parts",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Salvaged components for advanced electronic crafting.",
    },

    ["battery_cells"] = {
        label = "Battery Cells",
        weight = 100,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Salvaged cells for radios, batteries and tasers.",
    },

    ["copper_coil"] = {
        label = "Copper Coil",
        weight = 200,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Wound copper coil for motors and advanced electronics.",
        client = { image = "copper_coil.png" },
    },

    ["taser_cartridge"] = {
        label = "Taser Cartridge",
        weight = 50,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Replacement cartridge for a stun gun.",
    },

    ["laptop_usb_a"] = {
        label = "Laptop USB-A",
        weight = 15,
        width = 1,
        height = 1,
        description = "A USB drive that unlocks the Racing app",
        stack = false,
        close = false,
        consume = 0,
    },

    ["laptop_usb_b"] = {
        label = "Laptop USB-B",
        weight = 15,
        width = 1,
        height = 1,
        description = "A USB drive that unlocks the Black Market app",
        stack = false,
        close = false,
        consume = 0,
    },

    ["laptop_usb_c"] = {
        label = "Laptop USB-C",
        weight = 15,
        width = 1,
        height = 1,
        description = "A USB drive that unlocks the boosting app",
        stack = false,
        close = false,
        consume = 0,
    },

    ["gpu_950"] = {
        label = "GPU 950",
        weight = 900,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A graphics card used for cryptocurrency mining.",
        client = {
            image = "gpu_950.png",
        },
    },

    ["gpu_1050"] = {
        label = "GPU 1050",
        weight = 900,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A graphics card used for cryptocurrency mining.",
        client = {
            image = "gpu_1050.png",
        },
    },

    ["gpu_2080"] = {
        label = "GPU 2080",
        weight = 1200,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A graphics card used for cryptocurrency mining.",
        client = {
            image = "gpu_2080.png",
        },
    },

    ["gpu_5090"] = {
        label = "GPU 5090",
        weight = 1500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A graphics card used for cryptocurrency mining.",
        client = {
            image = "gpu_5090.png",
        },
    },

    ["thermal_paste"] = {
        label = "Thermal Paste",
        weight = 30,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A substance used to improve heat transfer between a CPU/GPU and its heatsink.",
        client = {
            image = "thermal_paste.png",
        },
    },

    ["powersupply"] = {
        label = "Power Supply",
        weight = 1500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A power supply unit for a mining rig.",
        client = {
            image = "powersupply.png",
        },
    },

    ["mining_motherboard"] = {
        label = "Mining Motherboard",
        weight = 1200,
        width = 2,
        height = 2,
        stackSize = 10,
        stack = true,
        close = true,
        description = "Mining motherboard with CPU, memory and ten GPU riser sockets. Required to run a mining rig.",
        client = { image = "mining_motherboard.png" },
    },

    ["mining_rig"] = {
        label = "Mining Rig",
        weight = 8000,
        width = 2,
        height = 3,
        stack = false,
        close = true,
        consume = 0,
        durability = true,
        description =
        "Empty mining rig frame. Needs a motherboard, 2x power supply and GPUs to mine. Placeable inside houses only. Durability is saved on the item.",
        client = {
            image = "mining_rig.png",
            event = "rm-cryptomining:client:useMiningRig",
        },
    },

    ["hack_phone"] = {
        label = "Hacking Phone",
        weight = 200,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        durability = true,
        description = "A modified phone for hacking vehicle security systems. Breaks after 4 uses.",
        client = {
            image = "hack_phone.png",
            event = "rm-smallcrimes:client:useHackPhone",
        },
    },

    ["vendingmachine"] = {
        label = "Vending Machine",
        weight = 25000,
        width = 2,
        height = 3,
        stack = false,
        close = true,
        consume = 0,
        description = "A placeable vending machine. Place it down to become its owner.",
        client = {
            image = "vendingmachine.png",
            event = "rm-shops:vending:use",
        },
    },

    ["television"] = {
        label = "Television",
        weight = 5000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        consume = 0,
        description = "A portable flat-screen TV. Use it to place one in the world. Pick it up again with target.",
        client = {
            export = "rm-smallresources.useItem",
        },
    },

    ["police_tv"] = {
        label = "Police TV Stand",
        description = "[PD] Rolling TV stand for briefings: videos, websites, a drawing board and image slides. Any officer can use it or pack it up.",
        weight = 12000,
        width = 2,
        height = 3,
        stack = false,
        close = true,
        consume = 0,
        client = {
            export = "rm-smallresources.useItem",
        },
    },

    ["cctv_camera"] = {
        label = "CCTV Camera",
        weight = 300,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "Standard security camera. Grainy feed with scanlines. Manage access from the CCTV tablet.",
        client = {
            export = "rm-laptop.useCameraItem",
            image = "cctv_camera.png",
        },
    },

    ["cctv_camera_advanced"] = {
        label = "Advanced CCTV Camera",
        weight = 350,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        consume = 0,
        description = "High-end security camera with a clean HD feed. No scanlines or visual distortion.",
        client = {
            export = "rm-laptop.useCameraItem",
            image = "cctv_camera.png",
        },
    },

    -- ["cctv_tablet"] = {
    --     label = "CCTV Tablet",
    --     weight = 0,
    --     width = 1,
    --     height = 1,
    --     stack = false,
    --     close = true,
    --     consume = 0,
    --     description = "View and manage your CCTV cameras and permissions.",
    --     client = {
    --         export = "rm-laptop.useTabletItem",
    --         image = "cctv_tablet.png",
    --     },
    -- },

    -- Tools & Crime

    ["lockpick"] = {
        label = "Lockpick",
        weight = 40,
        width = 1,
        height = 1,
        stackSize = 15,
        durability = 100,
        description = "Used to lockpick something",
    },

    ["advancedlockpick"] = {
        label = "Advanced Lockpick",
        weight = 50,
        width = 1,
        height = 1,
        stackSize = 15,
        durability = 100,
        description = "More durable than a regular lockpick",
        client = {
            export = "rm-vehicles.useAdvancedLockpick",
        },
    },

    ["police_stormram"] = {
        label = "Police stormram",
        weight = 8000,
        width = 2,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        consume = 0,
        -- not used from the inventory: carried, it adds "Breach door" on property doors (rm-properties
        -- raids), lab doors and mechanic stashes (the old rm-housing export is gone), and "Breach lock" on locked
        -- vehicles (rm-vehicles keys/client/policebreach.lua)
        description = "A police stormram for breaking down doors and vehicle locks. Carry it and target the door (Breach door) or a locked vehicle (Breach lock).",
    },

    ["spike_roll"] = {
        label = "Spike Strip Roll",
        description = "Careful its sharp",
        weight = 3000,
        width = 2,
        height = 2,
        stack = false,
        consume = 0,
        client = {
            export = "rm-police.useRoll",
        },
    },

    ["spike_deployer"] = {
        label = "Spike Deployer",
        description =
        "Remote spike strip deployer. Requires the right frequency to activate. Thank god for modern technology",
        weight = 2000,
        width = 2,
        height = 3,
        stack = false,
        consume = 0,
        client = {
            export = "rm-police.useDeployer",
        },
    },

    ["spike_deployer_remote"] = {
        label = "Spike Remote",
        description = "Remote for tuning to the frequency of a spike strip deployer",
        weight = 50,
        width = 1,
        height = 2,
        stack = false,
        consume = 0,
        close = true,
        client = {
            export = "rm-police.useRemote",
        },
        buttons = {
            {
                label = "Tune Frequency",
                action = function(slot)
                    exports["rm-police"]:tuneFrequency({
                        slot = slot,
                        name = "spike_deployer_remote",
                        close = true,
                    })
                end,
            },
        },
    },

    ["pickaxe"] = {
        label = "Pickaxe",
        weight = 2500,
        width = 1,
        height = 2,
        stack = false,
        close = true,
        description = "A basic mining tool",
        durability = true,
        decay = 1.0,
    },

    ["powersaw"] = {
        label = "Power Saw",
        weight = 2200,
        width = 1,
        height = 2,
        stack = false,
        close = true,
        description = "Cuts through mounting brackets, fasteners and padlocks - used for stripping AC units, cutting up cars at the chop shop and opening freight train containers.",
        durability = true,
        decay = 1.0,
    },

    ["small_drill"] = {
        label = "Drill",
        weight = 2500,
        width = 1,
        height = 2,
        stack = false,
        close = true,
        description = "A heavy-duty drill for boring through deposit boxes and safes",
        durability = true,
        decay = 1.0,
    },

    ["drillbit"] = {
        label = "Drill Bit",
        weight = 100,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "Consumed by the drill on each use",
        consume = 1,
    },

    ["rockwash_pan"] = {
        label = "Rock Wash Pan",
        weight = 500,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Used for washing rocks in water",
        client = {
            export = "rm-smallresources.rockwashpan",
        },
    },

    ["sewing_kit"] = {
        label = "Sewing Kit",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "A sewing kit for repairs.",
    },

    ["thermite"] = {
        label = "Thermite Charge",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "Thermite charge for cutting through metal.",
    },

    ["bomb_c4"] = {
        label = "C4 Explosive",
        weight = 1000,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 5,
        close = true,
        description = "Plastic explosive. Used to breach armored bus doors.",
    },

    ["trip_wire"] = {
        label = "Trip Wire",
        weight = 100,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Trip wire to mess with your enemys.",
    },

    ["shovel"] = {
        label = "Shovel",
        weight = 2000,
        width = 1,
        height = 3,
        stack = false,
        close = true,
        description = "With this shovel you are able to dig everything.",
        durability = true,
        decay = 1.0,
    },

    ["zipties"] = {
        label = "Zipties",
        weight = 20,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Zipties for securing items or people.",
    },

    ["handcuffs"] = {
        label = "Handcuffs",
        weight = 300,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Standard police handcuffs.",
    },

    ["blindfold"] = {
        label = "Blindfold",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Blindfold for restricting vision.",
    },

    ["hair_trimmer"] = {
        label = "Hair Trimmer",
        weight = 200,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Tool for trimming hair. Good for 2 cuts.",
    },

    ["repair_kit"] = {
        label = "Repair Kit",
        description = "Repairs the engine and bodywork up to 75% at the engine bay. Does not fix tires.",
        weight = 500,
        width = 1,
        height = 2,
        stackSize = 15,
        client = { image = "repair_kit.png" },
        server = { export = "rm-smallresources.repairkit" },
    },

    ["mechanic_repair_kit"] = {
        label = "Mechanic Repair Kit",
        description = "Workshop kit: repairs the vehicle to 100%. Only a mechanic can use it, inside their shop's service area.",
        weight = 1000,
        width = 1,
        height = 2,
        stackSize = 15,
        client = { image = "repair_kit.png" },
        server = { export = "rm-smallresources.mechanicrepairkit" },
    },

    ["heli_repair_kit"] = {
        label = "Helicopter Repair Kit",
        description = "Repairs a helicopter to 100%: engine, body, fuel tank and rotors. Only works on helicopters.",
        weight = 2000,
        width = 1,
        height = 2,
        stackSize = 10,
        client = { image = "repair_kit.png" },
        server = { export = "rm-smallresources.helirepairkit" },
    },

    ["tire_repair_kit"] = {
        label = "Tire Repair Kit",
        description = "Portable tire plug and inflation kit. Patches punctured tires so the car is driveable, does not restore tire wear.",
        weight = 500,
        width = 1,
        height = 2,
        stackSize = 15,
        client = { image = "tire_repair_kit.png" },
        server = { export = "rm-smallresources.tirekit" },
    },

    ["duct_tape"] = {
        label = "Duct Tape",
        description = "Strong multipurpose adhesive tape.",
        weight = 150,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["weaponrepairkit"] = {
        stackSize = 15,
        label = "Weapon Repair Kit",
        weight = 1500,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Hold the weapon and use the kit, or drag the kit onto the weapon",
        server = { export = "rm-smallresources.weaponrepairkit" },
    },

    ["body_repairkit"] = {
        label = "Body Repair Kit",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A kit for repairing body damage to vehicles.",
    },

    ["engine_repairkit"] = {
        label = "Engine Repair Kit",
        weight = 1500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        close = true,
        description = "A kit for repairing engine damage to vehicles.",
    },

    ["engine_repair_manual_1"] = {
        label = "Engine Repair Manual - Part 1",
        description = "Workshop manual for performance engines. Used up at the mechanic bench to build the I4 turbo, flat-6, V6 twin turbo and V8.",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "engine_repair_manual_1.png" },
    },

    ["engine_repair_manual_2"] = {
        label = "Engine Repair Manual - Part 2",
        description = "Advanced workshop manual. Used up at the mechanic bench to build the V8 supercharged, V10 and V12.",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "engine_repair_manual_2.png" },
    },

    ["bp_tire_drift"] = {
        label = "Drift Tire BP",
        description = "Blueprint required to craft Drift Tires. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_tire_drift.png" },
    },

    ["bp_tire_sport"] = {
        label = "Sport Tire BP",
        description = "Blueprint required to craft Sport Tires. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_tire_sport.png" },
    },

    ["bp_tire_rally"] = {
        label = "Rally Tire BP",
        description = "Blueprint required to craft Rally Tires. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_tire_rally.png" },
    },

    ["bp_tire_slick"] = {
        label = "Racing Slick Tire BP",
        description = "Blueprint required to craft Racing Slick Tires. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_tire_slick.png" },
    },

    ["bp_nitrous_system"] = {
        label = "Nitrous System BP",
        description = "Blueprint required to craft a Nitrous System. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_nitrous_system.png" },
    },

    ["bp_antilag_kit"] = {
        label = "Anti-Lag Kit BP",
        description = "Blueprint required to craft an Anti-Lag Kit. Used up when crafting.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        client = { image = "bp_antilag_kit.png" },
    },

    ["antilag_kit"] = {
        label = "Anti-Lag Kit",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "An anti-lag exhaust kit for a mechanic to install on a vehicle.",
    },

    ["steel_file"] = {
        label = "Steel File",
        description = "File for cutting metal.",
        weight = 150,
        width = 1,
        height = 1,
        stack = false,
        decay = true,
        consume = 0.1,
    },

    -- Materials & Crafting

    ["spring"] = {
        label = "Spring",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "A spring component.",
    },

    ["rubber"] = {
        label = "Rubber",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Rubber material.",
    },

    ["nails"] = {
        label = "Nails",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Nails.",
    },

    ["glass"] = {
        label = "Glass",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Glass material.",
    },

    ["plastic"] = {
        label = "Plastic",
        weight = 150,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Plastic material.",
    },


    ["gunpowder"] = {
        label = "Gunpowder",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Gunpowder for crafting explosives.",
    },

    ["rag"] = {
        label = "Rag",
        weight = 50,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "A rag for cleaning.",
    },

    ["aluminum"] = {
        label = "Aluminum",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 20,
        close = true,
        description = "A aluminum ore",
    },

    ["copper"] = {
        label = "Copper",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 20,
        close = true,
        description = "A copper ore",
    },

    ["sulfur"] = {
        label = "Sulfur",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 20,
        close = true,
        description = "A sulfur ore",
    },

    ["s_iron"] = {
        label = "Iron",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Iron bar.",
    },

    ["charcoal"] = {
        label = "Charcoal",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "A chunk of charcoal.",
    },

    ["rock"] = {
        label = "Rock",
        weight = 400,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Dirty rock it needs to be washed.",
    },

    ["s_aluminum"] = {
        label = "Smelted aluminum",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Clean smelted aluminum ore.",
    },

    ["s_sulfur"] = {
        label = "Smelted sulfur",
        weight = 250,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Clean smelted sulfur ore.",
    },

    ["s_copper"] = {
        label = "Smelted copper",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Clean smelted copper ore.",
    },


    ["wood_planks"] = {
        label = "Wood planks",
        weight = 300,
        width = 2,
        height = 1,
        stack = true,
        stackSize = 15,
        close = true,
        description = "Processed wood planks.",
    },

    ["gun_part_1"] = {
        label = "Gun Part #1",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        close = false,
        consume = 0,
        description = "Class 1 weapon component for pistols.",
        client = { image = "gun_part_1.png" },
    },

    ["gun_part_2"] = {
        label = "Gun Part #2",
        weight = 750,
        width = 1,
        height = 1,
        stack = true,
        close = false,
        consume = 0,
        description = "Class 2 weapon component for submachine guns.",
        client = { image = "gun_part_2.png" },
    },

    ["gun_part_3"] = {
        label = "Gun Part #3",
        weight = 1000,
        width = 1,
        height = 1,
        stack = true,
        close = false,
        consume = 0,
        description = "Class 3 weapon component for rifles.",
        client = { image = "gun_part_3.png" },
    },

    ["metal_parts"] = {
        label = "Metal Parts",
        weight = 300,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Machined metal parts, used to repair heavy machinery like windmills",
    },

    ["industrial_lubricant"] = {
        label = "Industrial Lubricant",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Heavy-duty lubricant, used to service turbines and other machinery",
    },

    ["fabric"] = {
        label = "Fabric",
        weight = 150,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Scrap fabric for bandages, rope and bags.",
    },

    ["iron_ore"] = {
        label = "Iron Ore",
        weight = 350,
        width = 1,
        height = 1,
        stackSize = 20,
        stack = true,
        description = "Unrefined iron for steel and metal components.",
    },

    ["s_iron_ore"] = {
        label = "Smelted Iron Ore",
        weight = 350,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Refined iron for steel and metal components.",
    },

    ["gold_nugget"] = {
        label = "Gold Nugget",
        weight = 50,
        width = 1,
        height = 1,
        stackSize = 20,
        stack = true,
        description = "Small gold deposit for jewellery and advanced electronics.",
    },

    ["coal"] = {
        label = "Coal",
        weight = 300,
        width = 1,
        height = 1,
        stackSize = 20,
        stack = true,
        description = "Coal chunks for smelting and processing.",
    },

    ["scrap_metal"] = {
        label = "Scrap Metal",
        weight = 400,
        width = 1,
        height = 1,
        stackSize = 30,
        stack = true,
        description = "Scrap from the wrecks at Rogers Salvage. The scrapyard trader turns it into recycled parts.",
    },

    ["recycled_parts"] = {
        label = "Recycled Parts",
        weight = 250,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
        description = "Reclaimed parts for repair kits and mechanical items.",
    },

    -- Fishing

    ["basicfishingrod"] = {
        label = "Basic fishing rod",
        description = "A fishing rod for bigginer fisherman",
        weight = 600,
        width = 1,
        height = 3,
        stackSize = 15,
        stack = true,
    },

    ["advancedfishingrod"] = {
        label = "Advanced fishing rod",
        description = "A fishing rod for advanced fisherman",
        weight = 700,
        width = 1,
        height = 3,
        stackSize = 15,
        stack = true,
    },

    ["basicbait"] = {
        label = "Basic fishing bait",
        description = "Fishing bait for bigginer fisherman",
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    ["probait"] = {
        label = "Advanced fishing bait",
        description = "Fishing bait for advanced fisherman",
        client = {
            image = "basicbait.png",
        },
        weight = 20,
        width = 1,
        height = 1,
        stackSize = 15,
        stack = true,
    },

    -- Hunting loot (rm-activities/hunting) - all 1x1 for 5x5 inventory

    ["hide_shark"] = {
        label = "Shark Hide",
        description = "A hide taken from a shark.",
        weight = 1500,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_whale"] = {
        label = "Whale Hide",
        description = "A hide taken from a whale.",
        weight = 2000,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_dolphin"] = {
        label = "Dolphin Hide",
        description = "A hide taken from a dolphin.",
        weight = 1250,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_stingray"] = {
        label = "Stingray Hide",
        description = "A hide taken from a stingray.",
        weight = 850,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_boar"] = {
        label = "Boar Hide",
        description = "A hide taken from a boar.",
        weight = 1100,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_coyote"] = {
        label = "Coyote Hide",
        description = "A hide taken from a coyote.",
        weight = 800,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_deer"] = {
        label = "Deer Hide",
        description = "A hide taken from a deer.",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_mtlion"] = {
        label = "Mt Lion Hide",
        description = "A hide taken from a mountain lion.",
        weight = 1000,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_rabbit"] = {
        label = "Rabbit Hide",
        description = "A hide taken from a rabbit.",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_cow"] = {
        label = "Cow Hide",
        description = "A hide taken from a cow.",
        weight = 1300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_pig"] = {
        label = "Pig Hide",
        description = "A hide taken from a pig.",
        weight = 900,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["hide_rat"] = {
        label = "Rat Hide",
        description = "A hide taken from a rat.",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_shark"] = {
        label = "Shark Meat",
        description = "Raw meat taken from a shark.",
        weight = 900,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_whale"] = {
        label = "Whale Meat",
        description = "Raw meat taken from a whale.",
        weight = 1200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_dolphin"] = {
        label = "Dolphin Meat",
        description = "Raw meat taken from a dolphin.",
        weight = 750,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_stingray"] = {
        label = "Stingray Meat",
        description = "Raw meat taken from a stingray.",
        weight = 450,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_boar"] = {
        label = "Boar Meat",
        description = "Raw meat taken from a boar.",
        weight = 600,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_coyote"] = {
        label = "Coyote Meat",
        description = "Raw meat taken from a coyote.",
        weight = 500,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_deer"] = {
        label = "Deer Meat",
        description = "Raw meat taken from a deer.",
        weight = 300,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_mtlion"] = {
        label = "Mt Lion Meat",
        description = "Raw meat taken from a mountain lion.",
        weight = 650,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_rabbit"] = {
        label = "Rabbit Meat",
        description = "Raw meat taken from a rabbit.",
        weight = 200,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_cow"] = {
        label = "Cow Meat",
        description = "Raw meat taken from a cow.",
        weight = 800,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_pig"] = {
        label = "Pig Meat",
        description = "Raw meat taken from a pig.",
        weight = 550,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_rat"] = {
        label = "Rat Meat",
        description = "Raw meat taken from a rat.",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },
    ["meat_chicken"] = {
        label = "Chicken Meat",
        description = "Raw meat taken from a chicken.",
        weight = 250,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 15,
    },

    ["salmon"] = {
        label = "Salmon",
        weight = 3000,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["catfish"] = {
        label = "Catfish",
        weight = 2000,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["redfish"] = {
        label = "Red sea bass",
        weight = 1500,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["gayfish"] = {
        label = "Gayfish",
        weight = 800,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["largemouthbass"] = {
        label = "Largemouth bass",
        weight = 1500,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["pike"] = {
        label = "Pike",
        weight = 2500,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["bream"] = {
        label = "Bream",
        weight = 800,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "",
    },

    ["eal"] = {
        label = "Eal",
        weight = 600,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["cod"] = {
        label = "Cod",
        weight = 3000,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "",
    },

    ["sparling"] = {
        label = "Sparling",
        weight = 100,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "",
    },

    -- Pets

    ["pet_shepherd"] = {
        label = "German Shepherd",
        weight = 0,
        width = 2,
        height = 2,
        consume = 0,
        stack = false,
        close = true,
        description = "An unregistered German Shepherd.",
        client = { export = "rm-smallresources.usePet" },
    },

    ["pet_rottweiler"] = {
        label = "Rottweiler",
        weight = 0,
        width = 2,
        height = 2,
        consume = 0,
        stack = false,
        close = true,
        description = "An unregistered Rottweiler.",
        client = { export = "rm-smallresources.usePet" },
    },

    ["pet_husky"] = {
        label = "Husky",
        weight = 0,
        width = 2,
        height = 2,
        consume = 0,
        stack = false,
        close = true,
        description = "An unregistered Husky.",
        client = { export = "rm-smallresources.usePet" },
    },

    ["pet_cat"] = {
        label = "Cat",
        weight = 0,
        width = 1,
        height = 2,
        consume = 0,
        stack = false,
        close = true,
        description = "An unregistered cat.",
        client = { export = "rm-smallresources.usePet" },
    },

    ["pet_food"] = {
        label = "Pet Food",
        weight = 400,
        width = 1,
        height = 1,
        stackSize = 15,
        consume = 0,
        stack = true,
        close = true,
        description = "Nutritious food for pets.",
        client = { export = "rm-smallresources.usePetFood" },
    },

    ["pet_water"] = {
        label = "Pet Water",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 15,
        consume = 0,
        stack = true,
        close = true,
        description = "Fresh water for pets.",
        client = { export = "rm-smallresources.usePetWater" },
    },

    ["pet_firstaid"] = {
        label = "Pet First Aid Kit",
        weight = 200,
        width = 1,
        height = 1,
        stackSize = 15,
        consume = 0,
        stack = true,
        close = true,
        description = "Restores some pet health.",
        client = { export = "rm-smallresources.usePetFirstAid" },
    },

    -- Police & Evidence

    ["cone"] = {
        label = "Traffic Cone",
        description = "A bright orange traffic cone for road safety",
        weight = 1500,
        width = 1,
        height = 2,
        stackSize = 15,
        stack = true,
        consume = 0,
        client = {
            export = "rm-police.useCone",
        },
    },

    ["barrier"] = {
        label = "Traffic Barrier",
        description = "A portable traffic barrier for blocking roads",
        weight = 8000,
        width = 2,
        height = 3,
        stackSize = 15,
        stack = true,
        consume = 0,
        client = {
            export = "rm-police.useBarrier",
        },
    },

    -- Crime-scene evidence: rm-police modules/evidence (replaced Ehbw-Evidence).
    -- See resources/[legal]/[lspd_lsgd]/rm-police/modules/evidence/config.lua
    ["evidencebag"] = {
        label = "Evidence Bag",
        description = "An empty evidence bag. Used up when you bag casings, blood, bullet fragments or lifted prints.",
        weight = 20,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 20,
        close = false,
    },

    ["evidence"] = {
        label = "Sealed Evidence Bag",
        description = "Evidence collected at a crime scene. Analyse it at the forensics lab.",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = false,
    },

    ["fingerreader"] = {
        label = "Fingerprint Reader",
        description = "Scans a person's fingerprint on the spot. Target the person and pick Scan fingerprint.",
        weight = 650,
        width = 2,
        height = 1,
        stack = false,
        client = {
            export = "rm-police.useFingerReader",
        },
    },

    ["gsrkit"] = {
        label = "GSR Testing Kit",
        description = "Single-use gunshot residue swab. Use near a person or target them.",
        weight = 120,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 10,
        client = {
            export = "rm-police.useGsrKit",
        },
    },

    ["camera"] = {
        label = "Photo Camera",
        description = "Good at taking photos.",
        weight = 250,
        width = 1,
        height = 1,
        stack = false,
        client = {
            export = "rm-police.useEvidenceCamera",
        },
    },

    ["evidence_camera"] = {
        label = "Evidence Camera",
        description = "Police scene camera. Evidence you have revealed is tagged on the photo.",
        weight = 600,
        width = 2,
        height = 1,
        stack = false,
        client = {
            export = "rm-police.useEvidenceCamera",
        },
    },

    ["photoevi"] = {
        label = "Evidence Photo",
        weight = 20,
        width = 1,
        height = 1,
        stack = false,
        client = {
            export = "rm-police.viewEvidencePhoto",
        },
    },

    ["napkin"] = {
        label = "Napkin",
        description = "Wipe your hands with it.",
        weight = 10,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 20,
        client = {
            export = "rm-police.useNapkin",
        },
    },

    ["gloves"] = {
        label = "Gloves",
        description = "Work gloves. Keep a pair on you and you leave no fingerprints, and nobody can take yours.",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 5,
    },

    ["uv_flashlight"] = {
        label = "UV Flashlight",
        description = "Ultraviolet lamp that shows fingerprints. Use it to switch it on or off.",
        weight = 300,
        width = 1,
        height = 2,
        stack = false,
        client = {
            export = "rm-police.useUvLight",
        },
    },

    ["fingerprint_kit"] = {
        label = "Fingerprint Kit",
        description = "Powder, brush and lifting tape. Needed to lift a print you found with UV light.",
        weight = 400,
        width = 1,
        height = 1,
        stack = false,
        close = false,
    },

    ["lab_report"] = {
        label = "Lab Report",
        weight = 10,
        width = 1,
        height = 1,
        stack = false,
        client = {
            export = "rm-police.readLabReport",
        },
    },

    -- Vehicles & Tuning

    ["parachute"] = {
        label = "Parachute",
        description = "Helps you land safely.",
        weight = 6000,
        width = 2,
        height = 3,
        stack = false,
        client = {
            anim = {
                dict = "clothingshirt",
                clip = "try_shirt_positive_d",
            },
            usetime = 1500,
        },
    },

    ["diving_gear"] = {
        label = "Diving Gear",
        weight = 5000,
        width = 2,
        height = 2,
        stackSize = 15,
        stack = true,
        close = true, -- the inventory closes so the put on / take off bar is visible
        description = "Diving gear for underwater exploration. Use again to take it off.",
    },

    ["diving_fill"] = {
        label = "Diving Tank",
        weight = 12000,
        width = 1,
        height = 2,
        stack = false,
        close = false,
        description = "Air tank for the diving gear: 5 minutes underwater when full. The bar shows the air left. Drag a tank onto another to top it up.",
    },

    ["rope"] = {
        label = "Towing Rope",
        weight = 1500,
        width = 1,
        height = 1,
        stack = true,
        stackSize = 5,
        close = true,
        consume = 0,
        description = "Attach to the rear of one vehicle and the front of another to tow it.",
        client = {
            image = "rope.png",
            export = "rm-smallresources.useTowingRope",
        },
    },

    ["vehicle_wax"] = {
        label = "Vehicle Wax",
        weight = 400,
        width = 1,
        height = 2,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A can of wax for polishing vehicles.",
    },

    ["nitrous"] = {
        label = "Nitrous Bottle",
        weight = 2000,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Nitrous oxide bottle. Use it next to a car with a nitrous system to mount it in the trunk.",
        client = {
            image = "nitrous.png",
            export = "rm-businesses.useNitrous",
        },
    },

    ["part_engine"] = {
        label = "Engine",
        weight = 25000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Complete engine block. Swap it in at a mechanic shop.",
    },

    ["part_oil"] = {
        label = "Engine Oil",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Fresh engine oil. Worn oil wears the engine out fast.",
    },

    ["part_transmission"] = {
        label = "Transmission",
        weight = 15000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Gearbox assembly.",
    },

    ["part_trans_fluid"] = {
        label = "Transmission Fluid",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Gearbox fluid. Worn fluid wears the transmission out fast.",
    },

    ["part_drivetrain"] = {
        label = "Drivetrain Swap Kit",
        weight = 18000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Driveshafts, differentials and transfer case. Converts a car to front, rear or all-wheel drive at a mechanic shop.",
        client = {
            image = "part_transmission.png",
        },
    },

    ["part_clutch"] = {
        label = "Clutch Kit",
        weight = 5000,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Clutch plate, pressure plate and bearing.",
    },

    ["part_brakes"] = {
        label = "Brake Discs & Calipers",
        weight = 8000,
        width = 2,
        height = 1,
        stack = false,
        close = true,
        description = "Set of brake discs and calipers for all wheels.",
    },

    ["part_brake_pads"] = {
        label = "Brake Pads",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "Set of brake pads for all wheels.",
    },

    ["part_suspension"] = {
        label = "Suspension Kit",
        weight = 10000,
        width = 2,
        height = 1,
        stack = false,
        close = true,
        description = "Springs and dampers for all corners.",
    },

    ["part_tires"] = {
        label = "Tire Set",
        weight = 12000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "Set of road tires.",
    },

    ["part_nos_kit"] = {
        label = "Nitrous System",
        weight = 6000,
        width = 2,
        height = 1,
        stack = false,
        close = true,
        description = "Nitrous lines, solenoids and bottle mount. Installed at a mechanic shop.",
    },



    ["bp_stancing_kit"] = {
        label = "Stancing Kit BP",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        description = "Blueprint for a lowered, cambered stance setup.",
        client = { image = "bp_stancing_kit.png" },
    },

    ["bp_standing_kit"] = {
        label = "Standing Kit BP",
        weight = 100,
        width = 1,
        height = 1,
        stack = true,
        close = true,
        description = "Blueprint for adjustable suspension ride-height changes.",
        client = { image = "bp_standing_kit.png" },
    },

    ["stancing_kit"] = {
        label = "Stancing Kit",
        weight = 4000,
        width = 2,
        height = 2,
        stack = true,
        stackSize = 5,
        close = true,
        description = "Camber plates and adjustable arms. A mechanic uses one to fit camber and track width changes.",
        client = { image = "stancing_kit.png" },
    },

    ["standing_kit"] = {
        label = "Standing Kit",
        weight = 5000,
        width = 2,
        height = 2,
        stack = true,
        stackSize = 5,
        close = true,
        description = "Coilovers and springs. A mechanic uses one to fit suspension height changes.",
        client = { image = "standing_kit.png" },
    },

    -- Bags & Clothing

    ["backpack_small"] = {
        label = "Small Backpack",
        description = "Small portable storage bag.",
        weight = 300,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        consume = 0,
    },

    ["backpack_medium"] = {
        label = "Medium Backpack",
        description = "Medium portable storage bag.",
        weight = 500,
        width = 2,
        height = 1,
        stack = false,
        close = false,
        consume = 0,
    },

    ["backpack_large"] = {
        label = "Large Backpack",
        description = "Large portable storage bag.",
        weight = 800,
        width = 2,
        height = 1,
        stack = false,
        close = false,
        consume = 0,
    },

    -- one piece of clothing; metadata says which square it goes in (data/clothing.lua, rm-appearance format)
    ["clothing_item"] = {
        label = "Clothing",
        description = "A piece of clothing",
        weight = 250,
        stack = false,
        close = true,
        client = {
            export = 'ox_inventory.useClothingItem',
        },
    },

    ["clothing_bag"] = {
        label = "Clothing Bag",
        description = 'A duffel bag with a change of clothes',
        width = 1,
        height = 2,
        weight = 600,
        stack = false,
    },

    ["prison_outfit"] = {
        label = "Prison Outfit",
        description = "Standard-issue prison uniform. Freemode male/female only.",
        weight = 500,
        width = 1,
        height = 2,
        stack = true,
        close = true,
        consume = 1,
        client = {
            label = "Changing into prison outfit...",
            anim = {
                dict = "clothingshirt",
                clip = "try_shirt_positive_d",
                flag = 49,
            },
            usetime = 10000,
            cancel = true,
            export = "rm-smallresources.prisonOutfit",
            disable = { combat = true, move = true, car = true },
        },
    },

    -- Packages & Special

    -- House robbery loot (md-houserobberies) - all 1x1 so a 5x5 bag isn't filled by a few pieces
    ["art1"] = {
        label = "Kitty Sleeping Art",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = { image = "art1.png" },
    },
    ["art2"] = {
        label = "Wide Eye Kitty Art",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = { image = "art2.png" },
    },
    ["art3"] = {
        label = "Fancy Kitty Art",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = { image = "art3.png" },
    },
    ["art4"] = {
        label = "Presidential Kitty Art",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "Id Vote For This",
        client = { image = "art4.png" },
    },
    ["art5"] = {
        label = "Obi Jesus Painting",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "I Swore My Allegiance To The Force, To Heaven!",
        client = { image = "art5.png" },
    },
    ["art6"] = {
        label = "Merp Kitty Art",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "Merp",
        client = { image = "art6.png" },
    },
    ["art7"] = {
        label = "Family Portait",
        weight = 1500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "Smile",
        client = { image = "art7.png" },
    },
    ["boombox"] = {
        label = "Boom Box",
        weight = 3000,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "How Did People Carry This",
        client = { image = "boombox.png" },
    },
    ["slow_laptop"] = {
        label = "Slow Laptop",
        weight = 2000,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "Can I Download More Ram?",
        client = { image = "laptop.png" },
    },
    ["desktop"] = {
        label = "Desktop",
        weight = 8000,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "I hope there isnt a virus",
        client = { image = "desktop.png" },
    },
    ["monitor"] = {
        label = "Monitor",
        weight = 4000,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "720HD bb",
        client = { image = "monitor.png" },
    },
    ["tablet"] = {
        label = "Tablet",
        weight = 500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "A used tablet. The pawnshop buys these.",
        client = { image = "tablet.png" },
    },
    ["speakers"] = {
        label = "Speakers",
        weight = 2500,
        width = 1,
        height = 1,
        stack = false,
        close = false,
        description = "Is This Even Loud?",
        client = { image = "speaker.png" },
    },

    ["blackmarketcard"] = {
        label = "Black Market Card",
        weight = 10,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        description = "A scratched contact card. Use a payphone after dark.",
        client = {
            image = "blackmarketcard.png",
        },
    },

    ["porch_package"] = {
        label = "Porch Package",
        weight = 800,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "A swiped porch delivery. Use it to open it up and see what was inside.",
        server = { export = "rm-illegal.usePorch_package" },
    },

    -- racing harness

    ['harness'] = {
        label = 'Racing Harness',
        weight = 800,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = 'A racing harness, straps you tight into your seat for high speed driving.',
        metadata = {
            durability = 100,
        },
    },

    -- RM weapon/skin items are declared in data/weapons.lua so ox retains weapon/component flags.
    

    -- all rm-activities/cases

    ["wep_skin_case"] = {
        label = "Weapon Skin Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "Contains finishes for the complete RM weapon collection, or a rock.",
        consume = 0,
        client = {
            image = "wep_skin_case.png",
        },
        server = {
            export = 'rm-activities.useWep_skin_case',
        },
    },

    ["fleeca_case"] = {
        label = "Fleeca Bank Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Fleeca Bank heist. Contains random loot.",
        consume = 0,
        client = {
            image = "fleeca_case.png",
        },
        server = {
            export = 'rm-activities.useFleeca_case',
        },
    },

    ["paleto_case"] = {
        label = "Paleto Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Paleto Bank heist. Contains random loot.",
        consume = 0,
        client = {
            image = "paleto_case.png",
        },
        server = {
            export = 'rm-activities.usePaleto_case',
        },
    },

    ["pacific_case"] = {
        label = "Pacific Bank Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Pacific Bank heist. Contains random loot.",
        consume = 0,
        client = {
            image = "pacific_case.png",
        },
        server = {
            export = 'rm-activities.usePacific_case',
        },
    },

    ["jewelry_case"] = {
        label = "Jewelry Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Jewelry Store heist. Contains random loot.",
        consume = 0,
        client = {
            image = "jewelry_case.png",
        },
        server = {
            export = 'rm-activities.useJewelry_case',
        },
    },

    ["bobcat_case"] = {
        label = "Bobcat Security Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Bobcat heist. Contains random loot.",
        consume = 0,
        client = {
            image = "bobcat_case.png",
        },
        server = {
            export = 'rm-activities.useBobcat_case',
        },
    },

    ["oilrig_case"] = {
        label = "Oil Rig Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A sealed case from an offshore rig job. Contains random loot.",
        consume = 0,
        client = {
            image = "oilrig_case.png",
        },
        server = {
            export = 'rm-activities.useOilrig_case',
        },
    },

    ["daily_crate"] = {
        label = "Daily Crate",
        weight = 500,
        width = 1,
        height = 1,
        stackSize = 10,
        stack = true,
        close = true,
        description = "Given for every hour you play. Cash, useful items and a very rare A-Class vehicle token.",
        consume = 0,
        client = {
            image = "daily_crate.png",
        },
        server = {
            export = 'rm-activities.useDaily_crate',
        },
    },

    ["supporter_case"] = {
        label = "Supporter Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "Daily thank-you case for Supporters (/dailyreward). Contains random loot.",
        consume = 0,
        client = {
            image = "supporter_case.png",
        },
        server = {
            export = 'rm-activities.useSupporter_case',
        },
    },

    ["premium_supporter_case"] = {
        label = "Premium Supporter Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "Daily thank-you case for Premium Supporters (/dailyreward). Double rewards.",
        consume = 0,
        client = {
            image = "premium_supporter_case.png",
        },
        server = {
            export = 'rm-activities.usePremium_supporter_case',
        },
    },

    ["cargo_crate_s"] = {
        label = "Cargo Crate (Standard)",
        weight = 6000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "A sealed transport crate from a faction cargo job. Open it yourself or hand it to your faction contact.",
        consume = 0,
        client = {
            image = "cargo_crate_s.png",
        },
        server = {
            export = 'rm-activities.useCargo_crate_s',
        },
    },

    ["cargo_crate_m"] = {
        label = "Cargo Crate (Secure)",
        weight = 9000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "A locked security crate from a faction cargo job. Better loot inside. Open it yourself or hand it to your faction contact.",
        consume = 0,
        client = {
            image = "cargo_crate_m.png",
        },
        server = {
            export = 'rm-activities.useCargo_crate_m',
        },
    },

    ["cargo_crate_l"] = {
        label = "Cargo Crate (Vault)",
        weight = 14000,
        width = 2,
        height = 2,
        stack = false,
        close = true,
        description = "A heavy vault crate from a faction cargo job. The best loot. Open it yourself or hand it to your faction contact.",
        consume = 0,
        client = {
            image = "cargo_crate_l.png",
        },
        server = {
            export = 'rm-activities.useCargo_crate_l',
        },
    },

    ["faction_cashbag"] = {
        label = "Sealed Cash Bag",
        weight = 2500,
        stack = false,
        close = true,
        description = "A sealed bag of cash for a faction job. Do not open it.",
        client = {
            image = "faction_cashbag.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_partsbox"] = {
        label = "Parts Toolbox",
        weight = 6000,
        stack = false,
        close = true,
        description = "A locked toolbox full of parts for a faction job. Do not open it.",
        client = {
            image = "faction_partsbox.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_package"] = {
        label = "Wrapped Package",
        weight = 4000,
        stack = false,
        close = true,
        description = "A tightly wrapped package for a faction job. Do not open it.",
        client = {
            image = "faction_package.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_envelope"] = {
        label = "Sealed Documents",
        weight = 50,
        stack = true,
        close = true,
        description = "Sealed papers for a faction dead drop. Do not read them.",
        client = {
            image = "faction_envelope.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_ledger"] = {
        label = "Account Book",
        weight = 400,
        stack = true,
        close = true,
        description = "A doctored account book for a faction job. Do not open it.",
        client = {
            image = "faction_ledger.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_carparts"] = {
        label = "Stripped Car Parts",
        weight = 3500,
        stack = true,
        close = true,
        description = "Parts pulled off a car for a faction job. Bring them to your contact.",
        client = {
            image = "faction_carparts.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["faction_protection"] = {
        label = "Protection Money",
        weight = 100,
        stack = true,
        close = true,
        description = "A roll of protection money collected for a faction. Bring it to your contact.",
        client = {
            image = "faction_protection.png",
        },
        server = {
            export = 'rm-illegal.useFactionItem',
        },
    },

    ["fake_plate"] = {
        label = "Plate Remover",
        weight = 1000,
        stack = true,
        close = true,
        description = "Quick-release tool from Iron Wheels. Use it at a car to take the plates off - radars and cameras read nothing. Use it again, or put the plates back at the rear of the car. Not used up.",
        client = {
            image = "fake_plate.png",
            export = 'rm-illegal.useFakePlate',
        },
    },

    ["racing_case"] = {
        label = "Racing Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Racing event. Contains random loot.",
        consume = 0,
        client = {
            image = "racing_case.png",
        },
        server = {
            export = 'rm-activities.useRacing_case',
        },
    },

    ["humanlabs_case"] = {
        label = "Human Labs Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Human Labs. Contains random loot.",
        consume = 0,
        client = {
            image = "humanlabs_case.png",
        },
        server = {
            export = 'rm-activities.useHumanlabs_case',
        },
    },

    ["digitalden_case"] = {
        label = "Digital Den Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A mysterious case from a Digital Den. Contains random loot.",
        consume = 0,
        client = {
            image = "digitalden_case.png",
        },
        server = {
            export = 'rm-activities.useDigitalden_case',
        },
    },

    ["bbus_card_case"] = {
        label = "BBus Card Case",
        weight = 1000,
        width = 1,
        height = 1,
        stackSize = 5,
        stack = true,
        close = true,
        description = "A sealed case of heist bus cards. Contains a random access card.",
        consume = 0,
        client = {
            image = "bbus_card_case.png",
        },
        server = {
            export = 'rm-activities.useBbus_card_case',
        },
    },

    -- polaroid cameras

    ["polaroid_camera"] = {
        label = "Polaroid camera",
        weight = 450,
        stack = false,
        close = true,
        description = "Did we just go back in time?",
        client = {
            image = "polaroid.png",
        },
    },
    ["dice"] = {
        label = "Dice",
        weight = 20,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "A pair of dice. Roll them - everyone nearby sees the result.",
        server = {
            export = "rm-smallresources.chanceDice",
        },
    },
    ["lucky_coin"] = {
        label = "Lucky Coin",
        weight = 10,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "Heads or tails? Flip it - everyone nearby sees the result.",
        server = {
            export = "rm-smallresources.chanceCoin",
        },
    },
    ["playing_cards"] = {
        label = "Playing Cards",
        weight = 50,
        width = 1,
        height = 1,
        stack = false,
        close = true,
        consume = 0,
        description = "A 52 card deck. Draw a card - everyone nearby sees it.",
        server = {
            export = "rm-smallresources.chanceCard",
        },
    },
    ["polaroid_paper"] = {
        label = "Polaroid paper",
        weight = 10,
        stack = true,
        close = false,
        description = "Some paper",
        client = {
            image = "photo.png",
        },
    },
    ["polaroid"] = {
        label = "Polaroid image",
        weight = 10,
        stack = false,
        close = true,
        description = "Cool image bro",
        client = {
            image = "photo.png",
        },
    },

    -- Every restaurant dish is this one item; the label/description/image and
    -- the hunger/thirst it restores live in per-instance metadata stamped when
    -- it's cooked or sold (rm-businesses/server/registers.lua).
    -- consume = 0 on purpose: rm-businesses removes it server-side itself,
    -- after it has read that metadata (rm-businesses/server/main.lua).
    ['business_food'] = {
        label = 'Food',
        weight = 200,
        -- stacks only with the same dish: ox_inventory merges slots whose metadata match
        -- exactly, and every dish carries its own recipe metadata
        stack = true,
        stackSize = 15,
        close = true,
        consume = 0,
        client = {
            export = 'rm-businesses.useFood',
        },
    },

    -- Restaurants food ingredients
    ['meat'] = {
        label = 'Meat',
        weight = 500,
        stack = true,
        close = true,
        description = '',
    },
    ['fish'] = {
        label = 'Fish',
        weight = 500,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_meat'] = {
        label = 'Sliced meat',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_fish'] = {
        label = 'Sliced fish',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_onion'] = {
        label = 'Sliced onion',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_carrot'] = {
        label = 'Sliced carrot',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_lettuce'] = {
        label = 'Sliced lettuce',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_cucumber'] = {
        label = 'Sliced cucumber',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_potato'] = {
        label = 'Sliced potato',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_tomato'] = {
        label = 'Sliced tomato',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_coffee'] = {
        label = 'Coffee powder',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_wheat'] = {
        label = 'Flour',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_corn'] = {
        label = 'Corn flour',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_strawberry'] = {
        label = 'Sliced strawberry',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_watermelon'] = {
        label = 'Sliced watermelon',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_soya'] = {
        label = 'Tofu',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_pineapple'] = {
        label = 'Sliced pineapple',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_apple'] = {
        label = 'Sliced apple',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_pear'] = {
        label = 'Sliced pear',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_lemon'] = {
        label = 'Sliced lemon',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_banana'] = {
        label = 'Sliced banana',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_peach'] = {
        label = 'Sliced peach',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_mango'] = {
        label = 'Sliced mango',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['sliced_orange'] = {
        label = 'Sliced orange',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['ice_cubes'] = {
        label = 'Ice cubes',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['cheese'] = {
        label = 'Cheese',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['tortilla'] = {
        label = 'Tortilla',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['taco_shell'] = {
        label = 'Taco shell',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['tortilla_chips'] = {
        label = 'Tortilla chips',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },

    -- Farming vegetables
    ['onion'] = {
        label = 'Onion',
        weight = 150,
        stack = true,
        close = true,
        description = '',
    },
    ['carrot'] = {
        label = 'Carrot',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['lettuce'] = {
        label = 'Lettuce',
        weight = 250,
        stack = true,
        close = true,
        description = '',
    },
    ['cucumber'] = {
        label = 'Cucumber',
        weight = 200,
        stack = true,
        close = true,
        description = '',
    },
    ['potato'] = {
        label = 'Potato',
        weight = 150,
        stack = true,
        close = true,
        description = '',
    },
    ['tomato'] = {
        label = 'Tomato',
        weight = 100,
        stack = true,
        close = true,
        description = '',
    },
    ['coffee_beans'] = {
        label = 'Coffee beans',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['wheat'] = {
        label = 'Wheat',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['corn'] = {
        label = 'Corn',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['strawberry'] = {
        label = 'Strawberry',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['pineapple'] = {
        label = 'Pineapple',
        weight = 10,
        stack = true,
        close = true,
        description = '',
    },
    ['watermelon'] = {
        label = 'Watermelon',
        weight = 5,
        stack = true,
        close = true,
        description = '',
    },
    ['soya'] = {
        label = 'Soy beans',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['eggplant'] = {
        label = 'Eggplant',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['blueberry'] = {
        label = 'Blueberry',
        weight = 8,
        stack = true,
        close = true,
        description = '',
    },
    ['pumpkin'] = {
        label = 'Pumpkin',
        weight = 2000,
        stack = true,
        close = true,
        description = '',
    },
    ['apple'] = {
        label = 'Apple',
        weight = 120,
        stack = true,
        close = true,
        description = '',
    },
    ['pear'] = {
        label = 'Pear',
        weight = 120,
        stack = true,
        close = true,
        description = '',
    },
    ['lemon'] = {
        label = 'Lemon',
        weight = 80,
        stack = true,
        close = true,
        description = '',
    },
    ['banana'] = {
        label = 'Banana',
        weight = 120,
        stack = true,
        close = true,
        description = '',
    },
    ['orange'] = {
        label = 'Orange',
        weight = 130,
        stack = true,
        close = true,
        description = '',
    },
    ['peach'] = {
        label = 'Peach',
        weight = 130,
        stack = true,
        close = true,
        description = '',
    },
    ['mango'] = {
        label = 'Mango',
        weight = 200,
        stack = true,
        close = true,
        description = '',
    },
    -- TGG casino claw machine prizes (tgg-casino-tables config/claw.lua)
    ['claw_plush_humpy'] = {
        label = 'Humpy Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_methy'] = {
        label = 'Methy Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_saki'] = {
        label = 'Saki Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_sticky'] = {
        label = 'Sticky Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_smokey'] = {
        label = 'Smokey Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_grindy'] = {
        label = 'Grindy Plush',
        description = 'A common prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_princess'] = {
        label = 'Princess Robo Bubblegum Plush',
        description = 'A rare prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_wasabi'] = {
        label = 'Shiny Wasabi Kitty Plush',
        description = 'A rare prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },
    ['claw_plush_master'] = {
        label = 'Master Plush',
        description = 'A rare prize from the casino claw machine.',
        weight = 300,
        stack = true,
        close = true,
    },

    -- Printer (rm-smallresources/items/printer): place it on a desk or the floor, then use it to print
    ['printer'] = {
        label = 'Printer',
        weight = 5000,
        stack = false,
        close = true,
        consume = 0,
        description = 'A desk printer. Use it to set it up anywhere, then print documents and images from your phone. Pick it up again to move it.',
        client = {
            image = 'printer.png',
            export = 'rm-smallresources.usePrinter',
        },
    },

    -- Stage platform (rm-smallresources/items/stage): scroll picks the size, then the rotation
    ['stage_platform'] = {
        label = 'Stage Platform',
        weight = 10000,
        stack = false,
        close = true,
        consume = 0,
        description = 'A stage for events. Use it, pick the size with the scroll wheel, then turn it and set it down. Pack it up again to get it back.',
        client = {
            image = 'stage_platform.png',
            export = 'rm-smallresources.useStage',
        },
    },

    -- DJ system (rm-smallresources/items/djsystem): use to place, then link to a station
    ['dj_advanced'] = {
        label = 'Advanced DJ Deck',
        weight = 10000,
        stack = false,
        close = true,
        consume = 0,
        description = 'A complete DJ deck. Use it to set up a DJ station and give it a name.',
        client = {
            image = 'dj_advanced.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_speaker_large'] = {
        label = 'Large Speaker',
        weight = 5000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Big club speaker. Link it to a DJ station; the longest range.',
        client = {
            image = 'dj_speaker_large.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_speaker_medium'] = {
        label = 'Medium Speaker',
        weight = 3000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Club speaker. Link it to a DJ station.',
        client = {
            image = 'dj_speaker_medium.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_speaker_small'] = {
        label = 'Small Speaker',
        weight = 1500,
        stack = false,
        close = true,
        consume = 0,
        description = 'Small speaker for a DJ station. Short range.',
        client = {
            image = 'dj_speaker_small.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_light_ambient'] = {
        label = 'Ambient Light',
        weight = 2000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Colour wash light for a DJ station.',
        client = {
            image = 'dj_light_ambient.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_light_spot'] = {
        label = 'Spotlight',
        weight = 3000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Moving head spotlight for a DJ station.',
        client = {
            image = 'dj_light_spot.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_light_bar'] = {
        label = 'Bar Light',
        weight = 2500,
        stack = false,
        close = true,
        consume = 0,
        description = 'LED bar light for a DJ station.',
        client = {
            image = 'dj_light_bar.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_smoke'] = {
        label = 'Smoke Machine',
        weight = 3000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Stage smoke machine for a DJ station.',
        client = {
            image = 'dj_smoke.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
    ['dj_fire'] = {
        label = 'Fire Machine',
        weight = 3000,
        stack = false,
        close = true,
        consume = 0,
        description = 'Stage flame machine for a DJ station.',
        client = {
            image = 'dj_fire.png',
            export = 'rm-smallresources.useDjItem',
        },
    },
}
