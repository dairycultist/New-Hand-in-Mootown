extends RigidBody3D

@export var mesh : MeshInstance3D
@export var collider : CollisionShape3D

const CUBE_MESH = preload("res://rigidbodies/cube.obj")
const DODEC_MESH = preload("res://rigidbodies/dodecahedron.obj")

func _ready() -> void:
	
	mass = 10
	
	match RandomNumberGenerator.new().randi_range(0, 3):
		0:
			mesh.mesh = CapsuleMesh.new()
			collider.shape = CapsuleShape3D.new()
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
