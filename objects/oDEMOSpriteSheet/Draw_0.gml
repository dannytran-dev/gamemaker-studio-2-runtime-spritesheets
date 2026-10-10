/// @description Draw

var _gui = c_white;
var _dim = make_colour_rgb(150, 160, 185);
var _accent = make_colour_rgb(120, 200, 255);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Header
draw_set_colour(_gui);
draw_text_transformed(24, 16, "Runtime Sprite Sheets", 2, 2, 0);
draw_set_colour(_dim);
draw_text(24, 52, "SPACE: toggle view    1: destroy sprite sheet    2: rebuild sprite sheet");

// On-screen buttons for mouse and touch
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for(var _b = 0; _b < array_length(buttonLabels_); _b++) {
	var _bx = button_x(_b);
	draw_set_colour(button_hover(_b) ? make_colour_rgb(64, 72, 96) : make_colour_rgb(40, 44, 58));
	draw_roundrect(_bx, buttonY_, _bx + buttonW_, buttonY_ + buttonH_, false);
	draw_set_colour(_accent);
	draw_roundrect(_bx, buttonY_, _bx + buttonW_, buttonY_ + buttonH_, true);
	draw_set_colour(_gui);
	draw_text(_bx + buttonW_ / 2, buttonY_ + buttonH_ / 2, buttonLabels_[_b]);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Checks if sprite sheet exists before drawing
if(!spritesheet_exists(spriteSheetName_)) {
	draw_set_colour(_accent);
	draw_text(24, 96, "Sprite sheet destroyed, all texture pages freed. Press 2 to rebuild.");
	draw_set_colour(c_white);
	exit;
}

if(!ready_) {
	draw_set_colour(_accent);
	draw_text(24, 96, "Loading images...");
	draw_set_colour(c_white);
	exit;
}

var _pages = spritesheet_get_texturepage_count(spriteSheetName_);
draw_set_colour(_accent);
draw_text(24, 72, string("Packed {0} images into {1} texture page(s) of {2}x{2} in {3} ms", imageCount_, _pages, pageSize_, string_format(packTime_, 0, 2)));

if(showPages_) {
	// Texture page view - checkerboard shows the transparent areas
	var _px = 24;
	var _py = 112;
	var _gap = 24;
	var _checker = 16;

	for(var _p = 0; _p < _pages; _p++) {
		var _ox = _px + _p * (pageSize_ + _gap);
		for(var _cy = 0; _cy < pageSize_ / _checker; _cy++) {
			for(var _cx = 0; _cx < pageSize_ / _checker; _cx++) {
				draw_set_colour(((_cx + _cy) mod 2 == 0) ? make_colour_rgb(46, 50, 64) : make_colour_rgb(36, 40, 52));
				draw_rectangle(_ox + _cx * _checker, _py + _cy * _checker, _ox + (_cx + 1) * _checker - 1, _py + (_cy + 1) * _checker - 1, false);
			}
		}
		draw_set_colour(_accent);
		draw_rectangle(_ox - 1, _py - 1, _ox + pageSize_, _py + pageSize_, true);
		draw_text(_ox, _py + pageSize_ + 8, string("Texture page {0}", _p));
	}

	draw_set_colour(c_white);
	draw_texturepage_all(spriteSheetName_, 0, _px, _py, _gap);
	exit;
}

// Draw function view - one cell per function
var _cols = 4;
var _cellW = 330;
var _cellH = 215;
var _startX = 24;
var _startY = 100;
var _labels = [
	"draw_image  (from a URL)", "draw_image_ext", "draw_image  (strip, auto frames)", "draw_image  (strip, auto-cropped)",
	"draw_image_general", "draw_image_part", "draw_image_part_ext", "draw_image_pos",
	"draw_image_pos_general", "draw_image_stretched", "draw_image_stretched_ext", "Second sheet via oSpriteSheetsManager",
];

for(var _i = 0; _i < array_length(_labels); _i++) {
	var _x = _startX + (_i mod _cols) * _cellW;
	var _y = _startY + (_i div _cols) * _cellH;
	draw_set_colour(make_colour_rgb(40, 44, 58));
	draw_roundrect(_x, _y, _x + _cellW - 12, _y + _cellH - 12, false);
	draw_set_colour(_dim);
	draw_text(_x + 10, _y + 8, _labels[_i]);
}
draw_set_colour(c_white);

var _cx = function(_index) { return 24 + (_index mod 4) * 330 + 159; };
var _cy = function(_index) { return 100 + (_index div 4) * 215 + 112; };
var _wave = sin(time_ / 30);

// 0. Plain draw of an image sprite_add downloaded from the web
if(instance_exists(oDEMOWebSheet)) {
	var _webShip = oDEMOWebSheet.ship_;
	draw_set_halign(fa_center);
	draw_set_colour(_dim);
	if(is_struct(_webShip)) {
		draw_set_colour(c_white);
		var _webScale = min(1, 140 / max(_webShip.width_, _webShip.height_));
		draw_image_ext(_webShip, 0, _cx(0), _cy(0), _webScale, _webScale, 0, c_white, 1);
		draw_set_colour(_dim);
		draw_text(_cx(0), _cy(0) + 76, "opengameart.org (CC0)");
	}
	else if(oDEMOWebSheet.is_ready()) {
		draw_text(_cx(0), _cy(0) - 20, "Download failed\n(no internet, or blocked by\nCORS on HTML5)");
	}
	else {
		draw_text(_cx(0), _cy(0), "Downloading...");
	}
	draw_set_halign(fa_left);
	draw_set_colour(c_white);
}

// 1. Scaled and rotated around its pivot
draw_image_ext(ship_, 0, _cx(1), _cy(1), 1 + _wave * 0.3, 1 + _wave * 0.3, time_ * 2, c_white, 1);

// 2. Animated strip, frame count read from coin_strip8.png
for(var _c = 0; _c < 5; _c++) {
	draw_image(coin_, time_ / 5 + _c, _cx(2) - 100 + _c * 50, _cy(2));
}

// 3. Animated strip with transparent padding cropped away
draw_image(explosion_, time_ / 4, _cx(3), _cy(3));

// 4. Per corner colour blending
draw_image_general(ship_, 0, _cx(4), _cy(4), 1, 1, 0, c_red, c_lime, c_blue, c_fuchsia, 1);

// 5. Revealing part of an image
var _reveal = (_wave * 0.5 + 0.5) * panel_.width_;
draw_image_part(panel_, 0, 0, 0, _reveal, panel_.height_, _cx(5) - panel_.width_ / 2, _cy(5) - panel_.height_ / 2);

// 6. Part with scale, colour and alpha
draw_image_part_ext(panel_, 0, 0, 0, panel_.width_, panel_.height_, _cx(6) - panel_.width_ * 0.75, _cy(6) - panel_.height_ * 0.75, 1.5, 1.5, c_yellow, 0.6);

// 7. Free quad distortion
var _w = 64;
var _h = 48;
var _skew = _wave * 30;
draw_image_pos(blocks_[0], 0, _cx(7) - _w + _skew, _cy(7) - _h, _cx(7) + _w + _skew, _cy(7) - _h, _cx(7) + _w - _skew, _cy(7) + _h, _cx(7) - _w - _skew, _cy(7) + _h, 1);
draw_set_alpha(1);

// 8. Quad with rotation and per corner colours, the first corner is placed on the image pivot
var _bx = _cx(8);
var _by = _cy(8);
draw_image_pos_general(blocks_[7], 0, _bx, _by, _bx + blocks_[7].width_, _by, _bx + blocks_[7].width_, _by + blocks_[7].height_, _bx, _by + blocks_[7].height_, time_, c_aqua, c_white, c_orange, c_white, 1);

// 9. Stretched to any size
var _sw = 120 + _wave * 80;
draw_image_stretched(panel_, 0, _cx(9) - _sw, _cy(9) - 40, _sw * 2, 80);

// 10. Stretched with colour and alpha
draw_image_stretched_ext(orb_, 0, _cx(10) - 60, _cy(10) - 60, 120, 120, c_white, 0.5 + _wave * 0.5);
draw_set_colour(_dim);
draw_set_halign(fa_center);
draw_text(_cx(10), _cy(10) + 70, string("orb_padded.png  256x256 -> {0}x{1}", orb_.width_, orb_.height_));
draw_set_halign(fa_left);
draw_set_colour(c_white);

// 11. Images from a second sprite sheet built by a manager prefab
if(instance_exists(oDEMOManagerSheet) && oDEMOManagerSheet.is_ready()) {
	var _gemSheet = oDEMOManagerSheet.spriteSheet_;
	var _gems = ["gem_red", "gem_green", "gem_blue"];
	for(var _g = 0; _g < array_length(_gems); _g++) {
		var _bob = sin(time_ / 15 + _g) * 10;
		draw_image(spritesheet_find_image(_gemSheet, _gems[_g]), 0, _cx(11) - 70 + _g * 70, _cy(11) + _bob);
	}
}
