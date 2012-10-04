require 'cinch'

class RecordLastFiveMessages
  include Cinch::Plugin

  listen_to :channel
  match /last5 (.*)/, :method => :last_five

  def initialize *args
    super
    @previous_messages = {}
  end

  def listen m
    @previous_messages[m.channel] ||= {}
    @previous_messages[m.channel][m.user] ||= []

    user_messages = @previous_messages[m.channel][m.user]
    user_messages << m
    user_messages.shift if user_messages.size > 5
    @previous_messages[m.channel][m.user] = user_messages
  end

  def last_five m, user
    user_messages = @previous_messages[m.channel][m.user]
    user_messages.each { |message|
      m.user.msg "#{user}> #{message.message}"
      # m.reply "#{user} (#{message.time})> #{message.message}"
    }
  end

end

