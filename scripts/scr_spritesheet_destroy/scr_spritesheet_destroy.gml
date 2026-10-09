/// 
/// @function				spritesheet_destroy(_spriteSheetName)
/// @description            Destroys a spritesheet and texture pages to avoid memory leaks
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if success false if not
/// 
function spritesheet_destroy(_spriteSheetName)
{
	if(spritesheet_exists(_spriteSheetName)) {
		// Clears all spritesheet from memory
		spritesheet_clear(_spriteSheetName);
		
		variable_struct_remove(global.SPRITESHEET_SYSTEM, _spriteSheetName);	
		return true;
	}
	else {
		spritesheet_log(string("The spritesheet {0} you are trying to destroy does not exist", _spriteSheetName));
		return false;
	}
}