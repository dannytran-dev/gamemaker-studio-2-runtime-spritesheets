/// 
/// @function				texture_stream_loading(_spriteSheetName)
/// @description            Checks if the current texture stream is loading. In HTML5 images might not be ready so we might need to wait
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if finished and false if loading
///
function texture_stream_loading(_spriteSheetName) {
	if(!texture_stream_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Finished: The spritesheet {0} texture stream has not started", _spriteSheetName))
		return false;
	}
	
	var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _texStream = variable_struct_get(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);
	
	// Drop any downloads that are taking too long
	_texStream.check_timeout();

	// If not finished then texture stream is still loading
	return !_texStream.finished();
}