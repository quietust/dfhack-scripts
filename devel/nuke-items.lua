-- Delete ALL items not held by units, buildings or jobs

local count = 0

for _,v in ipairs(df.global.world.items.all) do
    if not (v.flags.in_building or v.flags.construction or v.flags.in_job
            or dfhack.items.getGeneralRef(v,df.general_ref_type.UNIT_HOLDER)) then
        count = count + 1
        dfhack.items.remove(v)
    end
end

print('Deletion requested: '..count)
