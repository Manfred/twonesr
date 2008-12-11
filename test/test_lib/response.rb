module Response
  SCENARIOS = {
    'successful-login' => [
      302,
      {
        'Date' => 'Tue, 09 Dec 2008 21:02:27 GMT',
        'Set-Cookie' => 'CakeCookie[User]=Q2FrZQ%3D%3D.DqL6WjKugx8KnXVpbadaIJA1Q99UqbJQiNvMX1VkVnBPz7IzKThpmrHHND%2BVl0U75jK56IbIZCSgpUTctGOsPcovHWI%3D; expires=Thu, 09-Dec-2010 21:02:27 GMT; path=/',
        'Location' => 'http://www.twones.com/users/firefox_installed?cmd=login&v=0.5.5.395',
        'Content-Type' => 'text/html; charset=utf-8'
      }
    ],
    'failed-login' => [
      200,
      {
        'Date' => 'Tue, 09 Dec 2008 21:02:27 GMT',
        'Set-Cookie' => 'CakeCookie[User]=Q2FrZQ%3D%3D.DqL6WjKugx8KnXVpbadaIJA1Q99UqbJQiNvMX1VkVnBPz7IzKThpmrHHND%2BVl0U75jK56IbIZCSgpUTctGOsPcovHWI%3D; expires=Thu, 09-Dec-2010 21:02:27 GMT; path=/',
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