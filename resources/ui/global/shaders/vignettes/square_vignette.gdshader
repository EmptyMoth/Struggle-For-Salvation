shader_type canvas_item;

uniform vec3 color : source_color = vec3(0.0, 0.0, 0.0);
uniform float size: hint_range(0.0, 1.5) = 0.2;

void fragment() {
	vec2 centering = abs(UV * 2.0 - 1.0);
	vec2 u = size * TEXTURE_PIXEL_SIZE;
	u = smoothstep(vec2(0), u, 1.0 - centering);
	COLOR.a = 1.0 - COLOR.a * u.x * u.y;
	COLOR.rgb = color;
}