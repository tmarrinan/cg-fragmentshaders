#version 300 es
precision mediump float;

// Input
in vec2 model_uv;
in float anim_time;

// Uniforms
uniform sampler2D image;

// Output
out vec4 FragColor;

void main() {
    // scale and translate the texture coordinate such that it is in the range [-1.0, 1.0]
    //     multiply by 2, then subtract 1
    vec2 scaled_uv = (model_uv * 2.0) - 1.0;
    // calculate radius = magnitude of texture coordinate
    float radius = sqrt(pow(scaled_uv.x, 2.0) + pow(scaled_uv.y, 2.0));
    // calculate a texture coordinate offset = texture_coordinate * (sin(radius * 30.0 - time * 5.0) + 0.5) / 60.0
    vec2 tex_coordOffset = vec2(scaled_uv * (sin(radius * 30.0 - anim_time * 5.0) + 0.5) / 60.0);
    // calculate final texture coordinate = original_texture_coordinate + texture_coordinate_offset
    vec2 final_texCoord = model_uv + tex_coordOffset;
    // Color
    FragColor = texture(image, final_texCoord);
}
