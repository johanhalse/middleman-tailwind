# Tailwind for Middleman

Probably the easiest way to get [Tailwind CSS](https://tailwindcss.com/) into your Middleman app! It comes bundled with the standalone CLI executables and is very point-and-shoot, no npm or external pipelines needed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-tailwind'
```

And then execute:

$ bundle install

Or install it yourself as:

$ gem install middleman-tailwind

## Usage

If you don't have any special configuration needs, things should just work out of the box if you activate the extension in your `config.rb`:

```ruby
activate :tailwind
```

When you start your middleman server, a thread will spin up with the tailwind CLI in `watch` mode, watching for changes in all the `.erb` files under your `source` directory. The default path for your generated tailwind CSS file is `source/stylesheets/tailwind.css`, but you can change that with a configuration option:

```ruby
activate :tailwind do |config|
  config.destination_path = "source/stylesheets/another-filename.css"
end
```

You might want to customize your tailwind.config.js. Tell middleman-tailwind where to find it with the following config option and it'll pick that up.

```ruby
activate :tailwind do |config|
  config.config_path = "tailwind.config.js"
end
```

In the same vein, you can customize the application css that tailwind uses, like so:

```ruby
activate :tailwind do |config|
  config.css_path = "tailwind/application.tailwind.css"
end
```

That's all. GLHF!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/middleman-tailwind.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
