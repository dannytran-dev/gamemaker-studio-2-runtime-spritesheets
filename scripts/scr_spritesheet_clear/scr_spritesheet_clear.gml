///
/// @function				spritesheet_clear(_spriteSheetName)
/// @description            Clears/Deletes all sprite sheet texture pages sprites
///
/// @param {String}			[_spriteSheetName] - The sprite sheet name
/// @returns {Bool}			Returns true if clear is successful or false if not
///
function spritesheet_clear(_spriteSheetName)
{
	if(spritesheet_exists(_spriteSheetName)) {
		var _spritesheet = variable_struct_get(global.SPRITESHEET_SYSTEM, _spriteSheetName);
		var _texPages = variable_struct_get(_spritesheet, SPRITESHEET_TEXTUREPAGES_KEY);

		texture_stream_stop(_spriteSheetName);

		// Delete all texture pages
		for(var _i = 0; _i < array_length(_texPages); _i++) {
			var _texPageSpr = _texPages[_i].spriteIndex_;
			if(sprite_exists(_texPageSpr)) sprite_delete(_texPageSpr);
		}

		// Drop references so nothing draws from a recycled sprite index
		variable_struct_set(_spritesheet, SPRITESHEET_IMAGES_KEY, { });
		variable_struct_set(_spritesheet, SPRITESHEET_TEXTUREPAGES_KEY, []);

		return true;
	}
	else {
		spritesheet_log(string("The spritesheet {0} you are trying to clear does not exist", _spriteSheetName));
		return false;
	}
}
