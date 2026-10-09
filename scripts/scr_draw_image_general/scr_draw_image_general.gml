///
/// @function				draw_image_general(_image, _subImg, _x, _y, _image_xscale, _image_yscale, _rot, _c1, _c2, _c3, _c4, _alpha)
/// @description            This function combines the function draw_image_ext() with the function
///							draw_image_part(), adding in some additional blending options so that each
///							corner of the final sprite part can be blended with an individual colour.
///							Drawn as a textured quad since draw_sprite_general draws the whole texture page in HTML5.
///
/// @param {Asset.GMSprite}	 [_image] - The sprite struct associated to this texture page
/// @param {Real}			 [_subImg] - The subimg (frame) of the sprite to draw (image_index or -1 correlate to the current frame of animation in the object).
/// @param {Real}			 [_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			 [_y] - The y coordinate of where to draw the sprite.
/// @param {Real}			 [_image_xscale] - The horizontal scaling of the sprite, as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Real}			 [_image_yscale] - The vertical scaling of the sprite as a multiplier: 1 = normal scaling, 0.5 is half etc...
/// @param {Real}			 [_rot] - The rotation of the sprite. 0=right way up, 90=rotated 90 degrees counter-clockwise etc...
/// @param {Constant.Colour} [_c1] - The colour with which to blend the top left area of the sprite.
/// @param {Constant.Colour} [_c2] - The colour with which to blend the top right area of the sprite.
/// @param {Constant.Colour} [_c3] - The colour with which to blend the bottom right area of the sprite.
/// @param {Constant.Colour} [_c4] - The colour with which to blend the bottom left area of the sprite.
/// @param {Real}			 [_alpha] - The alpha of the sprite (from 0 to 1 where 0 is transparent and 1 opaque).
/// @returns {undefined}
///
function draw_image_general(_image, _subImg, _x, _y, _image_xscale, _image_yscale, _rot, _c1, _c2, _c3, _c4, _alpha) {
	gml_pragma("forceinline");

	if(!is_struct(_image)) return;

	var _subimg = (floor(_subImg) % _image.subImgs_);
	var _texturePage = _image.texturePages_[_subimg];
	var _sprite = _texturePage.spriteIndex_;

	if(!sprite_exists(_sprite)) return;

	// UVs of this frame's area on the texture page
	var _uvs = sprite_get_uvs(_sprite, 0);
	var _uScale = (_uvs[2] - _uvs[0]) / sprite_get_width(_sprite);
	var _vScale = (_uvs[3] - _uvs[1]) / sprite_get_height(_sprite);
	var _u1 = _uvs[0] + _image.subImgX_[_subimg] * _uScale;
	var _v1 = _uvs[1] + _image.subImgY_[_subimg] * _vScale;
	var _u2 = _u1 + _image.width_ * _uScale;
	var _v2 = _v1 + _image.height_ * _vScale;

	// Corners relative to the origin, scaled
	var _l = -_image.xOrig_ * _image_xscale;
	var _t = -_image.yOrig_ * _image_yscale;
	var _r = _l + _image.width_ * _image_xscale;
	var _b = _t + _image.height_ * _image_yscale;

	// Rotate counter-clockwise around the origin
	var _cos = dcos(_rot);
	var _sin = dsin(_rot);

	var _x1 = _x + _l * _cos + _t * _sin;	var _y1 = _y - _l * _sin + _t * _cos;
	var _x2 = _x + _r * _cos + _t * _sin;	var _y2 = _y - _r * _sin + _t * _cos;
	var _x3 = _x + _r * _cos + _b * _sin;	var _y3 = _y - _r * _sin + _b * _cos;
	var _x4 = _x + _l * _cos + _b * _sin;	var _y4 = _y - _l * _sin + _b * _cos;

	draw_primitive_begin_texture(pr_trianglelist, sprite_get_texture(_sprite, 0));
	    draw_vertex_texture_colour(_x1, _y1, _u1, _v1, _c1, _alpha);
	    draw_vertex_texture_colour(_x2, _y2, _u2, _v1, _c2, _alpha);
	    draw_vertex_texture_colour(_x3, _y3, _u2, _v2, _c3, _alpha);

	    draw_vertex_texture_colour(_x3, _y3, _u2, _v2, _c3, _alpha);
	    draw_vertex_texture_colour(_x4, _y4, _u1, _v2, _c4, _alpha);
	    draw_vertex_texture_colour(_x1, _y1, _u1, _v1, _c1, _alpha);
	draw_primitive_end();
}
