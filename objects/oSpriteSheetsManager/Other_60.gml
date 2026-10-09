/// @description HTML5 Image Loaded

// In HTML5 images need to be downloaded, even from included files.
// So we have this function in Async - Imaged Loaded to catch those situations
if(is_string(spriteSheet_)) texture_stream_async_image_loaded(spriteSheet_);
