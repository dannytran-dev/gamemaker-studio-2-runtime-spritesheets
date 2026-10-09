/// @description Init
//-----------------------------------------------------------------------------
// Inheritable prefab that builds one runtime sprite sheet and waits for it to
// finish. Make a child object, call event_inherited() in its Create event, then
// override spritesheet_add() and spritesheet_finish().
//-----------------------------------------------------------------------------

spriteSheet_ = VAR_SPRITESHEET_NAME;
started_ = false;
ready_ = false;

#region OVERRIDABLE
///
/// @function				spritesheet_add(_spriteSheet)
/// @description            Called once the texture stream has started. Add images with texture_stream_add here
///
/// @param {String}			[_spriteSheet] - The sprite sheet name
/// @return {Undefined}
/// 
function spritesheet_add(_spriteSheet) {

}

///
/// @function				spritesheet_finish(_spriteSheet)
/// @description            Called once every image has been packed onto a texture page
///
/// @param {String}			[_spriteSheet] - The sprite sheet name
/// @return {Undefined}
/// 
function spritesheet_finish(_spriteSheet) {

}
#endregion

///
/// @function				start()
/// @description            Creates the sprite sheet and starts a texture stream. Runs on the first step so children can override first
///
/// @return {Undefined}
/// 
function start() {
	started_ = true;
	
	// Create a sprite sheet name
	if(spritesheet_create(spriteSheet_) == -1) {
		spritesheet_log(string("{0}: The spritesheet {1} already exists", object_get_name(object_index), spriteSheet_));
		spriteSheet_ = -1;
		return;
	}

	// Starts a texture steam to make textxure pages
	// Texture page must be in a power of Eg. 128, 256, 512, 1024, 2048
	texture_stream_start(spriteSheet_, VAR_SPRITESHEET_SIZE, VAR_SPRITESHEET_SIZE, VAR_SPRITESHEET_TEX_SEPERATION);

	// Add sprites to the texture steam like below
	spritesheet_add(spriteSheet_);
}

///
/// @function				is_ready()
/// @description            Checks if the sprite sheet has finished packing and images can be drawn
///
/// @return {Bool}			Returns true if ready, false if not
/// 
function is_ready() {
	return ready_;
}

function on_destroy() {
	if(is_string(spriteSheet_) && spritesheet_exists(spriteSheet_)) {
		spritesheet_destroy(spriteSheet_);
	}
	ready_ = false;
}
