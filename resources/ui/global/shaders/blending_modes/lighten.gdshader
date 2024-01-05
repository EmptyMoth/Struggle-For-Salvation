shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

vec4 lighten(vec4 base, vec4 blend){
	return max(base, blend);
}

void fragment() {
	vec4 base = texture(screen_texture, SCREEN_UV);
	COLOR.rgb = lighten(base, COLOR).rgb;
}
