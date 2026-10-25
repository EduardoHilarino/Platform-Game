// ** Light Draw **

gpu_set_blendmode(bm_add);

shader_set(Sh_RadialLight);

// ** Set Uniforms **
shader_set_uniform_f(
    u_uv_bounds,
    uv_left,
    uv_top,
    uv_right,
    uv_bottom
);

shader_set_uniform_f(
    u_light_color,
    light_r,
    light_g,
    light_b
);

shader_set_uniform_f(u_intensity, light_intensity);

// ** Draw Light **
draw_sprite_stretched(
    Spr_Light,
    0,
    x - light_radius,
    y - light_radius,
    light_radius * 2,
    light_radius * 2
);

shader_reset();
gpu_set_blendmode(bm_normal);