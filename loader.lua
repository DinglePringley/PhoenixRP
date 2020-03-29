
local discordia = require('discordia')
local olib = require("./olib.lua")
--local commands = require("./commands.lua")
discordia.extensions()

local client = discordia.Client()
discordia.extensions() -- load all helpful extensions

local prefix = "!"
local textchannel = "683337300889174019"
local voicechannel = "684087586838282245"
local commands = {}
local targets = {}
local cooldown = {}

client:on('ready', function()
    print('Logged in as '.. client.user.username)
end)

client:on('ready', function()
    while( true )
    do
        client:setGame(os.date())
        guild = client:getGuild("679841824130859086")
        client._StatsDiscord = guild:getChannel("683718884708319265")
        client._StatsDiscord:setName("Total Members: "..guild.totalMemberCount)
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



commands[prefix.."help"] = function (user, msg)
	print("Working boss")
		msg.channel:send{
			 embed = {
            title = "Useful Commands",
            fields = {
                {name = "!help", value = "Will show you a list of commands you can use with this bot."},
                {name = "!time", value = "Will display the current date/time when requested"},
                {name = "!channel (Channel name)", value = "Will create a text channel with the name you set."},
                {name = "!voice (channel name)", value = "Will create a voice channel with the name you set."},
                {name = "!role (Role name)", value = "Will create you a role."}
            },
            color = discordia.Color.fromRGB(0, 4, 205).value,
        }
    }

            msg.channel:send{
             embed = {
            title = "Meme Commands",
            fields = {
                {name = "!slap (Mentioned user)", value = "Will slap the player you request to be slapped!"},
                {name = "!alexa", value = "Test it see what it does!"},
                {name = "!nuggit", value = "Test it see what it does!"},
                {name = "!kissy", value = "I mean you can see for yourself ;)"},
                {name = "!kiss (Mentiooned user", value = "Will kiss the player you request to be kissed!"},
                {name = "!whodid9:11", value = "Will tell you who did 9:11!!!!!"}
            },
            color = discordia.Color.fromRGB(9, 255, 0).value,
        }
    }

   		msg.channel:send{
			 embed = {
            title = "Admin Commands",
            fields = {
                {name = "!Kick", value = "Will kick the player you request to be kicked!"},
                {name = "!ban", value = "Will ban the player you request to be kicked!"},
                {name = "!spam (Mentioned user)", value = "Will spam the user mentioned"}
            },
            color = discordia.Color.fromRGB(205, 0, 0).value,
        }
    }    
end

    commands[prefix.."kick"] = function(user, msg)
    print("Running kick function")
    if not user then return end
    print("test")
    if msg.member:hasPermission(nil, "kickMembers") then
        print("Permission granted")
        local targets = msg.mentionedUsers
        if not targets[1] then msg.channel:send("Please @ atleast 1 person you want to ban!") return end
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
            u:kick("Banned using !ban command")
            msg.channel:send("Banning "..v.mentionString.."!")
            u:send("Sit bot")
        end
    else
        msg.channel:send("Permission denied!")
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

if args[1] == prefix.."kiss" then
    if not cooldown[msg.author] then
        cooldown[msg.author] = 0
    end
    
    table.remove(args, 1)
    if not args[1] then msg.channel:send("Please @ atleast one person to kiss!") return end
    msg.channel:send("You have kissed "..table.concat(args, " "))
    cooldown[msg.author] = os.time() + 20
end


local kissMsg = {}
kissMsg[1] = "Kiss Kiss"
kissMsg[2] = "Get away from me creep"
kissMsg[3] = "WHAT ARE YOU DOING?"
kissMsg[4] = "What are you doing stepbro!?!?!?"
kissMsg[5] = "White people"
kissMsg[6] = "Black people"
kissMsg[7] = "ok... No homo"
kissMsg[8] = "https://cdn.discordapp.com/attachments/665951262809784340/681952688736698369/FB_IMG_1581404126383.jpg"
kissMsg[9] = "https://cdn.discordapp.com/attachments/679841824135053363/683332209079615543/Screenshot_20200229_160137.jpg"

commands[prefix.."kissy"] = function(user,msg)
    print("Kiss registered")
    local kissMsg = kissMsg[math.random(#kissMsg)]
    if string.find(kissMsg, "http") then
        olib.HTTPFetch(kissMsg, function(body)
            coroutine.wrap(function()
                msg.channel:send({
                    file = {"Kiss_image.png", body},
                })
            end)()
        end)
    else
      msg.channel:send(kissMsg)
    end
end
	
local bean = {}
bean[1] = "https://tenor.com/view/beans-feijao-comida-fome-gif-7312038"
bean[2] = "https://tenor.com/view/bean-beans-stir-stirring-stirring-the-pot-gif-13271572"
bean[3] = "https://cdn.discordapp.com/attachments/679841824135053363/683342100112212080/images.png"
bean[4] = "https://cdn.discordapp.com/attachments/679841824135053363/683342132194705517/images.png"
bean[5] = "https://cdn.discordapp.com/attachments/679841824135053363/683342157813252196/images.png"

commands[prefix.."beans"] = function(user,msg)
	print("Beans registered")
	msg.channel:send(bean[math.random(#bean)])
end


commands[prefix.."time"] = function(user,msg)
    print("Time registered")
    msg.channel:send(os.date())

end

client:on("messageCreate", function(msg)

    local content = msg.content
    local args = content:split(" ")
    
     if args[1] == prefix.."role" then
         if not cooldown[msg.author] then
            cooldown[msg.author] = 0
        end
        if cooldown[msg.author] > os.time() then
            return
            msg.channel:send {
                embed = {
                description = "This command has a 60 second cooldown",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        }
        end
        guild = client:getGuild("679841824130859086")
        table.remove(args, 1)
        if not args[1] then msg.channel:send {
                embed = {
                description = "Please enter a name.",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        } return end
        local Role = guild:createRole(table.concat(args, " "))
        msg.channel:send("Role Created: `"..table.concat(args, " ").."`")
        cooldown[msg.author] = os.time() + 20
    end



        if args[1] == prefix.."channel" then
             if not cooldown[msg.author] then
            cooldown[msg.author] = 0
        end
        
        if cooldown[msg.author] > os.time() then
            return
            msg.channel:send {
                embed = {
                description = "This command has a 20 second cooldown",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        }
        end
        guild = client:getGuild("679841824130859086")
        table.remove(args, 1)
                if not args[1] then msg.channel:send {
                embed = {
                description = "Please enter a name.",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        } return end
        local channel = guild:createTextChannel(table.concat(args, " "))
        channel:setCategory(textchannel)
        msg.channel:send {
                embed = {
                description = "Text Channel Created: `"..table.concat(args, " ").."`",
                color = discordia.Color.fromRGB(0, 200, 0).value
            }
        }
        cooldown[msg.author] = os.time() + 20
    end

    if args[1] == prefix.."voice" then
         if not cooldown[msg.author] then
            cooldown[msg.author] = 0
        end
        
        if cooldown[msg.author] > os.time() then
            return
            msg.channel:send {
                embed = {
                description = "This command has a 20 second cooldown",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        }
        end
        guild = client:getGuild("679841824130859086")
        table.remove(args, 1)
        if not args[1] then msg.channel:send {
                embed = {
                description = "Please enter a name.",
                color = discordia.Color.fromRGB(200, 0, 0).value
            }
        } return end
        local channel = guild:createVoiceChannel(table.concat(args, " "))
        channel:setCategory(voicechannel)
                msg.channel:send {
                embed = {
                description = "Voice Channel Created: `"..table.concat(args, " ").."`",
                color = discordia.Color.fromRGB(0, 200, 0).value
            }
        }
        cooldown[msg.author] = os.time() + 20
    end
if args[1] == prefix.."slap" then
    if not cooldown[msg.author] then
        cooldown[msg.author] = 0
    end
    
    table.remove(args, 1)
    if not args[1] then msg.channel:send("Please @ atleast one person to slap!") return end
    msg.channel:send(msg.author.."You have slapped "..mentionedUsers)
    cooldown[msg.author] = os.time() + 20
end

if args[1] == prefix.."kiss" then
    if not cooldown[msg.author] then
        cooldown[msg.author] = 0
    end
    
    table.remove(args, 1)
    if not args[1] then msg.channel:send("Please @ atleast one person to kiss!") return end
    msg.channel:send("You have kissed "..table.concat(args, " "))
    cooldown[msg.author] = os.time() + 20
end


if args[1] == prefix.."pull" then
if not msg.member:hasRole("680055508014858287") then 
msg.channel:send("How do you know about that... Get lost!... **I SAID GET LOST**") return end

if not args[2] then msg.channel:send("Please @ the person for their ip :)") return end
    print("IP registered")
    msg.channel:send("I pulled their ip throught the discord api and it is: `"..math.random(10, 299).."."..math.random(10, 299).."."..math.random(10, 99).."."..math.random(10, 299).."`")

end

if args[1] == prefix.."boot" then
if not msg.member:hasRole("680055508014858287") then msg.channel:send("How do you know about that... Get lost!... **I SAID GET LOST**") return end
    if not cooldown[msg.author] then
        cooldown[msg.author] = 0
    end
    
    if cooldown[msg.author] > os.time() then
        return
        msg.channel:send("This command has a 20 second cooldown...")
    end
    
    table.remove(args, 1)
    if not args[1] then msg.channel:send("Please enter a ip to boot offline") return end
    msg.channel:send("Booting the following ip: `"..table.concat(args, " ").."`")
    cooldown[msg.author] = os.time() + 20
end
    
end)

commands[prefix.."alexa"] = function(user,msg)
    msg.channel:send {
        embed = {
            description = "**Get back to the kitchen <@!259373928617607168>**",
            color = discordia.Color.fromRGB(255, 110, 199).value
    }
}
end

commands[prefix.."nuggit"] = function(user,msg)
    msg.channel:send {
        embed = {
            description = "**<@341267679350620160> you are literally more inactive than my nan!**",
            color = discordia.Color.fromRGB(255, 140, 0).value
    }
}
end

local bomb = {}
bomb[1] = "Obama"
bomb[2] = "JFK"
bomb[3] = "George Washington"
bomb[4] = "Donald Trump"
bomb[5] = "Bush"
bomb[6] = "William Clinton"
bomb[7] = "Your mother"

commands[prefix.."whodid9:11"] = function(user,msg)
print("911")
    msg.channel:send{
    embed = {
    description = (bomb[math.random(#bomb)]).. " Did 9:11",
    color = discordia.Color.fromRGB(255, 0, 161).value
        }
    }
        end

commands[prefix.."test"] = function(user,msg)
        msg.channel:send"Tomsci is really gay"
        end

commands[prefix.."spam"] = function(user,msg)
    if not msg.member:hasRole("680055508014858287") then 
msg.channel:send("How do you know about that... Get lost!... **I SAID GET LOST**") return end
        local targets = msg.mentionedUsers
        for k, v in pairs(targets) do
            local u = msg.guild:getMember(v)
            if not u then return end
              for i=1, 100 do
            u:send("N Word")
    end
    end
end

commands[prefix.."sigel"] = function(user,msg)
    msg.channel:send{
    embed = {
    description = "<@363966483329449985> You are a nazi",
    color = discordia.Color.fromRGB(255, 0, 161).value
        }
    }
        end

commands[prefix.."echo"] = function(msg, arg)
    if not msg then return end
    if not msg.member then return end
    if not adminPermissions(msg.member) then
        msg.channel:send("You need specific permissions to use this command, sir.")
        return
    end
    if not arg then
        msg.channel:send("Please give a message for me to echo, sir.")
        return
    end

    local image, title, message = string.match(arg, '(.*) | (.*) | (.*)')
    if not image then image = "" title, message = string.match(arg, '(.*) | (.*)') end
    if not title then title = "" message = arg end

    print(image, title, message)

    msg.channel:send {
        embed = {
            title = title,
            thumbnail = {url = image},
            description = message,
            color = discordia.Color.fromRGB(55, 55, 200).value
        }
    }
end


local words = {}
words[1] = "Fact"
words[2] = "Provide"
words[3] = "Pear"
words[4] = "Hellish"
words[5] = "Sharp"
words[6] = "Water"
words[7] = "Uptight"
words[8] = "Blue"
words[9] = "Alike"
words[10] = "Sugar"
words[11] = "Car"
words[12] = "juvenile"

local activeWord = nil

commands[prefix.."game"] = function(user,msg)
    if activeWord then msg.channel:send("Sorry, a game is already active") return end
    print("Game do be working")
    activeWord = words[math.random(#words)]
    msg.channel:send("Welcome to hangman. The goal is to guess the word to save the man from being hung. Good luck.")
    print(string.len(activeWord))
    msg.channel:send("Your word has "..string.len(activeWord).. " letters in it.")
    msg.channel:send("Please guess one letter at a time. The letter will display in all spots it fits in!")
end

client:run("Bot NjkzODcxOTc5NDcxNTY4OTY4.XoDYrQ.qAgsKQjeIUNOnfz3OyxG4pNRvB0")


