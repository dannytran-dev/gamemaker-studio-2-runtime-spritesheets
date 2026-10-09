///
/// @function				texture_stream_async_image_loaded(_spriteSheetName)
/// @description            HTML5 callback for images to be downloaded. Must be called in Async - Image Loaded Event
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if successful and false if failed
///
function texture_stream_async_image_loaded(_spriteSheetName) {
	if(!ds_exists(async_load, ds_type_map)){
	    spritesheet_log(string("Texture Stream Recieve: Can only be used in Image Loaded Event"));
	    return false;
	}

	if(!texture_stream_exists(_spriteSheetName)) return false;

	// Async Data
	var _id = async_load[? "id"];
	var _status = async_load[? "status"];

	// Loading Sprites
	var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _texStream = variable_struct_get(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);
	var _loadingTexImages = _texStream.loadingTexImages_;

	// Find the matching tex image, sprites can load in any order
	for(var _loadIndex = 0; _loadIndex < array_length(_loadingTexImages); _loadIndex++)
	{
		var _texImage = _loadingTexImages[_loadIndex];
		if(_texImage.spriteAsset_ != _id) continue;

		// Remove tex image from loading tex images array
		array_delete(_loadingTexImages, _loadIndex, 1);

		// A negative status means the image failed to download
		if(_status >= 0 && _texImage.setup_image(_texStream)) {
			// Update sprite priority now that we know its size
			_texStream.update_tex_priority(_texImage);
			_texStream.update_img_load_progress();
		}
		else {
			spritesheet_log(string("Texture Stream Recieve Failed: Could not load {0}", _texImage.fPath_));
			if(sprite_exists(_texImage.spriteAsset_)) sprite_delete(_texImage.spriteAsset_);
			_texStream.remove_tex_image(_texImage);
		}

		return true;
	}

	return false;
}
