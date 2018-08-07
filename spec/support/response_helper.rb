module ResponseHelper
  def response_join
    JSON.parse(response.body) rescue {}
  end
end