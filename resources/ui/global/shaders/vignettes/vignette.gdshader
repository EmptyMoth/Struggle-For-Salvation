shader_type canvas_item;

uniform vec3 color : source_color = vec3(0.0, 0.0, 0.0);
uniform float opacity : hint_range(0.0, 20.0) = 15.0;
uniform float radius : hint_range(0.0, 2.0) = 0.5;

float vignette(vec2 uv){
	uv *= 1.0 - uv.xy;
	float vignette = uv.x * uv.y * opacity;
	return pow(vignette, radius);
}

void fragment(){
	COLOR.rgb = color;
	COLOR *= 1.0 - vignette(UV);
}