
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
--local working = "Tuesday 01:0:00"

client:on('ready', function()
    print('Logged in as '.. client.user.username)
end)

client:on('ready', function()
    while( true )
    do
        client:setGame("with the APC Discord")
        client._PoliceGuild = client:getGuild(policeGuild)
        client._emojiTick = client._PoliceGuild:getEmoji("694218209217347615")
	    client._emojiCross = client._PoliceGuild:getEmoji("694219068491825202")
        client._specificChannel = client._PoliceGuild:getChannel("693974403154968608")
    end
end)

--client:on('ready', function()
--    while(true)
--    do
--        if os.date("%A %H:%M:%S") == working then
--			guild = client:getGuild(policeGuild)
--            client._DingleDev = guild:getChannel("358711926060089354")
--            client._DingleDev:send("Testing and that")
--            break
--        end
--    end
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
        if message.channel.id == "693949445384962143" then
        message:addReaction(client._emojiTick)
        message:addReaction(client._emojiCross)
    end
end)





client:on('memberJoin', function(member)
    member:addRole("563037666283880470")
    member:addRole("504289165333102602")
    member:addRole("")
    member:setNickname("PCSO "..member.username)
end)

    commands[prefix.."Ban"] = function(user, msg)
    print("Running ban function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "banMembers") then
        print("Permission granted")
        local content = olib.Explode(" ", msg.content)
		local say = ""
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to ban sir!") return end
        for k, v in pairs(content) do
			if not (k == 1) then
			say = say.." "..v
		end
	end 
			if say == "" then
				msg.channel:send("Please give me a reason to ban this person!")
			return
		end
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
            u:ban(say)
            msg.channel:send("Banning "..v.mentionString.."for:"..say)
        end
    else
        msg.channel:send("You do not have permission to do that sir!")
    end
end

commands[prefix.."mute"] = function(user, msg) -- Will be able to mute people when requested
	print("Mute command running")
end

commands[prefix.."meeting"] = function(user, msg) -- Meeting command
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

commands[prefix.."help"] = function(user, msg) -- General help command
	print("Anthony stinks")
   		msg.channel:send{
			 embed = {
            title = "General commands",
            fields = {
                {name = "", value = "<@!634273754150731776>"},
                {name = "Testers!", value = "<@!528362905108742154>, <@!407653534067195934>, <@!249679264729792512>"}
            },
            color = discordia.Color.fromRGB(255, 10, 50).value,
        }
    }    
end



commands[prefix.."credit"] = function(user, msg) -- Just alittle credit just used to test if the bot is broken or not
	print("Anthony stinks")
   		msg.channel:send{
			 embed = {
            title = "Credit",
            fields = {
                {name = "Developer!", value = "<@!634273754150731776>"},
                {name = "Testers!", value = "<@!528362905108742154>, <@!407653534067195934>, <@!249679264729792512>"}
            },
            color = discordia.Color.fromRGB(255, 10, 50).value,
        }
    }    
end

commands[prefix.."echo"] = function(user, msg, client) -- Will repeat the words you request it to say
	if not user then return end
	if user:hasRole("417055663030796299") then
		local content = olib.Explode(" ", msg.content)
		local say = ""
		for k, v in pairs(content) do
			if not (k == 1) then
				say = say.." "..v
			end
		end 
		if say == "" then
			msg.channel:send("Please give me something to repeat...")
			return
		end
            msg.channel:send {
                embed = {
                description = say,
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
     	}
		msg:delete()
	else
		msg.channel:send("Looks like you don't have the power to command me...")
	end
end


    commands[prefix.."kick"] = function(user, msg) -- General kick function
    print("Running kick function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "kickMembers") then
        print("Permission granted")
        local content = olib.Explode(" ", msg.content)
		local say = ""
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to kick sir!") return end
        for k, v in pairs(content) do
			if not (k == 1) then
			say = say.." "..v
		end
	end 
			if say == "" then
				msg.channel:send("Please give me a reason")
			return
		end
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
            u:kick(say)
            msg.channel:send("|Kicking "..v.mentionString.."for:"..say)
        end
    else
        msg.channel:send("You do not have permission to do that sir!")
    end
end


client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoDs1w.l2LWJKB8e7guBctFc7XYRkCOonw")


