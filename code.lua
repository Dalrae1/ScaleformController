function createScaleform(scaleformName)
    local scaleform = RequestScaleformMovie(scaleformName)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    local scaleformTable = {}
    t1 = {
        __index = function(_, indexed)
            return function(_, ...)
                local args = {...}
                local expectingReturn = args[1]
                table.remove(args, 1)
                BeginScaleformMovieMethod(scaleform, indexed)
                for i,v in pairs(args) do
                    if type(v) == "string" then
                        ScaleformMovieMethodAddParamTextureNameString(v)
                    elseif type(v) == "number" then
                        if math.type(v) == "float" then
                            ScaleformMovieMethodAddParamFloat(v)
                        else
                            ScaleformMovieMethodAddParamInt(v)
                        end
                    elseif type(v) == "boolean" then
                        ScaleformMovieMethodAddParamBool(v)
                    end
                end
                local value = EndScaleformMovieMethodReturn()
                if expectingReturn then
                    while not IsScaleformMovieMethodReturnValueReady(value) do
                        Wait(0)
                    end
                    local returnString = GetScaleformMovieMethodReturnValueString(value)
                    local returnInt = GetScaleformMovieMethodReturnValueInt(value)
                    local returnBool = GetScaleformMovieMethodReturnValueBool(value)
                    EndScaleformMovieMethod()
                    if returnString ~= "" then
                        return returnString
                    end
                    if returnInt ~= 0 and not returnBool then
                        return returnInt
                    end
                    return returnBool
                end
            end
        end,
        __call = function(called, ms, r, g, b, a)
            local startScaleformTimer = GetGameTimer()
            CreateThread(function()
                repeat
                    Citizen.Wait(0)
                    DrawScaleformMovieFullscreen(scaleform, r or 255, g or 255, b or 255, a or 255)
                until GetGameTimer()-startScaleformTimer >= (ms or 2000)
            end)
        end
    }
    setmetatable(scaleformTable, t1)
    return scaleformTable
end
