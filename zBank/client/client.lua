esx = nil
creeatedate = {}
bankdata = {}
virementdata = {}
historique = {}
Trad = zBankTranslation[Language]
gettedrib = 0
PlayerMoney = 0
moulahbank = 0

Citizen.CreateThread(function()
	while esx == nil do
		TriggerEvent(trigger, function(obj) esx = obj end)
		Citizen.Wait(0)
	end

    PlayerLoaded = true
	esx.PlayerData = esx.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	esx.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	  esx.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #esx.PlayerData.accounts, 1 do
		if esx.PlayerData.accounts[i].name == account.name then
			esx.PlayerData.accounts[i] = account
		end
	end
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #esx.PlayerData.accounts, 1 do
		if esx.PlayerData.accounts[i].name == account.name then
			esx.PlayerData.accounts[i] = account
		end
	end
end)

function OpenBankMenuCreateAccount(use)

    local name = Trad["required"] 
    local firstname = Trad["required"]   
    local age = Trad["required"]   
    local sex = Trad["required"]   
    local nationality = Trad["required"] 
    
    local registermenu = RageUI.CreateMenu(Trad["registermenu_title"], Trad["registermenu_description"])
    local create = RageUI.CreateSubMenu(registermenu, Trad["createmenu_title"], Trad["createmenu_description"])
    RageUI.Visible(registermenu, not RageUI.Visible(registermenu))

    while registermenu do
        RageUI.IsVisible(registermenu, function()

            RageUI.Button(Trad["create_account_button"], nil, {}, true, {
                onSelected = function()
                    
                end
            }, create)

        end)
        RageUI.IsVisible(create, function()
            RageUI.Button(Trad["prefix"]..Trad["create_firstname"], nil, {RightLabel = name}, true, {
                onSelected = function()
                    name = KeyboardInput('Default', Trad["input_firstname"], '', 10)
                end
            })
            RageUI.Button(Trad["prefix"]..Trad["create_lastname"], nil, {RightLabel = firstname}, true, {
                onSelected = function()
                    firstname = KeyboardInput('Default', Trad["input_lastname"], '', 10)
                end
            })
            RageUI.Button(Trad["prefix"]..Trad["create_dateofbirth"], nil, {RightLabel = age}, true, {
                onSelected = function()
                    age = KeyboardInput('Default', Trad["input_dateofbirth"], '', 10)
                end
            })
            RageUI.Button(Trad["prefix"]..Trad["create_sex"], nil, {RightLabel = sex}, true, {
                onSelected = function()
                    sex = KeyboardInput('Default', Trad["input_sex"], '', 10)
                end
            })
            RageUI.Button(Trad["prefix"]..Trad["create_nationality"], nil, {RightLabel = nationality}, true, {
                onSelected = function()
                    nationality = KeyboardInput('Default', Trad["input_nationality"], '', 10)
                end
            })
            RageUI.Button(Trad["prefix"]..Trad["create_valid"], Trad["create_valid_description"]..pricecard..Trad["white"]..Trad["symbol_money"], {}, true, {
                onActive = function()
                    RageUI.Info(infocreate, {Trad["create_firstname"]..name, Trad["create_lastname"]..firstname, Trad["create_dateofbirth"]..age, Trad["create_sex"]..sex, Trad["create_nationality"]..nationality}, {})
                    end,
                onSelected = function()
                    if (name == nil or name == Trad["required"] ) then
                        esx.ShowNotification(Trad["required_firstname"])
                    elseif (firstname == nil or firstname == Trad["required"]) then
                        esx.ShowNotification(Trad["required_lastname"])
                    elseif (age == nil or age == Trad["required"]) then
                        esx.ShowNotification(Trad["required_dateofbirth"])
                    elseif (sex == nil or sex == Trad["required"]) then
                        esx.ShowNotification(Trad["required_sex"])
                    elseif (nationality == nil or nationality == Trad["required"]) then
                        esx.ShowNotification(Trad["required_nationality"])
                    elseif (name ~= nil or name ~= Trad["required"] and firstname ~= nil or firstname ~= Trad["required"] and age ~= nil or age ~= Trad["required"]  and sex ~= nil or sex ~= Trad["required"] and nationality ~= nil or nationality ~= Trad["required"]) then
                        TriggerServerEvent('zBank:createaccount', name, firstname, age, sex, nationality)
                        RageUI.CloseAll()
                    end
                end
            })

        end)

        if not RageUI.Visible(registermenu) 
        and not RageUI.Visible(create) 
        then
            registermenu = RMenu:DeleteType('menu', true)
        end
		Citizen.Wait(0)
    end
end

function OpenBankMenuAccount(use)
    

    local menucentral = RageUI.CreateMenu(Trad["registermenu_title"], Trad["registermenu_description"])
    local depositmenu = RageUI.CreateSubMenu(menucentral, Trad["deposit_menu_title"], Trad["deposit_menu_descrition"])
    local withraymenu = RageUI.CreateSubMenu(menucentral, Trad["withray_menu_title"], Trad["withray_menu_descrition"])
    local emprunmenu = RageUI.CreateSubMenu(menucentral, Trad["loan_menu_title"], Trad["loan_menu_descrition"])
    local virementmenu = RageUI.CreateSubMenu(menucentral, Trad["payment_menu_title"], Trad["payment_menu_descrition"])
    local hsitoriquemenu = RageUI.CreateSubMenu(menucentral, Trad["history_menu_title"], Trad["history_menu_descrition"])
    RageUI.Visible(menucentral, not RageUI.Visible(menucentral))
    while menucentral do
        RageUI.IsVisible(menucentral, function()
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_info"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_cash"]..PlayerMoney..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    
                end
            })
            RageUI.Button(Trad["central_menu_bank"]..moulahbank..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    
                end
            })
            for i = 1, #creeatedate, 1 do
                RageUI.Button(Trad["central_menu_rib"]..bankdata[i].rib, nil, {}, true, {
                    onSelected = function()
                            
                    end
                })
                RageUI.Button(Trad["central_menu_allinfo"], nil, {}, true, {
                    onActive = function()
                        RageUI.Info(Trad["central_menu_allinfo_info"], {Trad["central_menu_allinfo_info_firstname"]..bankdata[i].firstname, Trad["central_menu_allinfo_info_lastname"]..bankdata[i].lastname, Trad["central_menu_allinfo_info_dataofbirth"]..bankdata[i].dateofbirth, Trad["central_menu_allinfo_info_sex"]..bankdata[i].sex, Trad["central_menu_allinfo_info_nationality"]..bankdata[i].nationality, Trad["central_menu_allinfo_info_rib"]..bankdata[i].rib, Trad["central_menu_allinfo_info_create_date"]..creeatedate[i].datecreateaccount}, {})
                    end,
                })
            end
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_deposit"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_deposit"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, depositmenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_withdraw"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_withdraw"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, withraymenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_loan"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_loan"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, emprunmenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_payment"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, virementmenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_history"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_history"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, hsitoriquemenu)
        end)
        RageUI.IsVisible(depositmenu, function()

            RageUI.Button(Trad["deposit_menu_button"]..deposit1..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit1
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit2..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit2
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit3..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit3
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit4..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit4
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit5..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit5
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button2"], nil, {}, true, {
                onSelected = function()
                    amount = KeyboardInput("Default", Trad["input"], '', 10)
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
        end)
        RageUI.IsVisible(withraymenu, function()

            RageUI.Button(Trad["withray_menu_button"]..withdraw1..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw1
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw2..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw2
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw3..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw3
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw4..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw4
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw5..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw5
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button2"], nil, {}, true, {
                onSelected = function()
                    amount = KeyboardInput("Default", Trad["input"], '', 10)
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
        end)

        RageUI.IsVisible(emprunmenu, function()

            if ligne_loan_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_loan_menu1"]..Trad["separator_prefix"])
            end
            for i = 1, #creeatedate, 1 do
                if tonumber(bankdata[i].emprunt) == 0 then 
                    RageUI.Button(Trad["loan_menu_title"], Trad["loan_menu_descrition"], {}, true, {
                        onSelected = function()
                            
                        end
                    })
                else 
                    RageUI.Button(Trad["loan_menu_refunded_button"]..bankdata[i].montantemprunt..Trad["symbol_money"], nil, {}, true, {
                        onSelected = function()
                            
                        end
                    })
                    RageUI.Button(Trad["loan_menu_loan_date_button"]..bankdata[i].dateemprunt, nil, {}, true, {
                        onSelected = function()
                            
                        end
                    })
                    RageUI.Button(Trad["loan_menu_loan_information_button"], nil, {}, true, {
                        onSelected = function()
                            esx.TriggerServerCallback('zBank:gettimechiant', function(data)
                            end)
                        end
                    })
                end
            end
            if ligne_loan_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_loan_menu2"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["loan_menu_get_loan_button"], Trad["loan_menu_get_loan_button_descrition"]..maxemprunt..Trad["symbol_money"]..Trad["loan_menu_get_loan_button_descrition2"], {}, true, {
                onSelected = function()
                    amount = tonumber(KeyboardInput("Default", Trad["input_loan"], '', 10))
                    if amount <= maxemprunt then
                        TriggerServerEvent('zBank:CreateEmprunt', amount)
                        GetPlayerMoney()
                        RefreshBank()       
                    else
                        esx.ShowNotification(Trad["loan_menu_max_loan_price"]..maxemprunt..Trad["symbol_money"]) 
                    end
                end
            }) 
            RageUI.Button(Trad["loan_menu_title2"], Trad["loan_menu_descrition2"], {}, true, {
                onSelected = function()
                    amount = tonumber(KeyboardInput("Default", Trad["input_loan"], "", 10))
                    TriggerServerEvent('zBank:getamountremoursement', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["loan_menu_title3"], Trad["loan_menu_descrition3"], {}, true, {
                onSelected = function()
                    GetAll()
                    BankData()
                end
            })
         
        end) 
        RageUI.IsVisible(virementmenu, function()
            for i = 1, #creeatedate, 1 do
                if ligne_transfer_menu then 
                    RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
                else 
                    RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment_menu1"]..Trad["separator_prefix"])
                end
                if #virementdata == 0 then
                    RageUI.Button(Trad["payment_menu_no_have_payment_button"], nil, {}, true, {
                    })
                else 
                    for a = 1, #virementdata, 1 do
                        RageUI.Button(Trad["payment_menu_id_payment_button"]..virementdata[a].id, nil, {RightLabel = virementdata[a].auth}, true, {
                            onActive = function()
                                RageUI.Info(Trad["payment_menu_info"], {Trad["payment_menu_info_id"]..virementdata[a].id, Trad["payment_menu_info_sender"]..virementdata[a].ribsender, Trad["payment_menu_info_send_date"]..virementdata[a].datereceive, Trad["payment_menu_info_amount"]..virementdata[a].montantvirement, Trad["payment_menu_info_use"]..virementdata[a].auth}, {})
                            end,
                            onSelected = function()
                                virementid = virementdata[a].id
                                TriggerServerEvent('zBank:getvirement', virementid)
                            end
                        })
                    end
                    RageUI.Button(Trad["payment_menu_delete_payment_button"], Trad["payment_menu_delete_payment_button_descrition"], {}, true, {
                        onSelected = function()
                            TriggerServerEvent('zBank:deletevirement')
                        end
                    })
                end
                if ligne_transfer_menu then 
                    RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
                else 
                    RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment_menu2"]..Trad["separator_prefix"])
                end
                RageUI.Button(Trad["payment_menu_send_payment_button"], Trad["payment_menu_send_payment_button_descrition"], {}, true, {
                    onSelected = function()
                        yourrib = bankdata[i].rib
                        rib = tonumber(KeyboardInput('Default', Trad["input_rib"], '', 10))
                        amount = tonumber(KeyboardInput('Default', Trad["input"], '', 10))
                        TriggerServerEvent('zBank:virement', yourrib, rib, amount)
                        GetPlayerMoney()
                        RefreshBank()
                    end
                })
                RageUI.Button(Trad["payment_menu_send_payment_button2"], Trad["payment_menu_send_payment_button_descrition2"], {}, true, {
                    onSelected = function()
                        GetVirement()
                    end
                })
            end
        end)

        RageUI.IsVisible(hsitoriquemenu, function()
            RageUI.Button(Trad["history_menu_send_payment_button2"], Trad["history_menu_send_payment_button_descrition2"], {}, true, {
                onSelected = function()
                    GetHistorique()
                end
            })
            for i = 1, #creeatedate, 1 do
                if #historique == 0 then 
                    RageUI.Button(Trad["history_menu_no_button"], nil, {}, true, {
                        onSelected = function()
                            
                        end
                    })
                else
                    for y = 1, #historique, 1 do
                        RageUI.Button(historique[y].type.." "..Trad["de"].." : "..historique[y].montant..""..Trad["symbol_money"].." "..Trad["le"].." : "..historique[y].date, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                    end
                end
            end
        end)

        if not RageUI.Visible(menucentral) 
        and not RageUI.Visible(depositmenu)
        and not RageUI.Visible(withraymenu)
        and not RageUI.Visible(emprunmenu)
        and not RageUI.Visible(virementmenu)
        and not RageUI.Visible(hsitoriquemenu)
        then
            menucentral = RMenu:DeleteType('menu', true)
        end
		Citizen.Wait(0)
    end
end

function OpenAtmMenuAccount(use)

    local menucentral = RageUI.CreateMenu(Trad["registermenu_title"], Trad["registermenu_description"])
    local depositmenu = RageUI.CreateSubMenu(menucentral, Trad["deposit_menu_title"], Trad["deposit_menu_descrition"])
    local withraymenu = RageUI.CreateSubMenu(menucentral, Trad["withray_menu_title"], Trad["withray_menu_descrition"])
    local virementmenu = RageUI.CreateSubMenu(menucentral, Trad["payment_menu_title"], Trad["payment_menu_descrition"])
    local hsitoriquemenu = RageUI.CreateSubMenu(menucentral, Trad["history_menu_title"], Trad["history_menu_descrition"])
    RageUI.Visible(menucentral, not RageUI.Visible(menucentral))
    while menucentral do
        RageUI.IsVisible(menucentral, function()
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_info"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_cash"]..PlayerMoney..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    
                end
            })
            RageUI.Button(Trad["central_menu_bank"]..moulahbank..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    
                end
            })
            for i = 1, #creeatedate, 1 do
                RageUI.Button(Trad["central_menu_rib"]..bankdata[i].rib, nil, {}, true, {
                    onSelected = function()
                            
                    end
                })
                RageUI.Button(Trad["central_menu_allinfo"], nil, {}, true, {
                    onActive = function()
                        RageUI.Info(Trad["central_menu_allinfo_info"], {Trad["central_menu_allinfo_info_firstname"]..bankdata[i].firstname, Trad["central_menu_allinfo_info_lastname"]..bankdata[i].lastname, Trad["central_menu_allinfo_info_dataofbirth"]..bankdata[i].dateofbirth, Trad["central_menu_allinfo_info_sex"]..bankdata[i].sex, Trad["central_menu_allinfo_info_nationality"]..bankdata[i].nationality, Trad["central_menu_allinfo_info_rib"]..bankdata[i].rib, Trad["central_menu_allinfo_info_create_date"]..creeatedate[i].datecreateaccount}, {})
                    end,
                })
            end
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_deposit"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_deposit"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, depositmenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_withdraw"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_withdraw"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, withraymenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_payment"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, virementmenu)
            if ligne_main_menu then 
                RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
            else 
                RageUI.Separator(Trad["separator_prefix"]..Trad["separator_history"]..Trad["separator_prefix"])
            end
            RageUI.Button(Trad["central_menu_button_history"], nil, {RightLabel = Trad["prefix_central_menu"]}, true, {
                onSelected = function()
                    
                end
            }, hsitoriquemenu)
        end)
        RageUI.IsVisible(depositmenu, function()

            RageUI.Button(Trad["deposit_menu_button"]..deposit1..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit1
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit2..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit2
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit3..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit3
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit4..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit4
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button"]..deposit5..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = deposit5
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["deposit_menu_button2"], nil, {}, true, {
                onSelected = function()
                    amount = KeyboardInput("Default", Trad["input"], '', 10)
                    TriggerServerEvent('zBank:depositmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
        end)
        RageUI.IsVisible(withraymenu, function()

            RageUI.Button(Trad["withray_menu_button"]..withdraw1..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw1
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw2..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw2
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw3..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw3
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw4..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw4
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button"]..withdraw5..Trad["symbol_money"], nil, {}, true, {
                onSelected = function()
                    amount = withdraw5
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
            RageUI.Button(Trad["withray_menu_button2"], nil, {}, true, {
                onSelected = function()
                    amount = KeyboardInput("Default", Trad["input"], '', 10)
                    TriggerServerEvent('zBank:withdrawmoney', amount)
                    GetPlayerMoney()
                    RefreshBank()
                end
            })
        end)

        
        RageUI.IsVisible(virementmenu, function()
            for i = 1, #creeatedate, 1 do
                if ligne_transfer_menu then 
                    RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
                else 
                    RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment_menu1"]..Trad["separator_prefix"])
                end
                if #virementdata == 0 then
                    RageUI.Button(Trad["payment_menu_no_have_payment_button"], nil, {}, true, {
                    })
                else 
                    for a = 1, #virementdata, 1 do
                        RageUI.Button(Trad["payment_menu_id_payment_button"]..virementdata[a].id, nil, {RightLabel = virementdata[a].auth}, true, {
                            onActive = function()
                                RageUI.Info(Trad["payment_menu_info"], {Trad["payment_menu_info_id"]..virementdata[a].id, Trad["payment_menu_info_sender"]..virementdata[a].ribsender, Trad["payment_menu_info_send_date"]..virementdata[a].datereceive, Trad["payment_menu_info_amount"]..virementdata[a].montantvirement, Trad["payment_menu_info_use"]..virementdata[a].auth}, {})
                            end,
                            onSelected = function()
                                virementid = virementdata[a].id
                                TriggerServerEvent('zBank:getvirement', virementid)
                            end
                        })
                    end
                    RageUI.Button(Trad["payment_menu_delete_payment_button"], Trad["payment_menu_delete_payment_button_descrition"], {}, true, {
                        onSelected = function()
                            TriggerServerEvent('zBank:deletevirement')
                        end
                    })
                end
                if ligne_transfer_menu then 
                    RageUI.Line(line_color_r, line_color_g, line_color_b, line_opacity)
                else 
                    RageUI.Separator(Trad["separator_prefix"]..Trad["separator_payment_menu2"]..Trad["separator_prefix"])
                end
                RageUI.Button(Trad["payment_menu_send_payment_button"], Trad["payment_menu_send_payment_button_descrition"], {}, true, {
                    onSelected = function()
                        yourrib = bankdata[i].rib
                        rib = tonumber(KeyboardInput('Default', Trad["input_rib"], '', 10))
                        amount = tonumber(KeyboardInput('Default', Trad["input"], '', 10))
                        TriggerServerEvent('zBank:virement', yourrib, rib, amount)
                        GetPlayerMoney()
                        RefreshBank()
                    end
                })
                RageUI.Button(Trad["payment_menu_send_payment_button2"], Trad["payment_menu_send_payment_button_descrition2"], {}, true, {
                    onSelected = function()
                        GetVirement()
                    end
                })
            end
        end)

        RageUI.IsVisible(hsitoriquemenu, function()
            RageUI.Button(Trad["history_menu_send_payment_button2"], Trad["history_menu_send_payment_button_descrition2"], {}, true, {
                onSelected = function()
                    GetHistorique()
                end
            })
            for i = 1, #creeatedate, 1 do
                if #historique == 0 then 
                    RageUI.Button(Trad["history_menu_no_button"], nil, {}, true, {
                        onSelected = function()
                            
                        end
                    })
                else
                    for y = 1, #historique, 1 do
                        RageUI.Button(historique[y].type.." "..Trad["de"].." : "..historique[y].montant..""..Trad["symbol_money"].." "..Trad["le"].." : "..historique[y].date, nil, {}, true, {
                            onSelected = function()
                            end
                        })
                    end
                end
            end
        end)

        if not RageUI.Visible(menucentral) 
        and not RageUI.Visible(depositmenu)
        and not RageUI.Visible(withraymenu)
        and not RageUI.Visible(virementmenu)
        and not RageUI.Visible(hsitoriquemenu)
        then
            menucentral = RMenu:DeleteType('menu', true)
        end
		Citizen.Wait(0)
    end
end

function OpenBankGetCate(type)
    
    local bank = RageUI.CreateMenu("Banque", Trad["open_mebuuu"])
    RageUI.Visible(bank, not RageUI.Visible(bank))

    while bank do
        RageUI.IsVisible(bank, function()

            RageUI.Button("Acheter une carte bancaire", nil, {RightLabel = "~g~"..pricecard.." ~w~$"}, true, {
                onSelected = function()
                    TriggerServerEvent('zBank:buycarte')
                end
            })

            RageUI.Button("Accedé a votre compte", nil, {}, true, {
                onSelected = function()
                    if type == "atm" then
                        LoadInfo() 
                        TriggerServerEvent('zBank:GetAtm')
                    elseif type == "bank" then 
                        LoadInfo()
                        TriggerServerEvent('zBank:gethaveaccount')
                    end
                end
            })

        end)

        if not RageUI.Visible(bank) 

        then
            bank = RMenu:DeleteType('menu', true)
        end
		Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
    while true do
        local PlyCoord = GetEntityCoords(PlayerPedId())
        local activerfps2 = false
        local dst = GetDistanceBetweenCoords(PlyCoord, true)
        for k,v in pairs(Position.ATM) do
            if #(PlyCoord - v.poss) < 1.5 then
                activerfps2 = true
                RageUI.Text({ message = Trad["open_menu"], time_display = 1 })
                if IsControlJustReleased(0, 38) then
                    GetAll()
                    BankData()
                    GetHistorique()
                    GetPlayerRib()
                    GetPlayerMoney()
                    RefreshBank()
                    GetHistorique()
                    GetVirement()
                    OpenBankGetCate("atm")
                end
            end
        end
        if activerfps2 then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local PlyCoord = GetEntityCoords(PlayerPedId())
        local activerfps2 = false
        local dst = GetDistanceBetweenCoords(PlyCoord, true)
        for k,v in pairs(Position.BANQUE) do
            if #(PlyCoord - v.poss) < 1.5 then
                activerfps2 = true
                RageUI.Text({ message = Trad["open_menu"], time_display = 1 })
                if IsControlJustReleased(0, 38) then
                    LoadInfo()
                    OpenBankGetCate("bank")
                end
            end
        end
        if activerfps2 then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local PlyCoord = GetEntityCoords(PlayerPedId())
        local activerfps2 = false
        local dst = GetDistanceBetweenCoords(PlyCoord, true)
        for k,v in pairs(Position.CREATE) do
            if #(PlyCoord - v.poss) < 1.5 then
                activerfps2 = true
                RageUI.Text({ message = Trad["open_menu"], time_display = 1 })
                if IsControlJustReleased(0, 38) then
                    LoadInfo()
                    TriggerServerEvent('zBank:verifcreate')
                end
            end
        end
        if activerfps2 then
            Wait(1)
        else
            Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Position.BANQUE) do
		local BBANQUE = AddBlipForCoord(v.poss)
		SetBlipSprite(BBANQUE, 108)
		SetBlipScale (BBANQUE, 0.8)
		SetBlipColour(BBANQUE, 2)
		SetBlipAsShortRange(BBANQUE, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Banque')
		EndTextCommandSetBlipName(BBANQUE)
	end
end)

Citizen.CreateThread(function()
    if use_blips_atm then 
        for k, v in pairs(Position.ATM) do
            local BATM = AddBlipForCoord(v.poss)
            SetBlipSprite(BATM, 108)
            SetBlipScale (BATM, 0.3)
            SetBlipColour(BATM, 2)
            SetBlipAsShortRange(BATM, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Atm')
            EndTextCommandSetBlipName(BATM)
        end
    end
end)

function RefreshBank(action)
    TriggerServerEvent("zBank:getBank", action)
end

RegisterNetEvent("zBank:bank")
AddEventHandler("zBank:bank", function(money)
    moulahbank = tonumber(money)
end)

function GetPlayerMoney(action)
    TriggerServerEvent("zBank:getcash", action)
end

RegisterNetEvent("zBank:cash")
AddEventHandler("zBank:cash", function(money)
    PlayerMoney = tonumber(money)
end)

function GetPlayerRib(action)
    TriggerServerEvent("zBank:getrib", action)
end

RegisterNetEvent("zBank:rib")
AddEventHandler("zBank:rib", function(good)
    gettedrib = tonumber(godd)
end)

RegisterNetEvent("zBank:nohaveaccount")
AddEventHandler("zBank:nohaveaccount", function() 
    OpenBankMenuCreateAccount(true)
end)

RegisterNetEvent("zBank:haveaccount")
AddEventHandler("zBank:haveaccount", function() 
    OpenBankMenuAccount(true)
end)

RegisterNetEvent("zBank:haveatm")
AddEventHandler("zBank:haveatm", function() 
    OpenAtmMenuAccount(true)
end)

function GetAll()
    esx.TriggerServerCallback('zBank:getdatecreate', function(date)
        creeatedate = date;
    end)
    
end

function BankData()
    esx.TriggerServerCallback('zBank:getallinfo', function(data)
        bankdata = data;
    end)
end

function GetVirement()
    esx.TriggerServerCallback('zBank:getallVirement', function(data)
        virementdata = data;
    end)
end

function GetHistorique()
    esx.TriggerServerCallback('zBank:gethistorique', function(data)
        historique = data;
    end)
end

function LoadInfo()
    GetAll()
    BankData()
    GetHistorique()
    GetPlayerRib()
    GetPlayerMoney()
    RefreshBank()
    GetHistorique()
    GetVirement()
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end