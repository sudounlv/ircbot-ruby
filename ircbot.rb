require "bundler/setup"
Bundler.require

require_relative 'extend/string'
require_relative 'plugins/help_message'
require_relative 'plugins/respond_to_hello'
require_relative 'plugins/record_last_five_messages'
require_relative 'plugins/lurkers'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.net"
    c.nick = "projectbot-ruby"
    c.channels = %W{#sudounlv-bots}
    c.plugins.plugins = [HelpMessage, RespondToHello, RecordLastFiveMessages, Lurkers]
  end
end

bot.start
