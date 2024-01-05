shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

vec4 screen(vec4 base, vec4 blend){
	return 1.0 - (1.0 - base) * (1.0 - blend);
}

void fragment() {
	vec4 base = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = screen(base, COLOR).rgb;
}