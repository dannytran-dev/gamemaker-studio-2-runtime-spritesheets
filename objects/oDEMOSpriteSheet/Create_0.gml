/// @description Init
//-----------------------------------------------------------------------------
// Demo: loads PNGs from Included Files at runtime and packs them into texture
// pages, then draws them with every draw_image_* function.
//
// SPACE - Toggle between draw functions and texture page view
// 1     - Destroy the sprite sheet (frees all texture pages)
// 2     - Rebuild the sprite sheet
//
// The same three actions are on-screen buttons so mouse and touch users
// (the HTML5 build on phones) can use the demo too.
//-----------------------------------------------------------------------------

spriteSheetName_ = "DemoSheet";
pageSize_ = 512;
pageSep_ = 2;

showPages_ = false;
time_ = 0;

ready_ = false;
imageCount_ = 0;
packTime_ = 0;

// Images looked up once the sprite sheet is packed
ship_ = -1;
coin_ = -1;
explosion_ = -1;
panel_ = -1;
orb_ = -1;
blocks_ = [];

// On-screen buttons in the top right, in the same order as press_button()
buttonLabels_ = ["Toggle view", "Destroy", "Rebuild"];
buttonW_ = 150;
buttonH_ = 40;
buttonGap_ = 10;
buttonY_ = 16;

///
/// @function				button_x(_index)
/// @description            Gets the left edge of an on-screen button
///
/// @param {Real}			_index - Button index
/// @return {Real}
///
function button_x(_index) {
	var _count = array_length(buttonLabels_);
	var _totalW = _count * buttonW_ + (_count - 1) * buttonGap_;
	return room_width - 24 - _totalW + _index * (buttonW_ + buttonGap_);
}

///
/// @function				button_hover(_index)
/// @description            Checks if the mouse (or touch) is over an on-screen button
///
/// @param {Real}			_index - Button index
/// @return {Bool}
///
function button_hover(_index) {
	var _bx = button_x(_index);
	return point_in_rectangle(mouse_x, mouse_y, _bx, buttonY_, _bx + buttonW_, buttonY_ + buttonH_);
}

///
/// @function				press_button(_index)
/// @description            Runs the action for a button or its matching key
///
/// @param {Real}			_index - 0 toggle view, 1 destroy, 2 rebuild
/// @return {Undefined}
///
function press_button(_index) {
	switch(_index) {
		case 0:
			showPages_ = !showPages_;
			break;
		case 1:
			// Removes sprite sheet and sprites from memory
			if(spritesheet_exists(spriteSheetName_)) {
				spritesheet_destroy(spriteSheetName_);
				ready_ = false;
			}
			break;
		case 2:
			if(!spritesheet_exists(spriteSheetName_)) build_spritesheet();
			break;
	}
}

///
/// @function				build_spritesheet()
/// @description            Creates the sprite sheet and queues every demo image into its texture stream
///
/// @return {Undefined}
/// 
function build_spritesheet() {
	ready_ = false;
	
	// Create a sprite sheet name
	spritesheet_create(spriteSheetName_);

	// Starts a texture steam to make textxure pages
	// Texture page must be in a power of Eg. 128, 256, 512, 1024, 2048
	texture_stream_start(spriteSheetName_, pageSize_, pageSize_, pageSep_);

	// Blocks of many sizes to show off the packer
	imageCount_ = 0;
	for(var _i = 1; _i <= 20; _i++) {
		var _name = string("block_{0}", string_replace(string_format(_i, 2, 0), " ", "0"));
		if(texture_stream_add(spriteSheetName_, _name, string("images/{0}.png", _name))) imageCount_++;
	}
	
	// Origin is a 0-1 pivot, 0.5 is the center
	if(texture_stream_add(spriteSheetName_, "ship", "images/ship.png", 1, 0.5, 0.5)) imageCount_++;
	if(texture_stream_add(spriteSheetName_, "panel", "images/panel.png", 1, 0, 0)) imageCount_++;
	
	// -1 sub images reads the frame count from the _strip# in the file name
	if(texture_stream_add(spriteSheetName_, "coin", "images/coin_strip8.png", -1)) imageCount_++;
	
	// Clamp crops away transparent padding before packing
	if(texture_stream_add(spriteSheetName_, "explosion", "images/explosion_strip12.png", -1, 0.5, 0.5, true)) imageCount_++;
	if(texture_stream_add(spriteSheetName_, "orb", "images/orb_padded.png", 1, 0.5, 0.5, true)) imageCount_++;
}

///
/// @function				on_spritesheet_ready()
/// @description            Looks up every image now that the texture pages exist
///
/// @return {Undefined}
/// 
function on_spritesheet_ready() {
	ready_ = true;
	
	// Try to get image based on name. Will return -1 if fails
	ship_ = spritesheet_find_image(spriteSheetName_, "ship");
	coin_ = spritesheet_find_image(spriteSheetName_, "coin");
	explosion_ = spritesheet_find_image(spriteSheetName_, "explosion");
	panel_ = spritesheet_find_image(spriteSheetName_, "panel");
	orb_ = spritesheet_find_image(spriteSheetName_, "orb");
	
	blocks_ = [];
	for(var _i = 1; _i <= 20; _i++) {
		array_push(blocks_, spritesheet_find_image(spriteSheetName_, string("block_{0}", string_replace(string_format(_i, 2, 0), " ", "0"))));
	}
}

build_spritesheet();
