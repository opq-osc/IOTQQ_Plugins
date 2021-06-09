local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveGroupMsg(CurrentQQ, data)
if (string.find(data.Content, "nbnhhsh") == 1) then
     local main = "{\"text\":\"none\"}"
     keyWord = data.Content:gsub("nbnhhsh", "")
		 Payload = main:gsub("none", keyWord)
         response, error_message = http.request("POST",
                                   "https://lab.magiconch.com/api/nbnhhsh/guess", {
             body = Payload,
             headers = {
                 ["Content-Type"] = "application/json"
             }
         })
    html = response.body
		j = json.decode(html)
		if j[1].trans == nil then
		text = "Not Found!"
		else
		str = html:match("(trans(.-)])")
		Con1 = str:gsub("trans\":%[", "")
		Con2 = Con1:gsub("%]", "")
		text = "" ..j[1].name.. " Perhaps: " ..Con2.. ""
		end
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = text,
                atUser = 0
            }
        )
    end
    return 1
end
