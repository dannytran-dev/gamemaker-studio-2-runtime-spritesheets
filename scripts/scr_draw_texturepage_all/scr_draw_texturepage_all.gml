///
/// @function				draw_texturepage_all(_spriteSheetName, _startingIndex = 0, _x = x, _y = y, _sep = 0)
/// @description            Draws all spritesheet texturepage image based on starting index, side by side
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @param {Real}			[_startingIndex] - The starting index to draw from. Eg. 0 will draw from start to end & 1 will draw the second to end
/// @param {Real}			[_x] - The x coordinate of where to draw the first page. Defaults to the calling instance x
/// @param {Real}			[_y] - The y coordinate of where to draw the first page. Defaults to the calling instance y
/// @param {Real}			[_sep] - Horizontal gap between each page
/// @returns {undefined}
///
function draw_texturepage_all(_spriteSheetName, _startingIndex = 0, _x = x, _y = y, _sep = 0) {
	if(!spritesheet_exists(_spriteSheetName)) return;

	var _spriteSheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	var _texturePages = variable_struct_get(_spriteSheet, SPRITESHEET_TEXTUREPAGES_KEY);

	var _texPagesTotal = array_length(_texturePages);

	for(var _texIndex = _startingIndex; _texIndex < _texPagesTotal; _texIndex++) {
		var _texPageSprite = _texturePages[_texIndex].spriteIndex_;
		var _texPageWidth = sprite_get_width(_texPageSprite);
		draw_sprite(_texPageSprite, 0, _x + ((_texIndex - _startingIndex) * (_texPageWidth + _sep)), _y);
	}
}
