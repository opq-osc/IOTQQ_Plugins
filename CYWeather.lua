---数据来源自彩云天气®,需要请自行获取APIKey
---最终国家基本站点数据请以中央气象台NMC发布数据为准
local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if string.find(data.Content, "查天气") then
        keyWord = data.Content:gsub("查天气", "")
            if keyWord == "" then
                    return 1
            end
        response, error_message = 
            http.request(
                "GET",
                "http://json.xinmoe.cn/geocode.json"
        )
        local geo = response.body 
        local geojs = json.decode(geo)
        response, error_message = 
            http.request(
                "GET",
                "http://api.caiyunapp.com/v2.5/Put Your Key/weather.json?adcode=" ..geojs[keyWord].district_geocode.. "&unit=metric:v2"
        )
        local html = response.body 
        local a = json.decode(html)
        humidity = a.result.realtime.humidity * 100
        cloud = a.result.realtime.cloudrate * 100
        temp = a.result.realtime.temperature
        temp2 = a.result.realtime.apparent_temperature
        wind = a.result.realtime.wind.speed / 3.6
        vis = a.result.realtime.visibility
        press = a.result.realtime.pressure / 100
        time = a.server_time
        local t = os.date("%Y年%m月%d日%H:%M:%S",time) ---数据获取时间戳
        ApiRet =
                Api.Api_SendMsgV2(
                CurrentQQ,
                {
                    ToUserUid = data.FromGroupId,
                    SendToType = 2,
                    SendMsgType = "TextMsg", 
                    groupid = 0,
                   Content = "DataTime:" ..t.. " - " ..keyWord.. "\n气温：" ..temp.. "℃ & 体感温度：" ..string.format("%.1f",temp2).. "℃\n湿度：" ..humidity.. "%\n能见度：" ..vis.. "km\n云量：" ..cloud.. "%\n风：" ..string.format("%.1f",a.result.realtime.wind.direction).. "° & " ..string.format("%.1f",wind).. "m/s\n站点气压：" ..string.format("%.1f",press).. "hPa\n------------\n" ..a.result.forecast_keypoint.. ""
                }
            )
     end
   return 1
end
