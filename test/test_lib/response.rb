module Response
  SCENARIOS = {
    'successful-login' => [
      302,
      {
        'Date' => 'Tue, 09 Dec 2008 21:02:27 GMT',
        'Set-Cookie' => 'CakeCookie[User]=Q2FrZQ%3D%3D.DqL6WjKugx8KnXVpbadaIJA1Q99UqbJQiNvMX1VkVnBPz7IzKThpmrHHND%2BVl0U75jK56IbIZCSgpUTctGOsPcovHWI%3D; expires=Sat, 11-Dec-2010 21:25:42 GMT; path=/',
        'Location' => 'http://www.twones.com/users/timeline',
        'Content-Type' => 'text/html; charset=utf-8'
      }
    ],
    'failed-login' => [
      200,
      {
        'Date' => 'Tue, 09 Dec 2008 21:02:27 GMT',
        'Set-Cookie' => 'CAKEPHP=54aa4f818ca646f679b3adf5b0253a73; expires=Thu, 18 Dec 2008 21:27:16 GMT; path=/',
        'Content-Type' => 'text/html; charset=utf-8'
      }
    ]
  }
  def self.for(scenario)
    response = SCENARIOS[scenario]
    if response.nil?
      raise ArgumentError, "Unknown response scenario `#{scenario}'"
    end
    REST::Response.new(*response)
  end
end