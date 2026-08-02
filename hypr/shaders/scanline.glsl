precision mediump float;

varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 col = texture2D(tex, v_texcoord);

    // scanline effect
    float lines = sin(v_texcoord.y * 1000.0) * 0.03;
    col.rgb -= lines;

    gl_FragColor = col;
}
