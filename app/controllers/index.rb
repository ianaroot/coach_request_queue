# entries.map!{|entry| entry.new( entry['EntryId'],entry['DateCreated'],entry['Field4'],entry['Field2'],entry['Field3'], entry['Field12'], entry['Field18'], entry['Field5']), entry['Field8'], entry['Field14'] }

# .each do |entry|
#   puts "%s  (%-23s) %-20s [%s]" % [entry.date, entry.urgency_raw, entry.name, entry.phase]
# end
require 'ultrahook'
require 'pry'

post '/entries/create' do
  # binding.pry
  args = {}
  JSON.parse( params['FieldStructure'] )['Fields'].each do |field|
    if field["Title"] == "your city"
      args[:city] = params[field["ID"]]
    elsif field["Title"] == "your first name"
      args[:first_name] = params[field["ID"]]
    elsif field["Title"] == "your last name"
      args[:last_name] = params[field["ID"]]
    elsif field["Title"] == "your request"
      args[:comments]  = params[field["ID"]]
    elsif field["Title"] == "your email"
      args[:email] = params[field["ID"]]
    elsif field["Title"] == "your phase"
      args[:phase] = params[field["ID"]]
    elsif field["Title"] == "timing"
      args[:time_avail] = params[field["ID"]]
    elsif field["Title"] == "is remote help okay?"
      if params[field["ID"]] == 'yes'
        args[:remote_ok] = true
      else
        args[:remote_ok] = false
      end
    end
  end
  args[:date] = params['DateCreated']
  args[:name] = "#{args[:first_name]} #{args[:last_name]}"

  # args[:time_avail] = params['Field10']
  # args[:urgency] = params['Field9']
  # args[:email] = params['Field5']
  # args[:city] = params["Field2"]
  # args[:phase] = params['Field7']
  # args[:comments] = params['Field8']
  # args[:name] = params['Field3']
  entry = Entry.new( args )
  entry.save
end

get '/' do
  #this is gonna change to San Francisco for the real app
  @entries = Entry.all
  @entries = @entries.sort
  erb :index
end

get '/entries/:id' do
  @entry = Entry.find(params[:id])
  erb :show
end
