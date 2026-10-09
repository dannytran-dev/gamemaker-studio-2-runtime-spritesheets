/// 
/// @function				draw_image_ext(_image, _subImg, _x, _y, _image_xscale, _image_yscale, _rot, _colour, _alpha)
/// @description            This function will draw the given sprite as draw_image but with additional options to change the scale, blending, rotation, alpha
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @param {Real}			 [_image_xscale] - The horizontal scaling of the sprite, as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Real}			 [_image_yscale] - The vertical scaling of the sprite as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Real}			 [_rot] - The rotation of the sprite. 0=right way up, 90=rotated 90 degrees counter-clockwise etc...
/// @param {Constant.Colour} [_colour] - The colour with which to blend the sprite. c_white is to display it normally.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_ext(_image, _subImg, _x, _y, _image_xscale, _image_yscale, _rot, _colour, _alpha) {
	gml_pragma("forceinline");
	
	if (!is_struct(_image)) return;
	
	var _x1 = _x;
	var _y1 = _y;
	var _x2 = _x + (_image.width_ * _image_xscale);
	var _y2 = _y;
	var _x3 = _x + (_image.width_ * _image_xscale);
	var _y3 = _y + (_image.height_ * _image_yscale);
	var _x4 = _x;
	var _y4 = _y + (_image.height_ * _image_yscale);

	draw_image_pos_ext(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _colour, _alpha);
	
	// This doesn't work in HTML5 for animated sprites
	// The above is a work around but not as efficient
	//draw_image_general(_image, _subImg, _x, _y, _image_xscale, _image_yscale, _rot, _colour, _colour, _colour,_colour, _alpha);
}