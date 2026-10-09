/// 
/// @function				TexturePageImage(_id = -1, _subImgs = -1, _width = -1, _height = -1, _xOrig = -1, _yOrig = -1, _bboxLeft = -1, _bboxTop = -1, _bboxRight = -1, _bboxBot = -1)
/// @description            Class for texture page images. This class contains data that are relevant to each sprite on a texture page. Information like file path, which texture page its on, positional data, sub image positional data, etc
///
/// @param {Real}			[_id] - Unique indentfier of texture page image
/// @param {Real}			[_subImgs] - Total sub-images of texutre page image
/// @param {Real}			[_width] - Texture page image width
/// @param {Real}			[_height] - Texture page image height
/// @param {Real}			[_xOrig] - The x position of the origin
/// @param {Real}			[_yOrig] - The y position of the origin
/// @param {Real}			[_bboxLeft] - Left hand bounding box for the image, where the bounding box is defined by the maximum width and height of the sprite for the instance
/// @param {Real}			[_bboxTop] - Top hand bounding box for the image, where the bounding box is defined by the maximum width and height of the sprite for the instance
/// @param {Real}			[_bboxRight] - Right hand bounding box for the image, where the bounding box is defined by the maximum width and height of the sprite for the instance
/// @param {Real}			[_bboxBot] - Bot hand bounding box for the image, where the bounding box is defined by the maximum width and height of the sprite for the instance
/// @returns {Struct}		Returns a struct of type TexturePageImage
/// 
function TexturePageImage(_id = -1, _subImgs = -1, _width = -1, _height = -1, _xOrig = -1, _yOrig = -1, _bboxLeft = -1, _bboxTop = -1, _bboxRight = -1, _bboxBot = -1) constructor {
	
	id_ = _id;
	subImgs_ = _subImgs;
	width_ = _width;
	height_ = _height;
	xOrig_ = _xOrig;
	yOrig_ = _yOrig;
	xPivot_ = -1;
	yPivot_ = -1;
	bboxLeft_ = _bboxLeft;
	bboxTop_ = _bboxTop;
	bboxRight_ = _bboxRight;
	bboxBot_ = _bboxBot;
	
	texturePages_ = [];
	subImgX_ = [];
	subImgY_ = [];
	
	fPath_ = "";
}