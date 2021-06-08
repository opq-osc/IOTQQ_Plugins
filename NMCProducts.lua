local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if data.Content == "NMCRain24" then
        response, error_message = http.request("GET", "http://www.nmc.cn/rest/category/339")
        html = response.body
        j = json.decode(html)
        link = j.dataList[1].imgPath
        linkbig = link:gsub("/medium", "")
elseif data.Content == "NMCWind" then
        response, error_message = http.request("GET", "http://www.nmc.cn/rest/category/37")
        html = response.body
        j = json.decode(html)
        link = j.dataList[1].imgPath
        linkbig = link:gsub("/medium", "")
elseif data.Content == "NMCTemp" then
        response, error_message = http.request("GET", "http://www.nmc.cn/rest/category/35")
        html = response.body
        j = json.decode(html)
        link = j.dataList[1].imgPath
        linkbig = link:gsub("/medium", "")
elseif data.Content == "NMCSwpc" then
        response, error_message = http.request("GET", "http://www.nmc.cn/rest/category/ed662fa2a62b4f87aec67101228b1f75")
        html = response.body
        j = json.decode(html)
        link = j.dataList[1].imgPath
        linkbig = link:gsub("/medium", "")
else
      return 1
      end
        ApiRet = Api.Api_SendMsg(CurrentQQ, {
            toUser = data.FromGroupId,
            sendToType = 2,
            sendMsgType = "PicMsg",
            content = "",
            atUser = 0,
            picUrl = "http://image.nmc.cn" .. linkbig .. ""
        })
  return 1
end


