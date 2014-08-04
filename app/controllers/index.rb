# entries.map!{|entry| Request.new( entry['EntryId'],entry['DateCreated'],entry['Field4'],entry['Field2'],entry['Field3'], entry['Field12'], entry['Field18'], entry['Field5']), entry['Field8'], entry['Field14'] }

# .each do |request|
#   puts "%s  (%-23s) %-20s [%s]" % [request.date, request.urgency_raw, request.name, request.phase]
# end

post '/requests/create' do
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
  args[:name] = "#{params['Field3']} #{params['Field4']}"
  request = Request.new( args )
  request.save
end

get '/' do
  #this is gonna change to San Francisco for the real app
  @requests = Request.where(city: "Sf")
  @requests = @requests.sort
  erb :index
end
