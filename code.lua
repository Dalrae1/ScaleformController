function createScaleform(scaleformName)
    local scaleform = RequestScaleformMovie(scaleformName)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    local scaleformTable = {}
    t1 = {
        __index = function(_, indexed)
            return function(_, ...)
                local temp_args = {...}
                local expectingReturn =false 
                local thiscb = nil 
                if type(temp_args[#temp_args]) == 'function' then 
                    expectingReturn = true 
                    thiscb = temp_args[#temp_args]
                end 
                table.remove(temp_args,#temp_args)
                local args = temp_args
                
                
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
                    CreateThread(function()
                        while not IsScaleformMovieMethodReturnValueReady(value) do
                            Wait(0)
                        end
                        local returnString = GetScaleformMovieMethodReturnValueString(value)
                        local returnInt = GetScaleformMovieMethodReturnValueInt(value)
                        local returnBool = GetScaleformMovieMethodReturnValueBool(value)
                        EndScaleformMovieMethod()
                        if returnString ~= "" then
                            thiscb(returnString)
                            return 
                        end
                        if returnInt ~= 0 and not returnBool then
                            thiscb(returnInt)
                            return 
                        end
                        thiscb(returnBool)
                        return 
                    end)
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
                return 
            end)
        end
    }
    setmetatable(scaleformTable, t1)
    return scaleformTable
end
