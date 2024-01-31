extends Node2D;

var tap_particle := preload("res://Scenes/tap_particle.tscn");
var untap_particle := preload("res://Scenes/untap_particle.tscn");
var drag_particle := preload("res://Scenes/drag_particle.tscn");
#@onready var drag_particle := $"Drag Particle";

@onready var c_rect := $ColorRect;
@onready var drag_sprite := $Drag_Sprite;
@onready var display_tap_timer := $"Tap Display Timer";
@onready var test_text := $"Test Text";
@onready var tap_song := $tap_song;
@onready var tap_counter_text := $"Tap Counter";
@onready var inbetween_tap_timer := $"Inbetween Tap Timer";

var screen_size: Vector2;
var screen_center: Vector2;
var tap_hold_time := 0.0;
var is_tap_hold := false;
var tap_counter := 0;

func _ready() -> void:
	screen_size = get_viewport_rect().size;
	screen_center = screen_size / 2;
	c_rect.size = screen_size;
	c_rect.color = Color.MAGENTA;
	
	var dtt_half_size = display_tap_timer.size / 2
	display_tap_timer.position = screen_center - dtt_half_size;
	
	display_tap_timer.scale = Vector2.ZERO;
	
	set_pivot_to_screen_center();
	
	drag_sprite.visible = false;
	
	
func _draw() -> void:
	var size = get_viewport_rect().size;
	draw_line(Vector2(size.x/2, 0),Vector2(size.x/2, size.y),Color.BLACK, 3.0);
	draw_line(Vector2(0, size.y / 2),Vector2(size.x, size.y / 2),Color.BLACK, 3.0);
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		drag_sprite.position = event.position + Vector2(0.0, -25.0);
		drag_sprite.visible = true;
		
		#var new_drag := drag_particle.instantiate();
		#add_child(new_drag);
		#new_drag.position = event.position;
		
		if is_tap_hold:
			clear_timer();
			is_tap_hold = false;
	elif event is InputEventScreenTouch:
		if event.is_pressed():
			add_new_text_particle("tap", event.position);
			is_tap_hold = true;
			tap_song.play();
		#if event.is_double_tap():
			#print("double tap");
		if event.is_released():
			add_new_text_particle("untap", event.position);
			if is_tap_hold:
				clear_timer();
			
			drag_sprite.visible = false;
	elif event is InputEventPanGesture:
		test_text.text = "PAN";
	elif event is InputEventMagnifyGesture:
		test_text.text = "MAGNIFY";
	elif event is InputEventGesture:
		test_text.text = "GESTURE";
		
	
func _process(delta: float) -> void:
	if is_tap_hold:
		tap_hold_time += delta;
		if display_tap_timer.scale < Vector2(5.0, 5.0):
			display_tap_timer.scale += Vector2(0.01, 0.01);
	display_tap_timer.text = "%02d:%02d:%03d" % [tap_hold_time/60.0, fmod(tap_hold_time, 60.0), fmod(tap_hold_time, 1.0) * 100];
	
	
func clear_timer() -> void:
	tap_hold_time = 0.0;
	display_tap_timer.text = "%02d:%02d:%03d" % [0.0,0.0,0.0];
	is_tap_hold = false;
	display_tap_timer.scale = Vector2.ZERO;
	tap_song.stop();
	test_text.text = "";
	
func add_new_text_particle(type: String, position: Vector2) -> void:
	var new_text: Node;
	match(type):
		"tap":
			new_text = tap_particle.instantiate();
			new_text.position = position + Vector2(randi_range(-5.0, 5.0), -25.0);
			if inbetween_tap_timer.time_left > 0.0:
				tap_counter += 1;
				tap_counter_text.text = tap_counter;
		"untap":
			new_text = untap_particle.instantiate();
			new_text.position = position + Vector2(randi_range(-5.0, 5.0), 25.0);
		_:
			pass;
	add_child(new_text);

func set_pivot_to_screen_center() -> void:
	# display_tap_timer
	display_tap_timer.position = screen_center - display_tap_timer.size / 2;
	display_tap_timer.pivot_offset = display_tap_timer.size / 2;

	# Test Texts
	test_text.position = screen_center - test_text.size / 2;
	test_text.pivot_offset = test_text.size / 2;

