require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------\n\n"

puts "Quel est ton prénom ?"
print ">"
name = gets.chomp.to_s

user = HumanPlayer.new(name)
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

tour = 1
while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0) #le combat continue tant que le joueur humain et un bot sont en vie
	puts "----------------------------------------------------------".colorize(:blue)
	puts "          ---------> TOUR n°#{tour} <--------             ".colorize(:blue)
	puts "-----------------------------------------------------------\n\n".colorize(:blue)
	
	puts "=============== Ta situation dans le game =============\n\n".colorize(:yellow)

	user.show_state #annonce les points de vie du joueur et la puissance de son arme

	puts "=============== Bon du coup on fait quoi ? =============\n\n".colorize(:yellow)

	puts "Quelle action veux-tu effectuer ?" #affiche le menu des choix possibles à chaque tour
	puts "a - chercher une meilleure arme"
	puts "s - chercher à se soigner "
	puts "Ou attaquer un joueur en vue :"
	if player1.life_points > 0
		puts "0 - #{player1.show_state}."
	else
		puts "#{player1.name} est déjà mort(e)"
	end
	if player2.life_points > 0
		puts "1 - #{player2.show_state}."
	else
		puts "#{player2.name} est déjà mort(e)"
	end
	print ">"
	action = gets.chomp.to_s

	puts "======= Alors est-ce que tu as fais le bon choix ? ======\n\n".colorize(:yellow)
	
	if action == "a"
		user.search_weapon #changer la puissance de l'arme
	end
	if action == "s"
		user.search_health_pack #récupérer des points de vie
	end
	if action == "0"
		user.attacks(player1) #attaque le bot 1
	end
	if action == "1"
		user.attacks(player2) #attaque le bot 2
	end

	

	if player1.life_points > 0 || player2.life_points > 0 #attaque des bots s'ils sont en vie
	puts "================ La rispote arrive ! ==================\n\n".colorize(:yellow)
	end

	enemies.each do |enemy|
		next if enemy.life_points <= 0
		enemy.attacks(user)
	end
	tour+=1
end
	puts "======================= GAME OVER =====================\n\n".colorize(:yellow)
	puts "La partie est finie"
	if user.life_points > 0
		puts "BRAVO ! TU AS GAGNE !"
	elsif user.life_points <= 0
		puts "Loser ! Tu as perdu !"
	end