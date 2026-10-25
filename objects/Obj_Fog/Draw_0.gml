// ** Fog Draw **

draw_set_alpha(fog_alpha);
draw_set_color(fog_color);

draw_rectangle(
    camera_get_view_x(view_camera[0]),
    camera_get_view_y(view_camera[0]),
    camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]),
    camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]),
    false
);

draw_set_alpha(1);
draw_set_color(c_white);