local object

local function CreateObjectOnHand(model, offset, pos, rot)
    lib.requestModel(model)
    lib.requestAnimDict("anim@heists@box_carry@")
    
    local offset = offset or vec3(0.0, 0.0, 0.2)
    local pos = pos or vec3(0.2, 0.08, 0.2)
    local rot = rot or vec3(-45.0, 290.0, 0.0)

    object = CreateObject(model, GetEntityCoords(cache.ped) + vector3(offset.x or 0.0, offset.y or 0.0, offset.z or 0.2), true, false, false)

    TaskPlayAnim(cache.ped, "anim@heists@box_carry@", "idle", 3.0, -8, -1, 63, 0, 0, 0, 0)
    AttachEntityToEntity(object, cache.ped, GetPedBoneIndex(cache.ped, 60309), pos.x or 0.2, pos.y or 0.08, pos.z or 0.2,
        rot.x or -45.0, rot.y or 290.0, rot.z or 0.0, true, true, false, true, 1, true)

    CreateThread(function()
        while object and object > 0 and DoesEntityExist(object) do
            if not IsEntityPlayingAnim(cache.ped, "anim@heists@box_carry@", "idle", 63) then
                TaskPlayAnim(cache.ped, "anim@heists@box_carry@", "idle", 3.0, 3.0, -1, 63, 0, 0, 0, 0)
            end
            Wait(0)
        end
        ClearPedTasks(cache.ped)
        RemoveAnimDict("anim@heists@box_carry@")
    end)

    return object
end

local function RemoveOnHandObject()
    DeleteEntity(object)
    object = nil
    ClearPedTasks(cache.ped)
end

local function CheckItem(itemName, count)
    local prop = Config.Items[itemName]
    local totalCount = count or 1
    if prop then
        if totalCount >= (prop.requiredCount or 1) then
            CreateObjectOnHand(prop.propModel, prop.offset, prop.pos, prop.rot)
        else
            RemoveOnHandObject()
        end
    end
end

local function CheckItems()
    if not object then
        local items = exports.ox_inventory:GetPlayerItems()
        for _, data in pairs(items) do
            CheckItem(data.name)
        end
    end
end

if Config.Framework == "esx" then
    AddEventHandler("esx:playerLoaded", function()
        Wait(2000)
        CheckItems()
    end)

    AddEventHandler('esx:playerLogout', function()
        if object then
            DeleteEntity(object)
            object = nil
        end
    end)
else
    RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
    AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
        Wait(2000)
        CheckItems()
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload")
    AddEventHandler('QBCore:Client:OnPlayerUnload', function()
        if object then
            DeleteEntity(object)
            object = nil
        end
    end)
end

AddEventHandler('ox_inventory:itemCount', function(itemName, totalCount)
    CheckItem(itemName, totalCount)
end)

AddEventHandler('onResourceStop', function(rn)
    if rn ~= GetCurrentResourceName() then return end
    DeleteEntity(object)
end)
