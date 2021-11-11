extends Camera2D

const MOVE_SPEED = 1.0
const ROTATE_SPEED = 0.15

var middle_pressed = false
var right_pressed = false

func _unhandled_input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if event.pressed:
				zoom *= 1.0/1.1
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if event.pressed:
				zoom *= 1.1/1.0
		elif event.button_index == BUTTON_MIDDLE:
			middle_pressed = event.pressed
		elif event.button_index == BUTTON_RIGHT:
			right_pressed = event.pressed
			if not event.pressed:
				var rot = round(rotation_degrees/60.0) * 60
				$Tween.interpolate_property(self,"rotation_degrees",null,rot,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
				$Tween.start()
				gl.camera_rot = rot
	
	elif event is InputEventMouseMotion:
		if middle_pressed:
			position -= MOVE_SPEED * event.relative.rotated(rotation) * zoom
		if right_pressed:
			rotation_degrees += ROTATE_SPEED * event.relative.x
