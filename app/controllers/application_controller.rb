class ApplicationController < ActionController::API


    def hello
        client = Slack::Web::Client.new
        client.chat_postMessage(channel: '#botテスト', text: 'おはようございます♪')
        # client.chat_postMessage(channel: '#general', text: 'Hello World', as_user: true)
    end

    def name
        client = Slack::Web::Client.new
        client.chat_postMessage(channel: '#botテスト', text: 'スバル君のレムです')
    end

    def love
        client = Slack::Web::Client.new
        client.chat_postMessage(channel: '#botテスト', text: 'レムは、スバル君を愛しています')
    end
end
