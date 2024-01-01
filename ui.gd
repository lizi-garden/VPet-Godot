extends CanvasLayer

@onready var timer = $Timer
@onready var dock = $Dock
@onready var animation_player = $AnimationPlayer

var viewport_size   :Vector2

func _ready():
    viewport_size = get_viewport().size
    dock.set_deferred("size", Vector2(float(viewport_size.x), float(viewport_size.y)/5))
    dock.set_deferred("position", Vector2(0, float(viewport_size.y)*4/5))
    pass


func _unhandled_input(_event):
    animation_player.play("RESET")
    timer.start()


func _on_timer_timeout():
    animation_player.play("fade_out")
    pass
