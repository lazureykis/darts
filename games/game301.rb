# -*- encoding : utf-8 -*-

module Games
  class Game301
    STARTING_SCORE = 301
    NAME_LIMIT = 18

    attr_accessor :score
    attr_accessor :double

    def initialize(params = {})
      self.score = {}
      self.double = !!params[:double]
      puts "Starting 301 with#{'out' unless double} double."
    end

    def prepare
      while players.count < 2
        print "Enter your names: "
        self.score = Hash[$stdin.gets.split.map{|p| [p.slice(0, NAME_LIMIT).strip, STARTING_SCORE]}]
        if score.count < 1
          puts "Cannot start game without players."
        elsif score.count == 1
          puts "Wanna play with yourself?"
        end
      end
    end

    def run
      puts "Starting with players: #{players.join(', ')}"

      win = nil
      turn = 0
      while !win
        puts "\e[H\e[2J"
        score.sort {|a,b| a[1] <=> b[1]}.each do |name, points|
          puts "#{name.rjust(20)}: #{points.to_s.rjust(3)}"
        end

        cur_player = players[turn % players.count]
        puts "-" * 25
        print "#{cur_player}: "
        input = $stdin.gets.chomp.strip
        cur_score = input.to_i

        if input == 'q'
          puts "Bye."
          exit(0)
        end

        if self.score[cur_player] > cur_score
          self.score[cur_player] -= cur_score
        elsif self.score[cur_player] == cur_score
          win = cur_player
        end
        turn += 1
      end

      puts "#{win} wins!"
    end

    def players
      score ? score.keys : []
    end
  end
end