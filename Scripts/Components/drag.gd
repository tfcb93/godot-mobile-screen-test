extends Node2D;

class_name Drag;

@export_category("Drag Properties")
@export var drag_sensibility := 1;
@export var swap_sensibility := 100;

var drag_particle := preload("res://Scenes/drag_particle.tscn");

func drag(event: InputEvent) -> void:
	#drag_sprite.position = event.position + Vector2(0.0, -25.0);
	#drag_sprite.visible = true;
	
	var new_drag := drag_particle.instantiate();
	add_child(new_drag);
	new_drag.position = event.position;
	
	#print(event.position, event.relative);
	direction(event.relative);

func direction(relative: Vector2) -> void:
	if relative.x > drag_sensibility:
		print("right");
	elif(relative.x < drag_sensibility * -1): #if I use else, it will grab any other value as "left"
		print("left");
	else:
		print("idle");
		
	if(relative.x > swap_sensibility):
		print("swap right");
	elif (relative.x < (swap_sensibility * -1)):
		print("swap left");
