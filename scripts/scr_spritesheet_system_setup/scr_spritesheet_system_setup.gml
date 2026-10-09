//-----------------------------------------------------------------------------
// Runtime Sprite Sheets - Settings
// See README.md for full documentation
//-----------------------------------------------------------------------------

// Clears texture pages with a solid colour so packed areas can be visualized
#macro SPRITESHEET_DEBUG false

// Prints warnings and errors to the output console
#macro SPRITESHEET_LOGGING true

///
/// @function				spritesheet_log(_message)
/// @description            Prints a sprite sheet system message to the output console
///
/// @param {String}			[_message] - The message to print
/// @returns {undefined}
///
function spritesheet_log(_message) {
	if(SPRITESHEET_LOGGING) {
		show_debug_message("[RuntimeSpriteSheets] " + string(_message));
	}
}
