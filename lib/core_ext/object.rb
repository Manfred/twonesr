require 'cgi'

class Object
  def url_encode
    CGI.escape(self.to_s)
  end
end