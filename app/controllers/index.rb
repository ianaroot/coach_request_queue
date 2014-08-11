# entries.map!{|entry| entry.new( entry['EntryId'],entry['DateCreated'],entry['Field4'],entry['Field2'],entry['Field3'], entry['Field12'], entry['Field18'], entry['Field5']), entry['Field8'], entry['Field14'] }

# .each do |entry|
#   puts "%s  (%-23s) %-20s [%s]" % [entry.date, entry.urgency_raw, entry.name, entry.phase]
# end
require 'ultrahook'
require 'pry'

post '/entries/create' do
  args = {}
  args[:time_avail] = params['Field10']
  args[:urgency] = params['Field9']
  args[:date] = params['DateCreated']
  args[:email] = params['Field5']
  args[:city] = params["Field2"]
  if params['Field11'] == 'yes'
    args[:remote_ok] = true
  else
    args[:remote_ok] = false
  end
  args[:phase] = params['Field7']
  args[:comments] = params['Field8']
  args[:name] = params['Field3']
  entry = Entry.new( args )
  entry.save
end

get '/' do
  #this is gonna change to San Francisco for the real app
  @entries = Entry.where(city: "Sf")
  @entries = @entries.sort
  erb :index
end

get '/entries/:id' do
  @entry = Entry.find(params[:id])
  erb :show
end
