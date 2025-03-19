extends MeshInstance3D

# https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/arraymesh.html#doc-arraymesh
# look into heightmapshape for collision

func _ready():

	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()
	
	# generate mesh
	for x in 128:
		for z in 128:
			verts.append(Vector3(x, 0, z))
			normals.append(Vector3(0, 1, 0))
			uvs.append(Vector2(x, z))
	
	for x in 127:
		for z in 127:
			indices.append(z + x * 128)
			indices.append(z + 128 + x * 128)
			indices.append(z + 1   + x * 128)
			
			indices.append(z + 129 + x * 128)
			indices.append(z + 1   + x * 128)
			indices.append(z + 128 + x * 128)
	
	# push mesh
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices

	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
