require "anyfetch/original_filename/path"

module Anyfetch
  class File
    def initialize(uri, options = {})
      @uri = uri
      @options = options
    end

    def open
      file = ::File.open(@uri.path)
      file.extend(OriginalFilename::Path)
    end
  end
end
