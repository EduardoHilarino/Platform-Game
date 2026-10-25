// ** Bloom Draw End **

// ** Camera **
var _cam = view_camera[0];

var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

var _view_w = camera_get_view_width(_cam);
var _view_h = camera_get_view_height(_cam);

// ** Surface Resolution **
var _sw = max(1, ceil(_view_w / bloom_scale));
var _sh = max(1, ceil(_view_h / bloom_scale));

// ** Recreate Surfaces If Needed **
if (surface_exists(surf_bloom)) {
    if (surface_get_width(surf_bloom) != _sw ||
        surface_get_height(surf_bloom) != _sh) {

        surface_free(surf_bloom);
        surf_bloom = -1;
    }
}

if (surface_exists(surf_blur)) {
    if (surface_get_width(surf_blur) != _sw ||
        surface_get_height(surf_blur) != _sh) {

        surface_free(surf_blur);
        surf_blur = -1;
    }
}

// ** Create Surfaces **
if (!surface_exists(surf_bloom)) {
    surf_bloom = surface_create(_sw, _sh);
}

if (!surface_exists(surf_blur)) {
    surf_blur = surface_create(_sw, _sh);
}

// ** Capture Rastros **
surface_set_target(surf_bloom);

draw_clear_alpha(c_black, 0);

draw_set_color(c_white);
draw_set_alpha(1);

with (Obj_rastro) {

    draw_sprite_ext(
        sprite_index,
        image_index,
        (x - _cam_x) / other.bloom_scale,
        (y - _cam_y) / other.bloom_scale,
        image_xscale / other.bloom_scale,
        image_yscale / other.bloom_scale,
        image_angle,
        c_white,
        image_alpha
    );
}

surface_reset_target();

// ** Horizontal Blur **
surface_set_target(surf_blur);

draw_clear_alpha(c_black, 0);

gpu_set_blendmode_ext(bm_one, bm_zero);

shader_set(Sh_blur);

shader_set_uniform_f(
    u_direction,
    1 / _sw,
    0
);

draw_surface(surf_bloom, 0, 0);

shader_reset();

gpu_set_blendmode(bm_normal);

surface_reset_target();

// ** Vertical Blur **
surface_set_target(surf_bloom);

draw_clear_alpha(c_black, 0);

gpu_set_blendmode_ext(bm_one, bm_zero);

shader_set(Sh_blur);

shader_set_uniform_f(
    u_direction,
    0,
    1 / _sh
);

draw_surface(surf_blur, 0, 0);

shader_reset();

gpu_set_blendmode(bm_normal);

surface_reset_target();