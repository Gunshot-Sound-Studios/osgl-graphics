--!native

-- Module by 1waffle1, optimized by boatbomber
-- https://devforum.roblox.com/t/text-compression/163637

local dictionary = {}
do -- populate dictionary
	local length = 0
	for i = 32, 127 do
		if i ~= 34 and i ~= 92 then
			local c = string.char(i)
			dictionary[c], dictionary[length] = length, c
			length = length + 1
		end
	end
end

local escapemap = {}
do -- Populate escape map
	for i = 1, 34 do
		i = ({ 34, 92, 127 })[i - 31] or i
		local c, e = string.char(i), string.char(i + 31)
		escapemap[c], escapemap[e] = e, c
	end
end

local function escape(s)
	return string.gsub(s, '[%c"\\]', function(c)
		return "\127" .. escapemap[c]
	end)
end
local function unescape(s)
	return string.gsub(s, "\127(.)", function(c)
		return escapemap[c]
	end)
end

local function copy(t)
	local new = {}
	for k, v in pairs(t) do
		new[k] = v
	end
	return new
end

local b93Cache = {}
local function tobase93(n)
	local value = b93Cache[n]
	if value then
		return value
	end

	value = ""
	repeat
		local remainder = n % 93
		value = dictionary[remainder] .. value
		n = (n - remainder) / 93
	until n == 0

	b93Cache[n] = value
	return value
end

local b10Cache = {}
local function tobase10(value)
	local n = b10Cache[value]
	if n then
		return n
	end

	n = 0
	for i = 1, #value do
		n = n + 93 ^ (i - 1) * dictionary[string.sub(value, -i, -i)]
	end

	b10Cache[value] = n
	return n
end

local function compress(text)
	local dictionaryCopy = copy(dictionary)
	local key, sequence, size = "", {}, #dictionaryCopy
	local width, spans, span = 1, {}, 0
	local function listkey(k)
		local value = tobase93(dictionaryCopy[k])
		local valueLength = #value
		if valueLength > width then
			width, span, spans[width] = valueLength, 0, span
		end
		table.insert(sequence, string.rep(" ", width - valueLength) .. value)
		span += 1
	end
	text = escape(text)
	for i = 1, #text do
		local c = string.sub(text, i, i)
		local new = key .. c
		if dictionaryCopy[new] then
			key = new
		else
			listkey(key)
			key = c
			size += 1
			dictionaryCopy[new], dictionaryCopy[size] = size, new
		end
	end
	listkey(key)
	spans[width] = span
	return table.concat(spans, ",") .. "|" .. table.concat(sequence)
end

local function decompress(text)
	local dictionaryCopy = copy(dictionary)
	local sequence, spans, content = {}, string.match(text, "(.-)|(.*)")
	local groups, start = {}, 1
	for span in string.gmatch(spans, "%d+") do
		local width = #groups + 1
		groups[width] = string.sub(content, start, start + span * width - 1)
		start = start + span * width
	end
	local previous

	for width, group in ipairs(groups) do
		for value in string.gmatch(group, string.rep(".", width)) do
			local entry = dictionaryCopy[tobase10(value)]
			if previous then
				if entry then
					table.insert(dictionaryCopy, previous .. string.sub(entry, 1, 1))
				else
					entry = previous .. string.sub(previous, 1, 1)
					table.insert(dictionaryCopy, entry)
				end
				table.insert(sequence, entry)
			else
				sequence[1] = entry
			end
			previous = entry
		end
	end
	return unescape(table.concat(sequence))
end

return { Compress = compress, Decompress = decompress }