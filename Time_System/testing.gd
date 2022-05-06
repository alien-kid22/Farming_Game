extends Control

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	$hour.text = str(Time.hour)
	$minutes.text = str(Time.minute)
	$seconds.text = str(Time.second)
	$days.text = str(Time.day)
	$months.text = str(Time.month)
	$years.text = str(Time.year)
