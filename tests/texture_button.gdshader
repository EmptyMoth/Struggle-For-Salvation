shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	
	for (float i = -1.0; i <= 1.0; i += 0.1) {
		for (float j = -1.0; j <= 1.0; j += 0.1) {
			outline += texture(TEXTURE, UV + size * vec2(sin(i), sin(j))).a;
		}
	}
	
	outline = min(outline, 1.0);
	vec4 color = COLOR;
	COLOR = mix(color, line_color, outline - color.a);
}