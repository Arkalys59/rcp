-- Classe Rich Presence by Atoshi [OUTLAWSRP]

RichPresence = {}
RichPresence.__index = RichPresence

---@param appId number Application ID de Discord
---@param largeIcon string Nom de l'icône large
---@param largeIconText string Texte pour l'icône large
---@param smallIcon string|nil Nom de l'icône petite (optionnel)
---@param smallIconText string|nil Texte pour l'icône petite (optionnel)
---@param button1Text string|nil Texte pour le premier bouton (optionnel)
---@param button1Url string|nil URL pour le premier bouton (optionnel)
---@param button2Text string|nil Texte pour le deuxième bouton (optionnel)
---@param button2Url string|nil URL pour le deuxième bouton (optionnel)
---@return RichPresence Nouvelle instance de RichPresence
function RichPresence:new(appId, largeIcon, largeIconText, smallIcon, smallIconText, button1Text, button1Url, button2Text, button2Url)
    local self = setmetatable({}, RichPresence)
    self.appId = appId
    self.largeIcon = largeIcon
    self.largeIconText = largeIconText
    self.smallIcon = smallIcon
    self.smallIconText = smallIconText
    self.button1Text = button1Text
    self.button1Url = button1Url
    self.button2Text = button2Text
    self.button2Url = button2Url
    self:start()
    return self
end

function RichPresence:start()
    Citizen.CreateThread(function()
        while true do
            SetDiscordAppId(self.appId)
            SetDiscordRichPresenceAsset(self.largeIcon)
            SetDiscordRichPresenceAssetText(self.largeIconText)

            if self.smallIcon and self.smallIconText then
                SetDiscordRichPresenceAssetSmall(self.smallIcon)
                SetDiscordRichPresenceAssetSmallText(self.smallIconText)
            end

            if self.button1Text and self.button1Url then
                SetDiscordRichPresenceAction(0, self.button1Text, self.button1Url)
            end
            
            if self.button2Text and self.button2Url then
                SetDiscordRichPresenceAction(1, self.button2Text, self.button2Url)
            end

            Citizen.Wait(60000) 
        end
    end)
end

local rpc = RichPresence:new(1282169883043299399, 'logo_1024', 'Made by Atoshi', nil, nil, 'Discord', 'https://discord.gg/outlawsrp', nil, nil)
