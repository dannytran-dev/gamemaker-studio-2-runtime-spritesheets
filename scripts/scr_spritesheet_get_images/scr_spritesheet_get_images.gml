/// 
/// @function				spritesheet_get_images(_spriteSheetName)
/// @description            Gets all the images currently in spritesheet
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Array}		Returns all the images or an empty array
/// 
function spritesheet_get_images(_spriteSheetName)
{
	if(spritesheet_exists(_spriteSheetName)) {
		var _spriteSheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
		var _images = variable_struct_get(_spriteSheet, SPRITESHEET_IMAGES_KEY);		
		
		return _images;
	}
	else {
		spritesheet_log(string("The spritesheet {0} you are trying to get images does not exist", _spriteSheetName));
		return [];
	}
}