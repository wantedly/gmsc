require "json"

RSpec.describe GMSC do
  describe "VRSION" do
    it "has a version number" do
      expect(GMSC::VERSION).not_to be nil
    end
  end

  describe ".safe_convert" do
    let(:metadata) {
      {
        "user-agent"      => "grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)".encode(Encoding::ASCII_8BIT),
        "binary-data-bin" => [0, 1, 2, 234].pack('c*'), # "\x00\x01\x02\xEA" binary data
      }
    }

    it "converts a metadata to a Hash which can be safely converted to JSON" do
      hash = GMSC.safe_convert(metadata)
      expect(hash).to eq({
        "user-agent"      => "grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)",
        "binary-data-bin" => "AAEC6g==",
      })
      expect(hash.to_json).to eq("{\"user-agent\":\"grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)\",\"binary-data-bin\":\"AAEC6g==\"}")
    end
  end
end
