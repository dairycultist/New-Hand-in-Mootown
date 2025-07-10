shader_type spatial;

uniform sampler2D tex;

void vertex() {
	
	mat4 billboard_matrix = mat4(
        INV_VIEW_MATRIX[0],
        INV_VIEW_MATRIX[1],
        INV_VIEW_MATRIX[2],
        MODEL_MATRIX[3]
    );
	
	float a = NODE_POSITION_VIEW.x * 0.3;
	float cosa = cos(a);
	float sina = sin(a);
	
	mat4 sideturn_matrix = mat4(
		vec4(cosa, 0, sina, 0),
		vec4(0, 1, 0, 0),
		vec4(-sina, 0, cosa, 0),
		vec4(0, 0, 0, 1)
	);
	
    MODELVIEW_MATRIX = VIEW_MATRIX * billboard_matrix * sideturn_matrix;
}

void fragment() {
	vec4 c = texture(tex, UV);
	
	if (c.a < 0.5) {
		discard;
	}
	
	ALBEDO = c.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
