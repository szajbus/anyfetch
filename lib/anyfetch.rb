require "open-uri"
require "open_uri_redirections"

require "anyfetch/file"
require "anyfetch/ftp"
require "anyfetch/http"
require "anyfetch/version"

module Anyfetch extend self
  def open(uri, options = {})
    uri = URI.parse(uri)
    handler(uri, options).open
  end

  private

  def to_uri(uri)
    uri = uri.gsub('[', '%5B').gsub(']', '%5D').strip
    uri = ::URI.parse(::URI.encode(::URI.decode(uri)))
    URI.parse(uri)
  end

  def handler(uri, options = {})
    scheme = uri.scheme || "file"

    klass =
      case scheme
      when "file"    then File
      when "ftp"     then FTP
      when /^https?/ then HTTP
      else
        raise "No handler for '#{scheme}' protocol."
      end

    klass.new(uri, options)
  end
end
