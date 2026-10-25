// ** Light Settings **
light_radius = 50;
light_intensity = 0.10;

light_r = 0.75;
light_g = 0.85;
light_b = 1.0;

// ** Sprite UV **
var _uv = sprite_get_uvs(Spr_Light, 0);

uv_left = _uv[0];
uv_top = _uv[1];
uv_right = _uv[2];
uv_bottom = _uv[3];

// ** Shader Uniforms **
u_uv_bounds = shader_get_uniform(Sh_RadialLight, "u_uv_bounds");
u_light_color = shader_get_uniform(Sh_RadialLight, "u_light_color");
u_intensity = shader_get_uniform(Sh_RadialLight, "u_intensity");