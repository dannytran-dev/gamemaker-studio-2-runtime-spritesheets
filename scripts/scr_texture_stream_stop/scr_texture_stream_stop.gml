///
/// @function				texture_stream_stop(_spriteSheetName)
/// @description            Stops a texture stream in a specific sprite sheet. On windows or in some HTML5 cases the texture stream will finish before you can call this
///
/// @param {String}			[_spriteSheetName] - The sprite sheet to stop
/// @returns {Bool}			Returns true if stop was successful and false if failed
///
function texture_stream_stop(_spriteSheetName) {
	if(spritesheet_exists(_spriteSheetName)) {
		var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);

		// Free any images still waiting to be packed
		if(texture_stream_exists(_spriteSheetName)) {
			variable_struct_get(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY).destroy();
		}

		variable_struct_remove(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);

		return true;
	}
	else {
		spritesheet_log(string("Texture Stream Stop Failed: The spritesheet {0} you are trying to stop does not exist", _spriteSheetName));
		return false;
	}
}
