-- handling for TBC on the 3.3.5 client
if GetAccountExpansionLevel() ~= 1 then return end

-- ================ ROGUE ================

local SPEC_ROGUE_ASSA = 259
local SPEC_ROGUE_COMBAT = 260
local SPEC_ROGUE_SUB = 261

-- Blind
LCT_SpellData[2094] = {
  class = "ROGUE",
  opt_lower_cooldown = 90,
  cooldown = 180,
  cooldown_overload = { [SPEC_ROGUE_SUB] = 90, },
}

-- Blade Flurry
LCT_SpellData[13877] = {
  cooldown = 120,
  class = "ROGUE",
  talent = true,
  specID = { SPEC_ROGUE_COMBAT },
}

-- Cold Blood
LCT_SpellData[14177] = {
  cooldown = 180,
  class = "ROGUE",
  cooldown_starts_on_aura_fade = true,
  talent = true,
  specID = { SPEC_ROGUE_ASSA },
}

-- Shadowstep
LCT_SpellData[36554] = {
  cooldown = 30,
  class = "ROGUE",
  talent = true,
  specID = { SPEC_ROGUE_SUB },
}

-- Kick
LCT_SpellData[1766] = {
  cooldown = 10,
  class = "ROGUE",
  interrupt = true,
}
LCT_SpellData[1768] = 1766
LCT_SpellData[1769] = 1766
LCT_SpellData[38768] = 1766
LCT_SpellData[1767] = 1766

-- Distract
LCT_SpellData[1725] = {
  cooldown = 30,
  class = "ROGUE",
}

-- Evasion
LCT_SpellData[5277] = {
  class = "ROGUE",
  opt_lower_cooldown = 210,
  cooldown = 300,
  cooldown_overload = { [SPEC_ROGUE_COMBAT] = 210, },
}
LCT_SpellData[26669] = 5277

-- Sprint
LCT_SpellData[2983] = {
  class = "ROGUE",
  opt_lower_cooldown = 210,
  cooldown = 300,
  cooldown_overload = { [SPEC_ROGUE_COMBAT] = 210, },
}
LCT_SpellData[11305] = 2983
LCT_SpellData[8696] = 2983

-- Vanish
LCT_SpellData[1856] = {
  class = "ROGUE",
  opt_lower_cooldown = 210,
  cooldown = 300,
  cooldown_overload = { [SPEC_ROGUE_SUB] = 210, },
}
LCT_SpellData[26889] = 1856
LCT_SpellData[1857] = 1856

-- Riposte
LCT_SpellData[14251] = {
  cooldown = 6,
  class = "ROGUE",
  talent = true,
  specID = { SPEC_ROGUE_COMBAT },
}

-- Feint
LCT_SpellData[1966] = {
  cooldown = 10,
  class = "ROGUE",
}
LCT_SpellData[6768] = 1966
LCT_SpellData[25302] = 1966
LCT_SpellData[11303] = 1966
LCT_SpellData[8637] = 1966
LCT_SpellData[27448] = 1966

-- Ghostly Strike
LCT_SpellData[14278] = {
  cooldown = 20,
  class = "ROGUE",
}

-- Stealth
LCT_SpellData[1784] = {
  class = "ROGUE",
  opt_lower_cooldown = 5, -- Camouflage talent
  cooldown_starts_on_aura_fade = true,
  cooldown = 10,
  cooldown_overload = { [SPEC_ROGUE_SUB] = 5, },
}
LCT_SpellData[1785] = 1784
LCT_SpellData[1786] = 1784
LCT_SpellData[1787] = 1784

-- Adrenaline Rush
LCT_SpellData[13750] = {
  cooldown = 300,
  class = "ROGUE",
  talent = true,
  specID = { SPEC_ROGUE_COMBAT },
}

-- Premeditation
-- Cannot track this as it's only in stealth...
--LCT_SpellData[14183] = {
--  cooldown = 120,
--  class = "ROGUE",
--  talent = true,
--}

-- Preparation
LCT_SpellData[14185] = {
  cooldown = 600,
  class = "ROGUE",
  talent = true,
  resets = { 5277, 2983, 1856, 14177, 36554 }, -- TODO
  specID = { SPEC_ROGUE_SUB },
}

-- Kidney Shot
LCT_SpellData[408] = {
  cooldown = 20,
  class = "ROGUE",
}
LCT_SpellData[8643] = 408

-- Gouge
LCT_SpellData[1776] = {
  class = "ROGUE",
  opt_lower_cooldown = 9, -- Rare Lvl 70 PvP set + 60 sets
  cooldown = 10,
}
LCT_SpellData[11286] = 1776
LCT_SpellData[1777] = 1776
LCT_SpellData[38764] = 1776
LCT_SpellData[11285] = 1776
LCT_SpellData[8629] = 1776

-- Cloak of Shadows
LCT_SpellData[31224] = {
  cooldown = 60,
  class = "ROGUE",
}