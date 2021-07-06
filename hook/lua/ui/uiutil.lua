local version = tonumber( (string.gsub(string.gsub(GetVersion(), '1.5.', ''), '1.6.', '')) )

if version < 3652 then -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function
	LOG('Experimentalcybran: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is older then 3652. Hooking "UIFile" to add our own unit icons')

local MyUnitIdTable = {
   url0405=true, -- Monkeylord - (Experimental Spiderbot)
   ual0405=true, -- Galactic Colossus - (Experimental Assault Bot)
   ueb4205=true, -- Light Parashield - (Light Shield Generator)
   xsse0001=true, -- The Tlacuconos - (Experimental Tech1 Spaceship)
   urb5001=true, -- Eclispe - (Heavy Stealth Field Generator)
   xsl0310=true, -- Mobile Nuke Laucnher - (Mobile Nuke Laucnher)
   urb4401=true, -- Experimentale Heavy Nuke Denfense - (Anti Nuke Experimental)
   ura0205=true, -- The Hawk - (EMP Bomber)
   ual0311=true, -- EMP Missile Launcher - (EMP Missile Launcher)
   xsl0206=true, -- Ohiescebom - (Mobile Anti-Subs Launcher)
   url0206=true, --  The Turtle - (Amphibious Heavy Tank)
   uas0301=true, -- Submarine Battleship - (Submarine Battleship)
   uea0306=true, -- Tornado - (Fighter/Bomber)
   uese0001=true, -- EFOF Cleaner - (Tech1 Experimental Spaceship)
   uase0001=true, -- The Falling Star - (Experimental Tech1 Spaceship)
   url0311=true, -- Tech 3 Missile Bot - (Tech 3 Missile Bot)
   uab2310=true, -- Heavy Experimental Defense Installation  - (Heavy Experimental Defense Installation )
   urb5201=true, -- Shaker - (Tech 1 Air Staging Facility)
   ura0110=true, -- Support Bomber - (Support Bomber)
   uea0402=true, -- EFOF Transport - (Transport)
   uab5201=true, --  Tech 1 Air Staging Facility - (Air Staging Facility)
   urbse0001=true, -- Phlegyas - (Heavy Orbital Defence)
   uelew0001=true, -- SmallBoy - (Heavy Mobile Fortress Experimental)
   ualew0001=true, -- Hover Tank Experimental tech 1 - (Hover Tank Experimental tech 1)
   xsl0302=true, -- Cube - (Support Armored Command Unit)
   url0302=true, -- Ringer - (Assault Armored Command Unit)
   urlew0001=true, -- Albatros - (Heavy Experimentale Missile Launcher Bot)
   uabse0001=true, -- The Missionary - (Heavy Orbital Defence)
   xsl0405=true, -- Ythotha - (Experimental Assault Bot)
   xrl0405=true, -- Megalith - (Experimental Megabot)
   ueb5201=true, -- Tech 1 Air Staging Facility - (Air Staging Facility)
   ead0001=true, -- Triad - (Point Defense)
   uea0110=true, -- AS-U 010 Protector - (Support Bomber)
   xsb5201=true, -- Mini-Iathu-uhthe - (Air Staging Beacon)
   uea0401=true, -- EFOF Infallible - (Spaceships)
   xsb2306=true, -- Heavy Point Defense - (Heavy Point Defense)
   uel0108=true, -- SD-MA12 Bunker - ( Deployable Medium Tank)
   xsbse2001=true, -- The Tlatoanum - (Heavy Orbital Defence)
   ual0108=true, -- Ouaip - (Mobile Torpedo Launcher)
   xsl0110=true, -- Ehuhua - (Mobile Shield Generator)
   urse0001=true, -- The Land Shadow - (Experimental Tech1 Spaceship)
   uebse0001=true, -- The Eradicator - (Heavy Orbital Defence)
   ual5001=true, -- The Renaissance - (Mobile Air Staging Platform )
   ual0305=true, -- Gerridae - (Heavy Hover Tank)
   xsle0001=true, -- Axe - (Experimental Assault Bot)
   xsa0306=true, -- Virutola - (Gunship)
   uel0206=true, -- Morter Tank - (Morter Tank)
   ual0302=true, -- Cliper - (Support Armored Command Unit)
}

	local IconPath = "/Mods/Experimentalcybran"
	-- Adds icons to the engeneer/factory buildmenu
	local oldUIFile = UIFile
	function UIFile(filespec)
		local IconName = string.gsub(filespec,'_icon.dds','')
        IconName = string.gsub(IconName,'/icons/units/','')
		if MyUnitIdTable[IconName] then
			local curfile =  IconPath .. filespec
			return curfile
		end
		return oldUIFile(filespec)
	end

else
	LOG('Experimentalcybran: [uiutil.lua '..debug.getinfo(1).currentline..'] - Gameversion is 3652 or newer. No need to insert the unit icons by our own function.')
end -- All versions below 3652 don't have buildin global icon support, so we need to insert the icons by our own function