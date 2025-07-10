shader_type spatial;

uniform sampler2D tex;
uniform float sideturn_amount = 0.2;

void vertex() {

	mat4 billboard_matrix = mat4(
        INV_VIEW_MATRIX[0],
        vec4(0, 1, 0, 0),
        INV_VIEW_MATRIX[2],
        MODEL_MATRIX[3]
    );

	float a = NODE_POSITION_VIEW.x * sideturn_amount / NODE_POSITION_VIEW.z;
	float cosa = cos(a);
	float sina = sin(a);

	mat4 sideturn_matrix = mat4(
		vec4(cosa, 0, sina, 0),
		vec4(0, 1, 0, 0),
		vec4(-sina, 0, cosa, 0),
		vec4(0, 0, 0, 1)
	);

	float b = sin(TIME * 2.0 + NODE_POSITION_WORLD.x) * 0.2 + sin(TIME * 5.4 + NODE_POSITION_WORLD.y) * 0.05;
	float cosb = cos(b);
	float sinb = sin(b);

	mat4 sway_matrix = mat4(
		vec4(1, 0, 0, 0),
		vec4(0, cosb, -sinb, 0),
		vec4(0, sinb, cosb, 0),
		vec4(0, 0, 0, 1)
	);

    MODELVIEW_MATRIX = VIEW_MATRIX * billboard_matrix * sideturn_matrix * sway_matrix;
}

void fragment() {
	vec4 c = texture(tex, UV);

	if (c.a < 0.5) {
		discard;
	}

	ALBEDO = c.rgb;
}