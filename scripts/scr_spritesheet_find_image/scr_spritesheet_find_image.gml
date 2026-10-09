///
/// @function				spritesheet_find_image(_spriteSheetName, _imageName)
/// @description            Attempts to find a specific image from a sprite sheet
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @param {String}			[_imageName] - Unique indentifier for the image
/// @returns {Struct}		Returns a texture page image or -1 if it doesn't exists
///
function spritesheet_find_image(_spriteSheetName, _imageName)
{
	if(!spritesheet_exists(_spriteSheetName)) return -1;

	var _images = spritesheet_get_images(_spriteSheetName);
	return variable_struct_exists(_images, _imageName) ? variable_struct_get(_images, _imageName) : -1;
}
