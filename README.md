[![Gem Version](https://badge.fury.io/rb/lark-sdk.svg)](https://badge.fury.io/rb/lark-sdk)

> Ruby SDKs for Lark(飞书) API https://open.feishu.cn/

## 安装

Add this line to your application's Gemfile:

```ruby
gem 'lark-sdk'
```

And then execute:

	$ bundle install

Or install it yourself as:

	$ gem install lark-sdk

	require 'lark/sdk'

## 使用说明

初始化：

```ruby
# config/initializers/lark.rb

Lark.configure do |config|
  config.redis = Redis.new(url: 'redis://127.0.0.1:6379/1')
  # ...
end
```

实例化 API：

```ruby
api = Lark::Api.new(
	app_id: 'xxx',
	app_secret: 'xxx',
	tenant_key: 'xxx',
	isv: false/true, # 自建应用: false, 应用商店应用: true
)
```

加/解密：

```ruby

cipher = Lark::Cipher.new(encrypt_key)

# 解密
cipher.decrypt(message)

# 加密
cipher.encrypt(message)
```

[Api 列表](https://github.com/mycolorway/lark-ruby-sdk/wiki/API-List)


## 贡献

如果你有好的意见或建议，欢迎给我们提issue或pull request。

## License

The MIT License(http://opensource.org/licenses/MIT)

请自由地享受和参与开源
