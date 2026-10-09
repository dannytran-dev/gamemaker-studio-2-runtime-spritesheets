/// 
/// @function				spritesheet_get_texturepage_count(_spriteSheetName)
/// @description            Gets how many texture pages a sprite sheet was packed into
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Real}			Returns the texture page count or 0 if the sprite sheet doesn't exist
/// 
function spritesheet_get_texturepage_count(_spriteSheetName)
{
	if(!spritesheet_exists(_spriteSheetName)) return 0;
	
	var _spriteSheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
	return array_length(variable_struct_get(_spriteSheet, SPRITESHEET_TEXTUREPAGES_KEY));
}
