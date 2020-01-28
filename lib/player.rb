class Player
	attr_accessor :name, :life_points

	def initialize(name_to_give, life_points_to_give = 10) #par défaut les joueurs ont 10 points de vie
		@name = name_to_give.to_s
		@life_points = life_points_to_give
	end

	def show_state #donne le nom et les points de vie des joueurs
		"#{@name} a #{@life_points} point(s) de vie" 
	end

	def gets_damage(damages, player_hurt) #enlève des points de vie dès qu'un joueur est attaqué et annonce s'il est mort
		player_hurt.life_points = player_hurt.life_points - damages
		if player_hurt.life_points <= 0 then puts "Le joueur #{player_hurt.name} a été tué !" end 
	end

	def attacks(player_hurt) #décrit l'attaque d'un joueur sur un autre
		puts "Le joueur #{@name} attaque le joueur #{player_hurt.name}" 
		attack_damages = compute_damage #appelle la méthode "compute damage" et la met dans une variable
		puts "Il lui inflige #{attack_damages} points de dommages \n\n"
		gets_damage(attack_damages, player_hurt) #appelle la méthode "gets_damgae"
	end

	def compute_damage #les dégats d'une attaque sont aléatoires entre 1 et 6
		rand(1..6)
	end
end

class HumanPlayer < Player #héritage de la classe Player
	attr_accessor :weapon_level

	def initialize(name_to_give, life_points_to_give = 100, weapon_level_to_give = 1) #ajout de l'attribut :weapon_level
		@life_points = life_points_to_give
		@weapon_level = weapon_level_to_give.to_i
		@name = name_to_give.to_s
	end

	def show_state
		puts "#{@name} a #{@life_points} point(s) de vie et une arme de niveau #{@weapon_level}"
	end

	def compute_damage
		rand(1..6) * @weapon_level
	end

	def search_weapon #décrit la puissance de l'arme du joueur humain (multiplié entre 1 et 6)
		dice_roll = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{dice_roll}"
		if dice_roll > @weapon_level
			@weapon_level = dice_roll
			puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends BB!"
		else 
			puts "M@*#$... elle n'est pas mieux que ton arme actuelle...c'est dead"
		end
	end

	def search_health_pack #décrit si le joueur récupère des points de vue
		dice_roll = rand(1..6)
		if dice_roll == 1
			puts  "Tu n'as rien trouvé... "
		elsif dice_roll >= 2 && dice_roll <= 5
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
			@life_points = @life_points + 50
			if @life_points > 100 then @life_points = 100 end
		else 
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			@life_points = @life_points + 80
			if @life_points > 100 then @life_points = 100 end
		end
	end
end