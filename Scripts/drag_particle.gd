extends GPUParticles2D;

func _ready() -> void:
	emitting = true; # due to the nature of the lifetime, I need to set emmiting true before it comes in

func _on_finished() -> void:
	queue_free();
