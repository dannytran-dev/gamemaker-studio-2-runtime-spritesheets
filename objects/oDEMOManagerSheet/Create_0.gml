/// @description Init
//-----------------------------------------------------------------------------
// Example child of oSpriteSheetsManager. Builds a second sprite sheet that
// oDEMOSpriteSheet draws from, showing multiple sheets living side by side.
//-----------------------------------------------------------------------------

// Inherit the parent event
event_inherited();

spriteSheet_ = "GemSheet";

#region OVERRIDE
function spritesheet_add(_spriteSheet) {
	texture_stream_add(_spriteSheet, "gem_red", "images/gem_red.png");
	texture_stream_add(_spriteSheet, "gem_green", "images/gem_green.png");
	texture_stream_add(_spriteSheet, "gem_blue", "images/gem_blue.png");
}

function spritesheet_finish(_spriteSheet) {
	spritesheet_log(string("{0} is ready with {1} texture page(s)", _spriteSheet, spritesheet_get_texturepage_count(_spriteSheet)));
}
#endregion
