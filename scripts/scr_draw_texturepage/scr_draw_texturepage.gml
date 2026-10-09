///
/// @function				draw_texturepage(_spriteSheetName, _texPageIndex, _x, _y)
/// @description            Draws the given spritesheet texturepage image and sub-image at a position
///							within the game room
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @param {Real}			[_texPageIndex] - The texture page index to draw
/// @param {Real}			[_x] - The x coordinate of where to draw the sprite.
/// @param {Real}			[_y] - The y coordinate of where to draw the sprite.
/// @returns {undefined}
///
function draw_texturepage(_spriteSheetName, _texPageIndex, _x, _y) {
	if(!spritesheet_exists(_spriteSheetName)) return;

	var _spriteSheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _texturePages = variable_struct_get(_spriteSheet, SPRITESHEET_TEXTUREPAGES_KEY);

	if(_texPageIndex >= array_length(_texturePages)) return;

	var _spr = _texturePages[_texPageIndex].spriteIndex_;
	draw_sprite(_spr, 0, _x, _y);
}
