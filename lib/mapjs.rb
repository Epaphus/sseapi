class Mapsjs

  def self.alerts

    outages = 0
    @data = SSEapi.data 
    jsoutput = "
    var markers = ["
     
    @data['faults'].each do |item|

      jsoutput += "['#{item['title']}', #{item['location']['latitude']}, #{item['location']['longitude']}],"
      outages +=1
    end 
    jsoutput += "
    ];
    "
    if outages == 0
      
      jsoutput = "latlng = new google.maps.LatLng(50.7356,-1.900871);"
    end
    return jsoutput
  end
  
end