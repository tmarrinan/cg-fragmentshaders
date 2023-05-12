#version 300 es
precision highp float;

// Attributes
in vec3 position;
in vec2 uv;
in float time;

// Output
out vec2 model_uv;
out float anim_time;

void main() {
    // Pass UV coordinate and time onto the fragment shader
    model_uv = uv;
    anim_time = time;
    // Don't transform - expecting a fullscreen quad in 2D screen-space 
    gl_Position = vec4(position, 1.0);
}
