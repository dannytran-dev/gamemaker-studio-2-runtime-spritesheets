/// 
/// @function				texture_stream_start(_spriteSheetName, _texWidth, _texHeight, _texSep = 0, _timeout = 10)
/// @description            Starts a texture stream in a specific sprite sheet. This is where we process each sprite into a texture page
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @param {Real}			[_texWidth] - Texture page max width
/// @param {Real}			[_texHeight] - Texture page max height
/// @param {Real}			[_texSep] - Texture image seperation
/// @param {Real}			[_timeout] - Seconds to wait for downloading images before giving up on them. 0 waits forever
/// @returns {Bool}			Returns true if successful and false if failed
/// 
function texture_stream_start(_spriteSheetName, _texWidth, _texHeight, _texSep = 0, _timeout = 10) {
	// Check is sprite sheet exists
	if(!spritesheet_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Start Failed: The spritesheet {0} does not exist", _spriteSheetName))
		return false;
	}
	
	// Check if sprite sheet already has a texture stream
	if(texture_stream_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Start Failed: The spritesheet {0} already has a texture stream started", _spriteSheetName))
		return false;
	}
	
	// Create a new texture stream 
	var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _imageStream = new TextureStream(_texWidth, _texHeight, _texSep, _timeout);
	variable_struct_set(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY, _imageStream);
	
	return true;
}