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

## 使用

初始化：

```ruby
# config/initializers/lark.rb

Lark.configure do |config|
	config.redis = Redis.new(url: 'redis://127.0.0.1:6379/1')
	config.default_app_id = 'xxx'       # 应用 app ID
	config.default_app_secret = 'xxx'   # 应用 app secret
	config.default_isv = true           # 自建应用: false, 应用商店应用: true
	config.api_base_url = 'https://open.feishu.cn/open-apis/' # API 地址，默认：https://open.feishu.cn/open-apis/
  # ...
end
```

实例化 API：

```ruby
api = Lark::Api.new(
	app_id: 'xxx',        # default: Lark.config.default_app_id
	app_secret: 'xxx',    # default: Lark.config.default_app_secret
	isv: false/true,      # default: Lark.config.default_app_secret
	tenant_key: 'xxx'     # required while internal app
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

[Api 列表](https://github.com/seandong/lark-ruby-sdk/wiki/apis)


## 贡献

如果你有好的意见或建议，欢迎给我们提issue或pull request。

## License

The MIT License(http://opensource.org/licenses/MIT)

请自由地享受和参与开源
