///
/// @function				texture_stream_add(_spriteSheetName, _imageName, _fPath, _subImg = 1, _xOrig = 0.5, _yOrig = 0.5, _clamp = false, _removeBack = false)
/// @description            Adds an image into the texture stream to be processed into a sprite sheet later.
///							In HTML5 images might not be ready so need to use texture_stream_async_image_loaded
///							in the Image Load Event, meaning _removeBack wont work.
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @param {String}			[_imageName] - Unique identifier for the image
/// @param {String}			[_fPath] - File path of where this image lives in included folder
/// @param {Real}			[_subImg] - The amount of subimages in this sprite. Use -1 for automatic crop of image named in format of ..._strip5
/// @param {Real}			[_xOrig] - The x position of the origin
/// @param {Real}			[_yOrig] - The y position of the origin
/// @param {Bool}			[_clamp] - Indicates whether to crop image automatically
/// @param {Bool}			[_removeBack] - Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent. Doesn't work in HTML5
/// @returns {Bool}			Returns true if successful and false if failed
///
function texture_stream_add(_spriteSheetName, _imageName, _fPath, _subImg = 1, _xOrig = 0.5, _yOrig = 0.5, _clamp = false, _removeBack = false) {
	if(_subImg == 0) {
		spritesheet_log(string("Texture Stream Add Failed: The spritesheet {0}, sprite: {1} can't have 0 sub images", _spriteSheetName, _imageName));
		return false;
	}

	// Check if sprite sheet has a texture stream to add to
	if(!texture_stream_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Add Failed: The spritesheet {0} does not have a texture stream started", _spriteSheetName));
		return false;
	}

	var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _totalSubImg = _subImg;

	// If -1 try to get subImg count from _strip#
	if(_totalSubImg <= -1) {
		var _fileName = filename_change_ext(filename_name(_fPath), "");
		var _stripPos = string_last_pos("_strip", _fileName);
		var _stripCount = _stripPos > 0 ? string_digits(string_delete(_fileName, 1, _stripPos + 5)) : "";

		if(_stripCount == "" || real(_stripCount) <= 0) {
			spritesheet_log(string("Texture Stream Add Failed: Can't auto sub divide sub images for {0}, must use strip format Eg: _strip2", _fPath));
			return false;
		}

		_totalSubImg = real(_stripCount);
	}

	var _texStream = variable_struct_get(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);

	var _texImage = new TextureStreamImage(_imageName, _fPath, _totalSubImg, _xOrig, _yOrig, _clamp, _removeBack);

	// sprite_add returns -1 straight away if the file can't be found
	if(!sprite_exists(_texImage.spriteAsset_)) {
		spritesheet_log(string("Texture Stream Add Failed: Could not load {0} for image {1}", _fPath, _imageName));
		return false;
	}

	var _texPriority = _texImage.get_priority();

	// If tex priority(w * h) is less then 1 then either the image isn't ready or something went wrong
	if(_texPriority <= 1 || !file_exists(_fPath)) {
		_texStream.add_tex_priority(_texImage);
		_texStream.add_sprite_loading(_texImage);
	}
	else {
		if(!_texImage.setup_image(_texStream)) return false;

		_texStream.add_tex_priority(_texImage);
	}

	return true;
}
