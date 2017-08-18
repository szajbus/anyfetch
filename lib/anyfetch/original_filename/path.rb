module Anyfetch
  module OriginalFilename
    module Path
      def original_filename
        ::File.basename(path)
      end
    end
  end
end
