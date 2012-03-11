# Hirameki

Hirameki is a one-time token generator backed by Redis.

## Installation

Add this line to your application's Gemfile:

    gem 'hirameki'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hirameki

If you use Hirameki with Rails, put the following in `config/initializers/`.

```ruby
Hirameki.configure do |config|
  config.redis = Redis.new(host: "localhost", port: 6379)
  config.pepper = "put_a_long_pepper_in_here"
  config.expiration_time = 10.minutes
end
```

## Usage

it's super easy to use Hirameki. Give it a try on irb/pry!

```
 > token = Hirameki.generate!(10)
=> "4dc6d4ca42e5204ab2d9cb5a0e0a8ec715c7d152"
 > Hirameki.get(token)
=> 10
```

Thas't it!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2011 Yuki Nishijima. See LICENSE.md for further details.
