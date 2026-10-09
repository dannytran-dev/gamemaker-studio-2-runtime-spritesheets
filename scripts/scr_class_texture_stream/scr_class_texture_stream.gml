/// 
/// @function				TextureStream(_width, _height, _sep, _timeout = 10)
/// @description            Class for texture streams. A texture stream is a class that manages the texture pages state. Eg. If sprites are still loading lets keep track on that
///
/// @param {Real}			[_width] - Texture page max width
/// @param {Real}			[_height] - Texture page max height
/// @param {Real}			[_sep] - Texture image seperation
/// @param {Real}			[_timeout] - Seconds to wait for downloading images before giving up on them. 0 waits forever
/// @returns {Struct}		Returns a struct of type TextureStream
/// 
function TextureStream(_width, _height, _sep, _timeout = 10) constructor {
	
	// Settings
	width_ = _width;
	height_ = _height;
	sep_ = _sep;
	timeout_ = _timeout * 1000;
	startTime_ = current_time;
	
	// Texture images
	texImagePriorityList_ = ds_priority_create();
	loadingTexImages_ = [];
	loadingProgress_ = 0;
	finished_ = true;
	
	/// 
	/// @function				add_tex_priority(_texImage)
	/// @description            Adds a tex image using its priority
	///
	/// @param {Struct}			[_texImage] - Texture Image class
	/// @returns {undefined}			
	/// 
	static add_tex_priority = function(_texImage) {
		var _texPriority = _texImage.get_priority();
		ds_priority_add(texImagePriorityList_, _texImage, _texPriority);
	}
	
	/// 
	/// @function				update_tex_priority(_texImage)
	/// @description            Updates a tex image using its priority
	///
	/// @param {Struct}			[_texImage] - Texture Image class
	/// @returns {undefined}			
	/// 
	static update_tex_priority = function(_texImage) {
		var _texPriority = _texImage.get_priority();
		ds_priority_change_priority(texImagePriorityList_, _texImage, _texPriority);
	}
	
	/// 
	/// @function				add_sprite_loading(_texImage)
	/// @description            Adds a tex image that needs to be downlaoded into loading so that it can be processed later.
	///
	/// @param {Struct}			[_texImage] - Texture Image class
	/// @returns {undefined}			
	/// 
	static add_sprite_loading = function(_texImage) {
		array_push(loadingTexImages_, _texImage);
		update_img_load_progress();
	}
	
	/// 
	/// @function				update_img_load_progress()
	/// @description            Updates the currently loading progress
	///
	/// @returns {undefined}			
	/// 
	static update_img_load_progress = function()
	{
		// Calculate progress
		var _total = ds_priority_size(texImagePriorityList_);
		var _loaded = _total - array_length(loadingTexImages_);

		loadingProgress_ = _total > 0 ? _loaded / _total : 1;
		finished_ = _loaded == _total;
	}

	///
	/// @function				remove_tex_image(_texImage)
	/// @description            Removes a tex image from the stream. Eg. When an image failed to load
	///
	/// @param {Struct}			[_texImage] - Texture Image class
	/// @returns {undefined}
	///
	static remove_tex_image = function(_texImage) {
		ds_priority_delete_value(texImagePriorityList_, _texImage);
		update_img_load_progress();
	}

	///
	/// @function				check_timeout()
	/// @description            Gives up on images still downloading after the timeout. HTML5 never sends an
	///							Image Loaded event for a failed download (Eg. blocked by CORS) so without this the stream waits forever
	///
	/// @returns {undefined}
	///
	static check_timeout = function() {
		if(finished_ || timeout_ <= 0 || current_time - startTime_ < timeout_) return;

		for(var _i = array_length(loadingTexImages_) - 1; _i >= 0; _i--) {
			var _texImage = loadingTexImages_[_i];
			spritesheet_log(string("Texture Stream Timed Out: Gave up loading {0}", _texImage.fPath_));

			if(sprite_exists(_texImage.spriteAsset_)) sprite_delete(_texImage.spriteAsset_);
			ds_priority_delete_value(texImagePriorityList_, _texImage);
		}

		loadingTexImages_ = [];
		update_img_load_progress();
	}

	///
	/// @function				progress()
	/// @description            How much of the texture stream has finished loading
	///
	/// @returns {Real}			Returns a value from 0 to 1
	///
	static progress = function() {
		return loadingProgress_;
	}
	
	/// 
	/// @function				finished()
	/// @description            If the texture stream is finished loading
	///
	/// @returns {Bool}			Returns true if finished false if loading	
	/// 
	static finished = function() {
		return finished_;
	}
	
	/// 
	/// @function				destroy()
	/// @description            Frees any memory dependent variables in the texture stream. Call when done or risk a memory leak.
	///
	/// @returns {undefined}			
	/// 
	static destroy = function()
	{
		if(texImagePriorityList_ == -1) return;

		// Free any images that never made it onto a texture page
		while(ds_priority_size(texImagePriorityList_) > 0) {
			var _texImage = ds_priority_delete_max(texImagePriorityList_);
			if(sprite_exists(_texImage.spriteAsset_)) {
				sprite_delete(_texImage.spriteAsset_);
			}
		}

		ds_priority_destroy(texImagePriorityList_);
		texImagePriorityList_ = -1;
		loadingTexImages_ = [];
	}
}