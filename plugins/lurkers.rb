require 'cinch'
require 'set'

class Lurkers
  include Cinch::Plugin

  @@DELAY = 30*60

  listen_to :message, :join
  match /lurkers/, :method => :lurkers

  def initialize *args
    super
    @lurkers = Set.new
    @lurker_timers = {}
  end

  def listen m
    old_timer = @lurker_timers[m.user]
    old_timer.stop unless old_timer == nil
    @lurker_timers[m.user] = nil

    @lurkers.delete(m.user) 

    new_timer = Timer(@@DELAY, shots: 1) do 
      m.channel.send "#{m.user} has been added to the list of Lurkers (30 minutes inactive)" 
      @lurker_timers[m.user] = nil
      @lurkers.add m.user 
    end
   
    @lurker_timers[m.user] = new_timer
  end

  def lurkers m
    m.reply "There are currently no lurkers" if @lurkers.empty?
    @lurkers.each { |l|
      m.reply "#{l} is lurking"
    }
  end

end


