
local discordia = require('discordia')
local olib = require("./olib.lua")
local timer = require("timer")
--local commands = require("./commands.lua")
discordia.extensions()

local client = discordia.Client()
discordia.extensions() -- load all helpful extensions


local policeGuild = "358709912089657344"
local prefix = ">"
local commands = {}
local targets = {}
local cooldown = {}
local MinuteWarning = "Thursday 11:00:00"
local Meeting = "Saturday 11:00:00"
local logs = ""

client:on('ready', function()
        print('Logged in as '.. client.user.username)
    while(true)
	do
	client:setGame("with APC discord!")
        client._PoliceGuild = client:getGuild(policeGuild)
        client._emojiTick = client._PoliceGuild:getEmoji("694218209217347615")
        client._emojiCross = client._PoliceGuild:getEmoji("694219068491825202")
        client._specificChannel = client._PoliceGuild:getChannel("358712811007770644")
        client._joinChannel = client._PoliceGuild:getChannel("694497682793693264")
	client._logChannel = client._PoliceGuild:getChannel("544986930987925505")
        
        if os.date("%A %H:%M:%S") == MinuteWarning then
            guild = client:getGuild("358709912089657344")
            client._GuildChannel = guild:getChannel("358712811007770644")
            client._GuildChannel:send("The APC Meeting is on Saturdays at 19:30PM British Time! Important announcements and changes are disclosed during the meeting. If you can not make the meeting read the meeting notes posted after the meeting.")
            break
	
	if os.data("%A %H:%M:%S") == Meeting then
		guild = client:getGuild("358709912089657344")
		client._GuildChannel = guild:getChannel("694497682793693264")
		client._GuildChannel:send("<@&504289165333102602> Don't forget that the meeting is at 7:30PM Tonight!")
		break
        	end
    	end
end
end)

client:on('memberJoin', function(member)
    guild = client:getGuild(policeGuild)
    joinLeave = guild:getChannel("453672836645650435")
    joinLeave:send('Hey <@' .. member.id .. '>, Welcome to the APC.\n I have assigned you the appropriate tags and have set your name.\n If you have any issues please feel free to make a ticket at <#670432374391177218>. If you need help with making a ticket you can head over to the <#670432843884920833>')
end)

client:on('memberLeave', function(member)
    guild = client:getGuild(policeGuild)
    joinLeave = guild:getChannel("453672836645650435")
    joinLeave:send(member.username .. '#' .. member.discriminator .. ' just left the discord :slight_frown:\n\nThank you for your service o7')
    print(member.username)
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
    member:setNickname("PCSO "..member.username)
end)

--commands[prefix.."game"] = function(user,msg)
--print("running game")
--if user:hasPermission(nil, "muteMembers") then
--    local content = olib.Explode(" ", msg.content)
--    local game = ""
 --   for k, v in pairs(content) do
  --      if not (k == 1) then
    --            game = game.." "..v
      --      end
      --  end
      --  client:setGame(game)
      --  msg.channel:send("Setting game to:"..game)
  --  else
   --     msg.channel:send("You do not have permission for that")
  --  end
--end

    commands[prefix.."ban"] = function(user, msg)
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
	if not user then return end
	print("The mute command DOOOO Be kinda working")
	if msg.member:hasPermission(nil, "kickMembers") then
		print("Permission granted")
		local timer = require("timer")
		local targets = msg.mentionedUsers
		local args = msg.cleanContent:split(" ")
		local usertime = args[#args]
		if not args[2] then msg.channel:send("Please @ atleast 1 person you want to mute!") return end
		if not args[3] then msg.channel:send("Please prove a time in minutes!") return end
		 if not (type(tonumber(args[#args])) == "number") then msg.channel:send("Please provide a time in minutes! 1 = 1 minute") return end
		   print("Working?")
		for k, v in pairs(targets) do
			local u = msg.guild:getMember(v)
			if not u then return end
			u:addRole("670462767584772135")
			msg.channel:send("Muted "..u.mentionString.." for "..usertime.. " minute(s)!")
			client._logChannel:send{
					embed = {
						description = u.mentionString.. "has been mute!",
						color = discordia.Color.fromRGB(255,100,52).value
							}
						}
		
			timer.setTimeout(60000 * usertime, function()
				   coroutine.wrap(function()
				    if not u:hasRole("670462767584772135") then return end
				    u:removeRole("670462767584772135")
				    u:send("You have been unmuted!")
				   print(color)
				    client._logChannel:send{
							embed = {
								description = u.mentionString.. " has been unmuted after waiting the timer.",
								color = discordia.Color.fromRGB(102,255,102).value
							}
						}			
				    end)()
				end)
		    end
		else
		    msg.channel:send("Permission denied!")
		end
	end

commands[prefix.."unmute"] = function(user,msg)
    local color = discordia.Color.fromRGB(102,255,102).value
    print(color)
    if not user then return end
    if msg.member:hasPermission(nil, "kickMembers") then
    local targets = msg.mentionedUsers
    if not targets[1] then msg.channel:send("Please @ a user to unmute!") return end
    for k, v in pairs(targets) do
    local u = msg.guild:getMember(v)
    if not u then return end
    u:removeRole("670462767584772135")
    msg.channel:send("unmuted "..v.mentionString.."!")
    u:send("You have been unmuted")
    client._logChannel:send{
        embed = {
            description = u.mentionString.. " has been unmuted!",
            color = discordia.Color.fromRGB(102,255,101).value
        }
    }
end
else
    msg.channel:send("Permission denied!")
end
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

commands[prefix.."invite"] = function(user, msg)
	if not user then return end
    	if msg.member:hasPermission(nil, "muteMembers") then
	user:send("Here is the discord invite: https://discord.gg/A7KcNDB")
	else
	msg.channel:send("You do not have the right permissions for that one big man!")
end
end

commands[prefix.."help"] = function(user, msg) -- General help command
	print("Anthony stinks")
		 msg.channel:send{
             embed = {
            title = "General Commands",
            fields = {
            {name = "Commands", value = ">Credit\n>bots\n>info", inline = true},
		{name = "Uses", value = "Will show you all the people who helped make me\nAll the bots int the APC\n Give you relative links", inline = true},
            },
            color = discordia.Color.fromRGB(219, 192, 82).value,
        }
    }
   		msg.channel:send{
		embed = {
            title = "Admin commands",
            fields = {
			{name = "Commands", value = ">kick <users> <Reason>\n>ban <users> <Reason>\n>repeat <text\n>mute <user> <Time in mins>\n>unmute <user>\n>reload", inline = true},
			{name = "Uses", value = "Kicks all mentioned users\nBans all mentioned users\nRepeats you and removes your message\nWill mute the person you mention\n Will unmute the user mentioned if muted\nReloads the bot", inline = true},

            },
            color = discordia.Color.fromRGB(255, 10, 50).value,
        }
    }   
	
end

commands[prefix.."reload"] = function(user, msg)
	if not user then return end
	if msg.member:hasPermission(nil, "muteMembers") then
        client:stop()
        client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoSc_g.Tdvjc5_b8ggpcXUsTitX10wAJOE")
        print("reloaded!")
        msg.channel:send("Reload the bot!")
else
	msg.channel:send("You do not have permission for that!")
	end
end

commands[prefix.."credit"] = function(user, msg) -- Just alittle credit just used to test if the bot is broken or not idk
	print("Anthony stinks")
   		msg.channel:send{
			 embed = {
            title = "Credit",
            fields = {
		{name = "Developers!", value = "<@!634273754150731776>"},
                {name = "Testers!", value = "<@!528362905108742154>, <@!407653534067195934>, <@!249679264729792512>, <@325278718937530368>"},
		{name = "Top Fraggers!", value = "<@!301048048455516161>, <@!125267832404574208>, <@!228241645378732033>"}
             
          },  
            color = discordia.Color.fromRGB(255, 10, 50).value,
        }
    }    
end

commands[prefix.."dogs"] = function(user, msg) -- Just alittle credit just used to test if the bot is broken or not
	print("Anthony stinks")
   		msg.channel:send{
			 embed = {
            title = "Dogs",
            fields = {
                {name = "Dogs in the APC!", value = "<@251457705472950272>, <@213836326796132353>, <@429767479192059904>, <@118167225373818885>, <@118791558416826369>, <@217348465988993024>"},
		{name = "Pack Leader!", value = "<@187311442536431616>"},
       	},
		color = discordia.Color.fromRGB(255, 10, 50).value,
        }
    }    
end

commands[prefix.."repeat"] = function(user, msg, client) -- Will repeat the words you request it to say
	if not user then return end
    if msg.member:hasPermission(nil, "muteMembers") then
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
                color = discordia.Color.fromRGB(43, 100, 255).value
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

commands[prefix.."info"] = function(user,msg)
	print("Running info command")
msg.channel:send{
		embed = {
		description = "Here is the relevant links you need:\n Phoenix Wiki: https://wiki.phoenixrp.co.uk/index.php/Main_Page \n APC Handbook: https://wiki.phoenixrp.co.uk/index.php/APC_Handbook \n Public Roster: https://pnc.phoenixrp.co.uk/dash/roster/apc/ \n Enforcement guide: https://docs.google.com/spreadsheets/d/1FMzqCZt18r1W94ghH93j1bZaEL4eBGmk2l7G9UYUAJ8/edit#gid=1169698448\n \n If I have missed anything out message <@!634273754150731776>",
		color = discordia.Color.fromRGB(175, 167, 94).value
		}
	}
end
	
client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoSc_g.Tdvjc5_b8ggpcXUsTitX10wAJOE")


