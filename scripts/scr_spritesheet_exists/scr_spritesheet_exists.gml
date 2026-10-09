/// 
/// @function				spritesheet_exists(_spriteSheetName)
/// @description            Checks if a spritesheet exists
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}		Returns true if exists false if not
/// 
function spritesheet_exists(_spriteSheetName)
{
	if(!variable_global_exists("SPRITESHEET_SYSTEM")) return false;
	
	return variable_struct_exists(global.SPRITESHEET_SYSTEM, _spriteSheetName);
}