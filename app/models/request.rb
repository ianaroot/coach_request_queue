require 'date'

class Request < ActiveRecord::Base
  URGENCY = {'OMG, please help soon!' => 1,
             'this week please' => 2,
             'anytime this phase' => 3}
  # attr_accessor :id, :date, :phase, :city
  # def initialize( args = {} )
  #   @name = args[:name]
  #   @comments = args[:comments]
  #   @phase = args[:phase]
  #   @remote_ok = args[:remote_ok]
  #   @city = args[:city]
  #   @email = args[:email]
  #   @date = args[:date]
  #   @urgency = args[:urgency]
  #   @time_avail = args[:time_avail]
  # end


  def urgency
    URGENCY[@urgency]
  end

  def urgency_raw
    @urgency
  end

  def print_date
    Date.parse(date)
  end

  def <=>(other)
    case other.date <=> self.date
    when 0
      return self.urgency <=> other.urgency
    else
      return other.date <=> self.date
    end
  end

end

