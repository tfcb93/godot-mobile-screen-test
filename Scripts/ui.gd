extends Control;

@onready var tap_counter := $"HBoxContainer/HBoxContainer/Taps/Taps Counter";
@onready var combo_container := $HBoxContainer/Combo;
@onready var combo_counter := $"HBoxContainer/Combo/Combo Counter";
@onready var top_combo_counter := $"HBoxContainer/HBoxContainer/Top Combo/Top Combo Counter";

func _ready() -> void:
	combo_container.visible = false;
	Events.connect("tap", _on_tap);
	Events.connect("increase_combo", _on_increase_combo);
	Events.connect("drop_combo", _on_drop_combo);
	
func  _on_tap() -> void:
	tap_counter.text = str(Global.tap_counter);

func _on_increase_combo() -> void:
	if (Global.combo >= 10):
		combo_container.visible = true;
	combo_counter.text = str(Global.combo);
	
func _on_drop_combo() -> void:
	combo_container.visible = false;
	top_combo_counter.text = str(Global.top_combo); 
