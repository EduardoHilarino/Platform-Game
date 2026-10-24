// Colision Mask
	mask_index = Spr_player_Idle

// Horizontal Moviment
	hsp = 0;
	max_hsp = 1.8;

	acceleration = 0.10;
	deceleration = 0.075;
	turn_acceleration = 0.22;

// Vertical Moviment

	vsp = 0;

	jump_speed = -4.2;

	gravity_up = 0.24;
	gravity_down = 0.40;
	gravity_cut = 0.65;

	max_fall_speed = 4.5;

// Coyote time

	coyote_frames = 6;
	coyote_timer = 0;

// Jump buffer

	buffer_frames = 6;
	jump_buffer = 0;

// Moviment acumulators

	x_remainder = 0;
	y_remainder = 0;

// State

	grounded = false;

// Round values Colisions
	x = round(x);
	y = round(y);

// Camera
	if !instance_exists(obj_player_pixel)
	{
		instance_create_layer(x, y, layer, obj_player_pixel);
	}
	
	
// Saves the initial player position
	respawn_x = x;
	respawn_y = y;

// Control Death
	is_dead = false;
	
// Initial direction of the player
	facing = 1; // 1 = right, -1 = left

	image_xscale = facing;

// Coltrol of when Player is turning
	is_turning = false;
	turn_direction = 1;
	turn_locked = false;
	
// Memória da última direção pressionada
	last_move = 0;

// Janela para reconhecer uma virada
	turn_grace_frames = 8;
	turn_grace_timer = 0;

// Controle de animação
	is_turning = false;
	turn_direction = 1;