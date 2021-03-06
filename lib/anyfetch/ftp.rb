require "anyfetch/open_uri"
require "anyfetch/original_filename/content_type"

module Anyfetch
  class FTP < OpenURI
    def initialize(uri, options = {})
      @uri = uri
      @options = options
      setup_auth
    end

    private

    def setup_auth
      if @uri.user
        # URI-encoded user must be passed to open-uri
        # Rollback URI-encoding of user here
        @uri.instance_variable_set "@user", URI.decode(@uri.user)
      end

      if @uri.password
        # Rollback URI-encoding of password by open-uri lib
        @uri.instance_variable_set "@password", URI.decode(@uri.password)
      end
    end
  end
end
