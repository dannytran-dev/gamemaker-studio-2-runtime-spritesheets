/// @description Update

time_ += 1;

if(keyboard_check_pressed(vk_space)) showPages_ = !showPages_;

// Removes sprite sheet and sprites from memory
if(keyboard_check_pressed(ord("1")) && spritesheet_exists(spriteSheetName_)) {
	spritesheet_destroy(spriteSheetName_);
	ready_ = false;
}

if(keyboard_check_pressed(ord("2")) && !spritesheet_exists(spriteSheetName_)) {
	build_spritesheet();
}

// Only continue if were loading image into a texture stream
if(!texture_stream_exists(spriteSheetName_)) exit;

// Only continue if those images are still loading. HTML waits for images to load
if(texture_stream_loading(spriteSheetName_)) exit;

// Final step to add images onto a sprite sheet
var _start = get_timer();
texture_stream_finish(spriteSheetName_);
packTime_ = (get_timer() - _start) / 1000;

// This is where we should get images
on_spritesheet_ready();
