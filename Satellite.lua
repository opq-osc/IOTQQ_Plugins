local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if string.find(data.Content, "fy4真彩色") then
        response, error_message =
            http.request(
            "GET",
            "http://www.nmc.cn/rest/category/d3236549863e453aab0ccc4027105bad"
        )
        html = response.body
        str = html:gsub("/medium","")
		image = json.decode(str)
		pic = "http://image.nmc.cn/" ..image.dataList[1].imgPath.. ""
		elseif data.Content == "fy2红外" then
		response, error_message = http.request("GET", "http://www.nmc.cn/rest/category/57")
		html = response.body
		str = html:gsub("/medium", "")
        image = json.decode(str)
        pic = "http://image.nmc.cn/" ..image.dataList[1].imgPath.. ""
		else 
		return 1
		end
		ApiRet =
            Api.Api_SendMsg( 
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = "",
                atUser = 0,
                voiceUrl = "",
                voiceBase64Buf = "",
                picUrl = pic,
                picBase64Buf = "",
				fileMd5 = ""
            }
        )
  end