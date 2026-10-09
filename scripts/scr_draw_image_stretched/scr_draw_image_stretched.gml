/// 
/// @function				draw_image_stretched(_image, _subImg, _x, _y, _width, _height)
/// @description            This function simply takes a sprite resource and stretches it over the
///							given width and height so that it occupies that area.
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @param {Real}			 [_width] - The width of the area the stretched sprite will occupy.
/// @param {Real}			 [_height] - The height of the area the stretched sprite will occupy.
/// @returns {undefined}
/// 
function draw_image_stretched(_image, _subImg, _x, _y, _width, _height) {
	gml_pragma("forceinline");
	
	draw_image_stretched_ext(_image, _subImg, _x, _y, _width, _height, c_white, 1);
}