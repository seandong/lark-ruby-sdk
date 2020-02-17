# Lark

Unofficial ruby SDKS for lark [飞书](https://www.feishu.cn/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lark'
```

And then execute:

	$ bundle install

Or install it yourself as:

	$ gem install lark


## Usage

Add initialize configure to your project:

```ruby
# config/initializers/lark.rb

Lark.configure do |config|
  config.redis = Redis.new(url: 'redis://127.0.0.1:6379/1')
  # ...
end
```

Create lark API

```ruby
api = Lark::Api.new(
	app_id: 'xxx',
	app_secret: 'xxx',
	tenant_key: 'xxx',
	isv: false/true, # Internal app: false, ISV app: true
)
```

Invoke lark api, For example:

```ruby
# Get chat list
api.contact.list
```

Decrypt message

```ruby
Lark::Cipher.new(encrypt_key).decrypt(message)

# eg:
# encrypt = "P37w+VZImNgPEO1RBhJ6RtKl7n6zymIbEG1pReEzghk="
# Lark::Cipher.new('test key').decrypt encrypt
# => 'hello world'
```

## Api List

### 授权 (auth)

获取 app_access_token

	api.app_access_token

获取 tenant_access_token

	api.tenant_access_token

重新推送 app_ticket

	api.auth.app_ticket_resend

更新 app_ticket

	api.app_ticket = xxxx

### 身份验证 (authen)

请求身份验证

	api.authen.index(redirect_uri, state)

获取登录用户身份

	api.authen.access_token(code)

刷新 access_token

	api.authen.refresh_access_token(refresh_token)

获取用户信息

	api.user_info(user_access_token)


...


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lark. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/lark/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lark project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lark/blob/master/CODE_OF_CONDUCT.md).
