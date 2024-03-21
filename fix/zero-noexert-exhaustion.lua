--checks all units for the NOEXERT tag, and sets their Exhaustion counter to zero
--NOEXERT units (including Vampires, Necromancers, and Intelligent Undead) are unable to lower their Exhaustion, and are not supposed to gain Exhaustion.
--at least one activity (Individual Combat Training) doesn't respect NOEXERT, and will leave NOEXERT units permanently Tired. This script will fix 'Tired' NOEXERT units. Running it on repeat approximately at least every 350 ticks should prevent them from ever becoming Tired.
--Individual Combat Training seems to add 50 Exhaustion approximately every 9 ticks. 'Tired' appears at 2000 Exhaustion.

function isNoExert(u)
	if(u.curse.rem_tags1.NOEXERT) then --tag removal overrides tag addition, so if the NOEXERT tag is removed the unit cannot be NOEXERT.
		return false
	end
	if(u.curse.add_tags1.NOEXERT) then--if the tag hasn't been removed, and the unit has a curse that adds it, they must be NOEXERT.
		return true
	end
	if(dfhack.units.casteFlagSet(u.race,u.caste, df.caste_raw_flags.NOEXERT)) then --if the tag hasn't been added or removed, but their race and caste has the tag, they're NOEXERT.
		return true
	end
end

function fixNoExertExhaustion()
	for _, unit in ipairs(df.global.world.units.active) do
        if(isNoExert(unit)) then
			unit.counters2.exhaustion = 0	-- 0 represents no Exhaustion. NOEXERT units should never have Exhaustion above 0.
		end
    end
end

fixNoExertExhaustion()