// ** Soft Lighting Draw GUI Begin **

if (!surface_exists(application_surface)) {
    exit;
}

// ** Apply Shader **
shader_set(Sh_SoftLight);

shader_set_uniform_f(u_brightness, light_brightness);
shader_set_uniform_f(u_contrast, light_contrast);

shader_set_uniform_f(
    u_light_color,
    light_r,
    light_g,
    light_b
);

// ** Draw Final Game Image **
draw_surface_stretched(
    application_surface,
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height()
);

shader_reset();

// ** Bloom Composition **

if (instance_exists(Obj_bloom)) {

    var _bloom = instance_find(Obj_bloom, 0);

    if (surface_exists(_bloom.surf_bloom)) {

        gpu_set_blendmode(bm_add);

        draw_surface_stretched_ext(
            _bloom.surf_bloom,
            0,
            0,
            display_get_gui_width(),
            display_get_gui_height(),
            c_red,
            _bloom.bloom_strength
        );

        gpu_set_blendmode(bm_normal);
    }
}