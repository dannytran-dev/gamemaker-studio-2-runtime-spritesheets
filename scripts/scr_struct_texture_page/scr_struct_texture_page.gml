/// 
/// @function				struct_texture_page(_texPageNum, _spriteIndex)
/// @description            Creates an empty texture page struct. Wrapper function to template structs
///
/// @param {Real}			[_surfaceIndex] - The surface index. This will be deleted later
/// @param {Real}			[_spriteIndex] - The sprite index associated to this texture page
/// @returns {Struct}		Returns a struct of type texture page
/// 
function struct_texture_page(_surfaceIndex, _spriteIndex = -1) {
	var _struct = { };
	
	var _texPageName = string("TexturePage{0}", _surfaceIndex);
	variable_struct_set(_struct, "texPageName_", _texPageName);
	variable_struct_set(_struct, "surfaceIndex_", _surfaceIndex);
	variable_struct_set(_struct, "spriteIndex_", _spriteIndex);
	
	return _struct;
}