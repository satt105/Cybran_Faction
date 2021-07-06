#****************************************************************************
#**
#**  File     :  /data/units/URO1102/URO1102_script.lua
#**  Author(s):  Jessica St. Croix 
#**				modified by Asdrubaelvect
#**  Summary  :  Cybran support spaceships
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CAirUnit = import('/lua/cybranunits.lua').CAirUnit
local CAAAutocannon = import('/lua/cybranweapons.lua').CAAAutocannon
local CIFMissileLoaWeapon = import('/lua/cybranweapons.lua').CIFMissileLoaWeapon

URO1102 = Class(CAirUnit) {
   
	Weapons = {
        AAGun = Class(CAAAutocannon) {
            FxMuzzleScale = 2.25,
        },
		MissileRack = Class(CIFMissileLoaWeapon) {
		},
	},

}

TypeClass = URO1102