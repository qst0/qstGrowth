/// @desc ?
if sprite_width == other.sprite_width {
	win++;
	show_debug_message("WINNER!")
}

if win > 90 {
	room_goto_next()
}