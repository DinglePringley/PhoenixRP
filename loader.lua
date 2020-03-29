
local discordia = require('discordia')
local olib = require("./olib.lua")
--local commands = require("./commands.lua")
discordia.extensions()

local client = discordia.Client()
discordia.extensions() -- load all helpful extensions

local prefix = "!"
local commands = {}
local targets = {}
local cooldown = {}

client:on('ready', function()
    print('Logged in as '.. client.user.username)
end)

client:on('ready', function()
    while( true )
    do
        client:setGame("with the APC Discord")
        guild = client:getGuild("679841824130859086")
    end
end)

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




    commands[prefix.."kick"] = function(user, msg)
    print("Running kick function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "kickMembers") then
        print("Permission granted")
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to ban sir!") return end
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
            u:kick("Banned using !kick command")
            msg.channel:send("|Kicking "..v.mentionString.."!")
        end
    else
        msg.channel:send("You do not have permission to do that sir!")
    end
end


    commands[prefix.."ban"] = function(user, msg)
    print("Running kick function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "banMembers") then
        print("Permission granted")
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to ban!") return end
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
            u:ban("Banned using !ban command")
            msg.channel:send("Banning "..v.mentionString.."!")
        end
    else
        msg.channel:send("Permission denied!")
    end
end

commands[prefix.."meeting"] = function(msg, user)
    print(os.date("%A"))
	if not msg then return end
	if not msg.member then return end
    if not msg.member:hasRole("680055508014858287") then 
    msg.channel:send("You do not have the right permissions to do this request sir!") 
    return 
    end
    if os.date("%A") ~= "Saturday" then
        msg.channel:send("Command must be ran on a saturday sir!") 
        return
    end
    msg.channel:send("@here Meeting is Today at 7:30PM GMT make sure you can attend!")
end




client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoDYrQ.qAgsKQjeIUNOnfz3OyxG4pNRvB0")


