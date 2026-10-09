/// 
/// @function				draw_image_pos(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _alpha)
/// @description            With this function you can draw a sprite distorted over the area defined 
///							by the four corner coordinates. The first two arguments are the sprite to 
///							draw and the sub-image of the sprite (the same as in the function 
///							draw_image()) but the next ones are those that define the position of 
///							each of the four corners of the bounding box of the given sprite.
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
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
/// 
function draw_image_pos(_image, _subImg, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, _alpha) {
	gml_pragma("forceinline");
	
	if(!is_struct(_image)) return;
	
	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;
	
	if(!sprite_exists(_sprite)) return;
	
	var _uvX = _image.subImgX_[_subimg] / sprite_get_width(_sprite);
	var _uvY =  _image.subImgY_[_subimg] / sprite_get_height(_sprite);
	var _uvWidth = _image.width_ / sprite_get_width(_sprite);
	var _uvHeight = _image.height_ / sprite_get_height(_sprite);

	draw_set_alpha(_alpha);
	draw_set_color(c_white);
	draw_primitive_begin_texture(pr_trianglelist, sprite_get_texture(_sprite, 0));
	    draw_vertex_texture(_x1, _y1, _uvX, _uvY);
	    draw_vertex_texture(_x2, _y2, _uvX + _uvWidth, _uvY);
	    draw_vertex_texture(_x3, _y3, _uvX + _uvWidth, _uvY + _uvHeight);
    
	    draw_vertex_texture(_x4, _y4, _uvX, _uvY + _uvHeight);
	    draw_vertex_texture(_x1, _y1, _uvX, _uvY);
	    draw_vertex_texture(_x3, _y3, _uvX + _uvWidth, _uvY + _uvHeight);
	draw_primitive_end();
}