#!/usr/bin/ruby
$LOAD_PATH << './src'
require "game"

TDef::Game.init
TDef::Game.start
TDef::Game.main_loop