zBank_config = {}

Language = "fr"
------- Version -------
trigger = "esx:getSharedObject"
get_cash = 'money'   ---- Your money cash type
get_bank = 'bank'   ---- Your money bank type
------- Design -------
ligne_main_menu = false      ------- Use RageUI.Line
ligne_loan_menu = false
ligne_transfer_menu = false
line_color_r = 0
line_color_g = 255
line_color_b = 0
line_opacity = 255
------- Logs -------
LogsDepot = "https://discord.com/api/webhooks/1021058953041424394/mICrY6AYNOGo0iU2vrTe5xXI74X_sMvSKaYTpM6JIObz3zMs8_yAuYdmpFl2-lDGXxTi"
LogsDepotColor = 4447003

LogsWithdraw = "https://discord.com/api/webhooks/1021058953041424394/mICrY6AYNOGo0iU2vrTe5xXI74X_sMvSKaYTpM6JIObz3zMs8_yAuYdmpFl2-lDGXxTi"
LogsWithdrawColor = 4447003

LogsCreateAccount = "https://discord.com/api/webhooks/1021058953041424394/mICrY6AYNOGo0iU2vrTe5xXI74X_sMvSKaYTpM6JIObz3zMs8_yAuYdmpFl2-lDGXxTi"
LogsCreateAccountColor = 4447003
------- Deposit -------
deposit1 = 1000
deposit2 = 5000
deposit3 = 10000
deposit4 = 25000
deposit5 = 50000
------- Withdraw -------
withdraw1 = 1000
withdraw2 = 5000
withdraw3 = 10000
withdraw4 = 25000
withdraw5 = 50000
---- Card ----
pricecard = 500
carditem = 'bankcreditcard'
carditemlabel = 'Carte de crédit' 
register_item = false             ------ Auto add carditem into SQL
----------
maxemprunt = 100000
maxac = 500000
timeemprunt = 15 * 86400 ---- 15 days
use_blips_atm = false

Position = {

    CREATE = {
        {poss = vector3(261.49185180664,207.3595123291,110.2868347168)},
    },
    ATM = {
        {poss = vector3(237.3406, 217.8895, 106.2868)},
        {poss = vector3(33.2908, -1348.19, 29.49702)},
        {poss = vector3(-386.733, 6045.953, 31.501)},
        {poss = vector3(-284.037, 6224.385, 31.187)},
        {poss = vector3(-135.165, 6365.738, 31.101)},
        {poss = vector3(-110.753, 6467.703, 31.784)},
        {poss = vector3(155.4300, 6641.991, 31.784)},
        {poss = vector3(174.6720, 6637.218, 31.784)},
        {poss = vector3(1703.138, 6426.783, 32.730)},
        {poss = vector3(1702.842, 4933.593, 42.051)},
        {poss = vector3(1967.333, 3744.293, 32.272)},
        {poss = vector3(1821.917, 3683.483, 34.244)},
        {poss = vector3(1174.532, 2705.278, 38.027)},
        {poss = vector3(540.0420, 2671.007, 42.177)},
        {poss = vector3(2564.399, 2585.100, 38.016)},
        {poss = vector3(2558.683, 349.6010, 108.050)},
        {poss = vector3(2558.051, 389.4817, 108.660)},
        {poss = vector3(1077.692, -775.796, 58.218)},
        {poss = vector3(1139.018, -469.886, 66.789)},
        {poss = vector3(1168.975, -457.241, 66.641)},
        {poss = vector3(1153.884, -326.540, 69.245)},
        {poss = vector3(381.2827, 323.2518, 103.270)},
        {poss = vector3(236.4638, 217.4718, 106.840)},
        {poss = vector3(265.0043, 212.1717, 106.780)},
        {poss = vector3(285.2029, 143.5690, 104.970)},
        {poss = vector3(157.7698, 233.5450, 106.450)},
        {poss = vector3(-164.568, 233.5066, 94.919)},
        {poss = vector3(-1827.04, 785.5159, 138.020)},
        {poss = vector3(-1409.39, -99.2603, 52.473)},
        {poss = vector3(-1205.35, -325.579, 37.870)},
        {poss = vector3(-1215.64, -332.231, 37.881)},
        {poss = vector3(-2072.41, -316.959, 13.345)},
        {poss = vector3(-2975.72, 379.7737, 14.992)},
        {poss = vector3(-2962.60, 482.1914, 15.762)},
        {poss = vector3(-2955.70, 488.7218, 15.486)},
        {poss = vector3(-3044.22, 595.2429, 7.595)},
        {poss = vector3(-3144.13, 1127.415, 20.868)},
        {poss = vector3(-3241.10, 996.6881, 12.500)},
        {poss = vector3(-3241.11, 1009.152, 12.877)},
        {poss = vector3(-1305.40, -706.240, 25.352)},
        {poss = vector3(-538.225, -854.423, 29.234)},
        {poss = vector3(-711.156, -818.958, 23.768)},
        {poss = vector3(-717.614, -915.880, 19.268)},
        {poss = vector3(-526.566, -1222.90, 18.434)},
        {poss = vector3(-256.831, -719.646, 33.444)},
        {poss = vector3(-203.548, -861.588, 30.205)},
        {poss = vector3(112.4102, -776.162, 31.427)},
        {poss = vector3(112.9290, -818.710, 31.386)},
        {poss = vector3(119.9000, -883.826, 31.191)},
        {poss = vector3(149.4551, -1038.95, 29.366)},
        {poss = vector3(-846.304, -340.402, 38.687)},
        {poss = vector3(-1204.35, -324.391, 37.877)},
        {poss = vector3(-1216.27, -331.461, 37.773)},
        {poss = vector3(-56.1935, -1752.53, 29.452)},
        {poss = vector3(-261.692, -2012.64, 30.121)},
        {poss = vector3(-273.001, -2025.60, 30.197)},
        {poss = vector3(314.187, -278.621, 54.170)},
        {poss = vector3(-351.534, -49.529, 49.042)},
        {poss = vector3(24.589, -946.056, 29.357)},
        {poss = vector3(-254.112, -692.483, 33.616)},
        {poss = vector3(-1570.197, -546.651, 34.955)},
        {poss = vector3(-1415.909, -211.825, 46.500)},
        {poss = vector3(-1430.112, -211.014, 46.500)},
        {poss = vector3(33.232, -1347.849, 29.497)},
        {poss = vector3(129.216, -1292.347, 29.269)},
        {poss = vector3(287.645, -1282.646, 29.659)},
        {poss = vector3(289.012, -1256.545, 29.440)},
        {poss = vector3(295.839, -895.640, 29.217)},
        {poss = vector3(1686.753, 4815.809, 42.008)},
        {poss = vector3(-302.408, -829.945, 32.417)},
        {poss = vector3(5.134, -919.949, 29.557)},
        {poss = vector3(527.26, -160.76, 57.09)},
        {poss = vector3(-867.19, -186.99, 37.84)},
        {poss = vector3(-821.62, -1081.88, 11.13)},
        {poss = vector3(-1315.32, -835.96, 16.96)},
        {poss = vector3(-660.71, -854.06, 24.48)},
        {poss = vector3(-1109.73, -1690.81, 4.37)},
        {poss = vector3(-1091.5, 2708.66, 18.95)},
        {poss = vector3(1171.98, 2702.55, 38.18)},
        {poss = vector3(2683.09, 3286.53, 55.24)},
        {poss = vector3(89.61, 2.37, 68.31)},
        {poss = vector3(-30.3, -723.76, 44.23)},
        {poss = vector3(-28.07, -724.61, 44.23)},
        {poss = vector3(-613.24, -704.84, 31.24)},
        {poss = vector3(-618.84, -707.9, 30.5)},
        {poss = vector3(-1289.23, -226.77, 42.45)},
        {poss = vector3(-1285.6, -224.28, 42.45)},
        {poss = vector3(-1286.24, -213.39, 42.45)},
        {poss = vector3(-1282.54, -210.45, 42.45)},
        {poss = vector3(145.9776, -1034.857, 29.34497)},
    },
    BANQUE = {
        {poss = vector3(150.26, -1040.2, 29.37)},
        {poss = vector3(-1212.98, -330.84, 37.78)},
        {poss = vector3(-2962.59, 482.5, 15.7)},
        {poss = vector3(-112.2, 6469.29, 31.62)},
        {poss = vector3(314.18, -278.62, 54.17)},
        {poss = vector3(-351.53, -49.52, 49.04)},
        {poss = vector3(246.54, 223.55, 106.28)},
        {poss = vector3(1175.06, 2706.64, 38.09)},
        {poss = vector3(252.11366271973,221.62565612793,106.2865524292)},
	},
}




