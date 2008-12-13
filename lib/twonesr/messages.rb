module Twonesr
  class Messages
    def friends
      response = Twonesr.connection.get(
        Twonesr::Routes.messages_url(
          :collection => 'friends',
          :id => Twonesr.connection.user_id
        )
      )
      parse(response.body)
    end
    
    def parse(body)
      messages = []
      doc = Hpricot(body)
      doc.search('div.talk_msgs_msg').each do |message_element|
        message = {}
        if name_element = message_element.search('div.talk_msgs_msg_title a').first
          message[:name] = name_element.inner_text
        end
        if posted_element = message_element.search('div.talk_msgs_msg_title span').first
          message[:posted_at] = posted_element.inner_text
        end
        if body_element = message_element.search('div.talk_msgs_msg_body').first
          message[:body] = body_element.inner_text.gsub(/\t/, '').strip[0..-9]
        end
        messages << message
      end
      messages
    end
  end
end
