function Scr_Player_ChangeState(_new_state) {

    if (state == _new_state) {
        return;
    }

    previous_state = state;
    state = _new_state;

    switch (state) {

        case PlayerState.IDLE:
            sprite_index = Spr_player_Idle;
            break;

        case PlayerState.RUN:
			audio_play_sound(foot_07_grass_04, 0, 1, 0,2, random_range(.5,1.5));
            sprite_index = Spr_Player_run;
            break;

        case PlayerState.TURN:
            is_turning = true;
            turn_direction = facing;
            sprite_index = Spr_Player_turn;
            break;

        case PlayerState.JUMP:
            // Mantém o sprite atual até adicionar animação de pulo
            break;

        case PlayerState.FALL:
            // Mantém o sprite atual até adicionar animação de queda
            break;

        case PlayerState.DEATH:
            is_dead = true;

            hsp = 0;
            vsp = 0;

            x_remainder = 0;
            y_remainder = 0;

            is_turning = false;

            sprite_index = Spr_Player_death;
            break;
		
		case PlayerState.DASH:
			
			sprite_index = Spr_Player_Dash
			break;
    }

    image_index = 0;
}