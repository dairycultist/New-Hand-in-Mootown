shader_type spatial;
render_mode world_vertex_coords;

// credit: https://godotshaders.com/shader/triplanar-mapping/

group_uniforms top;
uniform sampler2D top_albedo: source_color;
uniform float top_scale = 1.0;

group_uniforms sides;
uniform sampler2D side_albedo: source_color;
uniform float side_scale = 1.0;

vec3 triplanar_map(vec3 x, vec3 y_pos, vec3 y_neg, vec3 z, vec3 n) {

	vec3 n2 = n * n;
    return
		(
			x * n2.x
			+ max(y_pos * n2.y * sign(n.y), 0.)
			+ max(y_neg * n2.y * -sign(n.y), 0.)
			+ z * n2.z
		)
		/ (n2.x + n2.y + n2.z);
}

void fragment() {

	vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.)).xyz;
	vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.)).xyz;

	ALBEDO = triplanar_map(
		texture(side_albedo, world_vertex.zy * side_scale).xyz,
		texture(top_albedo, world_vertex.xz * top_scale).xyz,
		texture(side_albedo, world_vertex.xz * side_scale).xyz,
		texture(side_albedo, world_vertex.xy * side_scale).xyz,
	world_normal);
}