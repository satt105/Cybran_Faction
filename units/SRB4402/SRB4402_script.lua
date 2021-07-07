--------------------------------------------------------------------------------
--  Summary:  Cybran Omni Disrupter
--   Author:  Sean 'Balthazar' Wheeldon
--------------------------------------------------------------------------------
local CRadarJammerUnit = import('/lua/cybranunits.lua').CRadarJammerUnit
local BareBonesWeapon = import('/lua/sim/defaultweapons.lua').BareBonesWeapon
local Utilities = import('/lua/utilities.lua')
local AIUtils = import('/lua/ai/aiutilities.lua')
local tableinsert = table.insert
local CreateAttachedEmitter = CreateAttachedEmitter
local WaitSeconds = WaitSeconds

SRB4402 = Class(CRadarJammerUnit) {
    Weapons = {
        PulseWeapon = Class(BareBonesWeapon) {
            OnFire = function(self)
                local aiBrain = self.unit:GetAIBrain()
                local Mypos = self.unit:GetPosition()
                local Range = self.MaxRadius or 2000
                local LocalUnits = {}
                for index, brain in ArmyBrains do
                    for i, unit in AIUtils.GetOwnUnitsAroundPoint(brain, categories.ALLUNITS - categories.COMMAND - categories.SUBCOMMANDER - categories.DARKNESSIMMUNE - categories.WALL - categories.MEDIUMWALL - categories.HEAVYWALL - categories.BENIGN, Mypos, Range) do
                        tableinsert(LocalUnits, unit)
                    end
                end
                for k, v in LocalUnits do
                    if v:IsIntelEnabled('Omni') then
                        Buff.ApplyBuff(v, 'DarknessOmniNerf')
                    end
                end
                self:PlaySound(self:GetBlueprint().Audio.Fire)
                self:PlayDarknessAnimation()
                self:CreateDarknessEffects()
            end,

            PlayDarknessAnimation = function(self)
                if self.ArmWaitThread then
                    KillThread(self.ArmWaitThread)
                end
                for k, v in self.unit.Rotator do
                    v:SetGoal(-50)
                    v:SetSpeed(1900)
                end
                self.ArmWaitThread = ForkThread(
                    function()
                        WaitTicks(1)
                        for k, v in self.unit.Rotator do
                            v:SetGoal(0)
                            v:SetSpeed(25)
                        end
                    end
                )
            end,

            CreateDarknessEffects = function(self)
                local army = self.unit:GetArmy()
                local epathR = '/effects/emitters/destruction_explosion_concussion_ring_03_emit.bp'
                local epathQ = '/effects/emitters/cybran_qai_shutdown_ambient_0'
                CreateAttachedEmitter(self.unit, 0, army, '/effects/emitters/flash_01_emit.bp'):ScaleEmitter( 20 ):OffsetEmitter( 0, 4, 0 )
                CreateAttachedEmitter(self.unit, 'XRC2201', army, epathR):OffsetEmitter( 0, 4, 0 )
                CreateAttachedEmitter(self.unit, 'XRC2201', army, epathR):ScaleEmitter( 3 ):OffsetEmitter( 0, 4, 0 )
                CreateAttachedEmitter(self.unit, 'XRC2201', army, epathR):ScaleEmitter( 6 ):OffsetEmitter( 0, 4, 0 )
                for i = 1, 4 do
                    CreateAttachedEmitter(self.unit, 0, army, epathQ .. i .. '_emit.bp')
                end
            end,
        },
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CRadarJammerUnit.OnStopBeingBuilt(self,builder,layer)
        if not self.Rotator then
            self.Rotator = {}
            self.Rotator.B01 = CreateRotator(self, ' B01', 'x')
            self.Rotator.B02 = CreateRotator(self, ' B02', 'x')
            self.Rotator.B03 = CreateRotator(self, ' B03', 'x')
        end
        if self.IntelEffects and not self.IntelFxOn then
            self.IntelEffectsBag = {}
            self.CreateTerrainTypeEffects( self, self.IntelEffects, 'FXIdle',  self:GetCurrentLayer(), nil, self.IntelEffectsBag )
            self.IntelFxOn = true
        end
        self.Intel = true
        self:ForkThread(self.FirePulse, self)
    end,

    OnIntelEnabled = function(self)
        self.Intel = true
        --self:ForkThread(self.FirePulse, self)
        CRadarJammerUnit.OnIntelEnabled(self)
    end,

    OnIntelDisabled = function(self)
        self.Intel = false
        CRadarJammerUnit.OnIntelDisabled(self)
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        CRadarJammerUnit.OnKilled(self, instigator, type, overkillRatio)
    end,

    FirePulse = function(self)
        while true do
            if self.Intel then
                WaitSeconds(2.5)
                --if aiBrain:GetEconomyIncome('ENERGY')
                self:GetWeaponByLabel('PulseWeapon'):FireWeapon()
                WaitSeconds(2.5)
            else
                WaitSeconds(1)
            end
        end
    end,

    IntelEffects = {
        {
            Bones = {
            	' B01',
            	' B02',
            	' B03',
            },
            Offset = {
              	0,
              	2,
              	0,
            },
            Type = 'Jammer01',
        },
    },
}
TypeClass = SRB4402
