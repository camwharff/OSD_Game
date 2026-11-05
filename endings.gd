extends Node

func generate_description() -> String:
	return sat_text() + perf_text() + work_text() + dinner_text() + tidy_text() + "and your cat " + cat_text() + energy_text()

func sat_text():
	var satisfaction = GameState.satisfaction
	return "You don't know how you feel about your day. "

func perf_text():
	var performance = GameState.performance
	return "You don't know how you performed at work. "

func work_text():
	return "You don't know if you got promoted, or if you even still have a job. "

func dinner_text():
	return "You don't know what you did for dinner, or who was there. "

func tidy_text():
	var tidiness = GameState.tidiness
	if tidiness < -2:
		return "You got home to a filthy apartment, "
	elif tidiness >= -2 and tidiness <= 4:
		return "Your apartment was just clean enough to feel comfortable, "
	else:
		return "Your apartment was immaculate when you got home, "

func cat_text():
	if GameState.flags.has("pet-cat") and GameState.flags.has("clean-litter") and GameState.flags.has("feed-cat"):
		return "greeted you ecstatically at the door and settled down with you for a good night sleep. "
	elif GameState.flags.has("clean-litter") and GameState.flags.has("feed-cat"):
		return "greeted you happily at the door, then meowed at you for attention all night. "
	elif GameState.flags.has("clean-litter"):
		return "greeted you at the door, then meowed at you for attention and food all night. "
	elif GameState.flags.has("feed-cat"):
		return "greeted you at the door, then meowed at you for attention and sat next to its litter box all night. "
	else:
		return "ignored you all night, hiding under the bed until breakfast. "

func energy_text():
	var energy = GameState.energy
	if energy < -3:
		return "You fell into bed exhausted, dreading tomorrow."
	elif energy >= -3 and energy <= 3:
		return "You had a long day, and were too tired to do anything fun before getting in bed."
	else:
		return "You felt energized after a day of hard work, and spent some time enjoying yourself before turning in for the night."
