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


            if @json[:event].has_key?(:client_msg_id) #これがないと無限ループになる
                if @json[:event][:text].include?("<@U02AR9TTRKN>") #メンションの時だけ呼び出す
                    channel = @json[:event][:channel]
                    user = @json[:event][:user]
                    words = ["、レムもそう思います！", "、鬼がかってますね！", "、さすがです！", "、ちょっと何言ってるか分かんないです:raised_hands:",
                    "、レムには難しいです:sweat_drops:", "はレムのヒーローです:sparkles:", "、天才です！"]
                    
                    if user=="U025DPJ1VB6"
                        message = "大志くん#{words[rand(7)]}"
                    elsif user=="U02583J9FPU"
                        message = "勇汰くん#{words[rand(7)]}"
                    elsif user=="U025L7P45Q9"
                        message = "亮太くん#{words[rand(7)]}"
                    else
                        message = "レムもそう思います！"
                    end
                    # message = "Shut up.\n Don't open your dirty mouth!!"
                    

                    body = {token: ENV['BOT_USER_ACCESS_TOKEN'],
                            channel: channel,
                            text: message}
                    conn.post '/api/chat.postMessage',body.to_json,
                        {"Content-type" => 'application/json',
                        "Authorization"=>"Bearer #{ENV['BOT_USER_ACCESS_TOKEN']}"}
                        #ヘッダーはつけなければいけないらしい、このままで大丈夫です。
                end
            end
        end
    end 
end