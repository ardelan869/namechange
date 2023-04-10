ULTRASV = {
    Price = 150,
    Notify = function(src, msg)
        TriggerClientEvent('notifications', src, '', 'Regierung', msg)
    end,
    NotEnough = 'Du hast nicht genügend Geld!',
    Log = {
        UserName = 'Ultra - Namechange',
        AuthName = 'Regierung',
        Icon = 'https://tenor.com/view/hi-deniz-deniz-gif-23653159',
        Title = 'NAMENSÄNDERUNG',
        Webhook = 'https://canary.discord.com/api/webhooks/1004198702417723532/Z6wNo9v__SUOzErwf_zFaEkl33D0Q0dSqNzxOw9AF8ljIZPRGicy6V8f1U38fkLxcEFL'
    }
}