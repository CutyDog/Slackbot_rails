module  Body

    class TestService
        def initialize(json)
            @json=json
        end
        def execute
            #Faradayを使って、JSON形式のファイルをPOSTできるようにする
            conn = Faraday::Connection.new(:url => 'https://my-men.slack.com') do |builder|
                builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
                builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
                builder.adapter Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
            end

            message = "レムは知っています！"

            if @json[:event][:type] != "bot_message" #これがないと無限ループになる
            body = {token: ENV['BOT_USER_ACCESS_TOKEN'],
                    channel: 'botテスト',
                    text: message}
            conn.post '/api/chat.postMessage',body.to_json,
                {"Content-type" => 'application/json',
                 "Authorization"=>"Bearer #{ENV['BOT_USER_ACCESS_TOKEN']}"}
                #ヘッダーはつけなければいけないらしい、このままで大丈夫です。
            end
        end
    end 
end