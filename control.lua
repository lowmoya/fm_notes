-- GUI functions
-- Add support for changing this to just the player index in the options menu
local function getNoteIndex(player_index)
	return game.get_player(player_index).name
end

local function openGUI(player_index)
	-- Prepare GUI
	local frame = game.get_player(player_index).gui.screen.add{
		type='frame',
		caption='Notes',
	}
	frame.style.width = 325
	frame.style.height = 490

	local main_flow = frame.add{type='flow', direction='vertical'}
	main_flow.style.vertical_spacing = 10

	local box = main_flow.add{type='text-box'}
	box.style.width = 300
	box.style.height = 400
	box.style.maximal_height = 400

	local control_flow = main_flow.add{type='flow'}
	local button = control_flow.add{type='button', name='notes-close', caption='Ok'}
	button.style.size = {40, 24}
	--local dragger = control_flow.add{type='empty-widget', style='draggable_space'}
	--dragger.name = 'notes-resize'
	--dragger.drag_target = frame
	--dragger.style.size = {248, 24}


	-- State behavior
	local noteIndex = getNoteIndex(player_index)
	if not global.notes[noteIndex] then
		global.notes[noteIndex] = {}
	end
	local notes = global.notes[noteIndex]

	notes.frame = frame
	notes.textbox = box
	if notes.text then
		box.text = notes.text
		frame.location = notes.location
	end
end

local function closeGUI(player_index)
	local notes = global.notes[getNoteIndex(player_index)]

	notes.text = notes.textbox.text

	notes.location = notes.frame.location
	notes.frame.destroy()
	notes.frame = nil
end


-- Init GUI functions
script.on_init(function()
	global.notes = {}
end)

script.on_event('notes-toggle', function(event)
	local notes = global.notes[getNoteIndex(event.player_index)]
	if notes and notes.frame then
		closeGUI(event.player_index)
	else
		openGUI(event.player_index)
	end
end)
script.on_event(defines.events.on_gui_click, function(event)
	if event.element.name == 'notes-close' then
		closeGUI(event.player_index)
	end
end)

script.on_event('notes-reset', function(event)
	local notes = global.notes[getNoteIndex(event.player_index)]
	if notes == nil then return end
	
	notes.location = {0, 0}
	if notes.frame ~= nil then
		notes.frame.location = notes.location
	end
end)
