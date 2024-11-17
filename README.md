# **Information**
Based on [LibCooldownTracker-1.0](https://github.com/vendethiel/LibCooldownTracker-10), thanks Vendethiel and team for the source.

Primary changes:
- Utilizes GUIDs instead of unitIDs such that it can be utilized by many more AddOns (maintains backwards compatibility with the old events).
- Supports cross-platform (RCE-TBC/WotLK, primarily)
- Built-in spec detection via LibSpecDetection-1.0 (instead of GladiusEx)

## **Usage**
```
Callbacks:
        LCT_CooldownUsed(unitid, spellid, isEnemy)
        LCT_CooldownUsedByGUID(guid, spellid, isEnemy)
        LCT_CooldownsReset(unitid)
        LCT_CooldownsResetByGUID(guid)

Functions:
        success = lib:Subscribe(self, event, [prefix])
        success = lib:Unsubscribe(self, event, [prefix])
        tpu = lib:GetUnitCooldownInfo(unitid, spellid, [prefix])
        tpu = lib:GetCooldownInfoByGUID(guid, spellid, [prefix])
        lib:AddCustomSpell(spellid, info, prefix)
        spellid, spell_data in lib:IterateCooldowns(class, specID, race, [prefix])
        spell_data = lib:GetCooldownData(spellid, [prefix])
        spells_data = lib:GetCooldownsData()
```
## **Examples**
```lua
    -- Example 1: Registering a callback and retrieving cooldown data

    local function OnCooldownUsed(event, guid, spellid, isEnemy)
        print("Cooldown used: Event =", event, "GUID =", guid, "Spell ID =", spellid, "Is Enemy =", isEnemy)
        
        -- Get the cooldown data for the spell
        local spell_data = lib:GetCooldownData(spellid, "myAddOnPrefix")
        if spell_data then
            print("Spell cooldown:", spell_data.cooldown)
            print("Class:", spell_data.class)
        end

        -- Get the current cooldown state for the unit
        local currentData = lib:GetCooldownInfoByGUID(guid, spellid, "myAddOnPrefix")
        if currentData then
            print("Current cooldown start:", currentData.cooldown_start)
            print("Current cooldown end:", currentData.cooldown_end)
        end
    end

    -- Register the callback
    local success = lib:Subscribe(self, "LCT_CooldownUsedByGUID", OnCooldownUsed, "myAddOnPrefix")
    if success then
        print("Callback registered successfully for myAddOnPrefix")
    end
```
```lua
    -- Example 2: Iterating over all cooldowns for a specific class and prefix

    for spellid, spell_data in lib:IterateCooldowns("MAGE", nil, nil, "myAddOnPrefix") do
        print("Spell ID:", spellid)
        print("Spell cooldown:", spell_data.cooldown)
        print("Class:", spell_data.class)
        if spell_data.specID then
            print("Spec IDs:", table.concat(spell_data.specID, ", "))
        end
    end
```
```lua
    -- Example 3: Create a custom spell and update an existing spell definition

    -- Define a new custom spell
    local customSpellID = 999999  -- A unique spell ID for the custom spell
    local customSpellData = {
        cooldown = 120,                         -- Cooldown duration in seconds
        class = "SHAMAN",                       -- Class associated with the spell
        cooldown_overload = { [262] = 60, },    -- Lower cooldown for Elemental
        sets_cooldowns = {                      -- Spells affected by this cooldown
            { spellid = 51505, cooldown = 10 }, -- Lava Burst, 10-second cooldown
            { spellid = 32182, cooldown = 300 } -- Heroism, 5-minute cooldown
        },
    }
    
    -- Add the custom spell to the library under a specific prefix
    lib:AddCustomSpell(customSpellID, customSpellData, "myAddOnPrefix")
    print("Custom spell added successfully:", customSpellID, customSpellData.name)
    
    -- Update an existing spell definition
    local existingSpellID = 51505  -- Spell ID for Lava Burst
    local updatedSpellData = {
        cooldown = 6,                -- Adjusted cooldown duration
        class = "SHAMAN",            -- Class remains the same
        specID = { 262, 263 },       -- Optional: spell only exists for Elemental and Enhancement
        sets_cooldowns = {           -- Update linked cooldowns
            { spellid = 999999, cooldown = 120 }, -- Custom Spell, 2-minute cooldown
        },
    }

    -- Assuming the existingSpellID already exists, an updated variant connected to the
    -- addon prefix "myAddonPrefix" will be created
    lib:AddCustomSpell(existingSpellID, updatedSpellData, "myAddOnPrefix")


```
### **Prefixes**:	

Prefixes are used to differentiate addons from one another, such that events for custom defined / updated spellIDs can be sent only to the correct subscriber(s) (callback). 

You only have to use prefixes if you want to support adding custom spells / configurations in your AddOn.

If you havn't defined a custom variation of a spell which already exists in the base configuration of the library, you will get the data for the base (non-custom) version of that spell.

The library will maintain extra data for each custom variation of spells defined by users of the library. **Don't subscribe with a prefix unless you actually need to, it will only consume more CPU/memory for the client.**
