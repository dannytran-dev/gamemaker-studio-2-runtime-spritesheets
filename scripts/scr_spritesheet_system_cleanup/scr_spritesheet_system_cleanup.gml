/// 
/// @function				spritesheet_system_cleanup()
/// @description            Removes all textures from video memory, and they will then be reloaded on first use.
///
/// @returns {undefined}
/// 
function spritesheet_system_cleanup() {
	draw_texture_flush();
}