extends CanvasLayer

func _ready():
	$Movement.show()
	$MessageTimer.start()
	$Hoe.hide()
	$Plant.hide()
	$Water.hide()
	$ColorRect1.show()
	$ColorRect2.hide()
	$ColorRect3.hide()
	$ColorRect4.hide()
	
func _on_MessageTimer_timeout():
	$Movement.hide()
	$ColorRect1.hide()
	$MessageTimer2.start()
	$Hoe.show()
	$ColorRect2.show()

func _on_MessageTimer2_timeout():
	$Hoe.hide()
	$ColorRect2.hide()
	$MessageTimer3.start()
	$Plant.show()
	$ColorRect3.show()

func _on_MessageTimer3_timeout():
	$Plant.hide()
	$ColorRect3.hide()
	$MessageTimer4.start()
	$Water.show()
	$ColorRect4.show()

func _on_MessageTimer4_timeout():
	$Water.hide()
	$ColorRect4.hide()
