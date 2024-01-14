extends Node2D

signal current_action_changed(action)
signal current_state_changed(state)

enum State {
    HAPPY,
    ILL,
    NORMAL,
    POORCONDITION
}

enum Action {
    DEFAULT,
    DRINK,
    EAT,
    GIFT,
    IDLE,
    MOVE,
    MUSIC,
    PINCH,
    RAISED,
    SAY,
    SHUTDOWN,
    SLEEP,
    STARTUP,
    STATE,
    SWITCH,
    THINK,
    TOUCHBODY,
    TOUCHHEAD,
    WORK
}

@onready var animation_player = $AnimationPlayer

@export var current_action = Action.STARTUP:
    set(value):
        if current_action != value:
            current_action = value
            current_action_changed.emit(value)
            pass

@export var current_state = State.NORMAL:
    set(value):
        if current_state != value:
            current_state = value
            current_state_changed.emit(value)
            pass

func _ready():
    connect("current_action_changed", _on_current_action_changed)
    start_up(current_state)
    
    randomize()
    pass


func _on_current_action_changed(action):
    match action:
        Action.DEFAULT: default(current_state)
        Action.DRINK:   pass
        Action.EAT:     pass
        Action.GIFT:    pass
        Action.IDLE:    pass
        Action.MOVE:    pass
        Action.MUSIC:   pass
        Action.PINCH:   pass
        Action.RAISED:  pass
        Action.SAY:     pass
        Action.SHUTDOWN:pass
        Action.SLEEP:   pass
        Action.STARTUP: start_up(current_state)
        Action.STATE:   pass
        Action.SWITCH:  pass
        Action.THINK:   pass
        Action.TOUCHBODY:pass
        Action.TOUCHHEAD:pass
        Action.WORK:    pass
    pass


func default(state :State):
    match state:
        State.HAPPY:            play_animation("default", "happy")
        State.ILL:              play_animation("default", "ill")
        State.NORMAL:           play_animation("default", "normal")
        State.POORCONDITION:    play_animation("default", "poorcondition")
    pass


func start_up(state :State):
    match state:
        State.HAPPY:            play_animation("startup", "happy")
        State.ILL:              play_animation("startup", "ill")
        State.NORMAL:           play_animation("startup", "normal")
        State.POORCONDITION:    play_animation("startup", "poorcondition")
    pass


var _lists      :Array
var _lists_full :Array

func play_animation(action_name :String, state_name :String):
    # Get the number of animations
    var num
    for i in range(1, 4):
        if animation_player.has_animation(action_name + "_" + state_name + "_" + str(i)):
            num = i
    
    # Check _lists and _lists_full
    if _lists_full != range(1, num + 1):
        _lists_full = range(1, num + 1)
        _lists = []
    
    if _lists.is_empty():
        _lists = range(1, num + 1)
        _lists.shuffle()
    
    # Play animations randomly
    var random = _lists.pop_back()
    animation_player.play(action_name + "_" + state_name + "_" + str(random))
    pass


func _on_animation_finished(anim_name):
    match anim_name:
        var value when value.contains("startup"):
            current_action = Action.DEFAULT
    pass
