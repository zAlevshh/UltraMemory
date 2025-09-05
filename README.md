Example Script:

local UltraMemory = require(script.Parent:WaitForChild("UltraMemory"));

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
