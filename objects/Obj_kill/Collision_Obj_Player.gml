if (other.state != PlayerState.DEATH) {
    with (other) {
        Scr_Player_ChangeState(PlayerState.DEATH);
    }
}