/// roomUpdated
///@param roomUpdated
if argument_count == 1 {
	if room == rmBlank {
			if instance_exists(oPlayer) {
				oGame.liveRoomPlayerX = oPlayer.x
				oGame.liveRoomPlayerY = oPlayer.y
				oGame.liveRoomReady = false;
			} else {
				oGame.liveRoomReady = true;
			}
		room_goto_live(argument0)
	} else {
		show_debug_message("Entering the live room the first time");
		if room == argument0 && instance_exists(oPlayer) {
			show_debug_message("The room we live loaded was the one we are in");
			oGame.liveRoomPlayerX = oPlayer.x
			oGame.liveRoomPlayerY = oPlayer.y
			oGame.liveRoomReady = false;
		} else {
			show_debug_message("We are entering a new live room");
			oGame.liveRoomReady = true;
		}
		room_goto_live(argument0)
	}
} else {
	show_debug_message("no arguments? -qst")
}
/*
	room_goto_live(argument0)
*/