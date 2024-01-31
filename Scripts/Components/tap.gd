extends Node2D

class_name Tap;

var tap_particle := preload("res://Scenes/tap_particle.tscn");

func tap(event: InputEvent) -> void:
	var new_text := tap_particle.instantiate();
	new_text.position = event.position + Vector2(randf_range(-5.0, 5.0), -25.0);
	add_child(new_text);
	#if inbetween_tap_timer.time_left > 0.0:
	Global.tap_counter += 1;
	Global.is_tap_hold = true;
	#tap_song.play();
	
	Events.emit_signal("tap");
	start_tap_timer();

func start_tap_timer() -> void:
	Events.emit_signal("start_tap_timer");
