extends MeshInstance3D

@export var SIZE := 128

# https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/arraymesh.html#doc-arraymesh
# look into heightmapshape for collision

func _ready():
	
	position.x -= SIZE / 2
	position.z -= SIZE / 2

	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()
	
	# generate mesh
	for x in SIZE:
		for z in SIZE:
			verts.append(Vector3(x, 0, z))
			normals.append(Vector3(0, 1, 0))
			uvs.append(Vector2(x, z))
	
	for x in SIZE - 1:
		for z in SIZE - 1:
			indices.append(z + x * SIZE)
			indices.append(z + x * SIZE + SIZE)
			indices.append(z + x * SIZE + 1)
			
			indices.append(z + x * SIZE + SIZE + 1)
			indices.append(z + x * SIZE + 1)
			indices.append(z + x * SIZE + SIZE)
	
	# push mesh
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices

	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
