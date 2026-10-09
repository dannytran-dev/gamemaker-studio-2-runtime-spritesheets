///
/// @function				spritesheet_system_init()
/// @description            Initializes the sprite sheet system. Safe to call more than once
///
/// @returns {undefined}
///
function spritesheet_system_init() {
	if(variable_global_exists("SPRITESHEET_SYSTEM")) return;

	global.SPRITESHEET_SYSTEM = { };

	#macro SPRITESHEET_IMAGES_KEY "images"
	#macro SPRITESHEET_TEXTURE_STREAM_KEY "texture_stream"
	#macro SPRITESHEET_TEXTUREPAGES_KEY "texture_pages"
}
