light_brightness = 1.08;
light_contrast = 1.05;

light_r = 0.98;
light_g = 0.98;
light_b = 1.0;

// ** Shader Uniforms **
u_brightness = shader_get_uniform(Sh_SoftLight, "u_brightness");
u_contrast = shader_get_uniform(Sh_SoftLight, "u_contrast");
u_light_color = shader_get_uniform(Sh_SoftLight, "u_light_color");

// ** Manual Application Surface Drawing **
application_surface_draw_enable(false);

lighting_enabled = true;