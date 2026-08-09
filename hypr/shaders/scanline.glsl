#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

// settings
const float vignette_strength = 0.35;
const float contrast = 1.1;

void main() {
    vec4 color = texture(tex, v_texcoord);

    // vignette
    vec2 uv = v_texcoord * 2.0 - 1.0;
    float dist = dot(uv, uv);
    float vignette = 1.0 - dist * vignette_strength;

    // contrast
    vec3 contrasted = (color.rgb - 0.5) * contrast + 0.5;

    // final
    vec3 finalColor = contrasted * vignette;

    fragColor = vec4(finalColor, color.a);
}
