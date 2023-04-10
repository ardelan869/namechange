ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterNetEvent('ardi:set:name')
AddEventHandler('ardi:set:name', function(first, last)
    local id = ESX.GetPlayerFromId(source).identifier
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    if first ~= nil or '' and last ~= nil or '' then
        if xPlayer.getMoney() >= ULTRASV.Price then
            xPlayer.removeMoney(ULTRASV.Price)
            SetName(source, id, first, last, name)
            ULTRASV.Notify(source, "Dein neuer Name lautet: " ..first.. ' '..last)
        elseif xPlayer.getAccount('bank').money >= ULTRASV.Price then
            xPlayer.removeAccountMoney('bank', ULTRASV.Price)
            SetName(source, id, first, last, name)
            ULTRASV.Notify(source, "Dein neuer Name lautet: " ..first.. ' '..last)
        else
            ULTRASV.Notify(source, ULTRASV.NotEnough)
        end
    end
end)

function SetName(src, id, first, last, old)
    local idents = ExtractIdentifiers(src)
    local full = first..' '..last
    SendToDiscord('Der Spieler **'..GetPlayerName(src)..'** heißt nun: **'..full..'**\n\n**[DETAILS]**\n**Alter Name:** '..old..'\n**Neuer Name:** '..full..'\n**Discord:** '..idents.discord..'\n**Steam:** '..idents.steam..'\n**License:** '..idents.license..'\n**XBL:** '..idents.xbl..'\n**Live:** '..idents.live..'\n**IP:** ||'..idents.ip..'||', ULTRASV.Log.UserName, ULTRASV.Log.AuthName, ULTRASV.Log.Icon, ULTRASV.Log.Title, ULTRASV.Log.Webhook)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname WHERE identifier = @identifier', {
		['@identifier']		= id,
		['@firstname']		= first,
		['@lastname']		= last
	})
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = '',
        ip = '',
        discord = '',
        license = '',
        xbl = '',
        live = ''
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, 'steam') then
            identifiers.steam = id
        elseif string.find(id, 'ip') then
            identifiers.ip = id
        elseif string.sub(id, 1, string.len('discord:')) == 'discord:' then
            discordid = string.sub(id, 9)
            identifiers.discord = '<@' .. discordid .. '>'
        elseif string.find(id, 'license') then
            identifiers.license = id
        elseif string.find(id, 'xbl') then
            identifiers.xbl = id
        elseif string.find(id, 'live') then
            identifiers.live = id
        end
    end
    return identifiers
end

function SendToDiscord(Message, Username, AuthName, Icon, Title, Webhook)
    local message = {
        username = Username,
        embeds = {{
            color = 123,
            author = {
                name = AuthName,
                icon_url = Icon
            },
            title = Title,
            description = Message,
            footer = {
                text = 'Send: ' .. os.date('%x %X %p'),
                icon_url = Icon,
            },
        }},
        avatar_url = Icon
    }
    PerformHttpRequest(Webhook, function(err, text, headers)
        end, 'POST', json.encode(message), {['Content-Type'] = 'application/json'})
end