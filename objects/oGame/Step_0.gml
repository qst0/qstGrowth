/// @desc ?
if (live_call()) return live_result;

#region keyboard check triggers
if keyboard_check_pressed(vk_escape) {
	game_end()
}

if keyboard_check_pressed(vk_f1) {
	global.debug = !global.debug
}

if keyboard_check_pressed(vk_f5) {
	game_restart()
}

if keyboard_check_pressed(vk_f6) {
	if instance_exists(oPlayer) {
		oPlayer.x = oPlayer.xstart
		oPlayer.y = oPlayer.ystart
	}
}

if keyboard_check_pressed(vk_f8) {
	room_goto_next()
}
#endregion

if room == rmBlank && !liveRoomReady {
	oPlayer.x = liveRoomPlayerX
	oPlayer.y = liveRoomPlayerY
	liveRoomReady = true;
}

step++;