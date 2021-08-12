require 'rss'
desc 'レムちゃんBotのリマインダー'

#Slack API設定
conn = Faraday::Connection.new(:url => 'https://my-men.slack.com') do |builder|
    builder.use Faraday::Request::UrlEncoded  # リクエストパラメータを URL エンコードする
    builder.use Faraday::Response::Logger     # リクエストを標準出力に出力する
    builder.adapter Faraday::Adapter::NetHttp     # Net/HTTP をアダプターに使う
end
channel = 'レムちゃんねる'
token = ENV['BOT_USER_ACCESS_TOKEN']
con_type = 'application/json'
auth = "Bearer #{ENV['BOT_USER_ACCESS_TOKEN']}"



task :morning_lem do
    greet = {token: token, channel: channel, text: "おはようございます♪"}
    conn.post '/api/chat.postMessage', greet.to_json, {"Content-type" => con_type, "Authorization"=> auth}

    categories = [:domestic, :business]
    categories.each do |category|
        cat = (category==:domestic ? "国内" : "経済")
        rss_source = "https://news.yahoo.co.jp/rss/topics/#{category}.xml"
        rss = RSS::Parser.parse(rss_source, validate: false)
        item = rss.items[1]
        text = "今日の#{cat}ニュースです！\n『#{item.title}』\n#{item.link}"
        news_pick = {token: token, channel: channel, text: text}
        conn.post '/api/chat.postMessage', news_pick.to_json, {"Content-type" => con_type, "Authorization"=> auth}
    end
end

task :send_photo => :environment do
    client = Slack::Web::Client.new
    client.files_upload(
        channels: '#botテスト',
        file: Faraday::UploadIO.new('public/images/lemu/lemu_1.jpg', 'image/jpeg'),
        title: 'レム',
        filename: 'lemu_1.jpg',
        initial_comment: '写真アップ'
    )
end