require "base64"
require "gmsc/version"

module GMSC
  class << self
    # @param [{ String => String, Array<String> }] metadata
    # @return [{ String => String, Array<String> }]
    def safe_convert(metadata)
      h = {}
      metadata.each do |k, v|
        if k.match?(/-bin$/)
          # If the value is binary, encode with Base64
          h[k] = v.is_a?(Array) ? v.map { |e| Base64.strict_encode64(e) } : Base64.strict_encode64(v)
        else
          h[k] = v.is_a?(Array) ? v.map { |e| e.encode(Encoding::UTF_8) } : v.encode(Encoding::UTF_8)
        end
      end
      h
    end
  end
end
