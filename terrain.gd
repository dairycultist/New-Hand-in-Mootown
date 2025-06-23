extends StaticBody3D

@export var SIZE := 128
@export var MAX_HEIGHT := 4

@export var TEX : NoiseTexture2D
@export var MAT : Material

func _ready():
	
	await TEX.changed
	var tex_image := TEX.get_image()
	
	# generate mesh/collision height map
	var height_map := PackedFloat32Array()
	
	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()
	
	for z in SIZE:
		for x in SIZE:
			
			var height := tex_image.get_pixel(
				z * tex_image.get_width() / SIZE,
				x * tex_image.get_height() / SIZE
			).r * MAX_HEIGHT
			
			verts.append(Vector3(x, height, z))
			normals.append(Vector3(0, 1, 0))
			uvs.append(Vector2(x, z))
			
			height_map.append(height)
	
	# upper bound inclusivity is so annoying
	for z in SIZE - 1:
		for x in SIZE - 1:
			indices.append(x + z * SIZE)
			indices.append(x + z * SIZE + 1)
			indices.append(x + z * SIZE + SIZE)
			
			indices.append(x + z * SIZE + SIZE + 1)
			indices.append(x + z * SIZE + SIZE)
			indices.append(x + z * SIZE + 1)
	
	# join mesh
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_TEX_UV] = uvs
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_INDEX] = indices

	# push mesh
	var mesh_instance := MeshInstance3D.new()
	
	mesh_instance.mesh = ArrayMesh.new()
	mesh_instance.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	mesh_instance.set_surface_override_material(0, MAT)
	mesh_instance.position.x -= (SIZE - 1) / 2.0
	mesh_instance.position.z -= (SIZE - 1) / 2.0
	
	add_child(mesh_instance)
	
	# create collider
	var coll_shape := CollisionShape3D.new()
	var shape := HeightMapShape3D.new()
	
	shape.map_width = SIZE
	shape.map_depth = SIZE
	shape.map_data = height_map
	
	coll_shape.shape = shape
	
	add_child(coll_shape)
	
	# debug draw collider
	#var debug_mesh := MeshInstance3D.new()
	#debug_mesh.mesh = shape.get_debug_mesh()
	#add_child(debug_mesh)
