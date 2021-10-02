# onset-code_loader
#### Put the code_loader.lua file in your package (load this file as shared) and edit the "Import" table to select which packages you want to import
#### Use "Import Name"_Loaded variable to check if something has loaded
#### Use (to know when something has loaded) : 
```lua
function ON_<Import Name>_LOADED()
   -- stuff
end
```