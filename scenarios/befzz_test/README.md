Preffered role (band) selector
-----
Original code/idea(?) 3RaGaming tag.lua ( https://github.com/3RaGaming/3Ra-Enhanced-Vanilla )  
  
Install
---
1. Requires **event.lua** to work ( https://github.com/3RaGaming/utils )  
2. control.lua:
```lua
require "event.lua"
require "band.lua"
```

Customize
---
Edit **band_roles.lua**

Troubleshoot
----
All existing event handlers (in control.lua)
```lua
script.on_event( id, func )
script.on_load( id, func )
script.on_init( id, func )
script.on_configuration_changed( id, func )
```
must be replaced with
```
Event.register( id, func )
```
because **each execution of `script.on_*`** will **remove** previously attached event handler.
