--[[---------------------------------------------------------
	Variables
-----------------------------------------------------------]]
Mania = Mania or {}
Mania.f4 = Mania.f4 or {}

--[[---------------------------------------------------------
	Function: triggerF4
-----------------------------------------------------------]]
function Mania.f4.triggerF4()

	--> Variables
	local frame = Mania.f4.frame

	--> Exists
	if !IsValid(frame) then
		Mania.f4.createF4()
		return
	end

	--> Visibility
	if frame:IsVisible() then
		Mania.f4.hideF4()
	else
		Mania.f4.showF4()
	end

end
hook.Add('ShowSpare2', 'triggerF4', Mania.f4.triggerF4)

--[[---------------------------------------------------------
	Function: showF4
-----------------------------------------------------------]]
function Mania.f4.showF4()

	--> Variables
	local frame = Mania.f4.frame

	--> Show
	frame:SetVisible(true)
	frame:Show()

	--> Reload
	frame.content:ReloadActive()

end

--[[---------------------------------------------------------
	Function: hideF4
-----------------------------------------------------------]]
function Mania.f4.hideF4()

	--> Variables
	local frame = Mania.f4.frame

	--> Show
	frame:SetVisible(false)
	frame:Hide()

end

--[[---------------------------------------------------------
	Function: createF4
-----------------------------------------------------------]]
function Mania.f4.createF4()

	--> Variables
	local settings = Mania.f4.settings

	--> Frame
	local frame = vgui.Create('ManiaFrame')
	frame:SetSettings(settings)
	frame:SetSize(settings.width, settings.height)
	frame:Center()

	--> Close
	frame:SetCloseFunction(function() 

		--> Hook
		hook.Call('ShowSpare2')

	end)

	--> Trigger
	frame.OnKeyCodePressed = function(pnl, key)
		if key == KEY_F4 then
			
			--> Hook
			hook.Call('ShowSpare2')

		end
	end

	--> Popup
	frame:MakePopup(explosed)

	--> Table
	Mania.f4.frame = frame

end

--[[---------------------------------------------------------
	Function: reloadF4 86a6465c027c6f059b948e56b1c15ec9f2bae022b666df6eb6220b9e298db813
-----------------------------------------------------------]]
function Mania.f4.reloadF4()

	--> Variables
	local frame = Mania.f4.frame
	local settings = Mania.f4.settings

	--> Frame
	if IsValid(frame) then
		frame:Remove()
	end

end
hook.Add('OnReloaded', 'reloadF4', Mania.f4.reloadF4)
