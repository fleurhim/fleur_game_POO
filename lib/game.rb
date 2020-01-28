require 'pry'
require_relative 'player'

class Game < HumanPlayer
	attr_accessor :human_player, :enemies_in_sight, :players_left, :enemies_in_sight_in_sight

	def initialize(name_human_player_to_create, players_left = 10) #initialise un nouveau jeu
		user = HumanPlayer.new(name_human_player_to_create)
		@enemies_in_sight = Array.new #array des ennemies encore vide
		@players_left = players_left #nombre de bots à vaincre
		@human_player = user
	end

	def kill_player(player) #retire les bots vaincus de l'array
		if player.life_points <= 0
			@enemies_in_sight.delete(player)
		end
	end

	def is_still_ongoing? #détermine si le jeu continue
		if @human_player.life_points > 0 && (@enemies_in_sight.any? || @players_left > 0)
			return true
		else 
			return false
		end
	end

	def new_players_in_sight #ajoute ou non des bots à l'array à chaque tour
		dice_roll = rand(1..6)
		if @players_left == 0 #si tous les bots sont déjà dans l'array on n'en n'ajoute plus
			puts "Tous les joueurs sont déjà en vue"
		else 
			if dice_roll == 1
				puts "Ouf ! Aucun nouveau joueur adverse n'arrive!"
			elsif dice_roll >= 2 && dice_roll <= 4
				@enemies_in_sight << Player.new("joueur_#{rand(1000..9999)}") #le nom du bot est random
				puts "Attention ! Un nouveau adversaire arrive !"
				@players_left = @players_left - 1
			elsif dice_roll > 4 && dice_roll <= 6
				@enemies_in_sight << Player.new("joueur_#{rand(1000..9999)}")
				@enemies_in_sight << Player.new("joueur_#{rand(1000..9999)}")
				puts "Attention ! Deux nouveaux adversaires arrivent !"
				@players_left = @players_left - 2
			end
		end
	end

	def show_players #montre les points de vie, l'arme du joueur et le nombre de bots restant
		@human_player.show_state
		puts "Il reste #{@players_left + @enemies_in_sight.length} enemies à tuer"
	end

	def menu #menu des choix possible
		puts "Quelle action veux-tu effectuer ?"
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner "
		puts "Ou attaquer un joueur en vue :"
		x = 0
		@enemies_in_sight.each do |enemy_in_sight| #affiche les bots qu'il est possible d'attaquer
			if @enemies_in_sight.include?(enemy_in_sight)
				puts "#{x} - #{enemy_in_sight.show_state}."
			end
			x+=1
		end
	end

	def menu_choice(action) #résultat du choix du joueur
		if action == "a"
			@human_player.search_weapon #nouvelle arme
		elsif action == "s"
			@human_player.search_health_pack #points de vie en plus
		elsif ["0","1","2","3","4","5","6","7","8","9","10"].include?(action)
			@human_player.attacks(@enemies_in_sight[action.to_i]) #attaque un bot
			kill_player(@enemies_in_sight[action.to_i]) #appelle la méthode kill_player pour le supprimer de l'array
		end
	end

	def enemies_in_sight_attack #attaque des bots sur le joueur
		if @enemies_in_sight.any?
		puts "========== La rispote arrive ! =============\n\n".colorize(:yellow)
		end

		@enemies_in_sight.each do |enemy|
		break if @human_player.life_points <=0
		enemy.attacks(@human_player)
		end
	end

	def end #messge de fin de jeu
		puts "La partie est finie"
		if @human_player.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
		elsif @human_player.life_points <= 0
		puts "Loser ! Tu as perdu !"
		end
	end
end


