#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

def load_games
  $GAMES_LOADED ||= Dir.glob(File.expand_path('./games/*.rb')).each do |game_path|
    require game_path
  end
end

def usage
  puts "USAGE: #{File.basename($0)} game_name"
  puts "Games supported: 301, 301d"
  exit(0)
end

def select_game
  load_games
  case ARGV[0]
  when '301d'
    Games::Game301.new(double: true)
  when '301'
    Games::Game301.new(double: false)
  when '', nil, '-h', '?', '--help', '-help'
    usage
  else
    abort "Unable to find game '#{ARGV[0]}'"
  end
end

def run
  game = select_game
  game.prepare
  game.run
end

run if File.basename($0) == File.basename(__FILE__)