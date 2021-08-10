class ApplicationController < ActionController::API

    def hello
        client = Slack::Web::Client.new
        client.chat_postMessage(channel: '#botテスト', text: 'レムちゃんだよ♪')
        # client.chat_postMessage(channel: '#general', text: 'Hello World', as_user: true)
    end
end
