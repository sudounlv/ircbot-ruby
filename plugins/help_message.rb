require 'cinch'

class HelpMessage
  include Cinch::Plugin

  match lambda{|m| /help #{m.bot.nick}/i}, :method => :help_message

  def help_message m
    m.reply <<-EOS.undent
      #{m.bot.nick} help:
        !help <- Display this help message
        hello #{m.bot.nick} <- If you type hello to me I'll say hi back!
        /msg #{m.bot.nick} hello <- if you private message me and say hello, I'll make sure to greet you back!
        !last5 <username> <- print out the last 5 messages <username> said
        !lurkers <- print out a list of all users lurking in the channel (30 minutes inactive)
    EOS
  end

end
