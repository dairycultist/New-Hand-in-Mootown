shader_type spatial;

uniform sampler2D tex;

vec3 pow3(vec3 vec, float fac) {
	return vec3(pow(vec.x, fac), pow(vec.y, fac), pow(vec.z, fac));
}

void fragment() {
	// convert from sRGB to linear RGB
	// (normal fac is 2.2 but this works better for shaded)
	ALBEDO = pow3(texture(tex, UV).rgb, 3);
}

void light() {
	
	float lightness = smoothstep(0.47, 0.53, dot(NORMAL, LIGHT) * 0.5 + 0.5) * 0.5 + 0.25;
	
	DIFFUSE_LIGHT += lightness * ATTENUATION * LIGHT_COLOR / PI;
}