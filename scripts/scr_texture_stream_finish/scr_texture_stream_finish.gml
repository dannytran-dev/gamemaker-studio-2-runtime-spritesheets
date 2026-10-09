/// 
/// @function				texture_stream_finish(_spriteSheetName)
/// @description            Finish a texture stream by drawing all sprites on each texture page and converting them into assets for later use.
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if successful and false if failed
/// 
function texture_stream_finish(_spriteSheetName) {
	// Check is sprite sheet exists
	if(!spritesheet_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Finish Failed: The spritesheet {0} does not exist", _spriteSheetName));
		return false;
	}
	
	// Check if sprite sheet already has a texture stream
	if(!texture_stream_exists(_spriteSheetName)) {
		spritesheet_log(string("Texture Stream Finish Failed: The spritesheet {0} texture stream does not exist", _spriteSheetName));
		return false;
	}
	
	// All Data
	var _spritesheet	= variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _images			= spritesheet_get_images(_spriteSheetName);
	var _texturePages	= variable_struct_get(_spritesheet, SPRITESHEET_TEXTUREPAGES_KEY);
	var _texStream		= variable_struct_get(_spritesheet, SPRITESHEET_TEXTURE_STREAM_KEY);
	
	if(!_texStream.finished()) {
		spritesheet_log(string("Texture Stream Finish Failed: The spritesheet {0} texture stream has not finished, sprites are loading!", _spriteSheetName));
		return false;
	}
	
	// Draw settings
	var _beginAlpha  = draw_get_alpha();
	var _beginColour = draw_get_colour();
	draw_set_alpha(1.0);
	draw_set_colour(c_white);
	gpu_set_blendenable(false);
	
	// Session to help create texture pages
	var _session = new TexturePageSession(_texStream);
	_session.new_texture_page();
	
	// Setup all the image areas
	_session.setup_areas(_images);
	
	// Create texture page
	_session.create_texture_page_sprite(_texturePages, _images);
	
	// Clear memory
	_session.destroy();
	_texStream.destroy();
	
	// Stops and removes texture stream from sprite sheet
	texture_stream_stop(_spriteSheetName);
	
	// Reset draw settings
	gpu_set_blendenable(true);
	draw_set_alpha(_beginAlpha);
	draw_set_colour(_beginColour);
		
	return true;
}