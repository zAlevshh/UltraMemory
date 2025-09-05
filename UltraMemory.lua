--!strict
--[=[
	Author: Xhuzzzz

	UltraMemory is a lightweight cleanup and resource management module for Roblox.
	It provides a unified way to track, dispose, and recycle objects such as Instances, connections, and tables.
]=]--

local UltraMemory = {}
UltraMemory.__index = UltraMemory;


local cleaners = {};

cleaners.Instance = function(obj: Instance)
	if (obj:IsA("Tween")) then
		obj:Cancel();
	end;
	obj:Destroy();
end;

cleaners.RBXScriptConnection = function(conn: RBXScriptConnection)
	if (conn.Connected) then
		conn:Disconnect();
	end;
end;

cleaners.table = function(t: {[any]: any})
	for k, v in pairs(t) do
		local cleaner = cleaners[typeof(v)];
		if (cleaner) then
			cleaner(v);
		end;
		t[k] = nil;
	end;
end;

function UltraMemory.new()
	return setmetatable({
		items = table.create(32);
		count = 0;
	}, UltraMemory) 
end;

function UltraMemory:Add(...:any)
	for i = 1, select("#", ...) do
		local v = select(i, ...);
		self.count += 1;
		self.items[self.count] = v;
	end;
end;

function UltraMemory:GetByIndex(index: number)
	return self.items[index];
end;

function UltraMemory:DisposeByIndex(index: number)
	local v = self.items[index];
	if (v) then
		local cleaner = cleaners[typeof(v)];
		if (cleaner) then
			cleaner(v);
		end;
		self.items[index] = self.items[self.count];
		self.items[self.count] = nil;
		self.count -= 1;
	end;
end;

function UltraMemory:DisposeAll()
	for i = self.count, 1, -1 do
		local v = self.items[i];
		local cleaner = cleaners[typeof(v)];
		if (cleaner) then
			cleaner(v);
		end
		self.items[i] = nil;
	end;
	self.count = 0;
end;


return UltraMemory;
