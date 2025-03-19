extends StaticBody3D

@export var SIZE := 128
@export var TEX_REGION : NoiseTexture2D
@export var TEX_DETAIL : NoiseTexture2D
@export var MAT : Material

# https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/arraymesh.html#doc-arraymesh
# look into heightmapshape for collision

# for_in_ inclusivity is so annoying

func _ready():
	
	var height_map := PackedFloat32Array()
	
	# generate mesh
	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indices = PackedInt32Array()
	
	await TEX_REGION.changed
	await TEX_DETAIL.changed
	var region := TEX_REGION.get_image()
	var detail := TEX_DETAIL.get_image()
	
	for z in SIZE:
		for x in SIZE:
			
			var height : float
			
			var v = region.get_pixel(x, z).r
			
			# TODO falloff V to 0 when close to edge of map
			
			var a = 1 + pow(2, 100 * v - 30)
			var b = 1 + pow(2, 55 - 100 * v)
			
			height = (0.5 * a - b) / (a * b) + 0.5
			
			height *= 16
			
			height += detail.get_pixel(x, z).r
			
			verts.append(Vector3(x, height, z))
			normals.append(Vector3(0, 1, 0))
			uvs.append(Vector2(x, z))
			
			height_map.append(height)
	
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
