extends "floating_body.gd"

const MESH_CUBE = preload("res://rigidbodies/chip_cube.obj")
const MESH_TETRAHEDRON = preload("res://rigidbodies/chip_tetrahedron.obj")

const MAT_CUBE = preload("res://rigidbodies/chip_cube.tres")
const MAT_TETRAHEDRON = preload("res://rigidbodies/chip_tetrahedron.tres")

func _ready() -> void:
	
	var rand = RandomNumberGenerator.new()
	
	var mesh := MeshInstance3D.new()
	var collider := CollisionShape3D.new()
	add_child(mesh)
	add_child(collider)
	
	#mesh.mesh = SphereMesh.new()
	#collider.shape = SphereShape3D.new()
	
	mass = 1
	
	match rand.randi_range(0, 1):
		0:
			mesh.mesh = MESH_CUBE
			var coll := BoxShape3D.new()
			coll.size = Vector3(2.0/3, 2.0/3, 2.0/3)
			collider.shape = coll
			mesh.material_override = MAT_CUBE
		1:
			mesh.mesh = MESH_TETRAHEDRON
			
			var shape := ConvexPolygonShape3D.new()
			shape.points = MESH_TETRAHEDRON.surface_get_arrays(0)[0]
			collider.shape = shape
			mesh.material_override = MAT_TETRAHEDRON
