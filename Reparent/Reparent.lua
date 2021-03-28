--Written by AstralKingdoms, this module is unfinished

--this code is bad in general, expect a rewrite

local RunService =  game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local HTTPService = game:GetService("HttpService")

local IsServer = RunService:IsServer()
local IsClient = RunService:IsClient()

local LockedServices = {
    ["SererSS"] = "ServerScriptService";
    ["Storage"] = "ServerStorage";
}

local Reparent = {}

function Reparent:Move(instanceObj, target)
    assert(typeof(instanceObj) == "Instance", "argument #1, instance expected got "..typeof(instanceObj))
    assert(typeof(target) == "Instance", "argument #2, instance expected got "..typeof(target))
    
    if IsServer then
        instanceObj.Parent = target
    end

    --this is pretty much pointless, i'll do work on this tomorrow
    if IsClient then
        if target.Name == LockedServices["Storage"] or target.Name == LockedServices["ServerSS"] then
            warn("Attempted to move object to locked instance")
        else
            instanceObj.Parent = target
        end
    end
end

function Reparent:Swap(_sent_obj_one, _sent_obj_two, storedLoc)
    local isLocked = false

    assert(typeof(_sent_obj_one) == "Instance", "argument #1 instance expected got "..typeof(_sent_obj_one))
    assert(typeof(_sent_obj_two) == "Instance", "argument #2 instance expected got "..typeof(_sent_obj_two))

    storedLoc = _sent_obj_one.Parent

    if IsServer then
        _sent_obj_one.Parent = _sent_obj_two.Parent
        _sent_obj_two.Parent = storedLoc
    end
    
    --this is also pointless, and bad and point and bad
    if IsClient then
        if (not isLocked) then
            _sent_obj_one.Parent = _sent_obj_two.Parent
            _sent_obj_two.Parent = storedLoc
        end
    end
end

function Reparent:GetInstanceProperties()
    local Props = {}
    

    return Props
end

return Reparent