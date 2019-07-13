/// @desc Movement / Control
if (live_call()) return live_result;
sprite_set_live(sprPlayer, true);

if oGame.step == 0 {

}

keyLeft = gamepad_axis_value(0,0) < -.5 || keyboard_check(ord("A"));
keyRight = gamepad_axis_value(0,0) >= .5 || keyboard_check(ord("D"));
keyUp = gamepad_axis_value(0,1) > .5 || keyboard_check(ord("W"));
keyDown = gamepad_axis_value(0,1) <= -.5 || keyboard_check(ord("S"));
keyJump = gamepad_button_check_pressed(0,gp_face1) || keyboard_check_pressed(vk_space);


// SIDE TO SIDE MOVEMENT

// Gravity and Friction happen first
if oGame.step % frictionRate == 0 {
	if hsp != 0 {
		if hsp > 0{
			hsp -= frictionFactor;
		} else if hsp < 0 {
			hsp += frictionFactor;
		}
	}
}

if oGame.step % walkRate == 0 {
var move = keyRight - keyLeft;
if (hsp + move * walksp) < maxwalksp
	and (hsp + move * walksp) > -maxwalksp
hsp += move * walksp;
}

 // we'll hit a solid going left or right
if place_meeting(x + hsp, y, oSolid)
	{
	while !place_meeting(x + sign(hsp)/10, y, oSolid) {
		x += sign(hsp)/10;
	}
	hsp = 0;
}

x += hsp;
// RISING AND FALLING MOVEMENT

// Gravity and Friction happen first
if oGame.step % frictionRate == 0 {
	if vsp != 0 {
		if vsp > 0{
			vsp -= frictionFactor;
		} else if hsp < 0 {
			vsp += frictionFactor;
		}
	}
}

if vsp < maxvsp {
	vsp += grv;
}
		
// jumping on the floor
if place_meeting(x, y + 0.1, oSolid){
	jumpCharges = maxJumpCharges;
	sinceLand = 0;
	if keyJump {
		vsp = - jumppow;
		sinceLand = 20;
	}
} else {
	// Jumpming in the air
	if sinceLand < 10 and keyJump {
		vsp = - jumppow;
	} else if keyJump and jumpCharges {
		var inst = instance_create_depth(x,y,depth + 1, oJumpDust)
		with inst {
			image_xscale = oPlayer.image_xscale
			image_yscale = oPlayer.image_yscale
		}
		vsp = - jumppow;
		jumpCharges--;
	}
	sinceLand++;
}



// do floor detections. aka falling and rising

if place_meeting(x, y + vsp, oSolid) { // We'll hit a solid
	// Regular Solid
	// So go toward it till we do hit it.
	while !place_meeting(x, y + sign(vsp)/10, oSolid) {
		y += sign(vsp)/10;
	}
	//Then stop.
	vsp = 0;
}

y += vsp;

// Animations

if hsp > 0.3 && image_xscale < 0 { // Now Moving Right.
	image_xscale = -1 * image_xscale;
} else if hsp < -0.3 && image_xscale > 0 { // Now Moving left.
	image_xscale = -1 * image_xscale;
} else {
	// don't change it
}

// Jumping
if !place_meeting(x, y + 0.1, oSolid) {
	sprite_index = sprPlayerJump;
	if (sign(vsp) > 0) { //falling
		//image_index = 6;
	} else { //Rising
		//image_index = 2;
	}
} else {
	image_speed = 1;
	if (hsp == 0) { //Idle
		if keyDown {
			sprite_index = sprPlayerDown;
		} else if keyUp {
			sprite_index = sprPlayer;
		} else {
			sprite_index = sprPlayer;
		}
	} else { //Running
		sprite_index = sprPlayer;
	}
}

iFrames--;