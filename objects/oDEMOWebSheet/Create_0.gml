/// @description Init
//-----------------------------------------------------------------------------
// Example of loading an image straight from a URL. sprite_add downloads it
// asynchronously and the manager packs it once the Async Image Loaded event
// arrives. Kept in its own sheet so a failed download never blocks the demo.
//
// Image: "Simple Spaceship" by ToxSickProductions, CC0
// https://opengameart.org/content/simple-spaceship-0
//-----------------------------------------------------------------------------

// Inherit the parent event
event_inherited();

spriteSheet_ = "WebSheet";
url_ = "https://opengameart.org/sites/default/files/SpaceShipNormal.png";
ship_ = -1;

#region OVERRIDE
function spritesheet_add(_spriteSheet) {
	texture_stream_add(_spriteSheet, "web_ship", url_);
}

function spritesheet_finish(_spriteSheet) {
	// Will be -1 if the download failed
	ship_ = spritesheet_find_image(_spriteSheet, "web_ship");
	spritesheet_log(is_struct(ship_) ? string("Downloaded {0}", url_) : string("Failed to download {0}", url_));
}
#endregion
