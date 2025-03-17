shader_type spatial;

uniform vec3 color1 : source_color;
uniform vec3 color2 : source_color;
uniform sampler3D noise;

void vertex() {
	
}

void fragment() {
	
	// sample texture (VERTEX is in view space, must go to world space)
	float sample = texture(noise, (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz - NODE_POSITION_WORLD).x;
	
	vec3 interp_color = mix(color1, color2, step(0.5, sample));
	
	interp_color = mix(interp_color, vec3(1,1,1), clamp(1.0 - 1000.0 * pow(sample - 0.5, 2), 0.0, 1.0));
	
	ALBEDO = interp_color;
	
	//METALLIC = 1.0;
	//SPECULAR = 1.0;
	//ROUGHNESS = 0.8;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
