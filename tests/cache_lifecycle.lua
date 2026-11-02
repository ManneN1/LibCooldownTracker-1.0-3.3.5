-- Run from the repository root with Lua 5.1. Blizzard APIs are mocked.

now = 100
zone = 'none'
strmatch = string.match
function GetTime() return now end
function GetServerTime() return math.floor(now) end
function IsInInstance() return zone ~= 'none', zone end
function IsRatedBattleground() return rated or false end
function wipe(t) for k in pairs(t) do t[k] = nil end return t end
function geterrorhandler() return function(e) error(e) end end
function GetSpellInfo(id) return 'Spell'..tostring(id), '', 'icon' end
function UnitGUID(unit) return unit == 'player' and 'playerGUID' or nil end
function UnitExists(unit) return unit == 'player' end
function UnitIsUnit(a,b) return a == b end
function UnitIsPlayer() return true end
function UnitName(unit) return unit end
function UnitAura() return nil end
function GetPlayerInfoByGUID() return 'Mage', 'MAGE' end
function strsplit(delimiter, value)
    local a,b = value:match('([^'..delimiter..']+)'..delimiter..'(.*)')
    return a or value, b
end
function tContains(t,v) for _,x in ipairs(t) do if x == v then return true end end end
bit = {band = function(a,b)
    local result, place = 0, 1
    while a > 0 and b > 0 do
        if a%2 == 1 and b%2 == 1 then result = result + place end
        a,b,place = math.floor(a/2), math.floor(b/2), place*2
    end
    return result
end}
bit_band = bit.band
COMBATLOG_OBJECT_TYPE_PLAYER = 1
COMBATLOG_OBJECT_REACTION_HOSTILE = 2
DEFAULT_CHAT_FRAME = {AddMessage = function() end}
function CreateFrame()
    local f = {scripts={}, events={}}
    function f:SetScript(k,v) self.scripts[k] = v end
    function f:GetScript(k) return self.scripts[k] end
    function f:RegisterEvent(k) self.events[k] = true end
    function f:UnregisterEvent(k) self.events[k] = nil end
    function f:UnregisterAllEvents() wipe(self.events) end
    function f:CreateTexture() return {SetAllPoints=function() end} end
    return f
end
function count(t) local n=0 for _ in pairs(t) do n=n+1 end return n end

dofile("libs/LibStub/LibStub.lua")
dofile("libs/CallbackHandler-1.0/CallbackHandler-1.0.lua")
LibStub:NewLibrary("LibSpecDetection-1.0", 1).GetSpecID = function() end
LCT_SpellData = {[1] = {cooldown=30}}
dofile("library.lua")

    CT=LibStub('LibCooldownTracker-1.0')
    assert(LCT_SpellData == nil)
    a,b,c = {},{},{}
    CT.RegisterCallback(a,'LCT_CooldownUsedByGUID',function() end)
    CT.tracked_players.keep = {spell=true}
    CT.RegisterCallback(b,'LCT_CooldownUsed',function() end)
    assert(CT.tracked_players.keep, 'second event subscription reset live state')
    CT.UnregisterAllCallbacks(a)
    assert(CT.frame.events.COMBAT_LOG_EVENT_UNFILTERED, 'remaining subscriber lost events')
    CT.Subscribe(CT,c,'LCT_CooldownUsedByGUID',function() end,'custom')
    CT.UnregisterAllCallbacks(b)
    assert(CT.frame.events.COMBAT_LOG_EVENT_UNFILTERED, 'prefix subscriber lost events')
    CT.Unsubscribe(CT,c,'LCT_CooldownUsedByGUID','custom')
    assert(not next(CT.tracked_players) and not next(CT.frame.events))
    assert(not CT.frame:GetScript('OnUpdate'))

CT.RegisterCallback(a, "LCT_CooldownUsedByGUID", function() end)
CT.frame:GetScript("OnEvent")(CT.frame, "COMBAT_LOG_EVENT_UNFILTERED", now,
    "SPELL_CAST_SUCCESS", "playerGUID", "Player", 1, nil, nil, nil, 1)
assert(CT:GetCooldownInfoByGUID("playerGUID", 1).cooldown_end == now + 30)
CT.UnregisterAllCallbacks(a)
assert(not next(CT.tracked_players))
LCT_SpellData = {[999] = {}}
dofile("library.lua")
assert(LCT_SpellData == nil)
print("PASS: multiple subscribers, prefix subscriptions, cache teardown and duplicate load")
