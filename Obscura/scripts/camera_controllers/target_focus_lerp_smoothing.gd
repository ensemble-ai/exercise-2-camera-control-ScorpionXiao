class_name TargetFocus
extends CameraControllerBase

@export var lead_speed:float = 1.2 #camera speed ratio faster than vessel
@export var catchup_speed:float = 100 #camera move back to vessel when vessel stop
@export var leash_distance:float = 12
@export var catchup_delay_duration:float = 0.2

var vc_distance #distance btw vessel and camera
var is_move:bool = false

func _ready() -> void:
	super()
	global_position = target.global_position + Vector3(0, dist_above_target, 0)

func _process(delta: float) -> void:
	if !current:
		return
	
	var camera_pos = global_position
	var vessel_pos = target.global_position
	var camera_speed: Vector3 = Vector3(0, 0, 0)
	
	vc_distance = target.global_position.distance_to(global_position)
	is_move = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")

	if vc_distance <= leash_distance:
		if is_move:
			camera_pos.x += target.velocity.x * lead_speed * delta
			camera_pos.z += target.velocity.z * lead_speed * delta
			global_position = camera_pos
			
	elif vc_distance > leash_distance:
		if is_move:
			camera_pos.x += target.velocity.x * delta
			camera_pos.z += target.velocity.z * delta
			global_position = camera_pos
	#set timer
	if not is_move:
		catchup_delay_duration -= delta
		if catchup_delay_duration <= 0:
			global_position = global_position.lerp(target.global_position, catchup_speed * delta / vc_distance)
	else:
		catchup_delay_duration = 0.2
	print(catchup_delay_duration)
	
	
	
	
	
	if draw_camera_logic:
		draw_logic()
	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
