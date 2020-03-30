
local discordia = require('discordia')
local olib = require("./olib.lua")
--local commands = require("./commands.lua")
discordia.extensions()

local client = discordia.Client()
discordia.extensions() -- load all helpful extensions


local policeGuild = "358709912089657344"
local prefix = ">"
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
        client._PoliceGuild = client:getGuild(policeGuild)
        client._emojiTick = client._PoliceGuild:getEmoji("670433015171645450")
    	client._emojiCross = client._PoliceGuild:getEmoji("670545387731288086")
        client._specificChannel = client._PoliceGuild:getChannel("358712811007770644")
    end
end)

client:on('messageCreate', function(msg)
	local message = msg
	local user = message.author
	local member = message.member
	if user == client.user then return end
	if user.bot then return end
	if not (msg.guild == client._PoliceGuild) then return end

	local cmd, arg = string.match(message.content, '(%S+) (.*)')
	if not cmd then cmd = message.content end

	print("running commands")
	if commands[cmd] then
		commands[cmd](msg, arg)
	end
    if message.channel.id == "693949445384962143" then
        message:addReaction(client._emojiTick)
        message:addReaction(client._emojiCross)
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

client:on('memberJoin', function(member)
    member:addRole("563037666283880470")
    member:addRole("563037544271314965")
    member:setNickname("PCSO "..member.username)
end)

    commands[prefix.."kick"] = function(user, msg)
    print("Running kick function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "kickMembers") then
        print("Permission granted")
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to kick sir!") return end
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
            u:ban("")
            msg.channel:send("Banning "..v.mentionString.."!")
        end
    else
        msg.channel:send("Permission denied!")
    end
end

commands[prefix.."mute"] = function(user, msg)
	print("Mute command running")
end

commands[prefix.."meeting"] = function (user, msg)
    print(os.date("%A"))
		if not msg then return end
		if not msg.member then return end
    	if not msg.member:hasRole("361232247065673739") then 
    	msg.channel:send("You do not have the right permissions to do this request sir!") 
    	return 
    	end
    	if os.date("%A") ~= "Saturday" then
       	 msg.channel:send("Command must be ran on a saturday sir!") 
       	 return
    	end
    	client._specificChannel:send("@APC Don't forget that the meeting is at 7:30PM Tonight!")
end

--client:on('memberUpdate', function(member)
--    if(member:hasRole("563037544271314965")) then
--    member:setNickname("PPC "..member.username)
--    end
--    if(member:hasRole("563037467385790474")) then
--    member:setNickname("PC "..member.username)
--    end
--    if(member:hasRole("563037417628499972")) then
--    member:setNickname("SPC "..member.username)
--    end
--    if(member:hasRole("563037157292244996")) then
--    member:setNickname("SGT "..member.username)
--    end
--        if(member:hasRole("563037118083891210")) then
--    member:setNickname("INS "..member.username)
--    end
--        if(member:hasRole("563037042997592067")) then
--    member:setNickname("CI "..member.username)
--    end
--        if(member:hasRole("563036019058933780")) then
--    member:setNickname("SI "..member.username)
--    end
--        if(member:hasRole("563035952822485003")) then
--    member:setNickname("CSI "..member.username)
--    end
--end)



--commands[prefix.."credit"] = function (user, msg)
--	print("Anthony stinks")
--   		msg.channel:send{
--			 embed = {
--            title = "Credit",
--            fields = {
--                {name = "Developers", value = "Dan Jones"},
--                {name = "Tester", value = "Fulton, Curly Curtis"}
--            },
--            color = discordia.Color.fromRGB(255, 0, 127).value,
--        }
--    }    
--end

commands[prefix.."Test"] = function (user, msg)
   msg.channel:send {
        embed = {
            description = "Testing and that",
            color = discordia.Color.fromRGB(255, 140, 0).value
    }
}
end

client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoDs1w.l2LWJKB8e7guBctFc7XYRkCOonw")


