local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if (string.find(data.Content, "TyM") == 1) then
        response, error_message = http.request("GET", "http://data.istrongcloud.com/v2/data/complex/currMerger.json")
        local html = response.body
        if html == "[]" then
            text = "南海及西太平洋无台风"
        else
            local j = json.decode(html)
            local count = 0
            for k,v in pairs(j) do
               count = count + 1
            end
            text = "" ..j['count'].ident.. " " ..j['count'].name.. "" ..j['count'].ename.. " " ..j['count'].points['count'].time.. "\n-------\n" ..j['count'].points['count'].strong.. "\nSpeed:" ..j['count'].points['count'].speed.. "m/s & Pressure:" ..j['count'].points['count'].pressure.. " hPa & Power:" ..j['count'].points['count'].power.. "级 \nMove:向" ..j['count'].points['count'].move_dir.. "方向以 " ..j['count'].points['count'].move_speed.. "km/h 移动 & Localtion:" ..j['count'].points['count'].lng.. "," ..j['count'].points['count'].lat.. "" 
        end
        Api.Api_SendMsgV2(CurrentQQ, {
            ToUserUid = data.FromGroupId,
            SendToType = 2,
            SendMsgType = "TextMsg",
            groupid = 0,
            Content = text,
            atUser = 0
        })
    end
    return 1
end
