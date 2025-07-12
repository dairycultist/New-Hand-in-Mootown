shader_type spatial;
render_mode world_vertex_coords;

// credit: https://godotshaders.com/shader/triplanar-mapping/

group_uniforms top;
uniform sampler2D top_albedo: source_color;
uniform float top_scale = 1.0;

group_uniforms sides;
uniform sampler2D side_albedo: source_color;
uniform float side_scale = 1.0;

vec3 triplanar_map(vec3 x, vec3 y, vec3 z, vec3 n) {
	n = n*n;
    return (x*n.x + y*n.y + z*n.z)/(n.x+n.y+n.z);
}

void fragment() {
	vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.)).xyz;
	vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.)).xyz;

	vec3 sides = texture(side_albedo, world_vertex.zy * side_scale).xyz;
    vec3 top = texture(top_albedo, world_vertex.xz * top_scale).xyz;

	ALBEDO = triplanar_map(sides, top, sides, world_normal);
}