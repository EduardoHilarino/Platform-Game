varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_direction;

void main()
{
    vec2 uv = v_vTexcoord;

    vec4 color = vec4(0.0);

    // ** Gaussian Blur - 9 Samples **
    color += texture2D(gm_BaseTexture, uv - u_direction * 4.0) * 0.016216;
    color += texture2D(gm_BaseTexture, uv - u_direction * 3.0) * 0.054054;
    color += texture2D(gm_BaseTexture, uv - u_direction * 2.0) * 0.121621;
    color += texture2D(gm_BaseTexture, uv - u_direction * 1.0) * 0.194595;

    color += texture2D(gm_BaseTexture, uv) * 0.227027;

    color += texture2D(gm_BaseTexture, uv + u_direction * 1.0) * 0.194595;
    color += texture2D(gm_BaseTexture, uv + u_direction * 2.0) * 0.121621;
    color += texture2D(gm_BaseTexture, uv + u_direction * 3.0) * 0.054054;
    color += texture2D(gm_BaseTexture, uv + u_direction * 4.0) * 0.016216;

    gl_FragColor = color * v_vColour;
}