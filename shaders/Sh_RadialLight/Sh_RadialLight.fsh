varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 u_uv_bounds;
uniform vec3 u_light_color;
uniform float u_intensity;

void main()
{
    // ** Normalize Sprite UV **
    vec2 uv = (v_vTexcoord - u_uv_bounds.xy)
            / (u_uv_bounds.zw - u_uv_bounds.xy);

    // ** Distance From Center **
    float dist = length((uv - 0.5) * 2.0);

    // ** Soft Light Falloff **
    float light = 1.0 - smoothstep(0.0, 1.0, dist);

    // ** Final Color **
    gl_FragColor = vec4(
        u_light_color * light * u_intensity,
        1.0
    );
}