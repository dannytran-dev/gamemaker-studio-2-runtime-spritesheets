/// 
/// @function				draw_image_pos_general(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _c1, _c2, _c3, _c4, _alpha)
/// @description            This function combines the function draw_image_pos() with the function 
///							draw_image_pos_ext(), adding in some additional blending options so that each 
///							corner of the final sprite part can be blended with an individual colour.
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
/// @param {Constant.Colour} [_c1] - The colour with which to blend the top left area of the sprite.
/// @param {Constant.Colour} [_c2] - The colour with which to blend the top right area of the sprite.
/// @param {Constant.Colour} [_c3] - The colour with which to blend the bottom right area of the sprite.
/// @param {Constant.Colour} [_c4] - The colour with which to blend the bottom left area of the sprite.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_pos_general(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _rot, _c1, _c2, _c3, _c4, _alpha) {
	gml_pragma("forceinline");
	
	if (!is_struct(_image)) return;

	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;
	
	if(!sprite_exists(_sprite)) return;

	var _uvX = _image.subImgX_[_subimg] / sprite_get_width(_sprite);
	var _uvY = _image.subImgY_[_subimg] / sprite_get_height(_sprite);
	var _uvWidth = _image.width_ / sprite_get_width(_sprite);
	var _uvHeight = _image.height_ / sprite_get_height(_sprite);

	var _dist1 = point_distance(_x1, _y1, _x2, _y2);
	var _dir1 = point_direction(_x1, _y1, _x2, _y2) + _rot;
	var _dist2 = point_distance(_x1, _y1, _x3, _y3);
	var _dir2 = point_direction(_x1, _y1, _x3, _y3) + _rot;
	var _dist3 = point_distance(_x1, _y1, _x4, _y4);
	var _dir3 = point_direction(_x1, _y1, _x4, _y4) + _rot;

	var _pivotX = _image.xPivot_;
	var _pivotY = _image.yPivot_;

	// Calculate the center of the primitive
	var _centerX = _x1 + (_dist2 * _pivotX) * lengthdir_x(1, _dir2);
	var _centerY = _y1 + (_dist2 * _pivotY) * lengthdir_y(1, _dir2);

	draw_primitive_begin_texture(pr_trianglelist, sprite_get_texture(_sprite, 0));
	    draw_vertex_texture_colour(_x1 - (_centerX - _x1), _y1 - (_centerY - _y1), _uvX, _uvY, _c1, _alpha);
	    draw_vertex_texture_colour(_x1 + lengthdir_x(_dist1, _dir1) - (_centerX - _x1), _y1 + lengthdir_y(_dist1, _dir1) - (_centerY - _y1), _uvX + _uvWidth, _uvY, _c2, _alpha);
	    draw_vertex_texture_colour(_x1 + lengthdir_x(_dist2, _dir2) - (_centerX - _x1), _y1 + lengthdir_y(_dist2, _dir2) - (_centerY - _y1), _uvX + _uvWidth, _uvY + _uvHeight, _c3, _alpha);
    
	    draw_vertex_texture_colour(_x1 + lengthdir_x(_dist3, _dir3) - (_centerX - _x1), _y1 + lengthdir_y(_dist3, _dir3) - (_centerY - _y1), _uvX, _uvY + _uvHeight, _c4, _alpha);
	    draw_vertex_texture_colour(_x1 - (_centerX - _x1), _y1 - (_centerY - _y1), _uvX, _uvY, _c1, _alpha);
	    draw_vertex_texture_colour(_x1 + lengthdir_x(_dist2, _dir2) - (_centerX - _x1), _y1 + lengthdir_y(_dist2, _dir2) - (_centerY - _y1), _uvX + _uvWidth, _uvY + _uvHeight, _c3, _alpha);
	draw_primitive_end();
}