/// 
/// @function				draw_image_part_ext(_image, _subImg, _left, _top, _width, _height, _x, _y, _image_xscale, _image_yscale, _colour, _alpha)
/// @description            This function will draw a part of the chosen sprite at the given position 
///							following the same rules as per draw_image_part(), only now you can scale 
///							the part, blend a colour with it, or change its alpha when drawing it to the 
///							screen (the same as when drawing a sprite with draw_image_ext()).
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_left] - The x position on the sprite of the top left corner of the area to draw.
/// @param {Real}			 [_top] - The y position on the sprite of the top left corner of the area to draw.
/// @param {Real}			 [_width] - The width of the area to draw.
/// @param {Real}			 [_height] - The height of the area to draw.
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @param {Real}			 [_image_xscale] - The horizontal scaling of the sprite, as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Real}			 [_image_yscale] - The vertical scaling of the sprite as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Constant.Colour} [_colour] - The colour with which to blend the sprite. c_white is to display it normally.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_part_ext(_image, _subImg, _left, _top, _width, _height, _x, _y, _image_xscale, _image_yscale, _colour, _alpha) {
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
	
	draw_sprite_part_ext(_sprite, 0, _sLeft, _sTop, _sWidth, _sHeight, _x, _y, _image_xscale, _image_yscale, _colour, _alpha);
}