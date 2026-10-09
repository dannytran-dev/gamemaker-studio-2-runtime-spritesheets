/// 
/// @function				draw_image(_image, _subImg, _x, _y)
/// @description            Draws the given spritesheet iamage and sub-image at a position within the game room
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @returns {undefined}
/// 
function draw_image(_image, _subImg, _x, _y) {
	gml_pragma("forceinline");
	
	if(!is_struct(_image)) return;
	
	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;
	
	if(!sprite_exists(_sprite)) return;
	
	var _left = _image.subImgX_[_subimg];
	var _top = _image.subImgY_[_subimg];
	var _width = _image.width_;
	var _height = _image.height_;
	var _sx = _x - _image.xOrig_;
	var _sy = _y - _image.yOrig_;
	
	draw_sprite_part(_sprite, 0, _left, _top, _width, _height, _sx, _sy);
}