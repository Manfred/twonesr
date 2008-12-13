module Response
  def self.file_fixture(path)
    File.join(File.expand_path('../../fixtures/files', __FILE__), path)
  end
  
  SCENARIOS = {
    'successful-login' => [
      302,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:27 GMT'],
        'set-cookie' => ['CakeCookie[User]=Q2FrZQ%3D%3D.DqL6WjKugx8KnXVpbadaIJA1Q99UqbJQiNvMX1VkVnBPz7IzKThpmrHHND%2BVl0U75jK56IbIZCSgpUTctGOsPcovHWI%3D; expires=Sat, 11-Dec-2010 21:25:42 GMT; path=/'],
        'location' => ['http://www.twones.com/users/timeline'],
        'content-type' => ['text/html; charset=utf-8']
      }
    ],
    'failed-login' => [
      200,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:27 GMT'],
        'set-cookie' => ['CAKEPHP=54aa4f818ca646f679b3adf5b0253a73; expires=Thu, 18 Dec 2008 21:27:16 GMT; path=/'],
        'content-type' => ['text/html; charset=utf-8']
      }
    ],
    'successful-token-retrieval' => [
      200,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:30 GMT'],
        'content-type' => ['text/html; charset=utf-8']
      },
      File.read(file_fixture('welcome_url_response_body.txt'))
    ],
    'failed-token-retrieval' => [
      302,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:30 GMT'],
        'content-type' => ['text/html; charset=utf-8']
      }
    ],
    'successful-playlist-add' => [
      200,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:30 GMT'],
        'content-type' => ['text/html; charset=utf-8']
      }
    ],
    'failed-playlist-add' => [
      520,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:30 GMT'],
        'content-type' => ['text/html; charset=utf-8']
      },
      'Service not found (520)'
    ],
    'successfull-message-collection-friends' => [
      200,
      {
        'date' => ['Tue, 09 Dec 2008 21:02:30 GMT'],
        'content-type' => ['text/html; charset=utf-8']
      },
      File.read(file_fixture('message_collection_friends.txt'))
    ]
  }
  
  def self.attributes_for(scenario)
    attributes = SCENARIOS[scenario]
    if attributes.nil?
      raise ArgumentError, "Unknown response scenario `#{scenario}'"
    end
    attributes
  end
  
  def self.for(scenario)
    REST::Response.new(*attributes_for(scenario))
  end
end