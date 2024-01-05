shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

vec4 linear_burn(vec4 base, vec4 blend){
	return base + blend - 1.0;
}

void fragment() {
	vec4 base = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = linear_burn(base, COLOR).rgb;
}
