local GLOBAL = GLOBAL

if GetModConfigData("enablecustomcolor") == true and GetModConfigData("makerainbow") ~= true then
    GetModConfigData("numbercolortop")[1] = GetModConfigData("ccred")
    GetModConfigData("numbercolortop")[2] = GetModConfigData("ccgreen")
    GetModConfigData("numbercolortop")[3] = GetModConfigData("ccblue")
    GetModConfigData("numbercolorbottom")[1] = GetModConfigData("ccred")
    GetModConfigData("numbercolorbottom")[2] = GetModConfigData("ccgreen")
    GetModConfigData("numbercolorbottom")[3] = GetModConfigData("ccblue")
    GetModConfigData("numbercolorclock")[1] = GetModConfigData("ccred")
    GetModConfigData("numbercolorclock")[2] = GetModConfigData("ccgreen")
    GetModConfigData("numbercolorclock")[3] = GetModConfigData("ccblue")
    GetModConfigData("numbercolorrain")[1] = GetModConfigData("ccred")
    GetModConfigData("numbercolorrain")[2] = GetModConfigData("ccgreen")
    GetModConfigData("numbercolorrain")[3] = GetModConfigData("ccblue")
    GetModConfigData("arrowcolortop")[1] = GetModConfigData("ccred")
    GetModConfigData("arrowcolortop")[2] = GetModConfigData("ccgreen")
    GetModConfigData("arrowcolortop")[3] = GetModConfigData("ccblue")
    GetModConfigData("arrowcolorbottom")[1] = GetModConfigData("ccred")
    GetModConfigData("arrowcolorbottom")[2] = GetModConfigData("ccgreen")
    GetModConfigData("arrowcolorbottom")[3] = GetModConfigData("ccblue")
end

AddSimPostInit(function(inst)
    if GetModConfigData("makerainbow") == true then
        local color = GLOBAL.Vector3(math.random(10) * .1, math.random(10) * .1, math.random(10) * .1)
        local xswitch, yswitch, zswitch = false, false, false
        GLOBAL.GetPlayer():DoPeriodicTask(0, function()
            if not xswitch then color.x = color.x + .01 else color.x = color.x - .01 end
            if not yswitch then color.y = color.y + .02 else color.y = color.y - .02 end
            if not zswitch then color.z = color.z + .03 else color.z = color.z - .03 end

            if color.x >= .9 then xswitch = true end
            if color.y >= .9 then yswitch = true end
            if color.z >= .9 then zswitch = true end
            if color.x <= .2 then xswitch = false end
            if color.y <= .2 then yswitch = false end
            if color.z <= .2 then zswitch = false end

            GetModConfigData("numbercolortop")[1] = color.x
            GetModConfigData("numbercolortop")[2] = color.y
            GetModConfigData("numbercolortop")[3] = color.z
        end)
    end
end)

require = GLOBAL.require
local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Badge = require "widgets/badge"

local mybadgelosefocus = Badge.OnLoseFocus
function Badge:OnLoseFocus()
	local asdf = mybadgelosefocus(self)
		self.isfocused=false
		if self.num then
			self.num:Show()
		end
		if self.num2 then
			self.num2:Hide()
		end
	return asdf
end

local mybadgegainfocus = Badge.OnGainFocus
function Badge:OnGainFocus()
	local asdf = mybadgegainfocus(self)
		self.isfocused=true
		if self.num then
			self.num:Hide()
		end
		if self.num2 then
			self.num2:Show()
		end
	return asdf
end

local mysetpercent = Badge.SetPercent
function Badge:SetPercent(val,max)
	local asdf = mysetpercent(self, val, max)
		if self.num then
			if not self.isfocused then
				self.num:Show()
			else
				if self.isfocused==false then
					self.num:Show()
				end
			end
		end
		if not self.num2 then
			self.num:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
			self.num2 = self:AddChild(Text(GLOBAL.BODYTEXTFONT, 33))
			self.num2:SetHAlign(GLOBAL.ANCHOR_MIDDLE)
			self.num2:SetPosition(5, 0, 0)
			self.num2:SetColour(GetModConfigData("numbercolorbottom")[1],GetModConfigData("numbercolorbottom")[2],GetModConfigData("numbercolorbottom")[3],GetModConfigData("numberalpha"))
			self.num2:Hide()
		
			if self.sanityarrow then
				GLOBAL.GetPlayer():DoPeriodicTask(0, function(inst)
					if self.arrowdir then
						if tostring(self.arrowdir)=="arrow_loop_increase" or tostring(self.arrowdir)=="arrow_loop_increase_more" or tostring(self.arrowdir)=="arrow_loop_increase_most" then
							if GetModConfigData("movearrows")==true then
								self.sanityarrow:SetPosition(-.25, 37, 0)
							end
							if GetModConfigData("makerainbow")~=true then
								self.sanityarrow:GetAnimState():SetMultColour(GetModConfigData("arrowcolortop")[1],GetModConfigData("arrowcolortop")[2],GetModConfigData("arrowcolortop")[3],GetModConfigData("numberalpha"))
							end
						end
						if tostring(self.arrowdir)=="arrow_loop_decrease" or tostring(self.arrowdir)=="arrow_loop_decrease_more" or tostring(self.arrowdir)=="arrow_loop_decrease_most" then
							if GetModConfigData("movearrows")==true then
								self.sanityarrow:SetPosition(-.25, -41, 0)
							end
							if GetModConfigData("makerainbow")~=true then
								self.sanityarrow:GetAnimState():SetMultColour(GetModConfigData("arrowcolorbottom")[1],GetModConfigData("arrowcolorbottom")[2],GetModConfigData("arrowcolorbottom")[3],GetModConfigData("numberalpha"))
							end
						end
					end
				end)
			end

			GLOBAL.TheInput:AddControlHandler(GLOBAL.CONTROL_OPEN_CRAFTING, function(down)
				self.num:Show()
			end)
			GLOBAL.TheInput:AddControlHandler(GLOBAL.CONTROL_OPEN_INVENTORY, function(down)
				self.num:Show()
			end)

		end
		if type(max)=="number" then
			max=math.ceil(max)
		end
		self.num2:SetString(tostring(max))
		if GetModConfigData("makerainbow")==true and not self.rainbowsetup then
			self.rainbowsetup=true
			GLOBAL.GetPlayer():DoPeriodicTask(0, function(inst)
				if self.num then
					self.num:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
				end
				if self.num2 then
					self.num2:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
				end
				if self.sanityarrow then
					self.sanityarrow:GetAnimState():SetMultColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
				end
			end)
		end

		if GetModConfigData("enableadapttopcolor")==true and GetModConfigData("makerainbow")~=true and not self.adaptivecolorsetup and self.num and self.num.string and max then
			self.adaptivecolorsetup=true
			GLOBAL.GetPlayer():DoPeriodicTask(0, function(inst)
				local foo=GLOBAL.tonumber(self.num.string)/GLOBAL.tonumber(max)
				if foo>.8 then
					self.num:SetColour(0,1,0,GetModConfigData("numberalpha"))
				end
				if foo<.8 and foo>.6 then
					self.num:SetColour(178/255,194/255,72/255,GetModConfigData("numberalpha"))
				end
				if foo<.6 and foo>.4 then
					self.num:SetColour(1,1,0,GetModConfigData("numberalpha"))
				end
				if foo<.4 and foo>.2 then
					self.num:SetColour(1,.5,.25,GetModConfigData("numberalpha"))
				end
				if foo<.2 then
					self.num:SetColour(1,0,0,GetModConfigData("numberalpha"))
				end
			end)
		end

	return asdf
end


local UIClock=require"widgets/uiclock"
local myclockupdate=UIClock.UpdateDayString
function UIClock:UpdateDayString()
	local asdf=myclockupdate(self)
	if GetModConfigData("displaytemperature")==true then
	    self.text:SetPosition(5, 3/self.base_scale, 0)
		self.text:SetColour(GetModConfigData("numbercolorclock")[1],GetModConfigData("numbercolorclock")[2],GetModConfigData("numbercolorclock")[3],GetModConfigData("numberalpha"))
		if not self.text2 then
		    self.text2 = self:AddChild(Text(GLOBAL.BODYTEXTFONT, 25/self.base_scale))
    		self.text2:SetPosition(5, -23/self.base_scale, 0)
			self.text2:SetColour(GetModConfigData("numbercolorclock")[1],GetModConfigData("numbercolorclock")[2],GetModConfigData("numbercolorclock")[3],GetModConfigData("numberalpha"))
			local temper=GLOBAL.GetPlayer().components.temperature.current or "?"
			self.inst:DoPeriodicTask(0, function(inst)
				if GetModConfigData("finstead")==true then
					if temper~="?" then
						temper=GLOBAL.GetPlayer().components.temperature.current*1.8000
						temper=temper+32
						temper=math.floor(temper)
					end
					self.text2:SetString(temper.."/176F")
				else
					temper=tostring(GLOBAL.GetPlayer().components.temperature.current or "?")
					temper=math.floor(temper)
					self.text2:SetString(temper.."/176C")
				end
				if GetModConfigData("makerainbow")==true and not self.rainbowsetup then
					self.rainbowsetup=true
					GLOBAL.GetPlayer():DoPeriodicTask(0, function(inst)
						if self.text then
							self.text:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
						end
						if self.text2 then
							self.text2:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
						end
					end)
				end
			end)
		end
	end
	return asdf
end

AddSimPostInit(function(inst)
	if (GLOBAL.IsDLCEnabled(1)) then
		local MoistureMeter = require "widgets/moisturemeter"
		local mymoistureact = MoistureMeter.Activate
		function MoistureMeter:Activate()
			local asdf = mymoistureact(self)
				if self.num then
					self.num:SetColour(GetModConfigData("numbercolorrain")[1],GetModConfigData("numbercolorrain")[2],GetModConfigData("numbercolorrain")[3],GetModConfigData("numberalpha"))
					self.num:Show()
					if GetModConfigData("makerainbow")==true and not self.rainbowsetup then
						self.rainbowsetup=true
						GLOBAL.GetPlayer():DoPeriodicTask(0, function(inst)
							self.num:SetColour(GetModConfigData("numbercolortop")[1],GetModConfigData("numbercolortop")[2],GetModConfigData("numbercolortop")[3],GetModConfigData("numberalpha"))
						end)
					end
				end
			return asdf
		end
		local mymoisturedeact = MoistureMeter.Deactivate
		function MoistureMeter:Deactivate()
			local asdf = mymoisturedeact(self)
				if self.num then
					self.num:Hide()
					inst:DoTaskInTime(.25, function(inst)
						self.num:Hide()
					end)
				end
			return asdf
		end
		local mymoisturelosefoc = MoistureMeter.OnLoseFocus
		function MoistureMeter:OnLoseFocus()
			local asdf = mymoisturelosefoc(self)
				if self.num then
					self.num:Show()
				end
			return asdf
		end
	end
end)
