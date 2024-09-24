shader_type spatial;
render_mode cull_front;
uniform float explosion: hint_range(0.0, 1.0, 0.1);
uniform vec4 color: source_color;

void vertex() {
	VERTEX += NORMAL * 1./(explosion - 1.);
}

void fragment() {
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
