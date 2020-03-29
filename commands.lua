local discordia = require('discordia')
local olib = require("./olib.lua")
discordia.extensions()
local client = discordia.Client()
local commands = {}
local prefix = "!"


client:on('messageCreate', function(message)
	    local cmd, arg = string.match(message.content, '(%S+) (.*)')
    if not cmd then cmd = message.content end

    local func = commands[string.lower(cmd)]
    if func then
        if not message.member then return end
        if not message then return end
        if not client then return end

        func(message.member, message, client)
        return
    end
end)

commands[prefix.."test1"] = function(user,msg)
	msg.channel:send("testing and that")
end