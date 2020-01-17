# Mu::RestClient

This is a REST client I made for fun. ❤️

It is simple, yet flexible enough for my use cases.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mu-rest_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mu-rest_client

## Usage

Require it:

```ruby
require 'mu/rest-client'
```

### Success

```ruby
result = Mu::RestClient.api_request(
  domain: 'reqres.in',
  path: '/api/users/2',
)
result.success? # => true
result.unwrap(:http_code) # => '200'
result.unwrap(:body)
# => {"data"=>
#   {"id"=>2,
#    "email"=>"janet.weaver@reqres.in",
#    "first_name"=>"Janet",
#    "last_name"=>"Weaver",
#    "avatar"=>"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"}}
```

### Error 404

```ruby
result = Mu::RestClient.api_request(
  domain: 'reqres.in',
  path: '/api/users/23',
)
result.error? # => true
result.code # => :http_error
result.unwrap(:http_code) # => '404'
result.unwrap(:response) # => #<Net::HTTPNotFound 404 Not Found readbody=true>
result.unwrap(:body) # => {}
```

### Error 400

```ruby
result = Mu::RestClient.api_request(domain: 'reqres.in', path: '/api/login', method: :post, body_params: { email: "peter@klaven" })
result.error? # => true
result.http_code # => '400'
result.unwrap(:body) # => {"error"=>"Missing email or username"}
```

### Success 204

```ruby
result = Mu::RestClient.api_request(
  domain: 'reqres.in',
  path: '/api/users/2',
  method: :delete,
  success_codes: ['204'],
)
result.success? # => true
result.http_code # => '204'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://source.olisti.co/olistik/mu-rest_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mu::RestClient project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://source.olisti.co/olistik/mu-rest_client/blob/master/CODE_OF_CONDUCT.md).
