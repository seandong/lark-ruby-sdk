require_relative '../api'

module Lark
  module Apis
    module Bot
      def info
        get 'bot/v3/info/'
      end

      def add(chat_id)
        post 'bot/v3/add', {chat_id: chat_id}
      end

      def remove(chat_id)
        post 'bot/v3/remove', {chat_id: chat_id}
      end

      # @param [String] token 机器人Token
      # @param [String] title 消息标题
      # @param [String] text  消息内容
      def send_message(token, title, text)
        post "bot/hook/#{token}", { title: title, text: text }
      end

      # @param [String] token     机器人Token
      # @param [String] title     消息标题
      # @param [String] markdown  markdown内容。注意只支持部分 markdown 语法。
      #                           若需要使用图片，markdown 中的图片链接必须为通过「上传图片」接口上传的图片的 image_key，直接使用图片链接无法发送
      #                           详见https://open.feishu.cn/document/ukTMukTMukTM/uADOwUjLwgDM14CM4ATN。
      # @param [Hash] btnDic      配置按钮。key 为按钮文字，value 为按钮点击跳转的链接。
      def send_markdown(token, title, markdown, btnDic)
        body = {
          'msg_type': 'interactive',
          'card': {
            'elements': [{
                           'tag': 'markdown',
                           'content': markdown
                         }],
            'header': {
              'title': {
                'content': title,
                'tag': 'plain_text'
              }
            }
          }
        }
        unless btnDic.empty?
          actions = []
          btnDic.each_pair do |btn, url|
            actions.push({ 'tag': 'button',
                           'text': {
                             'tag': 'plain_text',
                             'content': btn.to_s
                           },
                           'type': 'primary',
                           'url': url })
          end
          body[:card][:elements].push({ 'tag': 'action',
                                        'actions': actions })
        end
        post "bot/v2/hook/#{token}", body
      end
    end
  end
end