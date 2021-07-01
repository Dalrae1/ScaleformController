# ScaleformController
A function I made to display scaleforms easily. Supports scaleform returns too.

Note that if you set the scaleform to return you should verify that the scaleform is meant to return a value. If it isn't, it will yield forever waiting for a return value.

Examples

Basic usage example
```
local scaleform = createScaleform("Scaleform_Name")
local functions = scaleform:functionThatWillReturn(functionArgs1, functionArgs2, ...,cb(results)) -- Will return a value when last having a cb action
local functionsnotreturn = scaleform:functionThatWillReturn(functionArgs1, functionArgs2, ...) -- Without return values
```

Return a value from a scaleform function
```
local scaleform = createScaleform("LOADINGSCREEN_STARTUP")
local numRows = scaleform:getLoadingScreenMovieClipName(0,function(num) --cb
    print(num)
end )
```

Show a scaleform for 2 seconds
```
local scaleform = createScaleform("COUNTDOWN")
scaleform:SET_MESSAGE("5")
scaleform(2000)
```

Show a scaleform for 2 seconds with more functions
```
local scaleform = createScaleform("COUNTDOWN")
scaleform:SET_MESSAGE("yeet")
scaleform:SET_COUNTDOWN_LIGHTS(2)
scaleform(2000)
```

Shows "wasted" for 2 seconds
```
local scaleform = createScaleform("MP_BIG_MESSAGE_FREEMODE")
scaleform:SHOW_SHARD_WASTED_MP_MESSAGE("wasted", "You died nub")
scaleform(2000)
```
