local Scene = require('script.lib.core.scene')
local Gradient = require('script.lib.ui.gradient')
local LinearLayout = require('script.lib.ui.layout.linear')
local Block = require('script.lib.ui.block')
local Text = require('script.lib.ui.text')
local Button = require('script.lib.ui.comctl.button')

local modname = 'script.scene.welcome'
local M = Scene:new()
_G[modname] = M
package.loaded[modname] = M

function M:new(o)
	o = o or {}
	o.name = 'Welcome Scene'
	o.state = {focused=nil, hover=nil}
	setmetatable(o, self)
	self.__index = self
	return o;
end

function M:init()
	self.minw = 800
	self.minh = 600
	UIExt.set_minw(self.minw, self.minh)

	UIExt.trace('Scene [Welcome page] init')
	-- INFO
	local info = UIExt.info()
	-- BG
	local bg = LinearLayout:new({
		right = info.width,
		bottom = info.height
	})
	self.layers.bg = self:add(bg)
	bg:add(Block:new({
		color = '#111111',
		right = info.width,
		bottom = info.height
	}))
	UIExt.trace('Scene [Welcome page]: create background #' .. self.layers.bg.handle)
	-- BG2
	local bg2 = Gradient:new({
		color1 = '#111111',
		color2 = '#AAAAAA',
		direction = 1,
		pre_resize = function(this, left, top, right, bottom)
			return left, ((bottom - top) / 2) - 100, right, bottom
		end
	})
	self.layers.bg2 = bg:add(bg2)
	UIExt.trace('Scene [Welcome page]: create background2 #' .. self.layers.bg2.handle)
	-- TEXT
	local cc = Text:new({
		color = '#EEEEEE',
		text = 'Made by bajdcc',
		size = 24,
		pre_resize = function(this, left, top, right, bottom)
			return right - 200, bottom - 50, right, bottom
		end,
		hit = function(this, evt)
			if evt == WinEvent.leftbuttondown then
				FlipScene('Welcome')
			end
		end
	})
	self.layers.cc = self:add(cc)
	UIExt.trace('Scene [Time page]: create text #' .. self.layers.cc.handle)
	-- TEXT
	local text = Text:new({
		color = '#EEEEEE',
		text = '【自制简易游戏框架】',
		pre_resize = function(this, left, top, right, bottom)
			return left, top, right, bottom / 2
		end
	})
	self.layers.text = self:add(text)
	UIExt.trace('Scene [Welcome page]: create text #' .. self.layers.text.handle)
	-- MENU
	self:init_menu(info)

	-- EVENT
	self:init_event()

	self.resize(self)
	UIExt.paint()
end

function M:destroy()
	UIExt.trace('Scene [Welcome page] destroy')
	UIExt.clear_scene()
end

function M:init_event()
	self.handler[self.win_event.created] = function(this)
		UIExt.trace('Scene [Welcome page] Test created message!')
	end
	self.handler[self.win_event.timer] = function(this, id)
	end
end

function M:init_menu(info)
	-- MENU CONTAINER LAYOUT
	local menu = LinearLayout:new({
		align = 2,
		pre_resize = function(this, left, top, right, bottom)
			local w = left + (right - left) / 2
			local h = top + (bottom - top) / 2
			return w - 100, h, w + 100, h + 250
		end
	})
	self.layers.menu = self:add(menu)
	
	-- MENU BUTTON
	Button:new({
		text = '控件',
		click = function()
			FlipScene('ComCtl')
		end
	}):attach(menu)

	Button:new({
		text = '动画',
		click = function()
			FlipScene('Time')
		end
	}):attach(menu)

	Button:new({
		text = '退出',
		click = function()
			UIExt.quit(0)
		end
	}):attach(menu)
end

return M