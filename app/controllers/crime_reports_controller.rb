class CrimeReportsController < ApplicationController
  # require 'soda/client'

  def add_community_area
    res = HTTParty.get(APPLICATION_CONFIG['community_area_data_url'].to_s,
                       headers: {
                         'Content-Type' => 'application/json'
                       })
    response = JSON.parse(res.body)
    # onetime operation
    response.each do |i|
      if i['ca'].present?
        CommunityArea.create(
          id: i['ca'],
          name: i['community_area_name']
        )
      end
    end
    render json: { data: CommunityArea.all.attributes.reject{|key| key if ['created_at', 'updated_at'].include? key } }, status: 200
  end

  def community_areas
    community_areas = CommunityArea.all.map{ |ca| ca.attributes.reject{ |key| key if ['created_at', 'updated_at'].include? key }}
    render json: { data: community_areas }, status: 200
  end

  def add_crime_report

  end

  def crime_reports
    require 'soda/client'
    require 'csv'

    client = SODA::Client.new({:domain => "data.cityofchicago.org"})
    response = client.get("ijzp-q8t2", { :$limit => 7000000 })
    # results = []
    # response.each do |crime|
    #   results.append({
    #     date: DateTime.parse(crime['date']).strftime('%d-%m-%Y'),
    #     time: DateTime.parse(crime['date']).strftime('%I:%M %p'),
    #     day: DateTime.parse(crime['date']).strftime('%A'),
    #     month: DateTime.parse(crime['date']).strftime('%B'),
    #     year: crime['year'],
    #     primary_type: crime['primary_type'] || '',
    #     description: crime['description'] || '',
    #     location_description: crime['location_description'] || '',
    #     arrest: crime['arrest'] || false,
    #     domestic: crime['domestic'] || false,
    #     on_weekend: ['Saturday', 'Sunday'].include?(DateTime.parse(crime['date']).strftime('%A')) ? true : false,
    #     beat: crime['beat'] || '',
    #     district: crime['district'] || '',
    #     community_area_id: crime['community_area'] || 78,
    #     community_area: crime['community_area'].present? ? (crime['community_area'] != '0' ? CommunityArea.find(crime['community_area']).name : '') : ''
    #   })
    # end
    file = Rails.root.join("lib", "csv", "crime_report_2001_2022.csv")
    headers = ['Date', 'Time', 'Day', 'Month', 'Year', 'Primary Type', 'Description', 'Location Description', 'Arrest', 'Domestic', 'On Weekend', 'Beat', 'District', 'Community Area ID', 'Community Area']
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
      response.each do |crime|
        writer << [
            DateTime.parse(crime['date']).strftime('%d-%m-%Y'),
            DateTime.parse(crime['date']).strftime('%I:%M %p'),
            DateTime.parse(crime['date']).strftime('%A'),
            DateTime.parse(crime['date']).strftime('%B'),
            crime['year'],
            crime['primary_type'] || '',
            crime['description'] || '',
            crime['location_description'] || '',
            crime['arrest'] || false,
            crime['domestic'] || false,
            ['Saturday', 'Sunday'].include?(DateTime.parse(crime['date']).strftime('%A')) ? true : false,
            crime['beat'] || '',
            crime['district'] || '',
            crime['community_area'] || 78,
            crime['community_area'].present? ? (crime['community_area'] != '0' ? CommunityArea.find(crime['community_area']).name : '') : ''
        ]
      end
    end
    render json: { data: 'success' }, status: 200
  end

end