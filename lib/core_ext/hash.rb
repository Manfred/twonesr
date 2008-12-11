class Hash
  def url_encode
    map do |key, value|
      "#{key.url_encode}=#{value.url_encode}"
    end.join('&')
  end
end