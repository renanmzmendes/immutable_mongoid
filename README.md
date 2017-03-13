# ImmutableMongoid
The motivation behind this gem is to bring immutable behavior to MongoDB database. That means that changes to records are never lost! You will always have the complete history of a record's changes. It relies on `mongoid`.

## Usage
To use this plugin you must simply add the following line to your model:
`include ImmutableMongoid`

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'immutable_mongoid', github: renanmzmendes/immutable_mongoid
```

And then execute:
```bash
$ bundle
```

## Contributing
I have a small prototype working, but I'd like some help from more expert mongoid users in order to make this a robust and reliable gem.

If you are interested in contributing, just fork the repository and send me a pull request when your changes are ready. Don't forget to include test cases! :-)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
