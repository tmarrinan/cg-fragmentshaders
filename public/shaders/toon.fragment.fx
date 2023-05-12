#version 300 es
precision mediump float;

// Input
in vec2 model_uv;

// Uniforms
uniform sampler2D image;

// Output
out vec4 FragColor;

void main() {
    // Color
    FragColor = texture(image, model_uv);
    
    // Color components
    float red = float(int(FragColor.r * 4.0)) / 4.0;
    float green = float(int(FragColor.g * 4.0)) / 4.0;
    float blue = float(int(FragColor.b * 4.0)) / 4.0;

    FragColor = vec4(red, green, blue, FragColor.a);
}
