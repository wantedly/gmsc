require "base64"
require "gmsc/version"

module GMSC
  class << self
    # @param [{ String => String }] metadata
    # @return [{ String => String }]
    def safe_convert(metadata)
      h = {}
      metadata.each do |k, v|
        if k.match?(/-bin$/)
          # If the value is binary, encode with Base64
          h[k] = Base64.strict_encode64(v)
        else
          h[k] = v.encode(Encoding::UTF_8)
        end
      end
      h
    end
  end
end
