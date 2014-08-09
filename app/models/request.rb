# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  date       :string(255)
#  urgency    :string(255)
#  name       :string(255)
#  email      :string(255)
#  phase      :string(255)
#  city       :string(255)
#  time_avail :string(255)
#  remote_ok  :boolean
#  comments   :text
#  params     :text
#

class Request < ActiveRecord::Base

  URGENCY = {'OMG, please help soon!' => 1,
             'this week please' => 2,
             'anytime this phase' => 3}

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

