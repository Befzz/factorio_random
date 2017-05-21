-- A part of band.lua
-- Feel free to edit.

return {

["to_print"] = {
  "%name now in a [%band] band.",
  "%name has joined [%band] band.",
  "%name is supporting [%band] band."  
},

["roles"] = {
  ["Trooper"] = {
    "item/tank",
    "item/exoskeleton-equipment",
    "item/power-armor-mk2",
    "item/energy-shield-mk2-equipment",
    "item/battery",
    "item/battery-mk2-equipment",
    tooltip = {
      "Incoming!!!",
      "If the facts don't fit the theory, change the facts.",
      "I suppose it is tempting, if the only tool you have is a hammer, to treat everything as if it were a nail.",
      "There's a fine line between genius and insanity. I have erased this line."
    },
    verbs = {
      "strengthened",
      "reinforced"
    }
  },
  ["Security"] = {
    "item/gun-turret",
    "item/laser-turret",
    "item/atomic-bomb",
    "item/firearm-magazine",
    "item/piercing-rounds-magazine",
    "item/flamethrower-turret",
    "item/stone-wall",
    "item/pistol",
    tooltip = {
      "I like guns.",
      "Robocop!", 
      "Attack is the best form of defense.",
      "Only the insecure strive for security."
    },
    verbs = {
      "strengthened",
      "enhanced",
      "reinforced"
    } 
  },
  ["Resources"] = {
    "item/steel-axe",
    "item/iron-axe",
    "item/iron-ore",
    "item/copper-ore",
    tooltip = {
      "Mine or not to mine", 
      "The nation behaves well if it treats the natural resources as assets which\n it must turn over to the next generation increased, and not impaired, in value."
    },
    verbs = {
      "enriched",
      "smelted"
    }
  },
  ["Production"] = {
    "item/assembling-machine-1",
    "item/assembling-machine-2",
    "item/assembling-machine-3",
    "item/inserter",
    "item/stack-inserter",
    tooltip = {
      "When every physical and mental resources is focused, one's power to solve a problem multiplies tremendously.",
      "The production of too many useful things results in too many useless people. ",
      "Everything must be made as simple as possible. But not simpler."
    },
    verbs = {
      "enhanced"
    } 
  },
  ["Science"] = {
    "item/science-pack-1",
    "item/science-pack-2",
    "item/science-pack-3",
    "item/military-science-pack",
    "item/production-science-pack",
    "item/high-tech-science-pack",
    "item/space-science-pack",
    tooltip = {
      "Science without religion is lame, religion without science is blind",
      "If we knew what it was we were doing, it would not be called research, would it?",
      "Somewhere, something incredible is waiting to be known.",
      "I'm sure the universe is full of intelligent life. It's just been too intelligent to come here."
    },
    verbs = {
      "advanced"
    } 
  },
  ["Spaghetti"] = {
    "item/transport-belt",
    "item/fast-transport-belt",
    "item/express-transport-belt",
    "item/fast-underground-belt",
    "item/fast-splitter",
    "item/splitter",
    "item/express-splitter",
    tooltip = {
      "Naturally italian",
      '"A long, thin, cylindrical, solid pasta"(wiki)'
    },
    verbs = {
      "perfected",
      "chaosed",
      "hodgepodged",
      "noodled",
      "macaronied",
      "pastaed",
      "seasoned",
      "belted"
    } 
      
  },
  ["Trains"] = {
    "entity/curved-rail",
    "item/cargo-wagon",
    "item/fluid-wagon",
    "item/locomotive",
    "item/rail-signal",
    "item/rail",
    tooltip = {
      "Ch, ch, choooo!",
      "The only way of catching a train I have ever discovered is to miss the train before. ",
      "If a trainstation is where the train stops, what's a workstation...?"
    },
    verbs = {
      "expanded",
      "extended"
    } 
  },
  ["Powah!"] = {
    "item/steam-turbine",
    "item/nuclear-reactor",
    "item/heat-exchanger",
    "item/steam-engine",
    "item/solar-panel",
    "item/accumulator",
    "item/boiler",
    "fluid/steam",
    tooltip = {
      "I ve Got The power!",
      "Power Overwhelming!!!111",
      "Its Over 9000!!!",
      '"If you want to find the secrets of the universe, think in terms of energy, frequency and vibration." (Tesla)'
    },
    verbs = {
      "amplified",
      "intensified"
    }
  },
  ["Lurker"] = {
    "item/night-vision-equipment",
    "entity/construction-robot",
    "item/wooden-chest",
    "item/stone-brick",
    "item/distractor-capsule",
    "entity/dry-tree",
    "entity/tree-09-red",
    "entity/stone-rock",
    "entity/green-coral",
    "entity/player",
    "entity/tree-05",
    tooltip = {
      "Not here",
      "I just watch",
      "I am an owl, bird of the night. I see everything. I know everything.",
      "A day without sunshine is like, you know, night.",
      "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe."
    },
    verbs = {
      "lurked",
      "noned",
      "nothinged"
    }
  },
  ["Oil"] = {
    "item/storage-tank",
    "item/pipe-to-ground",
    "item/oil-refinery",
    "item/chemical-plant",
    "item/pumpjack",
    "fluid/crude-oil",
    "fluid/heavy-oil",
    "fluid/light-oil",
    "fluid/petroleum-gas",
    "fluid/lubricant",
    "fluid/sulfuric-acid",
    tooltip = {
      "We're running out of oil!",
      "Black gold",
      "Naturally occurring, yellow-to-black liquid found in geological formations beneath the Earth's surface, which is commonly refined into various types of fuels.",
      "Components of petroleum are separated using a technique called fractional distillation.",
      "The petroleum industry generally classifies crude oil by the geographic location it is produced in (e.g. West Texas Intermediate, Brent, or Oman), its API gravity (an oil industry measure of density), and its sulfur content."
    },
    verbs = {
      "lubricated",
      "sulfured"
    }
  },
  ["Cat"] = {
    "item/raw-fish",
    tooltip = {
      "=^.^=",
      "Meow",
      "In a cat's eye, all things belong to cats.",
      "Cats don't like change without their consent.",
      "Heard melodies are sweet, but those unheard, are sweeter",
      "God does not play dice with the universe"
    },
    verbs = {
      "mewed",
      "meowed",
      "miaowed"
    } 
  },
  ["Dog"] = {
    "entity/small-biter",
    "entity/medium-biter",
    "entity/big-biter",
    "entity/behemoth-biter",
    tooltip = {
      "Not a cat",
      "Friend",
      "It's not the size of the dog in the fight, it's the size of the fight in the dog.",
      "When what you want is a relationship, and not a person, get a dog",
      "A dog has one aim in life... to bestow his heart."
    },
    verbs = {
      "woofed"
    }
  }
}
}