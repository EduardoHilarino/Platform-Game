// Turn Animation
if (state == PlayerState.TURN && sprite_index == Spr_Player_turn) {

    is_turning = false;

    if (!grounded) {
        Scr_Player_ChangeState(PlayerState.FALL);
    }
    else if (abs(hsp) > 0.10) {
        Scr_Player_ChangeState(PlayerState.RUN);
    }
    else {
        Scr_Player_ChangeState(PlayerState.IDLE);
    }
}

// Death Animation
if (state == PlayerState.DEATH && sprite_index == Spr_Player_death) {
    Scr_Player_respawn();

    is_dead = false;
    is_turning = false;

    Scr_Player_ChangeState(PlayerState.IDLE);
}