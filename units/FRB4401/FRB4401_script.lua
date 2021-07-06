#****************************************************************************
#**
#**  File     :  /units/URB4401/URB4401_script.lua
#**  Author(s):  David Tomandl, Greg Kohne, thebigalex (Edit to experimental Shield)
#**
#**  Summary  :  Cybran Experimental Shield Generator MK I Script
#**
#**  Copyright © 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CShieldStructureUnit = import('/lua/cybranunits.lua').CShieldStructureUnit
local Shield = import('/lua/shield.lua').Shield

FRB4401 = Class(CShieldStructureUnit) {
    
    ShieldEffects = {
                '/effects/emitters/cybran_shield_02_generator_01_emit.bp',
                '/effects/emitters/cybran_shield_02_generator_02_emit.bp',
                '/effects/emitters/cybran_shield_02_generator_03_emit.bp',
    },
    
    OnStopBeingBuilt = function(self,builder,layer)
        CShieldStructureUnit.OnStopBeingBuilt(self,builder,layer)
        self.Rotator1 = CreateRotator(self, 'Shaft', 'z', nil, 30, 5, 30)
        self.Trash:Add(self.Rotator1)
		self.ShieldEffectsBag = {}

    end,

    OnShieldEnabled = function(self)
        CShieldStructureUnit.OnShieldEnabled(self)
        if self.Rotator1 then
            self.Rotator1:SetTargetSpeed(10)
        end
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
		    self.ShieldEffectsBag = {}
		end
        for k, v in self.ShieldEffects do
            table.insert( self.ShieldEffectsBag, CreateAttachedEmitter( self, 'Shaft', self:GetArmy(), v ) )
        end

    end,

    OnShieldDisabled = function(self)
        CShieldStructureUnit.OnShieldDisabled(self)
        self.Rotator1:SetTargetSpeed(0)
        
        if self.ShieldEffectsBag then
            for k, v in self.ShieldEffectsBag do
                v:Destroy()
            end
	    self.ShieldEffectsBag = {}
	end
    end,
}

TypeClass = FRB4401