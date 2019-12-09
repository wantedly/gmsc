# GMSC - **g**RPC **m**etadata **s**afe **c**onverter

**g**RPC **m**etadata **s**afe **c**onverter.

Converts a gRPC metadata to a Hash which can be safely converted to JSON.

In gRPC, binary metadata is represented by a "-bin" suffix of a key, so GMSC checks the key and converts the value to the Base64 encoded format if necessary.

cf. https://github.com/grpc/grpc/blob/v1.25.0/doc/PROTOCOL-HTTP2.md  
cf. https://github.com/grpc/grpc-go/blob/v1.25.0/Documentation/grpc-metadata.md#storing-binary-data-in-metadata

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gmsc'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gmsc

## Usage

```ruby
[1] pry(main)> metadata = {
[1] pry(main)*   "user-agent"      => "grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)".encode(Encoding::ASCII_8BIT),
[1] pry(main)*   "binary-data-bin" => [0, 1, 2, 234].pack('c*'), # "\x00\x01\x02\xEA" binary data
[1] pry(main)* }
=> {"user-agent"=>"grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)", "binary-data-bin"=>"\x00\x01\x02\xEA"}

[2] pry(main)> GMSC.safe_convert(metadata)
=> {"user-agent"=>"grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)", "binary-data-bin"=>"AAEC6g=="}

[3] pry(main)> GMSC.safe_convert(metadata).to_json
=> "{\"user-agent\":\"grpc-node/1.19.0 grpc-c/7.0.0 (linux; chttp2; gold)\",\"binary-data-bin\":\"AAEC6g==\"}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/south37/gmsc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/south37/gmsc/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GMSC project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/south37/gmsc/blob/master/CODE_OF_CONDUCT.md).
