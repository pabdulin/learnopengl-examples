@ctype vec2 hmm_vec2
@ctype vec3 hmm_vec3
@ctype mat4 hmm_mat4

@vs vs_offscreen
in vec3 a_pos;
in vec2 a_tex_coords;
out vec2 tex_coords;

uniform vs_params {
    mat4 model;
    mat4 view;
    mat4 projection;
};

void main() {
    gl_Position = projection * view * model * vec4(a_pos, 1.0);
    tex_coords = a_tex_coords;
}
@end

@vs vs_display
in vec2 a_pos;
in vec2 a_tex_coords;
out vec2 tex_coords;

void main() {
    gl_Position = vec4(a_pos, 0.0, 1.0);
    tex_coords = a_tex_coords;
}
@end

@fs fs
in vec2 tex_coords;
out vec4 frag_color;

uniform texture2D _diffuse_texture;
uniform sampler diffuse_texture_smp;
#define diffuse_texture sampler2D(_diffuse_texture, diffuse_texture_smp)

void main() {
    frag_color = texture(diffuse_texture, tex_coords);
}
@end

@program offscreen vs_offscreen fs
@program display vs_display fs
