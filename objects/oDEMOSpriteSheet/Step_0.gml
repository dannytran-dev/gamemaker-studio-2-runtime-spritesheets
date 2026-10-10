/// @description Update

time_ += 1;

if(keyboard_check_pressed(vk_space)) press_button(0);
if(keyboard_check_pressed(ord("1"))) press_button(1);
if(keyboard_check_pressed(ord("2"))) press_button(2);

// Mouse and touch. HTML5 maps the first touch to the mouse
if(mouse_check_button_pressed(mb_left)) {
	for(var _i = 0; _i < array_length(buttonLabels_); _i++) {
		if(button_hover(_i)) press_button(_i);
	}
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
