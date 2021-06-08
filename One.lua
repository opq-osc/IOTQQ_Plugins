local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if data.Content == "一言" or data.Content == "晚上好" then
  response, error_message = 
            http.request(
            "GET",
            "https://cdn.jsdelivr.net/gh/YunYouJun/el-bot-api/data/young.json"
)
        local html = response.body
        local json = json.decode(html)
        local rand = math.random
        local randseed= math.randomseed
        local num = rand(100)
        text = json[num]
elseif data.Content == "早安" or data.Content == "早" or data.Content == "早上好" then
        text = "早早早"
else 
  return 1
end
        Api.Api_SendMsgV2( --群
            CurrentQQ,
            {
                ToUserUid = data.FromGroupId,
                SendToType = 2,
                SendMsgType = "ReplayMsg",
                Content = text,
                ReplayInfo = {
                  UserID = data.FromUserId,
                  RawContent = data.Content,
                  MsgSeq = data.MsgSeq,
                  MsgTime = data.MsgTime
                 }
           }
        )
return 1
end