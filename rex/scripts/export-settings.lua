-- Writes the settings made in the Rex app's Settings window to settings_snapshot.lua.
--
--   rex do ~/.config/rex/scripts/export-settings.lua
--
-- init.lua can't set these, so they live in their own file. Restore them on
-- another Mac with scripts/apply-settings.lua.

local DOMAIN = "com.superlogical.rex"
local config = (os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")) .. "/rex"
local path = config .. "/settings_snapshot.lua"

-- Window positions, caches, update checks, and per-session state belong to
-- this machine, not to the configuration.
local skip_prefixes = { "NS", "SU", "Onboarding.", "RexSync.", "rex.local-server.", "rex.sync." }
local skip = {
	["rex.server.run-mode"] = true,
	["Workspace.lastFocusedSession"] = true,
	["Workspace.programActivitySeen"] = true,
}
local keep = { ["SUEnableAutomaticChecks"] = true }

local function skipped(key)
	if keep[key] then
		return false
	end
	if skip[key] then
		return true
	end
	for _, prefix in ipairs(skip_prefixes) do
		if key:sub(1, #prefix) == prefix then
			return true
		end
	end
	return false
end

-- Lua can't see the value types in `defaults read`, so read them through
-- Foundation. Data that holds JSON (like custom themes) comes back as text.
local reader = [[
ObjC.import('Foundation');
const dom = $.NSUserDefaults.standardUserDefaults.persistentDomainForName(']] .. DOMAIN .. [[');
const out = {};
if (dom.isNil()) { JSON.stringify(out); } else {
for (const k of ObjC.deepUnwrap(dom.allKeys)) {
  const v = dom.objectForKey(k);
  if (v.isKindOfClass($.NSString)) out[k] = { type: 'string', value: v.js };
  else if (v.isKindOfClass($.NSNumber)) {
    const t = v.objCType;
    out[k] = t === 'c' || t === 'B' ? { type: 'bool', value: !!v.boolValue }
      : { type: t === 'f' || t === 'd' ? 'float' : 'int', value: v.doubleValue };
  } else if (v.isKindOfClass($.NSArray)) out[k] = { type: 'array', value: ObjC.deepUnwrap(v) };
  else if (v.isKindOfClass($.NSData)) {
    const s = $.NSString.alloc.initWithDataEncoding(v, $.NSUTF8StringEncoding);
    try { out[k] = { type: 'json', value: JSON.stringify(JSON.parse(s.js), null, 2) }; } catch (e) {}
  }
}
JSON.stringify(out);
}
]]

local r, err = rex.exec({ "osascript", "-l", "JavaScript", "-e", reader })
if not r then
	error("couldn't run osascript: " .. tostring(err))
end
if not r.ok then
	error("couldn't read " .. DOMAIN .. ": " .. r.stderr)
end
local prefs = assert(rex.json.decode(r.stdout))

local keys = {}
for key, pref in pairs(prefs) do
	local simple = pref.type ~= "array"
	if pref.type == "array" then
		simple = true
		for _, item in ipairs(pref.value) do
			simple = simple and type(item) == "string"
		end
	end
	if simple and not skipped(key) then
		table.insert(keys, key)
	end
end
table.sort(keys)

local function long_string(s)
	local level = ""
	while s:find("]" .. level .. "]", 1, true) do
		level = level .. "="
	end
	return "[" .. level .. "[\n" .. s .. "\n]" .. level .. "]"
end

local function number(pref)
	local n = pref.value
	if pref.type == "float" and n == math.floor(n) then
		return string.format("%d.0", n)
	end
	return tostring(n)
end

local lines = {
	"-- Generated snapshot of the Rex app's preferences. Edit in Rex, then regenerate.",
	"-- Regenerate: rex do ~/.config/rex/scripts/export-settings.lua",
	"-- Restore:    rex do ~/.config/rex/scripts/apply-settings.lua, then restart Rex",
	"--",
	"-- Keys are the app's preference names. A float = n entry keeps a whole",
	"-- number stored as a decimal; { json = ... } is stored as JSON data.",
	"return {",
}
for _, key in ipairs(keys) do
	local pref = prefs[key]
	local value
	if pref.type == "string" then
		value = string.format("%q", pref.value)
	elseif pref.type == "bool" then
		value = tostring(pref.value)
	elseif pref.type == "int" then
		value = number(pref)
	elseif pref.type == "float" then
		value = "{ float = " .. number(pref) .. " }"
	elseif pref.type == "array" then
		local items = {}
		for i, item in ipairs(pref.value) do
			items[i] = string.format("%q", item)
		end
		value = "{ " .. table.concat(items, ", ") .. (#items > 0 and " }" or "}")
	elseif pref.type == "json" then
		value = "{ json = " .. long_string(pref.value) .. " }"
	end
	table.insert(lines, string.format("\t[%q] = %s,", key, value))
end
table.insert(lines, "}")

local file = assert(io.open(path, "w"))
file:write(table.concat(lines, "\n"), "\n")
file:close()

return string.format("wrote %d settings to %s", #keys, path)
