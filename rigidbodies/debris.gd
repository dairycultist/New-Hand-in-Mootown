extends RigidBody3D

const CUBE_MESH = preload("res://rigidbodies/cube.obj")
const DODEC_MESH = preload("res://rigidbodies/dodecahedron.obj")

const MATERIAL = preload("res://rigidbodies/debris.tres")

func _ready() -> void:
	
	var rand = RandomNumberGenerator.new()
	
	var mesh := MeshInstance3D.new()
	var collider := CollisionShape3D.new()
	add_child(mesh)
	add_child(collider)
	
	var unique_material = MATERIAL.duplicate()
	unique_material.albedo_color = Color.from_ok_hsl(rand.randf(), 0.7, 0.7, 1.0)
	mesh.material_override = unique_material
	
	mass = 5
	
	match rand.randi_range(0, 3):
		0:
			mesh.mesh = CapsuleMesh.new()
			collider.shape = CapsuleShape3D.new()
			
			mass = 10
		1:
			mesh.mesh = SphereMesh.new()
			collider.shape = SphereShape3D.new()
		2:
			mesh.mesh = CUBE_MESH
			collider.shape = BoxShape3D.new()
		3:
			mesh.mesh = DODEC_MESH
			
			var shape := ConvexPolygonShape3D.new()
			shape.points = DODEC_MESH.surface_get_arrays(0)[0]
			collider.shape = shape
			
			mass = 20
