Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.Menu = {
    Chair = {
        { label = "เกาอี้ 1", value = 'prop_table_03_chr' },
        { label = "ม้านั่ง", value = 'prop_bench_06' },
    },
    Table = {
        { label = "โต๊ะ 1", value = 'prop_proxy_chateau_table' },
        { label = "โต๊ะ 1 (มีร่ม)", value = 'prop_table_para_comb_01' },
        { label = "โต๊ะ 2 (มีร่ม)", value = 'prop_table_para_comb_02' },
        { label = "โต๊ะ 3 (มีร่ม)", value = 'prop_table_para_comb_03' },
        { label = "โต๊ะ 4 (มีร่ม)", value = 'prop_table_para_comb_04' },
        { label = "โต๊ะ 5 (มีร่ม)", value = 'prop_table_para_comb_05' },
        { label = "โต๊ะ ขนาดเล็ก (น้ำตาล)", value = 'prop_patio_lounger1_table' },
        { label = "โต๊ะ ขนาดเล็ก (สีขาว)", value = 'prop_table_03b' },
        { label = "โต๊ะสีขาว 1", value = 'prop_table_03' },
        { label = "โต๊ะสีขาว 2", value = 'prop_ven_market_table1' },
        { label = "โต๊ะสีน้ำตาล", value = 'prop_table_04' },
    },
    Tree = {
        { label = "ต้นไม้ 1", value = 'p_int_jewel_plant_02' },
        { label = "ต้นไม้ 2", value = 'prop_fbibombplant' },
        { label = "ต้นไม้ 3", value = 'prop_fib_plant_01' },
        { label = "ต้นไม้ 4", value = 'prop_pot_plant_05a' },
        { label = "ต้นไม้ 5", value = 'prop_windowbox_a' },
        { label = "ต้นไม้ 6", value = 'prop_windowbox_b' },
        { label = "ต้นไม้ 7", value = 'prop_windowbox_small' },
    },
    Umbe = {
        { label = "ร่ม 1", value = 'prop_parasol_04c' },
		{ label = "ร่ม 2", value = 'prop_beach_parasol_01' },
        { label = "ร่ม 3", value = 'prop_beach_parasol_02' },
        { label = "ห้ามใช้", value = 'p_ld_stinger_s' }
        
    },
    Fence = {
        { label = "รั้ว 1", value = 'prop_fncres_03a' },
		{ label = "รั้ว 2", value = 'prop_fncres_03b' },
		{ label = "รั้ว 3", value = 'prop_fncres_03c' }
    },
    Other = {
        { label = "ป้ายฮอทดอก", value = 'prop_venice_sign_19' },
        { label = "ป้ายพิชซ่า", value = 'prop_venice_sign_05' },
        { label = "ป้ายไอซ์ครีม", value = 'prop_venice_sign_02' },
        { label = "ป้ายโคล่า", value = 'prop_shopsign_01' },
        { label = "ป้ายลดราคา", value = 'prop_venice_sign_03' },
        { label = "ร้านฮอทดอก", value = 'prop_hotdogstand_01' },
        { label = "ร้านเบอร์เกอร์", value = 'prop_burgerstand_01' },
        { label = "เครื่องคิดเงิน", value = 'prop_till_01' },
        { label = "ร้านกาแฟ", value = 'p_ld_coffee_vend_01' },
        { label = "ที่ปิ้ง BBQ", value = 'prop_bbq_4' },
        { label = "กระทะ", value = 'prop_pot_05' },
        { label = "หม้อ", value = 'prop_pot_03' },
        { label = "ถาดผลไม้", value = 'prop_bar_fruit' },
        { label = "มีด 1", value = 'prop_cleaver' },
        { label = "มีด 2", value = 'prop_knife' },
        { label = "ลังผลไม้", value = 'prop_fruit_stand_02' },
        { label = "ลังผลไม้", value = 'prop_fruit_stand_03' },
        { label = "กระดาษชำระ", value = 'prop_bar_coasterdisp' },
        { label = "เครื่องทำกาแฟ", value = 'prop_coffee_mac_02' },
        { label = "เครื่องปิ้งขนมปัง", value = 'prop_toaster_01' },
        { label = "ซอสมะเขือเทศ", value = 'prop_food_ketchup' },
        { label = "มัสตาร์ด", value = 'prop_food_mustard' },
        { label = "ซอสมะเขือเทศ (อย่างดี)", value = 'v_ret_247_ketchup2' },
        { label = "ซอสมะเขือเทศ (แพ็ค)", value = 'v_ret_247_ketchup1' },
        { label = "มัสตาร์ด (แพ็ค)", value = 'v_ret_247_mustard' },
        { label = "เซ็ตเบอร์เกอร์", value = 'prop_food_bs_tray_02' },
        { label = "เซ็ตฮอทดอก", value = 'prop_food_bs_tray_03' },
        { label = "ไก่", value = 'prop_int_cf_chick_01' },
        { label = "เครื่องปั่นน้ำผลไม้", value = 'prop_kitch_juicer' },
        { label = "ถุงกระดาษขนาดใหญ่", value = 'prop_paper_bag_01' },
        { label = "ถุงกระดาษขนาดเล็ก", value = 'prop_paper_bag_small' },
        { label = "ฟองน้ำ", value = 'prop_scourer_01' },
        { label = "เสาไฟ 1", value = 'prop_oldlight_01a' },
        { label = "เสาไฟ 2", value = 'prop_snow_streetlight_09' },
        { label = "เสาไฟ 3", value = 'prop_streetlight_02' },
        { label = "เสาไฟ 4", value = 'prop_streetlight_06' },
        { label = "เสาไฟ 5", value = 'prop_streetlight_07a' },
        { label = "เสาไฟ 6", value = 'prop_streetlight_07b' },
        { label = "เสาไฟ 7", value = 'prop_streetlight_08' }, 
        { label = "เสาไฟ 8", value = 'prop_streetlight_11a' }
    },
    Vend = {
        { label = "ตู้กาแฟ", value = 'prop_vend_coffe_01' },
        { label = "ตู้ขนม", value = 'prop_vend_snak_01' },
        { label = "ตู้โซดา", value = 'prop_vend_soda_01' },
        { label = "ตู้โคล่า", value = 'prop_vend_soda_02' },
        { label = "ตู้กดน้ำ", value = 'prop_vend_water_01' },
        { label = "ตู้กดน้ำขนาดเล็ก", value = 'prop_watercooler_dark' },
        { label = "ตู้กดน้ำผลไม้", value = 'prop_juice_dispenser' },
        { label = "ตู้น้ำแข็ง", value = 'p_ice_box_01_s' },
    }

}