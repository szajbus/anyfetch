require "net/sftp"

module Anyfetch
  class SFTP
    def initialize(uri, options = {})
      @uri = uri
      @options = options
    end

    def open
      user = @options.delete(:user) || @uri.user
      options = { password: @uri.password }.merge(@options)

      filename = ::File.basename(@uri.path)

      tempfile = Tempfile.new(filename)
      tempfile.binmode

      Net::SFTP.start(@uri.host, user, options) do |sftp|
        sftp.file.open(@uri.path, "r") do |file|
          while !file.eof? do
            tempfile << file.read(32 * 1024 * 1024)
          end
        end
      end

      tempfile.extend(OriginalFilename::Path)
    end
  end
end
