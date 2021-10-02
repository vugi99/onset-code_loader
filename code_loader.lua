
local Import = { -- Identifiers given by packages to identify the code they have loaded there, put the identifiers you want to import here (see package docs to know what they use?)
    --"code_loader_tester",
}

local function IsImportAllowed(Import_identifier)
    for i, v in ipairs(Import) do
        if v == Import_identifier then
            return true
        end
    end
    return false
end

for i, v in ipairs(Import) do
    _ENV["CodeLoaderNeed" .. v] = function()
        return true
    end
    AddFunctionExport("CodeLoaderNeed" .. v, _ENV["CodeLoaderNeed" .. v])
end

AddEvent("CodeLoaderLoad", function(Import_identifier, p_name, str_func)
    if IsImportAllowed(Import_identifier) then
        if GetPackageName() == p_name then
            if IsServer() then
                load(str_func, nil, "t", _ENV)()
            else
                loadstring(str_func)
            end
            if _ENV["ON_" .. Import_identifier .. "_LOADED"] then
                _ENV[Import_identifier .. "_Loaded"] = true
                _ENV["ON_" .. Import_identifier .. "_LOADED"]()
            end
        end
    end
end)

AddEvent("OnPackageStart", function()
    CallEvent("RequestCodeLoad", Import, GetPackageName())
end)