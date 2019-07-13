/// @desc ?
if (live_call()) return live_result;
debug = false;

step = 0

audio_play_sound(bgmGrowthHEY,1,true)

room_goto(rmTest)
curLiveRoom = 0
liveRooms = [rmTest]
while curLiveRoom < array_length_1d(oGame.liveRooms) {
	liveRoom = liveRooms[curLiveRoom]
	room_set_live(liveRoom, true)
	curLiveRoom++
}
curLiveRoom = 0

liveRoomPlayerX = 0;
liveRoomPlayerY = 0;
liveRoomReady = false;

