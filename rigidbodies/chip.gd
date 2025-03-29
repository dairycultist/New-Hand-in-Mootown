extends "floating_body.gd"

const MESH_CUBE = preload("res://rigidbodies/chip_cube.obj")
const MESH_TETRAHEDRON = preload("res://rigidbodies/chip_tetrahedron.obj")

const MATERIAL = preload("res://rigidbodies/chip_tetrahedron.tres")

func _ready() -> void:
	
	var rand = RandomNumberGenerator.new()
	
	var mesh := MeshInstance3D.new()
	var collider := CollisionShape3D.new()
	add_child(mesh)
	add_child(collider)
	
	#mesh.mesh = SphereMesh.new()
	#collider.shape = SphereShape3D.new()
	
	mesh.material_override = MATERIAL
	
	mass = 1
	
	match rand.randi_range(0, 1):
		0:
			mesh.mesh = MESH_CUBE
			collider.shape = BoxShape3D.new()
		1:
			mesh.mesh = MESH_TETRAHEDRON
			
			var shape := ConvexPolygonShape3D.new()
			shape.points = MESH_TETRAHEDRON.surface_get_arrays(0)[0]
			collider.shape = shape
