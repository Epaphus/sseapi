outages = 0
totaloutages = 0

#xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:sseapi' => "#{request.url.chomp request.path_info}/sseapi-ns", 'xmlns:atom' => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "SSE Power outages"
    xml.description "List of power outages"
    xml.link request.url.chomp request.path_info
    xml.tag!("atom:link", :href => "#{request.url}", :rel => "self", :type => "application/rss+xml" )
 

    @data['faults'].each do |item|
      totaloutages+=1

  
        affectedareas = ""
         item['affectedAreas'].each do |area|
          affectedareas = "#{affectedareas} #{area}, "
        end
 
        xml.item do
          xml.title item['title']
          xml.guid "#{request.url.chomp request.path_info}/fault/#{item['reference']}"
          xml.description item['message']
          xml.link request.url.chomp request.path_info
          xml.tag!("sseapi:type", item['type'])
          xml.tag!("sseapi:googlemaps", "http://maps.google.com/?q=#{item['location']['latitude']},#{item['location']['longitude']}" )
          xml.tag!("sseapi:loggeddate", item['loggedAtUtc'] )
          xml.tag!("sseapi:engineereta", item['estimatedArrivalOnSiteUtc'] )
          xml.tag!("sseapi:nexupdate", item['estimatedFaultUpdateTimeUtc'] )
          xml.tag!("sseapi:areas", affectedareas )
        
        end
    end
  end
end

