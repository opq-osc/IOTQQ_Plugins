---数据来源自和风天气®,需要请自行获取APIKey
local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    log.notice("From Lua Log ReceiveFriendMsg %s", CurrentQQ)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    log.notice("From Lua Log tianqi ReceiveGroupMsg %s", CurrentQQ)
    if string.find(data.Content, "Air") then
        keyWord = data.Content:gsub("Air", "")
            if keyWord == "" then
                    return 1
            end
        response, error_message = 
            http.request(
                "GET",
                "https://geoapi.heweather.net/v2/city/lookup?location=" ..url_encode(keyWord).. "&key=Put Your Key"---geo data
        )
        local html1 = response.body 
        local c = json.decode(html1) ---main data
        ---air start     
        response, error_message = 
        http.request(
                "GET",
                "https://devapi.heweather.net/v7/air/now?location=" ..c.location[1].id.. "&key=Put Your Key" 
        )
        local html3 = response.body
        local air = json.decode(html3)
        ---air end
        local text= "" ..c.location[1].adm2.. "-" ..c.location[1].name.. "\nAQI：" ..air.now.aqi.. " " ..air.now.category.. "\nPM10：" ..air.now.pm10.. "\nPM2.5：" ..air.now.pm2p5.. "\nCO：" ..air.now.co.. "\nDataTime：" ..air.now.pubTime.. ""
Api.Api_SendMsg( 
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                content = text
            }
        )
            end
            return 1
        end
function ReceiveEvents(CurrentQQ, data, extData)
            return 1
end
function url_encode(str)
    if (str) then
        str = string.gsub(str, "\n", "\r\n")
        str =
            string.gsub(
            str,
            "([^%w ])",
            function(c)
                return string.format("%%%02X", string.byte(c))
            end
        )
        str = string.gsub(str, " ", "+")
    end
    return str
    end
