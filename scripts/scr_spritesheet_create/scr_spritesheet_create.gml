/// 
/// @function				spritesheet_create(_spriteSheetName)
/// @description            Creates a sprite sheet
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {String}		Returns sprite sheet name or -1 if failed
/// 
function spritesheet_create(_spriteSheetName)
{
	// Makes sure the system is ready, so it never has to be called manually
	spritesheet_system_init();
	
	if(!spritesheet_exists(_spriteSheetName)) {
		var _spriteSheet = { };
		variable_struct_set(_spriteSheet, SPRITESHEET_IMAGES_KEY, { });
		variable_struct_set(_spriteSheet, SPRITESHEET_TEXTUREPAGES_KEY, []);
		
		variable_struct_set(global.SPRITESHEET_SYSTEM, _spriteSheetName, _spriteSheet);
				
		return _spriteSheetName;
	}
	else {
		return -1;
	}
}