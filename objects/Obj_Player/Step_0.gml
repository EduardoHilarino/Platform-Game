
	// Guardar posição horizontal anterior
	var previous_x = x;

	// ** 1. Player Input **
	
	var move = keyboard_check(ord("D"))
	         - keyboard_check(ord("A"));

	var jump_pressed = keyboard_check_pressed(vk_space);
	var jump_held = keyboard_check(vk_space);


	// ** 3. Verify Ground **

	grounded = place_meeting(x, y + 1, Obj_Solid);

		// Updates coyote time
		if (grounded) {
		    coyote_timer = coyote_frames;
		}
		else {
		    coyote_timer = max(0, coyote_timer - 1);
		}


	// =====================================
	// DETECÇÃO DE VIRADA COM MEMÓRIA
	// =====================================

	 // Guardar a direção anterior
	 // por alguns frames após soltar a tecla
	 if (move == 0) {
	     turn_grace_timer = max(0, turn_grace_timer - 1);
	 }
	 else if (move == last_move) {
	     turn_grace_timer = turn_grace_frames;
	 }

	 // Detectar uma nova direção contrária
	 var direction_changed = (move != 0 && last_move != 0 && move != last_move);

	 // Verificar se ainda existe impulso
	 var has_momentum = (move != 0 && abs(hsp) > 0.15 && sign(hsp) != move);

	 // Iniciar virada
	 if (direction_changed && turn_grace_timer > 0 && has_momentum && grounded && !is_turning) {
	     is_turning = true;

	     // Guardar a direção anterior
	     turn_direction = sign(hsp);
	 }

	 // Atualizar a direção lembrada
	 if (move != 0) {
	     last_move = move;
	     turn_grace_timer = turn_grace_frames;
	 }


	// ** 2. Horizontal Moviment **

	var target_hsp = move * max_hsp;
	var rate = acceleration;

	if (move == 0) {
	    rate = deceleration;
	}
	else if (hsp != 0 && sign(hsp) != move) {
	    rate = turn_acceleration;
	}

		// Aproximates the speed with the target speed
		if (hsp < target_hsp) {
		    hsp = min(hsp + rate, target_hsp);
		}
		else if (hsp > target_hsp) {
		    hsp = max(hsp - rate, target_hsp);
		}


	// ** 4. Jump Buffer **
	
	if (jump_pressed) {
	    jump_buffer = buffer_frames;
	}
	else {
	    jump_buffer = max(0, jump_buffer - 1);
	}


	// ** 5. Executes Jump **

	if (jump_buffer > 0 && coyote_timer > 0) {

	    vsp = jump_speed;

	    jump_buffer = 0;
	    coyote_timer = 0;

	    grounded = false;
	}


	// ** 6. Dynamic Gravity **

	if (!grounded || vsp < 0) {

	    if (vsp < 0) {

	        if (jump_held) {
	            vsp += gravity_up;
	        }
	        else {
	            vsp += gravity_cut;
	        }

	    }
	    else {
	        vsp += gravity_down;
	    }

	    vsp = min(vsp, max_fall_speed);

	}
	else {
	    vsp = 0;
	}


	// ** 7. Horizontal Colisions **

		// Fractionary moviments
		x_remainder += hsp;

		// Get pixel perfects
		var move_x = floor(abs(x_remainder))
		           * sign(x_remainder);

		x_remainder -= move_x;

		// Aplicates moviment pixel per pixel
		repeat (abs(move_x)) {

		    var dir_x = sign(move_x);

		    if (!place_meeting(x + dir_x, y, Obj_Solid)) {
		        x += dir_x;
		    }
		    else {
		        hsp = 0;
		        x_remainder = 0;
		        break;
		    }
		}


	// ** 8. Vertical Colisions **

		// Fractionary moviments
		y_remainder += vsp;

		// Get pixel perfects
		var move_y = floor(abs(y_remainder))
		           * sign(y_remainder);

		y_remainder -= move_y;

		// Aplicates moviment pixel per pixel
		repeat (abs(move_y)) {

		    var dir_y = sign(move_y);

		    if (!place_meeting(x, y + dir_y, Obj_Solid)) {
		        y += dir_y;
		    }
		    else {
		        vsp = 0;
		        y_remainder = 0;
		        break;
		    }
		}


	// ** 9. Updates Animations **

		// Verificar se existe uma parede na direção atual
		var blocked = false;

		if (abs(hsp) > 0.01) {
		    blocked = place_meeting(x + sign(hsp), y, Obj_Solid);
		}

		// Verificar velocidade horizontal real
		var is_moving = (abs(hsp) > 0.10) && !blocked;

		// Escolher animação
		var new_sprite = Spr_player_Idle;

		if (is_turning) {
		    new_sprite = Spr_Player_turn;
		}
		else if (is_moving) {
		    new_sprite = Spr_Player_run;
		}

		// Trocar sprite somente quando necessário
		if (sprite_index != new_sprite) {
		    sprite_index = new_sprite;
		    image_index = 0;
		}

		if (is_turning) {
		    facing = turn_direction;
		}
		else if (move != 0) {
		    facing = move;
		}

		image_xscale = facing;
