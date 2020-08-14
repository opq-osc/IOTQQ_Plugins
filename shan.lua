local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if string.find(data.Content, "请使用新版手机QQ查看闪照。") then
local image = data.Content:match("[a-zA-z]+://[^\s]*")
            ApiRet =
                Api.Api_SendMsg(
                CurrentQQ,
                {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "PicMsg",
                content = "2",
                atUser = 0,
                voiceUrl = "",
                voiceBase64Buf = "",
                picUrl = "" ..image.. "",
                picBase64Buf = "",
				fileMd5 = ""
                }
            )
            log.notice("From Lua SendMsg Ret-->%d", ApiRet.Ret)
        end
    return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
return 1
end
--author Mengxin001 2020
