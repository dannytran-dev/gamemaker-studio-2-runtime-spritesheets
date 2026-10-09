/// @description Wait to spritesheet images

if(!started_) start();

if(ready_ || !is_string(spriteSheet_)) exit;

// Only continue if were loading image into a texture stream
if(!texture_stream_exists(spriteSheet_)) exit;

// Only continue if those images are still loading. HTML waits for images to load
if(texture_stream_loading(spriteSheet_)) exit;

// Final step to add images onto a sprite sheet
texture_stream_finish(spriteSheet_);
ready_ = true;

// Finish Setup Sprites
spritesheet_finish(spriteSheet_);
