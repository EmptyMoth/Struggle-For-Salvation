shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

vec4 linear_dodge(vec4 base, vec4 blend){
	return base + blend;
}

void fragment() {
	vec4 base = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = linear_dodge(base, COLOR).rgb;
}
