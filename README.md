# ScaleformController
A function I made to display scaleforms easily. Supports scaleform returns too.

Note that if you set the scaleform to return you should verify that the scaleform is meant to return a value. If it isn't, it will yield forever waiting for a return value.

Examples

Basic usage example
```
local scaleform = createScaleform("Scaleform_Name")
local willReturn = scaleform:functionThatWillReturn(true, functionArgs1, functionArgs2, ...) -- Will return a value
local wontReturn = scaleform:functionThatWillReturn(false, functionArgs1, functionArgs2, ...) -- Will not return (nil)
local infiniteYield = scaleform:functionThatWontReturn(true, functionArgs1, functionArgs2, ...) -- Will get stuck waiting for a return value
```

Return a value from a scaleform function
```
local scaleform = createScaleform("LOADINGSCREEN_STARTUP")
local numRows = scaleform:getLoadingScreenMovieClipName(true, 0) -- First argument being whether it should wait for a return value.
print(numRows)
```

Show a scaleform for 2 seconds
```
local scaleform = createScaleform("COUNTDOWN")
scaleform:SET_MESSAGE(false, "5")
scaleform(2000)
```

Show a scaleform for 2 seconds with more functions
```
local scaleform = createScaleform("COUNTDOWN")
scaleform:SET_MESSAGE(false, "yeet")
scaleform:SET_COUNTDOWN_LIGHTS(false, 2)
scaleform(2000)
```

Shows "wasted" for 2 seconds
```
local scaleform = createScaleform("MP_BIG_MESSAGE_FREEMODE")
scaleform:SHOW_SHARD_WASTED_MP_MESSAGE(false, "wasted", "You died nub")
scaleform(2000)
```
