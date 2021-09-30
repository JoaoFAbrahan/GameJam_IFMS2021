extends Area2D

func _on_Life_Item_body_entered(body):
	body.Heal(12);
	body.HealthBar.Health_Update(body.health, -20);
	$FruitCollect_SFX.play();
	$AnimationPlayer.play(("Collected"));

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free();
