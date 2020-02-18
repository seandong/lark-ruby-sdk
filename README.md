# Lark

Unofficial ruby SDKS for lark [飞书](https://www.feishu.cn/)

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

初始化配置：

```ruby
# config/initializers/lark.rb

Lark.configure do |config|
  config.redis = Redis.new(url: 'redis://127.0.0.1:6379/1')
  # ...
end
```

新建 Lark API 接口实例：

```ruby
api = Lark::Api.new(
	app_id: 'xxx',
	app_secret: 'xxx',
	tenant_key: 'xxx',
	isv: false/true, # Internal app: false, ISV app: true
)
```

`app_access_token`：

```ruby
api.app_access_token
```

`tenant_access_token`：

```ruby
api.tenant_access_token
```

`app_ticket`：

```ruby
# 设置 app_ticket
api.app_ticket = xxx

# 获取 app_ticket
api.app_ticket
```

消息解密：

```ruby
Lark::Cipher.new(encrypt_key).decrypt(message)

# eg:
# encrypt = "P37w+VZImNgPEO1RBhJ6RtKl7n6zymIbEG1pReEzghk="
# Lark::Cipher.new('test key').decrypt encrypt
# => 'hello world'
```

## Api 列表


### 身份验证
[`lib/lark/apis/authen.rb`](lib/lark/apis/authen.rb)

| 名称 | 接口 |
| --- | --- |
| [请求身份验证](https://open.feishu.cn/document/ukTMukTMukTM/ukzN4UjL5cDO14SO3gTN) | `api.authen.index(redirect_uri, state)` |
| [获取登录用户身份](https://open.feishu.cn/document/ukTMukTMukTM/uEDO4UjLxgDO14SM4gTN) | `api.authen.access_token(code)` |
| [刷新 access_token](https://open.feishu.cn/document/ukTMukTMukTM/uQDO4UjL0gDO14CN4gTN) | `api.authen.refresh_access_token(refresh_token)` |
| [获取用户信息](https://open.feishu.cn/document/ukTMukTMukTM/uIDO4UjLygDO14iM4gTN) | `api.authen.user_info(user_access_token)` |


### 通讯录
[`lib/lark/apis/contact.rb`](lib/lark/apis/contact.rb)

| 名称 | 接口 |
| --- | --- |
| [获取通讯录授权范围](https://open.feishu.cn/document/ukTMukTMukTM/ugjNz4CO2MjL4YzM) | `api.contact.scope_get` |
| [新增部门](https://open.feishu.cn/document/ukTMukTMukTM/uYzNz4iN3MjL2czM) | `api.contact.department_add` |
| [批量新增部门](https://open.feishu.cn/document/ukTMukTMukTM/uMDOwUjLzgDM14yM4ATN) | `api.contact.department_batch_add` |
| [删除部门](https://open.feishu.cn/document/ukTMukTMukTM/ugzNz4CO3MjL4czM) | `api.contact.department_delete` |
| [更新部门信息](https://open.feishu.cn/document/ukTMukTMukTM/uczNz4yN3MjL3czM) | `api.contact.department_update` |
| [获取部门详情](https://open.feishu.cn/document/ukTMukTMukTM/uAzNz4CM3MjLwczM) | `api.contact.department_get` |
| [获取子部门列表](https://open.feishu.cn/document/ukTMukTMukTM/ugzN3QjL4czN04CO3cDN) | `api.contact.department_children` |
| [获取子部门 ID 列表](https://open.feishu.cn/document/ukTMukTMukTM/ukjNz4SO2MjL5YzM) | `api.contact.department_children_ids` |
| [批量获取部门详情](https://open.feishu.cn/document/ukTMukTMukTM/uczN3QjL3czN04yN3cDN) | `api.contact.department_batch_get` |
| [获取部门用户列表](https://open.feishu.cn/document/ukTMukTMukTM/uEzNz4SM3MjLxczM) | `api.contact.department_user_list` |
| [获取部门用户详情](https://open.feishu.cn/document/ukTMukTMukTM/uYzN3QjL2czN04iN3cDN) | `api.contact.department_user_detail_list` |
| [新增用户](https://open.feishu.cn/document/ukTMukTMukTM/uMzNz4yM3MjLzczM) | `api.contact.user_add` |
| [批量新增用户](https://open.feishu.cn/document/ukTMukTMukTM/uIDOwUjLygDM14iM4ATN) | `api.contact.user_batch_add` |
| [删除用户](https://open.feishu.cn/document/ukTMukTMukTM/uUzNz4SN3MjL1czM) | `api.contact.user_delete` |
| [更新用户信息](https://open.feishu.cn/document/ukTMukTMukTM/uQzNz4CN3MjL0czM) | `api.contact.user_update` |
| [批量获取用户信息](https://open.feishu.cn/document/ukTMukTMukTM/uIzNz4iM3MjLyczM) | `api.contact.user_batch_get` |
| [获取企业自定义用户属性配置](https://open.feishu.cn/document/ukTMukTMukTM/ucTN3QjL3UzN04yN1cDN) | `api.contact.tenant_custom_attr_get` |
| [查询批量任务执行状态](https://open.feishu.cn/document/ukTMukTMukTM/uUDOwUjL1gDM14SN4ATN) | `api.contact.task_get` |
| [获取应用管理员管理范围](https://open.feishu.cn/document/ukTMukTMukTM/uMzN3QjLzczN04yM3cDN) | `api.contact.user_admin_scope_get` |
| [获取角色列表](https://open.feishu.cn/document/ukTMukTMukTM/uYzMwUjL2MDM14iNzATN) | `api.contact.role_list` |
| [获取角色成员列表](https://open.feishu.cn/document/ukTMukTMukTM/uczMwUjL3MDM14yNzATN) | `api.contact.role_members` |
| [使用手机号或邮箱获取用户 ID](https://open.feishu.cn/document/ukTMukTMukTM/uUzMyUjL1MjM14SNzITN) | `api.user.batch_get_id` |


### 用户群组
[`lib/lark/apis/user.rb`](lib/lark/apis/user.rb)

| 名称 | 接口 |
| --- | --- |
| [获取用户所在的群列表](https://open.feishu.cn/document/ukTMukTMukTM/uQzMwUjL0MDM14CNzATN) | `api.user.group_list` |
| [获取群成员列表](https://open.feishu.cn/document/ukTMukTMukTM/uUzMwUjL1MDM14SNzATN) | `api.chat.members` |
| [搜索用户所在的群列表](https://open.feishu.cn/document/ukTMukTMukTM/uUTOyUjL1kjM14SN5ITN) | `api.chat.search` |


### 应用管理
[`lib/lark/apis/application.rb`](lib/lark/apis/application.rb)

| 名称 | 接口 |
| --- | --- |
| [校验应用管理员](https://open.feishu.cn/document/ukTMukTMukTM/uITN1EjLyUTNx4iM1UTM) | `api.application.is_user_admin` |
| [获取应用在企业内的可用范围](https://open.feishu.cn/document/ukTMukTMukTM/uIjM3UjLyIzN14iMycTN) | `api.application.app_visibility` |
| [获取用户可用的应用](https://open.feishu.cn/document/ukTMukTMukTM/uMjM3UjLzIzN14yMycTN) | `api.application.user_visible_apps` |
| [获取企业安装的应用](https://open.feishu.cn/document/ukTMukTMukTM/uYDN3UjL2QzN14iN0cTN) | `api.application.app_list` |
| [更新应用可用范围](https://open.feishu.cn/document/ukTMukTMukTM/ucDN3UjL3QzN14yN0cTN) | `api.application.app_update_visibility` |


### 应用商店
[`lib/lark/apis/pay.rb`](lib/lark/apis/pay.rb)

| 名称 | 接口 |
| --- | --- |
| [查询用户是否在应用开通范围](查询用户是否在应用开通范围) | `api.pay.paid_scope_check_user` |
| [查询租户购买的付费方案](https://open.feishu.cn/document/ukTMukTMukTM/uETNwUjLxUDM14SM1ATN) | `api.pay.order_list` |
| [查询订单详情](https://open.feishu.cn/document/ukTMukTMukTM/uITNwUjLyUDM14iM1ATN) | `api.pay.order_get` |


### 机器人 → 群信息和群管理
[`lib/lark/apis/chat.rb`](lib/lark/apis/chat.rb)

| 名称 | 接口 |
| --- | --- |
| [创建群](https://open.feishu.cn/document/ukTMukTMukTM/ukDO5QjL5gTO04SO4kDN) | `api.chat.create` |
| [获取群列表](https://open.feishu.cn/document/ukTMukTMukTM/uITO5QjLykTO04iM5kDN) | `api.chat.list` |
| [获取群信息](https://open.feishu.cn/document/ukTMukTMukTM/uMTO5QjLzkTO04yM5kDN) | `api.chat.info` |
| [更新群信息](https://open.feishu.cn/document/ukTMukTMukTM/uYTO5QjL2kTO04iN5kDN) | `api.chat.update` |
| [拉用户进群](https://open.feishu.cn/document/ukTMukTMukTM/ucTO5QjL3kTO04yN5kDN) | `api.chat.chatter_add` |
| [移除用户出群](https://open.feishu.cn/document/ukTMukTMukTM/uADMwUjLwADM14CMwATN) | `api.chat.chatter_delete` |
| [解散群](https://open.feishu.cn/document/ukTMukTMukTM/uUDN5QjL1QTO04SN0kDN) | `api.chat.disband` |


### 机器人信息和管理
[`lib/lark/apis/bot.rb`](lib/lark/apis/bot.rb)

| 名称 | 接口 |
| --- | --- |
| [获取机器人信息](https://open.feishu.cn/document/ukTMukTMukTM/uAjMxEjLwITMx4CMyETM) | `api.bot.info` |
| [拉机器人进群](https://open.feishu.cn/document/ukTMukTMukTM/uYDO04iN4QjL2gDN) | `api.bot.add` |
| [将机器人移出群](https://open.feishu.cn/document/ukTMukTMukTM/ucDO04yN4QjL3gDN) | `api.bot.remove` |


### 消息
[`lib/lark/apis/message.rb`](lib/lark/apis/message.rb)

| 名称 | 接口 |
| --- | --- |
| [批量发送消息](https://open.feishu.cn/document/ukTMukTMukTM/ucDO1EjL3gTNx4yN4UTM) | `api.message.batch_send` |
| [发送消息（文本/图片/富文本/名片/卡片）](https://open.feishu.cn/document/ukTMukTMukTM/uUjNz4SN2MjL1YzM) | `api.message.direct_send` |


### 图片
[`lib/lark/apis/image.rb`](lib/lark/apis/image.rb)

| 名称 | 接口 |
| --- | --- |
| [上传图片](https://open.feishu.cn/document/ukTMukTMukTM/uEDO04SM4QjLxgDN) | `api.image.upload` |
| [获取图片](https://open.feishu.cn/document/ukTMukTMukTM/uYzN5QjL2cTO04iN3kDN) | `api.image.download` |


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lark. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/lark/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lark project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lark/blob/master/CODE_OF_CONDUCT.md).
