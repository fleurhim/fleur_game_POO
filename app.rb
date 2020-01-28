require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("José")

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------\n\n"

tour = 1
while player1.life_points > 0 && player2.life_points > 0 #le combat continue tant que les deux joueurs sont en vie
	puts "------------------------------------------------------".colorize(:blue)
	puts "          ---------> TOUR n°#{tour} <--------             ".colorize(:blue)
	puts "------------------------------------------------------\n\n".colorize(:blue)
	
	puts " ====== Voici l'état de chaque joueur :======".colorize(:yellow)
	puts player1.show_state #donne les points de vie et le nom du joueur 1
	puts player2.show_state #donne les points de vie et le nom du joueur 2
	puts "======= Passons à la phase d'attaque :=======".colorize(:yellow)
	player1.attacks(player2) #le joueur 1 attaque le joueur 2
	break if player2.life_points <= 0 #le jeu s'arrête si un joueur meurt
	player2.attacks(player1) #le joueur 2 attaque le joueur 1
	tour+=1
end

puts "======= Et voilà c'est la fin du jeu ! ======= ".colorize(:yellow)