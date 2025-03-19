shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float size = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	float dist = pow(UV.x - 0.5, 2) + pow(UV.y - 0.5, 2);

	if (dist > size || dist < size - 0.08) {
		discard;
	}

	vec4 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);

	float brightness = 0.299 * screen_color.r + 0.587 * screen_color.g + 0.114 * screen_color.b;

	brightness = 1.0 / (1.0 + pow(2, 20.0 * brightness - 10.0));

	COLOR.rgb = vec3(brightness, brightness, brightness);
	COLOR.a = 1.0;
}
