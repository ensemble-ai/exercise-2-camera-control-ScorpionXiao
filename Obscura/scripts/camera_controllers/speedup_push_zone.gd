class_name PushZone
extends CameraControllerBase

@export var push_ratio:float = 30
@export var pushbox_top_left:Vector2 = Vector2(-20, -20) #outer box
@export var pushbox_bottom_right:Vector2 = Vector2(20, 20)
@export var speedup_zone_top_left:Vector2 = Vector2(-6, -6) #inner box
@export var speedup_zone_bottom_right:Vector2 = Vector2(6, 6)

var is_touch_outer: bool = false
var is_touch_inner:bool = false
var is_btw: bool = false
var is_move: bool = false

var previous_position: Vector3
var movement_direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	super()
	global_position = target.global_position + Vector3(0, dist_above_target, 0)


func _process(delta: float) -> void:
	if !current:
		return
	
	is_move = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")
	
	var inner_box_width = abs(speedup_zone_top_left.x - speedup_zone_bottom_right.x)
	var inner_box_height = abs(speedup_zone_top_left.y - speedup_zone_bottom_right.y)
	var outer_box_width = abs(pushbox_top_left.x - pushbox_bottom_right.x)
	var outer_box_height = abs(pushbox_top_left.y - pushbox_bottom_right.y)
	
	var tpos = target.global_position
	var cpos = global_position #camera
	
	var inner_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - inner_box_width / 2.0)
	var inner_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + inner_box_width / 2.0)
	var inner_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - inner_box_height / 2.0)	
	var inner_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + inner_box_height / 2.0)
	#outer box
	#boundary checks
	var outer_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - outer_box_width / 2.0)
	var outer_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + outer_box_width / 2.0)
	var outer_diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - outer_box_height / 2.0)	
	var outer_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + outer_box_height / 2.0)
	
	is_move = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")
	
	if inner_diff_between_left_edges < 0 or inner_diff_between_right_edges > 0 or inner_diff_between_top_edges < 0 or inner_diff_between_bottom_edges > 0:
		is_touch_inner = true
	else:
		is_touch_inner = false
	
	if outer_diff_between_left_edges < 0 or outer_diff_between_right_edges > 0 or outer_diff_between_top_edges < 0 or outer_diff_between_bottom_edges > 0:
		is_touch_outer = true
	else:
		is_touch_outer = false
	
	if is_touch_inner and not is_touch_outer:
		is_btw = true
	else:
		is_btw = false
		
	var current_position = target.global_position
	movement_direction = (current_position - previous_position).normalized()
	previous_position = current_position
		
	if is_touch_outer:
		if outer_diff_between_left_edges < 0:
			global_position.x += outer_diff_between_left_edges
			global_position.z += movement_direction.z * push_ratio * delta
		if outer_diff_between_right_edges > 0:
			global_position.x += outer_diff_between_right_edges
			global_position.z += movement_direction.z * push_ratio * delta
		if outer_diff_between_top_edges < 0:
			global_position.z += outer_diff_between_top_edges
			global_position.x += movement_direction.x * push_ratio * delta
		if outer_diff_between_bottom_edges > 0:
			global_position.z += outer_diff_between_bottom_edges
			global_position.x += movement_direction.x * push_ratio * delta
	if is_btw and is_move:
		global_position += movement_direction * push_ratio * delta

	if draw_camera_logic:
		draw_logic()
	super(delta)
	

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var inner_box_width:float = abs(speedup_zone_top_left.x - speedup_zone_bottom_right.x)
	var inner_box_height:float = abs(speedup_zone_top_left.y - speedup_zone_bottom_right.y)
	var inner_left:float = -inner_box_width / 2
	var inner_right:float = inner_box_width / 2
	var inner_top:float = -inner_box_height / 2
	var inner_bottom:float = inner_box_height / 2
	
	var outer_box_width:float = abs(pushbox_top_left.x - pushbox_bottom_right.x)
	var outer_box_height:float = abs(pushbox_top_left.y - pushbox_bottom_right.y)
	var outer_left:float = -outer_box_width / 2
	var outer_right:float = outer_box_width / 2
	var outer_top:float = -outer_box_height / 2
	var outer_bottom:float = outer_box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_bottom))
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_top))
	
	immediate_mesh.surface_add_vertex(Vector3(inner_left, 0, inner_top))
	immediate_mesh.surface_add_vertex(Vector3(inner_right, 0, inner_top))
	
	immediate_mesh.surface_add_vertex(Vector3(outer_right, 0, outer_top))
	immediate_mesh.surface_add_vertex(Vector3(outer_right, 0, outer_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(outer_right, 0, outer_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_left, 0, outer_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(outer_left, 0, outer_bottom))
	immediate_mesh.surface_add_vertex(Vector3(outer_left, 0, outer_top))
	
	immediate_mesh.surface_add_vertex(Vector3(outer_left, 0, outer_top))
	immediate_mesh.surface_add_vertex(Vector3(outer_right, 0, outer_top))
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
