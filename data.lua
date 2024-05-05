
-- Have a button for opening the notes and not setting the location, just in case the user
-- misplaces the window.
data:extend{
	{
		type = 'custom-input',
		name = 'notes-toggle',
		key_sequence = 'N',
		action = 'lua'
	},
	{
		type = 'custom-input',
		name = 'notes-reset',
		key_sequence = 'SHIFT + N',
		action = 'lua'
	}
}
