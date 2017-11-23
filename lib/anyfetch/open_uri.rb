require "tempfile"
require "anyfetch/original_filename/content_type"

module Anyfetch
  class OpenURI
    def initialize(*args)
      raise NotImplementedError
    end

    def open
      file = super(@uri, @options)

      if file.is_a?(StringIO)
        file = to_tempfile(file)
      end

      file.extend(OriginalFilename::ContentType)
      file
    end

    private

    # OpenURI returns either Tempfile or StringIO depending of the size of
    # the response. We want to unify this and always return Tempfile.
    def to_tempfile(io)
      tempfile = Tempfile.new('open-uri')
      tempfile.binmode
      ::OpenURI::Meta.init(tempfile, io)
      tempfile << io.string
      tempfile
    end
  end
end
