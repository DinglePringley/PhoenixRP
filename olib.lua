local olib = {}
local chars = {"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m","Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","1","2","3","4","5","6","7","8","9","0"}
local http = require('coro-http')

function olib.randomString(length)
	local string = ""
	for i=1, length do
		string = string..chars[math.random(#chars)] 
	end
	return string
end

function olib.stripDiscordID(id)
	local str = tostring(id) 
	str = str:gsub('[%p%c%s]','')
	return str
end

local string_sub = string.sub
local string_find = string.find
local string_len = string.len
function olib.Explode(separator, str, withpattern)
	if ( separator == "" ) then return {str} end
	if ( withpattern == nil ) then withpattern = false end

	local ret = {}
	local current_pos = 1

	for i = 1, string_len( str ) do
		local start_pos, end_pos = string_find( str, separator, current_pos, not withpattern )
		if ( not start_pos ) then break end
		ret[ i ] = string_sub( str, current_pos, start_pos - 1 )
		current_pos = end_pos + 1
	end

	ret[ #ret + 1 ] = string_sub( str, current_pos )

	return ret
end

function olib.formatMoney(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end

function olib.HTTPFetch(url, onSuccess, onFailure, headers)
	if not url then return false end
	headers = headers or {}

	coroutine.wrap(function()
		local res, body = http.request("GET", url, headers)

		if res and body and onSuccess then
			onSuccess(body, string.len(body), headers)
		end
		if not body and onFailure then
			onFailure(res)
		end
	end)()
end


return olib