require 'cinch'

class RespondToHello
  include Cinch::Plugin

  match /hello.*/, :method => :say_hello,
    :use_prefix => false, :react_on => :private

  match lambda{|m| /hello #{m.bot.nick}/i}, :method => :say_hello,
    :use_prefix => false, :react_on => :channel

  def initialize(*args)
    super
  end

  def say_hello m
    m.reply "Hello #{m.user}"  
  end

end

