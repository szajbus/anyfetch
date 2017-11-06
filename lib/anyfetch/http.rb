require "anyfetch/original_filename/content_type"

module Anyfetch
  class HTTP
    OPTIONS = {
      "User-Agent" => "Mozilla/5.0 (X11; Linux x86_64; rv:39.0) Gecko/20100101 Firefox/39.0",
      :allow_redirections => :safe,
    }

    def initialize(uri, options)
      @uri = uri
      @options = OPTIONS.merge(options)
      setup_basic_auth
    end

    def open
      file = super(@uri, @options)
      file.extend(OriginalFilename::ContentType)
      file
    end

    private

    def setup_basic_auth
      if @uri.user || @uri.password
        @options[:http_basic_authentication] = [@uri.user, @uri.password]
        @uri.user = nil
        @uri.password = nil
      end
    end
  end
end
