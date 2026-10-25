varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_brightness;
uniform float u_contrast;
uniform vec3 u_light_color;

void main()
{
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;

    // ** Soft Contrast **
    vec3 color = (tex.rgb - 0.5) * u_contrast + 0.5;

    // ** Ambient Lighting **
    color *= u_brightness;

    // ** Subtle Light Tint **
    color *= u_light_color;

    // ** Final Color **
    gl_FragColor = vec4(clamp(color, 0.0, 1.0), tex.a);
}