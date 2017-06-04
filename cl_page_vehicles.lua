--[[---------------------------------------------------------
	Variables
-----------------------------------------------------------]]
local PANEL = {}

--[[---------------------------------------------------------
	Function: Init
-----------------------------------------------------------]]
function PANEL:Init()

	--> Categories
	self:SetCategories(DarkRP.getCategories().vehicles)

	--> Variables
	self.actionText = Mania.f4.language.purchase

	--> Name
	self:SetNameCallback(function(item)
		return {
			text = item.name,
			color = Color(0, 0, 0, 245)
		}

	end)

	--> Money
	self:SetMoneyCallback(function(item)
		return {
			text = DarkRP.formatMoney(item.price),
			color = Color(0, 0, 0, 255)
		}
	end)

	--> Model
	self:SetModelCallback(function(item)

		--> Return
		return item.model

	end)

	--> Maximum
	self:SetMaximumCallback(function(item)

		--> Return
		return ''

	end)

	--> Action
	self:SetActionCallback(function(item)

		--> Purchase
		RunConsoleCommand('DarkRP', 'buyvehicle', item.name)

		--> Close
		if self.tab.shouldClose then
			hook.Call('ShowSpare2')
		end

	end)

	--> Validation
	self:SetValidationCallback(function(item)

		--> Variables
	    local ply = LocalPlayer()

	    --> Search
	    local failSearch = self:GetSearchCallback()(item)
	    if failSearch then
	    	return false, true, nil, nil, true
	    end

	    --> Checks
	    local cost = item.getPrice and item.getPrice(ply, item.price) or item.price

	    if istable(item.allowed) and not table.HasValue(item.allowed, ply:Team()) then return false, true end
	    if item.customCheck and not item.customCheck(ply) then return false, true end

	    local canbuy, suppress, message, price = hook.Call("canBuyVehicle", nil, ply, item)

	    cost = price or cost

	    if not ply:canAfford(cost) then return false, false, message, cost end

	    if canbuy == false then
	        return false, suppress, message, cost
	    end

	    --> Return
	    return true, nil, message, cost

	end)

	--> Disabled
	self:SetDisabledCallback(function(panel, can, important, _, _, isSearch)

		--> Search
		if isSearch then
			panel:SetVisible(false)
			return false
		end

		--> Defaults
	    if can and (GAMEMODE.Config.hideNonBuyable or (important and GAMEMODE.Config.hideTeamUnbuyable)) then
	        panel:SetVisible(false)
	        return false
	    else
	        panel:SetVisible(true)
	        return true
	    end

	end)

	--> Reload
	self:ReloadContent()

end

--[[---------------------------------------------------------
	Define: ManiaPage-vehicles
-----------------------------------------------------------]]
derma.DefineControl('ManiaPage-vehicles', 'ManiaPage-vehicles', PANEL, 'ManiaPage-base')