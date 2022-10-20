TriggerEvent(trigger, function(obj) esx = obj end)
Trad = zBankTranslation[Language]
local function addHistorique(what, montant)
    local what = what
    local montant = montant
    local date = os.date("%d/%m/%Y | %X")
    local xPlayer = esx.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO bank_historique (type, date, montant, identifier) VALUES (@type, @date, @montant, @identifier)', {
        ['@type'] = what,
        ['@date'] = date,
        ['@montant'] = montant,
        ['@identifier'] = xPlayer.identifier,
    }, function()
    end)
end
 
function LogsDiscord(Couleur, Titre, Value, Webhook)

    local Content = {
        {
            ["author"] = {
                ["name"] = "Bank Logs System",
            },
            ["title"] = Titre,
            ["description"] = Value,
            ["color"] = Couleur,
            ["footer"] = {
                ["text"] = "zBank by !Zixos#8062",
            }
        }
    }    
    PerformHttpRequest(Webhook, function() end, 'POST', json.encode({username = nil, embeds = Content}), {['Content-Type'] = 'application/json'})

end

esx.RegisterServerCallback("zBank:GetInfoAccount", function(source, cb)
    local account = {}
    local xPlayer = esx.GetPlayerFromId(source)
    
    MySQL.Async.fetchAll("SELECT rib, firstname, lastname, dateofbirth, sex, nationality, emprunt FROM `bank_account` WHERE `identifier`=@identifier", {
		['@identifier'] = xPlayer.identifier
	}, function(result)

		for k, v in pairs(result) do
            account = {
                rib = v.rib,
                firstname = v.firstname,
                lastname = v.lastname,
                dateofbirth = v.dateofbirth,
                sex = v.sex,
                nationality = v.nationality,
                emprunt = v.emprunt,
            }
                
		end
		cb(account)
	end)
end)

esx.RegisterServerCallback("zBank:getdatecreate", function(source, cb)
    local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT datecreateaccount FROM bank_account WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

RegisterNetEvent('zBank:createaccount')
AddEventHandler('zBank:createaccount', function(name, firstname, age, sex, nationality)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
    local rib = math.random(111111, 999999) 
    local name = name
    local firstname = firstname
    local age = age
    local sex = sex
    local nationality = nationality

    if xPlayer.getAccount(get_cash).money >= pricecard then 
        xPlayer.removeAccountMoney(get_cash, pricecard)

        MySQL.Async.fetchAll("SELECT * FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
            if result[1] then 
                xPlayer.showNotification(Trad["already_have_account_1"]..pricecard..Trad["symbol_money"]..Trad["already_have_account_2"])
            else
                MySQL.Async.execute('INSERT INTO bank_account (rib, identifier, firstname, lastname, dateofbirth, sex, nationality, datecreateaccount, emprunt, montantemprunt, interdit) VALUES (@rib, @identifier, @firstname, @lastname, @dateofbirth, @sex, @nationality, @datecreateaccount, @emprunt, @montantemprunt, @interdit)', {
                    ['@rib'] = rib,
                    ['@identifier'] = xPlayer.identifier,
                    ['@firstname'] = name,
                    ['@lastname'] = firstname,
                    ['@dateofbirth'] = age,
                    ['@sex'] = sex,	
                    ['@nationality'] = nationality,
                    ['@datecreateaccount'] = os.date("%d/%m/%Y | %X"),
                    ['@emprunt'] = false,
                    ['@montantemprunt'] = 0,
                    ['@interdit'] = false,
                }, function()
                end)
                xPlayer.addInventoryItem(carditem, 1)
                xPlayer.showNotification(Trad["createaccount_succes"])
                LogsDiscord(LogsCreateAccountColor, GetPlayerName(_source)..""..Trad["createaccount_logs_1"], Trad["createaccount_logs_text"], LogsCreateAccount)
            end
        end)
    else 
        xPlayer.showNotification(Trad["enough_money"])
    end
end)

RegisterServerEvent("zBank:buycarte") 
AddEventHandler("zBank:buycarte", function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)

    if xPlayer.getAccount(get_cash).money >= pricecard then 
        xPlayer.removeAccountMoney(get_cash, pricecard)
        xPlayer.addInventoryItem(carditem, 1)
        xPlayer.showNotification(Trad["buy_card"])
    else 
        xPlayer.showNotification(Trad["enough_money"])
    end
    
end)

RegisterServerEvent("zBank:getBank") 
AddEventHandler("zBank:getBank", function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)

    local nankped = xPlayer.getAccount(get_bank).money

    TriggerClientEvent("zBank:bank", _source, nankped)
    
end)

RegisterServerEvent("zBank:getcash") 
AddEventHandler("zBank:getcash", function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)

    local moneyped = xPlayer.getAccount(get_cash).money

    TriggerClientEvent("zBank:cash", _source, moneyped)
end)

RegisterServerEvent("zBank:getrib") 
AddEventHandler("zBank:getrib", function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT rib FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        good = result[1]
    end)

    TriggerClientEvent("zBank:rib", _source, good)
end)

RegisterNetEvent('zBank:gethaveaccount')
AddEventHandler('zBank:gethaveaccount', function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)

    local items = xPlayer.getInventoryItem(carditem).count

    MySQL.Async.fetchAll("SELECT * FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        if result[1] and items ~= 0 then 
            TriggerClientEvent("zBank:haveaccount", _source)
        else 
            xPlayer.showNotification(Trad["dont_have_account"])
        end
    end)

end)

RegisterNetEvent('zBank:GetAtm')
AddEventHandler('zBank:GetAtm', function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)

    local items = xPlayer.getInventoryItem(carditem).count

    MySQL.Async.fetchAll("SELECT * FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        if result[1] == 0 then 
            xPlayer.showNotification(Trad["dont_have_account"])
        elseif items == 0 then 
            xPlayer.showNotification("Vous n'avez pas de carte bancaire")
        elseif result[1] and items ~= 0 then 
            TriggerClientEvent("zBank:haveatm", _source)
        end
    end)

end)

RegisterServerEvent('zBank:verifcreate')
AddEventHandler('zBank:verifcreate', function()
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
  
    MySQL.Async.fetchAll("SELECT * FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
        if result[1] then 
            xPlayer.showNotification(Trad["have_account"])
        else 
            TriggerClientEvent("zBank:nohaveaccount", _source)
        end
    end)

end)

RegisterServerEvent('zBank:depositmoney')
AddEventHandler('zBank:depositmoney', function(amount)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
    local count = tonumber(amount)

    if xPlayer.getAccount(get_cash).money >= count then 
        xPlayer.removeAccountMoney(get_cash, count)
        xPlayer.addAccountMoney(get_bank, count)
        addHistorique(Trad["historique_deposit"], count)
        xPlayer.showNotification(Trad["srv_deposit_1"]..count..Trad["symbol_money"]..Trad["onaccount"])
        LogsDiscord(LogsDepotColor, GetPlayerName(_source)..Trad["deposit_logs_1"]..count..Trad["logs_symbol_money"], Trad["deposit_logs_text"], LogsDepot)
    else 
        xPlayer.showNotification(Trad["enough_money"])
    end

end)

RegisterServerEvent('zBank:withdrawmoney')
AddEventHandler('zBank:withdrawmoney', function(amount)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
    local count = tonumber(amount)

    if xPlayer.getAccount(get_bank).money >= count then 
        xPlayer.removeAccountMoney(get_bank, count)
        xPlayer.addAccountMoney(get_cash, count)
        addHistorique(Trad["historique_withray"], count)
        xPlayer.showNotification(Trad["srv_withdraw_1"]..count..Trad["symbol_money"]..Trad["de"]..Trad["onaccount"])
        LogsDiscord(LogsWithdrawColor, GetPlayerName(_source)..Trad["withdraw_logs_1"]..count..Trad["logs_symbol_money"], Trad["withdraw_logs_text"], LogsWithdraw)
    else
        xPlayer.showNotification(Trad["enough_money"])
    end

end)

RegisterNetEvent('zBank:CreateEmprunt')
AddEventHandler('zBank:CreateEmprunt', function(amount)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
    local count = tonumber(amount)

    if maxemprunt >= count then 

        MySQL.Async.fetchAll("SELECT emprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
            if tonumber(result[1].emprunt) == 0 then 
                
                local expiration = timeemprunt

                if expiration < os.time() then
                    expiration = os.time() + expiration
                end
                MySQL.Async.execute("UPDATE bank_account SET `emprunt` = @emprunt, `montantemprunt` = @montantemprunt, `expirationemprunt` = @expirationemprunt, `dateemprunt` = @dateemprunt WHERE identifier = @identifier", {
                    ['@identifier'] = xPlayer.identifier,
                    ['@emprunt'] = 1,
                    ['@montantemprunt'] = count,
                    ['@expirationemprunt'] = expiration,
                    ['@dateemprunt'] = os.date("%d/%m/%Y | %X"),
                }, function()
                end)
                xPlayer.addAccountMoney(get_bank, count)
                xPlayer.showNotification(Trad["success_loan"]..count..Trad["symbol_money"]..Trad["success_loan2"])
                xPlayer.showNotification(Trad["loan_pay_max"])
                ok = false
            else
                xPlayer.showNotification(Trad["have_loan"])
            end
        end)
    else 
        DropPlayer(_source, Trad["ac_message"])
    end
end)

esx.RegisterServerCallback("zBank:getallinfo", function(source, cb)
    local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM bank_account WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

esx.RegisterServerCallback("zBank:gettimechiant", function(source, cb)
    local xPlayer = esx.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT emprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(emprunttt)
        if tonumber(emprunttt[1].emprunt) == 1 then 
            
            MySQL.Async.fetchScalar('SELECT expirationemprunt FROM bank_account WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier
            }, function(result)
                if tonumber(result) ~= 157 then
                    if tonumber(result) <= os.time() then
                        MySQL.Async.fetchScalar('SELECT montantemprunt FROM bank_account WHERE identifier = @identifier', {
                            ['@identifier'] = xPlayer.identifier
                        }, function(dontbuy)
                            force = tonumber(dontbuy)
                            xPlayer.removeAccountMoney(get_bank, dontbuy)
                            xPlayer.showNotification(Trad["loan_timeout"]..dontbuy..Trad["symbol_money"])
                        end)
                        MySQL.Async.execute("UPDATE bank_account SET `emprunt` = @emprunt, `montantemprunt` = @montantemprunt, `expirationemprunt` = @expirationemprunt, `dateemprunt` = @dateemprunt WHERE identifier = @identifier", {
                            ['@identifier'] = xPlayer.identifier,
                            ['@emprunt'] = 0,
                            ['@montantemprunt'] = 0,
                            ['@expirationemprunt'] = 0,
                            ['@dateemprunt'] = 0,
                        }, function()
                        end)
                    else
                        local tempsrestant = (((tonumber(result)) - os.time())/60)
                        local day        = (tempsrestant / 60) / 24
                        local hrs        = (day - math.floor(day)) * 24
                        local minutes    = (hrs - math.floor(hrs)) * 60
                        local txtday     = math.floor(day)
                        local txthrs     = math.floor(hrs)
                        local txtminutes = math.ceil(minutes)
                        xPlayer.showNotification(Trad["loan_print_time1"]..math.floor(day)..Trad["loan_print_time2"]..txthrs..Trad["loan_print_time3"])
                    end
                end
    
            end)
        end
    end)
end)

RegisterNetEvent('zBank:getamountremoursement')
AddEventHandler('zBank:getamountremoursement', function(amount)
    local _source = source
    local xPlayer = esx.GetPlayerFromId(source)
    local count = tonumber(amount)

    if count <= maxac then

        if xPlayer.getAccount(get_bank).money >= count then 

            MySQL.Async.fetchAll("SELECT * FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result)
                if tonumber(result[1].emprunt) == 1 then 
                        
                    MySQL.Async.fetchAll("SELECT montantemprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result2)
                        
                        if count <= tonumber(result2[1].montantemprunt) then
                            xPlayer.removeAccountMoney(get_bank, count)
                            MySQL.Async.execute("UPDATE bank_account SET `montantemprunt` = @montantemprunt WHERE identifier = @identifier", {
                                ['@identifier'] = xPlayer.identifier,
                                ['@montantemprunt'] = result2[1].montantemprunt - count,

                            }, function()
                                MySQL.Async.fetchAll("SELECT montantemprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result3)
                                    if tonumber(result3[1].montantemprunt) == 0 then 
                                        MySQL.Async.execute("UPDATE bank_account SET `emprunt` = @emprunt, `expirationemprunt` = @expirationemprunt, `dateemprunt` = @dateemprunt WHERE identifier = @identifier", {
                                            ['@identifier'] = xPlayer.identifier,
                                            ['@emprunt'] = 0,
                                            ['@expirationemprunt'] = 0,
                                            ['@dateemprunt'] = 0,
                                        }, function()
                                        end)
                                        xPlayer.showNotification(Trad["success_loan_pay"])
                                    else
                                        xPlayer.showNotification(Trad["failed_loan_pay"])
                                    end
                                end)
                            end)
                        else        
                            MySQL.Async.fetchAll("SELECT montantemprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result4)
                                newmoney = count - result4[1].montantemprunt 
                                MySQL.Async.execute("UPDATE bank_account SET `montantemprunt` = @montantemprunt WHERE identifier = @identifier", {
                                    ['@identifier'] = xPlayer.identifier,
                                    ['@montantemprunt'] = count - result4[1].montantemprunt - newmoney,    
                                }, function()
                                    MySQL.Async.fetchAll("SELECT montantemprunt FROM bank_account WHERE identifier = @identifier", {['identifier'] = xPlayer.identifier}, function(result5)
                                        if tonumber(result5[1].montantemprunt) == 0 then 
                                            MySQL.Async.execute("UPDATE bank_account SET `emprunt` = @emprunt, `expirationemprunt` = @expirationemprunt, `dateemprunt` = @dateemprunt WHERE identifier = @identifier", {
                                                ['@identifier'] = xPlayer.identifier,
                                                ['@emprunt'] = 0,
                                                ['@expirationemprunt'] = 0,
                                                ['@dateemprunt'] = 0,
                                            }, function()
                                            end)
                                        end
                                        xPlayer.removeAccountMoney(get_bank, count)
                                        xPlayer.addAccountMoney(get_bank, newmoney)
                                        xPlayer.showNotification(Trad["mid_pay_loan"]..tonumber(newmoney)..Trad["symbol_money"])
                                        xPlayer.showNotification(Trad["success_loan_pay"])
                                    end)
                                end)
                            end)
                        end
                    end)
                        
                else
                    xPlayer.showNotification(Trad["no_have_loan"])
                end
            end)
        else 
            xPlayer.showNotification(Trad["enough_money"])
        end
    else 
        DropPlayer(_source, Trad["ac_message"])
    end
end)

RegisterServerEvent('zBank:virement')
AddEventHandler('zBank:virement', function(yourrib, rib, amount)
    local xPlayer = esx.GetPlayerFromId(source)
    yourrib = yourrib
    ribtarget = rib
    count = amount

    if xPlayer.getAccount(get_bank).money >= count then

        MySQL.Async.fetchAll('SELECT * FROM bank_account WHERE rib = @rib', {
            ['@rib'] = ribtarget
        }, function(result)
            if result[1] ~= nil then 
                MySQL.Async.execute('INSERT INTO bank_virement (ribsender, ribreceiver, datereceive, montantvirement, auth) VALUES (@ribsender, @ribreceiver, @datereceive, @montantvirement, @auth)', {
                    ['@ribsender'] = yourrib,
                    ['@ribreceiver'] = ribtarget,
                    ['@datereceive'] = os.date("%d/%m/%Y | %X"),
                    ['@montantvirement'] = count,
                    ['@auth'] = Trad["recuperable"],
                }, function()
                end)
                xPlayer.removeAccountMoney(get_bank, count)
                xPlayer.showNotification(Trad["send_payment"]..count..Trad["symbol_money"]..Trad["send_payment2"]..ribtarget)
            else 
                xPlayer.showNotification(Trad["rib_not_exist"])
            end 
        end)
        
    else
        xPlayer.showNotification(Trad["enough_money"])
    end
end)

esx.RegisterServerCallback("zBank:getallVirement", function(source, cb)
    local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM bank_account WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        if result[1] ~= nil then 
            MySQL.Async.fetchAll("SELECT * FROM bank_virement WHERE ribreceiver = @ribreceiver", {['ribreceiver'] = result[1].rib}, function(result2)
                cb(result2)
            end)
        end 

	end)
end)

RegisterServerEvent('zBank:getvirement')
AddEventHandler('zBank:getvirement', function(virementid)
    local xPlayer = esx.GetPlayerFromId(source)
    virementid = virementid

    MySQL.Async.fetchAll('SELECT * FROM bank_virement WHERE id = @id', {
		['@id'] = virementid
	}, function(result)

        if result[1].auth == Trad["recuperable"] then 
            MySQL.Async.execute("UPDATE bank_virement SET `auth` = @auth WHERE id = @id", {
                ['@id'] = result[1].id,
                ['@auth'] = Trad["recup"],    
            }, function()
            end)
            xPlayer.addAccountMoney(get_bank, tonumber(result[1].montantvirement))

            xPlayer.showNotification(Trad["get_payment"]..result[1].id)
        else 
            xPlayer.showNotification(Trad["already_get_payment"])
        end

	end)

end)

RegisterServerEvent('zBank:deletevirement')
AddEventHandler('zBank:deletevirement', function()
    local xPlayer = esx.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM bank_account WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        MySQL.Async.execute('DELETE FROM bank_virement WHERE ribreceiver = @ribreceiver', {['ribreceiver'] = result[1].rib})
	end)

end)

esx.RegisterServerCallback("zBank:gethistorique", function(source, cb)
    local xPlayer = esx.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM bank_historique WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        cb(result)
	end)
end)
