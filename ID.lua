local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if string.find(data.Content, "id") then --查询NMC自动站编号
   keyWord = data.Content:gsub("id", "") --提取待查询的站点名
        response, error_message = --从Json查询
            http.request(
            "GET",
            "http://json.moex.club/moenmc.json" --个人自建数据Json归档，暂未限制请求频率
        )
    local html = response.body --获取Json
		local str = html
		local id = json.decode(str) --反序列化
            ApiRet =
                Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg", 
                    groupid = 0,
                    content = "" ..keyWord.. "" ..id[keyWord].desc.. "",--获取匹配站点，返回ID
                    atUser = 0
                }
            )
			str = nil
		  html = nil
      id = nil
  end
  return 1
end
