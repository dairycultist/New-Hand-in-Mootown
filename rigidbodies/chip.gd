extends "floating_body.gd"

const MESH_CUBE = preload("res://rigidbodies/chip_cube.obj")
const MESH_OCTAHEDRON = preload("res://rigidbodies/chip_octahedron.obj")
const MESH_TETRAHEDRON = preload("res://rigidbodies/chip_tetrahedron.obj")

const MAT_CUBE = preload("res://rigidbodies/chip_cube.tres")
const MAT_OCTAHEDRON = preload("res://rigidbodies/chip_octahedron.tres")
const MAT_TETRAHEDRON = preload("res://rigidbodies/chip_tetrahedron.tres")

func generate_shape_from_mesh(mesh):
	
	var shape := ConvexPolygonShape3D.new()
	shape.points = mesh.surface_get_arrays(0)[0]
	
	return shape

func _ready() -> void:
	
	var rand = RandomNumberGenerator.new()
	
	var mesh := MeshInstance3D.new()
	var collider := CollisionShape3D.new()
	add_child(mesh)
	add_child(collider)
	
	mass = 1
	
	match rand.randi_range(0, 3):
		0:
			mesh.mesh = MESH_CUBE
			mesh.material_override = MAT_CUBE
			
			var coll := BoxShape3D.new()
			coll.size = Vector3(2.0/3, 2.0/3, 2.0/3)
			collider.shape = coll
		1:
			mesh.mesh = MESH_TETRAHEDRON
			mesh.material_override = MAT_TETRAHEDRON
			
			collider.shape = generate_shape_from_mesh(MESH_TETRAHEDRON)
		2:
			mesh.mesh = MESH_OCTAHEDRON
			mesh.material_override = MAT_OCTAHEDRON
			
			collider.shape = generate_shape_from_mesh(MESH_OCTAHEDRON)
		#3:
			#mesh.mesh = SphereMesh.new()
			#mesh.material_override = MAT_OCTAHEDRON
			#
			#collider.shape = SphereShape3D.new()
