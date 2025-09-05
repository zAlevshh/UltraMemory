# 🧹 UltraMemory
UltraMemory is a **lightweight memory and resource manager for Roblox Lua**.  
It helps you track and safely clean up **Instances, events, tables, and custom objects** to prevent memory leaks.  

---

## ✨ Features
- 🚀 Lightweight and fast  
- 🧼 Automatic cleanup for `Instances`, `RBXScriptConnections`, `Tweens`, and tables  
- 🔄 Custom disposal logic for user-defined objects  
- 🔍 Simple and consistent API  

---

## 📦 Installation
1. Copy `UltraMemory.lua` into your Roblox project (e.g. in `ServerScriptService`).  
2. Require it in your scripts:

## 📦 Use Example

```lua
local UltraMemory = require(script.Parent:WaitForChild("./path/to/UltraMemory");

local newMemoryInstance = UltraMemory.new();

local Part: Part = Instance.new("Part");
Part.Parent = workspace;
Part.Name = "Testing";
Part:PivotTo(CFrame.new(-11.38, 0.5, -0.67));

newMemoryInstance:Add(Part);

local Connection = Part.Touched:Connect(function(hit: BasePart)
	print("Touched by: ", hit.Parent.Name);
end);

newMemoryInstance:Add(Connection);

local myTable = { foo = "bar", number = 123};
newMemoryInstance:Add(myTable);


task.delay(10, function()
	print("Cleaning all the resources!");
	newMemoryInstance:DisposeAll();
end);
```
