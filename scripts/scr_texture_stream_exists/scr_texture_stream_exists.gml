/// 
/// @function				texture_stream_exists(_spriteSheetName)
/// @description            Checks if a texture stream exists
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if exists and false if not
/// 
function texture_stream_exists(_spriteSheetName) {
	// Make sure sprite sheet exists
	if(!spritesheet_exists(_spriteSheetName)) return false;
	
	var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	return variable_struct_exists(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);
}