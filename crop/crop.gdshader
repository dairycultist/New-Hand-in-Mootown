shader_type spatial;

uniform sampler2D tex;
uniform float growth : hint_range(0.0, 1.0) = 1.0;

vec3 pow3(vec3 vec, float fac) {
	return vec3(pow(vec.x, fac), pow(vec.y, fac), pow(vec.z, fac));
}

void vertex() {

	VERTEX *= vec3(
		mix(0.7, 1.0, growth),
		mix(0.5, 1.0, growth),
		mix(0.7, 1.0, growth)
	);
}

void fragment() {
	// convert from sRGB to linear RGB
	// (normal fac is 2.2 but this works better for shaded)
	ALBEDO = pow3(texture(tex, UV).rgb, 3) * vec3(
		mix(0.3, 1.0, growth),
		mix(0.5, 1.0, growth),
		mix(0.3, 1.0, growth)
	);
}

void light() {

	float lightness = smoothstep(0.47, 0.53, dot(NORMAL, LIGHT) * 0.5 + 0.5) * 0.5 + 0.25;

	DIFFUSE_LIGHT += lightness * ATTENUATION * LIGHT_COLOR / PI;
}