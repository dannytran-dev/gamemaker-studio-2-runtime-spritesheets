/// 
/// @function				TextureStreamImage(_id, _fPath, _subImg, _xOrig, _yOrig, _clamp, _removeBack)
/// @description            Class for texture stream images. Contains data relevant for conversion onto a sprite sheet
///
/// @param {String}			[_id] - Unique identifier for this texture stream image
/// @param {String}			[_fPath] - File path of file location
/// @param {String}			[_subImg] - Total sub-images of the image
/// @param {String}			[_xOrig] - The x position of the origin
/// @param {String}			[_yOrig] - The y position of the origin
/// @param {String}			[_clamp] - Indicates whether to crop image automatically
/// @param {String}			[_removeBack] - Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent. Doesn't work in HTML5
/// @returns {Struct}		Returns a struct of type TextureStreamImage
/// 
function TextureStreamImage(_id, _fPath, _subImg, _xOrig, _yOrig, _clamp, _removeBack) constructor {
	
	id_ = _id;
	fPath_ = _fPath;
	spriteAsset_ = sprite_add(_fPath, _subImg, _removeBack, false, 0, 0);
	subImgCount_ = _subImg;
	subImgRows_ = -1;
	width_ = sprite_get_width(spriteAsset_);
	height_ = sprite_get_height(spriteAsset_);
	xOrig_ = _xOrig;
	yOrig_ = _yOrig;
	clampLeft_ = -1;
	clampTop_ = -1;
	clamp_ = _clamp;
	removeBack_ = _removeBack;
	
	/// 
	/// @function				setup_image(_texStream)
	/// @description            This function sets up data such as width, height, clamps, origin, etc
	///
	/// @param {Struct}			[_texStream] - the current texture stream
	/// @returns {Bool}			Returns true if success and false if failed
	/// 
	static setup_image = function(_texStream)
	{
		width_ = sprite_get_width(spriteAsset_);
		height_ = sprite_get_height(spriteAsset_);

		// If clamp calculate the new width and height based on bbox collision size
		if(clamp_) {
			sprite_collision_mask(spriteAsset_, false, 0, 0, 0, 0, 0, 0, 0);
			clampLeft_ = sprite_get_bbox_left(spriteAsset_);
			clampTop_ = sprite_get_bbox_top(spriteAsset_);
			width_ = sprite_get_bbox_right(spriteAsset_) - sprite_get_bbox_left(spriteAsset_) + 1;
			height_ = sprite_get_bbox_bottom(spriteAsset_) - sprite_get_bbox_top(spriteAsset_) + 1;
		}
		else {
			clampLeft_ = 0;
			clampTop_ = 0;
		}

		// A texture page starts with one free area inset by the seperation
		var _widthSmaller = width_ <= _texStream.width_ - _texStream.sep_;
		var _heightSmaller = height_ <= _texStream.height_ - _texStream.sep_;
		if(_widthSmaller && _heightSmaller) {
			// Based on the original width and height
			xOrig_ *= sprite_get_width(spriteAsset_);
			yOrig_ *= sprite_get_height(spriteAsset_);

			return true;
		}
		else {
			sprite_delete(spriteAsset_);
			spriteAsset_ = -1;
			spritesheet_log(string("Texture Stream Image Failed: The image {0} is larger then the sprite sheet!", id_));
			return false;
		}
	}
	
	/// 
	/// @function				get_priority()
	/// @description            Priority is calculated based on image size. (Width + Height) * 0.5
	///
	/// @returns {Real}			Returns a priority number 
	/// 
	static get_priority = function()
	{
		return floor((width_ + height_) * 0.5);
	}
}