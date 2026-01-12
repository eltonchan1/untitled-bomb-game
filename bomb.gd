extends RigidBody3D

@export var explosion_force = 2.5
@export var explosion_radius = 5.0
@export var fuse_time = 2.0
@export var explode_on_contact = true

var timer = 0.0
var has_exploded = false

func _ready():
	# physics settings
	gravity_scale = 1.0
	
	# monitoring for collisions
	contact_monitor = true
	max_contacts_reported = 5
	
	# contact detection
	body_entered.connect(_on_body_entered)

func _process(delta):
	if has_exploded:
		return
		
	timer += delta
	if timer >= fuse_time:
		explode()

func _on_body_entered(body):
	if has_exploded:
		return
	if explode_on_contact:
		explode()

func explode():
	# find all players
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsShapeQueryParameters3D.new()
	var sphere = SphereShape3D.new()
	sphere.radius = explosion_radius
	query.shape = sphere
	query.transform = global_transform
	
	var results = space_state.intersect_shape(query)
	
	for result in results:
		var body = result.collider
		if body.has_method("apply_knockback"):
			var direction = (body.global_position - global_position).normalized()
			body.apply_knockback(direction, explosion_force)
	
	queue_free()
