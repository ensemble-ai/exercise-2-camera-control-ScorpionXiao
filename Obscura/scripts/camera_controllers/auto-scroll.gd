class_name AutoScroll
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(-10, -5)
@export var bottom_right: Vector2 = Vector2(10, 5)
@export var autoscroll_speed: Vector3 = Vector3(5, 0, 0)
var frame_position: Vector3

func _ready() -> void:
	super()
	global_position = target.global_position + Vector3(0, dist_above_target, 0)
	

func _process(delta: float) -> void:
	if !current:
		return
	
	frame_position.x += autoscroll_speed.x * delta
	frame_position.z += autoscroll_speed.z * delta

	var min_x = frame_position.x + top_left.x
	var max_x = frame_position.x + bottom_right.x
	var min_z = frame_position.z + top_left.y
	var max_z = frame_position.z + bottom_right.y
			
	global_position = frame_position
	
	#global_position = camera
	#target.global_position = vessel
	
	if target.global_position.x <= min_x:
		target.global_position.x = min_x
	elif target.global_position.x >= max_x:
		target.global_position.x = max_x
	
	if target.global_position.z <= min_z:
		target.global_position.z = min_z
	elif target.global_position.z >= max_z:
		target.global_position.z = max_z
		
	target.global_position.x += autoscroll_speed.x * delta
	target.global_position.z += autoscroll_speed.z * delta
	
	#print(global_position)
	#print(target.global_position)
	#print(target.velocity)
	#print(min_x)
	#print(max_x)
	
		
	if draw_camera_logic:
		draw_logic()
		
	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	#immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	#immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	#immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))
	#
	#immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
