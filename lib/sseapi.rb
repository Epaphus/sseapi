class SSEapi

  def self.data
    SSEapi.parse_data
  end

  private
  
  def self.fetch_data  
    begin
      uri = URI.parse("http://api.sse.com/powerdistribution/network/v1/api/faults")

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      sse_get = http.request(request)
      @sse_httpcode = sse_get.code
      @sse_data = sse_get.body
      
    end rescue begin
   
      @sse_error = $!
    end
   
    if @sse_httpcode != "200"  
      @sse_data =   "{\"timestampUtc\":\"0\",\"faults\":[{\"title\":\"Error\",\"reference\":\"\",\"loggedAtUtc\":\"\",\"type\":\"\",\"location\":{\"latitude\":0,\"longitude\":-0},\"estimatedRestorationTimeUtc\":\"\",\"message\":\"Error contacting SSE API, Error: #{@sse_error} HTTP code: #{@sse_httpcode} \",\"affectedAreas\":[\"\"],\"uri\":\"\"}],\"uri\":\"http://api.sse.com/powerdistribution/network/v1/api/faults/\",\"message\":\"0 reported faults\"}"
    end
    @sse_data
  end
  
   def self.parse_data
    @sse_parsed=JSON.parse(SSEapi.fetch_data)
  end

end