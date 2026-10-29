-- Writes settings_snapshot.lua back into the Rex app's preferences.
--
--   rex do ~/.config/rex/scripts/apply-settings.lua
--
-- Restart Rex afterwards so the Settings window picks up the new values.

local DOMAIN = "com.superlogical.rex"
local config = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/rex"
local settings = dofile(config .. "/settings_snapshot.lua")

local function hex(s)
	return (s:gsub(".", function(c)
		return string.format("%02x", c:byte())
	end))
end

local function arguments(value)
	local t = type(value)
	if t == "string" then
		return { "-string", value }
	elseif t == "boolean" then
		return { "-bool", tostring(value) }
	elseif t == "number" then
		if value == math.floor(value) then
			return { "-int", string.format("%d", value) }
		end
		return { "-float", tostring(value) }
	elseif t == "table" and value.float then
		return { "-float", tostring(value.float) }
	elseif t == "table" and value.json then
		return { "-data", hex(value.json) }
	elseif t == "table" then
		local args = { "-array" }
		for _, item in ipairs(value) do
			table.insert(args, tostring(item))
		end
		return args
	end
end

local keys = {}
for key in pairs(settings) do
	table.insert(keys, key)
end
table.sort(keys)

local applied, failed = 0, {}
for _, key in ipairs(keys) do
	local args = arguments(settings[key])
	if not args then
		table.insert(failed, key .. ": unsupported value")
	else
		local argv = { "defaults", "write", DOMAIN, key }
		for _, arg in ipairs(args) do
			table.insert(argv, arg)
		end
		local r, err = rex.exec(argv)
		if r and r.ok then
			applied = applied + 1
		else
			table.insert(failed, key .. ": " .. (r and r.stderr or tostring(err)))
		end
	end
end

for _, message in ipairs(failed) do
	rex.log("error", message)
end
return string.format("applied %d of %d settings; restart Rex to see them", applied, #keys)
