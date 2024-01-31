extends Node2D;

@export var combo_limit_time := 2.0;

var combo_counter_method := "idle" # should be an enum;
var tap_timer := 0.0;
var untap_timer := 0.0;

func _ready() -> void:
	Events.connect("start_tap_timer", _on_start_tap_timer);
	Events.connect("start_untap_timer", _on_start_untap_timer);
	
func _process(delta: float) -> void:
	if (combo_counter_method != "idle"):
		if combo_counter_method == "tap":
			tap_timer += delta;
			if(tap_timer >= combo_limit_time):
				drop_combo();
		elif combo_counter_method == "untap":
			untap_timer += delta;
			if(untap_timer >= combo_limit_time):
				drop_combo();
	
func _on_start_tap_timer() -> void:
	tap_timer = 0.0;
	combo_counter_method = "tap";
	
	Global.combo += 1;
	Events.emit_signal("increase_combo")

func _on_start_untap_timer() -> void:
	print(untap_timer);
	untap_timer = 0.0;
	combo_counter_method = "untap";

func drop_combo() -> void:
	combo_counter_method = "idle";
	if Global.combo > Global.top_combo:
		Global.top_combo = Global.combo;
	Global.combo = 0;
	Events.emit_signal("drop_combo");
