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

my_game = Game.new(name) #initialisation du Game

tour = 1
while my_game.is_still_ongoing? #détermine si le jeu continue
	puts "------------------------------------------------------".colorize(:blue)
	puts "          	------> TOUR n°#{tour} <------          ".colorize(:blue)
	puts "------------------------------------------------------\n\n".colorize(:blue)

	puts "============ Ta situation dans le game =============\n\n".colorize(:yellow)
	my_game.show_players ##montre les points de vie, l'arme du joueur et le nombre de bots restant
	puts "=================== Ils arrivent ! =================\n\n".colorize(:yellow)
	my_game.new_players_in_sight #ajoute ou non des bots à l'array 
	puts "=========== Bon du coup on fait quoi ? =============\n\n".colorize(:yellow)
	my_game.menu #menu des choix possibles
	print ">"
	action = gets.chomp.to_s #récupère le choix du joueur
	puts "===== Alors est-ce que tu as fais le bon choix ? =====\n\n".colorize(:yellow)
	my_game.menu_choice(action) #en fonction du choix du joueur (nouvelle arme, attaque, points de vie en plus...)
	my_game.enemies_in_sight_attack #ataque des bots sur le joueur
	tour+=1
end
puts "==================== GAME OVER =======================\n\n".colorize(:yellow)
my_game.end #fin du jeu

