/// 
/// @function				draw_image_stretched_ext(_image, _subImg, _x, _y, _width, _height)
/// @description            This function simply takes a sprite resource and stretches it over the
///							given width and height so that it occupies that area.
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @param {Real}			 [_width] - The width of the area the stretched sprite will occupy.
/// @param {Real}			 [_height] - The height of the area the stretched sprite will occupy.
/// @param {Constant.Colour} [_colour] - The colour with which to blend the sprite. c_white is to display it normally.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_stretched_ext(_image, _subImg, _x, _y, _width, _height, _colour, _alpha) {
	gml_pragma("forceinline");
	
	if(!is_struct(_image)) return;
	
	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;
	
	if(!sprite_exists(_sprite)) return;
	
	var _left = _image.subImgX_[_subimg];
	var _top = _image.subImgY_[_subimg];
	
	var _image_xscale = _width / _image.width_;
	var _image_yscale = _height / _image.height_;
	
	draw_sprite_part_ext(_sprite, 0, _left, _top, _image.width_, _image.height_, _x, _y, _image_xscale, _image_yscale, _colour, _alpha);
}