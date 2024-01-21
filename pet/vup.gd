extends Node2D

# signal
################################################################################

signal current_mood_changed(mood)
signal current_action_changed(action)

# enum
################################################################################
enum Mood {
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
    RAISED_STOP,
    RAISED_MOVING, 
    SAY,
    SHUTDOWN,
    SLEEP,
    STARTUP,
    STATE,
    SWITCH,
    THINK,
    TOUCHBODY,
    HAPPYTURN,
    TOUCHHEAD,
    WORK
}

enum Mode {
    GENERAL,
    FSM
}

# onready
################################################################################
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_back = $AnimatedSprite2D/Layer1
@onready var eat_food_sprite = $AnimatedSprite2D/Layer2
@onready var animated_sprite_front = $AnimatedSprite2D/Layer3
@onready var fsm = $FSM


# export
################################################################################

@export var current_mood :Mood = Mood.NORMAL:
    set(value):
        if current_mood != value:
            current_mood = value
            current_mood_changed.emit(value)

@export var current_action :Action = Action.STARTUP:
    set(value):
        if current_action != value:
            current_action = value
            current_action_changed.emit(value)


# methods
################################################################################

func eat(food :Texture2D):
    if food:
        eat_food_sprite.texture = food
    
    current_action = Action.EAT
    animation_player.stop(true)
    eat_set_play(current_mood)


func shutdown():
    current_action = Action.SHUTDOWN


func raised_stop(start :bool = true):
    if start:
        current_action = Action.RAISED_STOP
    else:
        current_action = Action.RAISED_STOP
        fsm.change_state_to("end")


func raised_moving():
    current_action = Action.RAISED_MOVING


func startup():
    current_action = Action.STARTUP


func touch_body(start :bool = true):
    if current_action == Action.HAPPYTURN:
        return
    
    if start:
        current_action = Action.TOUCHBODY
    else:
        current_action = Action.TOUCHBODY
        fsm.change_state_to("end")


func happy_turn(start :bool = true):
    if current_mood == Mood.HAPPY:
        if start:
            current_action = Action.HAPPYTURN
        else:
            current_action = Action.HAPPYTURN
            fsm.change_state_to("end")
    else:
        touch_body(start)


func touch_head(start :bool = true):
    if start:
        current_action = Action.TOUCHHEAD
    else:
        current_action = Action.TOUCHHEAD
        fsm.change_state_to("end")


# ready
################################################################################
func _ready():
    connect("current_action_changed", _on_current_action_changed)
    fsm.connect("_enter", _on_fsm_entered)

    start_up_set_play(current_mood)
    randomize()


func _on_current_action_changed(action :Action):
    match action:
        Action.DEFAULT:         default_set_play(current_mood)
        Action.DRINK:           pass
        Action.EAT:             eat_set_play(current_mood)
        Action.GIFT:            pass
        Action.IDLE:            pass
        Action.MOVE:            pass
        Action.MUSIC:           pass
        Action.PINCH:           pass
        Action.RAISED_STOP:     fsm.change_state_to("play")
        Action.RAISED_MOVING:   raised_moving_set_play(current_mood)
        Action.SAY:             pass
        Action.SHUTDOWN:        shutdown_set_play(current_mood)
        Action.SLEEP:           pass
        Action.STARTUP:         start_up_set_play(current_mood)
        Action.STATE:           pass
        Action.SWITCH:          pass
        Action.THINK:           pass
        Action.TOUCHBODY:       fsm.change_state_to("play")
        Action.HAPPYTURN:       fsm.change_state_to("play")
        Action.TOUCHHEAD:       fsm.change_state_to("play")
        Action.WORK:            pass


func default_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("default", "happy")
        Mood.ILL:              play_animation("default", "ill")
        Mood.NORMAL:           play_animation("default", "normal")
        Mood.POORCONDITION:    play_animation("default", "poorcondition")


func eat_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("eat", "happy")
        Mood.ILL:              play_animation("eat", "ill")
        Mood.NORMAL:           play_animation("eat", "normal")
        Mood.POORCONDITION:    play_animation("eat", "poorcondition")


func raised_stop_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("raised_stop", "happy", Mode.FSM)
        Mood.ILL:              play_animation("raised_stop", "ill", Mode.FSM)
        Mood.NORMAL:           play_animation("raised_stop", "normal", Mode.FSM)
        Mood.POORCONDITION:    play_animation("raised_stop", "poorcondition", Mode.FSM)


func raised_moving_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("raised_moving", "happy")
        Mood.ILL:              play_animation("raised_moving", "ill")
        Mood.NORMAL:           play_animation("raised_moving", "normal")
        Mood.POORCONDITION:    play_animation("raised_moving", "poorcondition")


func shutdown_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("shutdown", "happy")
        Mood.ILL:              play_animation("shutdown", "ill")
        Mood.NORMAL:           play_animation("shutdown", "normal")
        Mood.POORCONDITION:    play_animation("shutdown", "poorcondition")


func start_up_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("startup", "happy")
        Mood.ILL:              play_animation("startup", "ill")
        Mood.NORMAL:           play_animation("startup", "normal")
        Mood.POORCONDITION:    play_animation("startup", "poorcondition")


func touch_body_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("touch_body", "happy", Mode.FSM)
        Mood.ILL:              play_animation("touch_body", "ill", Mode.FSM)
        Mood.NORMAL:           play_animation("touch_body", "normal", Mode.FSM)
        Mood.POORCONDITION:    play_animation("touch_body", "poorcondition", Mode.FSM)


func happy_turn_set_play():
    play_animation("touch_body", "happy_turn", Mode.FSM)


func touch_head_set_play(mood :Mood):
    match mood:
        Mood.HAPPY:            play_animation("touch_head", "happy", Mode.FSM)
        Mood.ILL:              play_animation("touch_head", "ill", Mode.FSM)
        Mood.NORMAL:           play_animation("touch_head", "normal", Mode.FSM)
        Mood.POORCONDITION:    play_animation("touch_head", "poorcondition", Mode.FSM)


var _suffix := "_c"
var random_gen
var random_fsm

func play_animation(action_name :String, mood_name :String, mode :Mode = Mode.GENERAL):
    
    # General Mode
    if mode == Mode.GENERAL:
        # Get the number of animations
        var num
        for i in range(1, 4):
            if animation_player.has_animation(action_name + "_" + mood_name + "_" + str(i)):
                num = i

        # If animation is not exist
        if num == null:
            print(action_name + " animation in " + mood_name + " is not exist")
            return

        # Play animations randomly
        random_gen = get_random(num)
        animation_player.play(action_name + "_" + mood_name + "_" + str(random_gen))
    
    
    # FSM Mode
    if mode == Mode.FSM:     
        # Get the number of animations
        var num
        for i in range(1, 4):
            if animation_player.has_animation(action_name + "_" + mood_name + "_" + "tb" + str(i) + _suffix):
                num = i

        # If animation is not exist
        if num == null:
            print(action_name + "_" + mood_name + "_" + "tb1"  + _suffix + " is not exist")
            return
        
        # Play animations randomly
        if random_fsm == null:
            random_fsm = get_random(num)
        
        animation_player.play(action_name + "_" + mood_name + "_" + "tb" + str(random_fsm) + _suffix)


# shuffle bag
################################################################################
var _lists      :Array
var _lists_full :Array

func get_random(num :int):
    # Check _lists and _lists_full
    if _lists_full != range(1, num + 1):
        _lists_full = range(1, num + 1)
        _lists = []
    
    if _lists.is_empty():
        _lists = range(1, num + 1)
        _lists.shuffle()
    
    return _lists.pop_back()


# AnimationPlayer
################################################################################
func _on_animation_finished(anim_name :String):
    match anim_name:
        var value when value.contains("startup"):
            current_action = Action.DEFAULT
        var value when value.contains("shutdown"):
            get_tree().quit()
        var value when value.contains("eat"):
            current_action = Action.DEFAULT
        var value when value.contains("_a"):
            fsm.change_state_to("stay")
        var value when value.contains("_c"):
            current_action = Action.DEFAULT
            fsm.change_state_to("empty")


# FSM
################################################################################

func _on_fsm_entered(to):
    match to:
        "play":     _suffix = "_a"
        "stay":     _suffix = "_b"
        "end":      _suffix = "_c"
    
    match current_action:
        Action.RAISED_STOP:     raised_stop_set_play(current_mood)
        Action.TOUCHBODY:       touch_body_set_play(current_mood)
        Action.HAPPYTURN:       happy_turn_set_play()
        Action.TOUCHHEAD:       touch_head_set_play(current_mood)
