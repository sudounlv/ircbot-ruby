require "bundler/setup"
Bundler.require

require_relative 'extend/string'
require_relative 'plugins/help_message'
require_relative 'plugins/respond_to_hello'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.net"
    c.nick = "projectbot-ruby"
    c.channels = %W{#sudounlv-bots}
    c.plugins.plugins = [HelpMessage, RespondToHello]
  end

end

bot.start
