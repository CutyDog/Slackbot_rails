class SlackController < ApplicationController

    def index
    end

    def create
        # # RTM Clientのインスタンス生成
        # client = Slack::RealTime::Client.new

        # # ユーザからのメッセージを検知したときの処理
        # client.on :message do |data|
        #     if data['text'].include?('こんにちは')
        #     client.message channel: data['channel'], text: "Hi!"
        #     end
        #     if data['text'].include?('かしこい') || data['text'].include?('えらい')
        #     client.message channel: data['channel'], text: "Thank you!"
        #     end
        #     if data['text'].include?('おやすみ')
        #     client.message channel: data['channel'], text: "Good night"
        #     end
        # end

        json_hash  = params[:slack]
        Body::TestService.new(json_hash).execute

        @body = JSON.parse(request.body.read)
        case @body['type']
        when 'url_verification'
            render json: @body
        when 'event_callback'
            # ..
        end
    end
end
