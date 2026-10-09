/// 
/// @function				draw_image_part(_image, _subImg, _left, _top, _width, _height, _x, _y)
/// @description            With this function you can draw part of any sprite at a given position within the room
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_left] - The x position on the sprite of the top left corner of the area to draw.
/// @param {Real}			 [_top] - The y position on the sprite of the top left corner of the area to draw.
/// @param {Real}			 [_width] - The width of the area to draw.
/// @param {Real}			 [_height] - The height of the area to draw.
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @returns {undefined}
/// 
function draw_image_part(_image, _subImg, _left, _top, _width, _height, _x, _y) {
	gml_pragma("forceinline");
	
	if(!is_struct(_image)) return;
	
	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;
	
	if(!sprite_exists(_sprite)) return;
	
	var _sLeft = _image.subImgX_[_subimg] + _left;
	var _sTop = _image.subImgY_[_subimg] + _top;
	
	var _sWidth = clamp(_width - _left, 0, _image.width_ - _left);
	var _sHeight = clamp(_height - _top, 0, _image.height_ - _top);
	
	draw_sprite_part(_sprite, 0, _sLeft, _sTop, _sWidth, _sHeight, _x, _y);
}