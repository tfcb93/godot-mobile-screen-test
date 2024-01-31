extends Area2D

@export_category("Touch Area")
@export_range(5,90,5) var reduced_width_percentage := 10;
@export_range(5,90,5) var reduced_height_percentage := 10;

@export_subgroup("Functions")
@export var tap_function : Tap;
@export var untap_function : Untap;
@export var drag_function : Drag;

@onready var collision_shape := $Collision;
@onready var sprite := $Sprite;

var screen_size: Vector2;
var screen_center: Vector2;

# Ready functions ---- start

func _ready() -> void:
	# Initializing necessary variables
	screen_size = get_viewport_rect().size;
	screen_center = screen_size / 2;
	
	expand_width();
	expand_height();
	center_position();
	
	input_pickable = true;

func expand_width() -> void:
	collision_shape.shape.size.x = screen_size.x - ((screen_size.x * reduced_width_percentage)/100);
	sprite.scale.x = collision_shape.shape.size.x / sprite.texture.get_width();

func expand_height() -> void:
	collision_shape.shape.size.y = screen_size.y - ((screen_size.y * reduced_height_percentage)/100);
	sprite.scale.y = collision_shape.shape.size.y / sprite.texture.get_height();
	
func center_position() -> void:
	position = screen_center;


# Input functions --- Start

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() and tap_function:
			tap_function.tap(event);
		elif event.is_released() and untap_function:
			untap_function.untap(event);
	if event is InputEventScreenDrag:
		if drag_function:
			drag_function.drag(event);
