/// 
/// @function				TexturePageSession(_texStream)
/// @description            Class for texture page session. This is the final step for generating texture pages, and in this step we will take in all the inforamtion, process, then draw them ontop a texture page using surfaces.
///
/// @param {Struct}			[_texStream] - Texture stream class - Texture page state 
/// @returns {Struct}		Returns a struct of type TexturePageSession
/// 
function TexturePageSession(_texStream) constructor {

	areas_ = [];
	texPage_ = [];
	texStream_ = _texStream;
	
	texPageImage_ = -1;
	texImage_ = -1;
	imgWidth_ = -1;
	imgHeight_ = -1;
	
	trashQueue_ = ds_queue_create();
	
	debugSpriteSheetColor_ = c_fuchsia;
	
	/// 
	/// @function				new_texture_page()
	/// @description			Creates a new texture page based on texture stream settings
	///
	/// @returns {undefined}			
	/// 
	static new_texture_page = function() {
		var _areas = areas_;
		var _texPage = texPage_;
	
		var _width = texStream_.width_;
		var _height = texStream_.height_;
		var _sep = texStream_.sep_;
	
		var _subArea = [_sep, _sep, _width - _sep, _height - _sep];
		array_push(_areas, _subArea);
	
		// Texture Page Surface
		var _texPageSurface = surface_create(_width, _height);
		array_push(_texPage, _texPageSurface);
	
		surface_set_target(_texPage[array_length(_texPage) - 1]);
	
		// In debug give the sprite sheet a white bg color to visualize
		if(SPRITESHEET_DEBUG) {
			draw_clear_alpha(debugSpriteSheetColor_, 1);
		}
		else {
			draw_clear_alpha(0, 0);
		}
	}
	
	/// 
	/// @function				setup_areas(_images)
	/// @description            Calculates the areas for all texture images in _images
	///
	/// @param {Id.DsPriority}	[_images] - Prioritity queue of all texture images
	/// @returns {undefined}			
	/// 
	static setup_areas = function(_images) {
		var _texImagePriorityList = texStream_.texImagePriorityList_;
		
		// Loop through all sprites and add them to the texture page
		// Will exit while loop since the list becomes 0 which is false
		while(ds_priority_size(_texImagePriorityList)) {
			texImage_ = ds_priority_delete_max(_texImagePriorityList);
			texPageImage_ = new TexturePageImage();
			variable_struct_set(_images, texImage_.id_, texPageImage_);
		
			var _texImageSprites = texImage_.spriteAsset_;

			for( var _i = 0; _i < sprite_get_number(_texImageSprites); _i++ ) {
				var _info = find_area(texImage_);
					
				// Couldn't find an area for the subimage
		        if(_info.minAreaID_ == -1) { 
		            new_texture_page();
					_info = find_area(texImage_);
		        }
                
		        subimg_to_area(_texImageSprites, _i, _info.minAreaID_, _info.surfaceID_);
		    }
		
			delete_sprite(_texImageSprites);
		}
		// Need to reset all surfaces before we can convert the surfaces to sprites
		// This must happen first before we make our texture pages since we are still drawing to certain surfaces
		for(var _resetSurf = 0; _resetSurf < array_length(texPage_); _resetSurf++)
		{
			surface_reset_target();
		}
	}
	
	/// 
	/// @function				create_texture_page_sprite(_texturePages, _images)
	/// @description            Converts texture pages into sprite sheets to be used later
	///
	/// @param {Array}			[_texturePages] - Array of all texture pages stored in a global struct
	/// @param {Array}			[_images] - Array of all images stored in a global struct
	/// @returns {undefined}			
	/// 
	static create_texture_page_sprite = function(_texturePages, _images) {
		// Create texture page
		for(var _n = 0; _n < array_length(texPage_); _n++) {	
			// Create texture page sprite from surfrace
			var _texPageSurface = texPage_[_n];
			var _texPageSurfaceWidth = surface_get_width(_texPageSurface);
			var _texPageSurfaceHeight = surface_get_height(_texPageSurface);
		
			var texPageSpriteTemp_ = sprite_create_from_surface(_texPageSurface, 0, 0, _texPageSurfaceWidth, _texPageSurfaceHeight, false, false, 0, 0);
			texPage_[_n] = texPageSpriteTemp_;
		
			// Save it to the texture pages map
			array_push(_texturePages, struct_texture_page(_texPageSurface, texPageSpriteTemp_));
		
			// Loop through all the images and give them reference to this texture page sprite asset
			var _allImages = variable_struct_get_names(_images);
			for(var _imageIndex = 0; _imageIndex < array_length(_allImages); _imageIndex++) {
				var _imageName = _allImages[_imageIndex];
				var _imageTexSubImgs = variable_struct_get(_images, _imageName).texturePages_;
			
				for(var _subImageIndex = 0; _subImageIndex < array_length(_imageTexSubImgs); _subImageIndex++) {
					// If the surface index are the same set the new sprite sheet index
					if(_texPageSurface == _imageTexSubImgs[_subImageIndex].surfaceIndex_) {
						_imageTexSubImgs[_subImageIndex].spriteIndex_ = texPageSpriteTemp_;
					}
				}
			}
		
			// Cleanup memory
			surface_free(_texPageSurface);
		}
	}
	
	/// 
	/// @function				find_area(_texImage)
	/// @description            Finds and area on the texture page and returns that area ID for future reference
	///
	/// @param {Struct}			[_texImage] - Texture Image
	/// @returns {Real}			Returns the area ID which is the index in the array 		
	/// 
	static find_area = function(_texImage) {
		var _areas = areas_;
		var _subAreas = areas_[0];
		var _minAreaSize = 10000000000000;
		var _width = _texImage.width_;
		var _height = _texImage.height_;
		
		var _surfaceInfo = {
			minAreaID_: -1,
			surfaceID_: -1
		};
	
		// _subAreas is 4 values. x cord, y cord, width, height
		// Eg. Current width = _subAreas[_n + 2] & current height = _subAreas[_n + 3]
		for(var _i = 0; _i < array_length(_areas); _i++) {
			// Early escape if we already found something on the current texture page
			if(_surfaceInfo.surfaceID_ != _i && _surfaceInfo.minAreaID_ > -1 && _surfaceInfo.surfaceID_ > -1) return _surfaceInfo;
			
			// Reset values
			_minAreaSize = 10000000000000;
			_subAreas = _areas[_i];
			
			for(var _n = 0; _n < array_length(_subAreas); _n += 4) {			
			    if(_width <= _subAreas[_n + 2] && _height <= _subAreas[_n + 3]) {
			        if(((_subAreas[_n + 2] + _subAreas[_n + 3]) / 2) < _minAreaSize) {
			            _minAreaSize = (_subAreas[_n + 2] + _subAreas[_n + 3]) / 2;
			            _surfaceInfo.minAreaID_ = _n;
						_surfaceInfo.surfaceID_ = _i;
			        }
			    }
			}
		}

		return _surfaceInfo;
	}
	
	/// 
	/// @function				subimg_to_area(_sprite, _subimg, _areaID)
	/// @description            Will convert each image into subimages and draw them. Should be called after setting target to surface
	///
	/// @param {Asset.GMSprite}	[_sprite] - Unique sprite asset index
	/// @param {Real}			[_subimg] - Sub image count
	/// @param {Real}			[_areaID] - Araa ID to reference array index
	/// @returns {undefined}	
	/// 
	static subimg_to_area = function(_sprite, _subimg, _areaID, _surfaceID) {
		var _areas			= areas_;
		var _subAreas		= _areas[_surfaceID];
		var _texPage		= texPage_;
		var _texStream		= texStream_;
		var _texPageImage	= texPageImage_;
		var _texStreamImage = texImage_;
	
		var _subImgsCount	= _texStreamImage.subImgCount_;
		var _subImgWidth	= _texStreamImage.width_;
		var _subImgHeight	= _texStreamImage.height_;
	
		var _sep = _texStream.sep_;
		
		surface_reset_target();
		surface_set_target(_texPage[_surfaceID]);
	
		draw_sprite_part( 
		    _sprite, _subimg, 
		    _texStreamImage.clampLeft_, _texStreamImage.clampTop_, 
		    _subImgWidth, _subImgHeight, 
		    _subAreas[_areaID], _subAreas[_areaID + 1] 
		);

		if(_subimg == 0)
		{
			_texPageImage.id_			= _texStreamImage.id_;
			_texPageImage.subImgs_		= _subImgsCount;
			_texPageImage.width_		= _subImgWidth;
			_texPageImage.height_		= _subImgHeight;
			_texPageImage.xOrig_		= _texStreamImage.xOrig_ - _texStreamImage.clampLeft_;
			_texPageImage.yOrig_		= _texStreamImage.yOrig_ - _texStreamImage.clampTop_;
			_texPageImage.xPivot_		= _texPageImage.xOrig_ / _subImgWidth;
			_texPageImage.yPivot_		= _texPageImage.yOrig_ / _subImgHeight;
			_texPageImage.bboxLeft_		= sprite_get_bbox_left(_sprite) - _texStreamImage.clampLeft_;
			_texPageImage.bboxTop_		= sprite_get_bbox_top(_sprite) - _texStreamImage.clampTop_;
			_texPageImage.bboxRight_	= sprite_get_bbox_right(_sprite) - _texStreamImage.clampLeft_;
			_texPageImage.bboxBot_		= sprite_get_bbox_bottom(_sprite) - _texStreamImage.clampTop_;
			_texPageImage.fPath_		= _texStreamImage.fPath_;
		}
	
		// Add sub image of the sprite to an array
		var _texPageNum = _texPage[_surfaceID];
		_texPageImage.texturePages_[_subimg] = struct_texture_page(_texPageNum);
		_texPageImage.subImgX_[_subimg] = _subAreas[_areaID];
		_texPageImage.subImgY_[_subimg] = _subAreas[_areaID + 1];
	
		// Add new empty ares to area array
		if(_subImgHeight < _subAreas[_areaID + 3]) {
			array_push(_subAreas, 
				_subAreas[_areaID],
				_subAreas[_areaID + 1] + _subImgHeight + _sep,
				_subAreas[_areaID + 2],
				_subAreas[_areaID + 3] - _subImgHeight - _sep
			);
		}
	
		if(_subImgWidth < _subAreas[_areaID + 2]) {
			array_push(_subAreas, 
				_subAreas[_areaID] + _subImgWidth + _sep,
				_subAreas[_areaID + 1],
				_subAreas[_areaID + 2] - _subImgWidth - _sep,
				_subImgHeight
			);
		}
	
		// Remove the current area
		repeat(4)
			array_delete(_subAreas, _areaID, 1);
	}
	
	/// 
	/// @function				delete_sprite(_sprite)
	/// @description            Delete's a sprite asset index
	///
	/// @param {Asset.GMSprite}	[_sprite] - Unique sprite asset index
	/// @returns {undefined}	
	/// 
	static delete_sprite = function(_sprite) {
		ds_queue_enqueue(trashQueue_, _sprite);
	}
	
	/// 
	/// @function				delete_sprite(_sprite)
	/// @description            Frees up any variable memory. If destroy isn't called will cause a memory leak
	///
	/// @returns {undefined}	
	/// 
	static destroy = function() {
		// Clear memory
		while(ds_queue_size(trashQueue_) > 0) {
			var _trashSprite = ds_queue_dequeue(trashQueue_);
			sprite_delete(_trashSprite);
		}
		ds_queue_destroy(trashQueue_);
	}
}