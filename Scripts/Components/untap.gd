extends Node2D

class_name Untap;

var untap_particle := preload("res://Scenes/untap_particle.tscn");

func untap(event: InputEvent) -> void:
	var new_text := untap_particle.instantiate();
	new_text.position = event.position + Vector2(randf_range(-5.0, 5.0), 25.0);
	add_child(new_text);
	Global.is_tap_hold = false;
	start_untap_timer();

func start_untap_timer() -> void:
	Events.emit_signal("start_untap_timer");
