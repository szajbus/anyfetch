require "terrapin"
require "mime-types"

module Anyfetch
  module OriginalFilename
    module ContentType
      def original_filename
        if meta.include? 'content-disposition'
          match = meta['content-disposition'].match(/filename=(\"?)(.+)\1/)
          return match[2] unless match.nil?
        end

        filename = ::File.basename(base_uri.path)
        ext = ::File.extname(filename)

        cmd = Terrapin::CommandLine.new('/usr/bin/file', '--mime-type -b :file')
        begin
          mime_type = cmd.run(:file => path)
        rescue
          mime_type = meta['content-type']
        end

        if mime = MIME::Types[mime_type.to_s.strip].first
          mime_ext = mime.extensions.first
          ext != mime_ext ? [::File.basename(filename, ext), '.', mime_ext].join : filename
        else
          filename
        end
      end
    end
  end
end
