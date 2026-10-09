/// 
/// @function				draw_image_pos_ext(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _colour, _alpha)
/// @description            With this function you can draw a sprite distorted over the area following 
///							the same rules as per draw_image_pos(), only now you can rot the part, 
///							blend a colour with it, or change its alpha when drawing it to the 
///							screen (the same as when drawing a sprite with draw_image_ext()).
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x1] - The first x coordinate.
/// @param {Real}			 [_y1] - The first y coordinate.
/// @param {Real}			 [_x2] - The second x coordinate.
/// @param {Real}			 [_y2] - The second y coordinate.
/// @param {Real}			 [_x3] - The third x coordinate.
/// @param {Real}			 [_y3] - The third y coordinate.
/// @param {Real}			 [_x4] - The fourth x coordinate.
/// @param {Real}			 [_y4] - The fourth y coordinate.
/// @param {Real}			 [_rot] - The rotation of the sprite. 0=right way up, 90=rotated 90 degrees counter-clockwise etc...
/// @param {Constant.Colour} [_colour] - The colour with which to blend the sprite. c_white is to display it normally.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_pos_ext(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _colour, _alpha) {
	gml_pragma("forceinline");
	
	draw_image_pos_general(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _colour, _colour, _colour, _colour, _alpha)
}