#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;

// Output
out vec4 FragColor;

void main() {
    // Fisheye effect
    vec2 scaled_uv = (model_uv * 2.0) - 1.0;
    float theta = atan(scaled_uv.y, scaled_uv.x);
    float magnitude = sqrt(pow(scaled_uv.x, 2.0) + pow(scaled_uv.y, 2.0));
    float radius = pow(magnitude, 1.2);

    vec2 tex_coord = vec2(1.01 * radius * cos(theta), 1.01 * radius * sin(theta));
    tex_coord = vec2(0.5 * (tex_coord.x + 1.0), 0.5 * (tex_coord.y + 1.0));

    // Offset for red and blue
    vec2 red_offset = vec2(tex_coord.x + 0.01, tex_coord.y);
    vec2 blue_offset = vec2(tex_coord.x - 0.01, tex_coord.y);

    // Color
    FragColor = texture(image, blue_offset);
    float i = mod(tex_coord.y, 100.0);
    bool is_even = i < 50.0;
    if (is_even) {
        FragColor = vec4((FragColor.r * texture(image, red_offset).r), (FragColor.g * texture(image, tex_coord).g), (FragColor.b * texture(image, blue_offset).b), (FragColor.a * texture(image, tex_coord).a)) + 0.9;
    } else {
        FragColor = vec4((FragColor.r * texture(image, red_offset).r), (FragColor.g * texture(image, tex_coord).g), (FragColor.b * texture(image, blue_offset).b), (FragColor.a * texture(image, tex_coord).a)) - 0.9;
    }
}
