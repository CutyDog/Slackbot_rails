class SlackController < ApplicationController

    def index
        @lem_announces = { "レム名言集" =>
                         { one: "ここから始めましょう\nイチからーー\nいいえ、ゼロから！",
                           two: "姉様姉様。\nどうやら少し混乱されているみたいですお客様",
                           three: "鬼がかってますね！",
                           four: "穀潰しの発言ですよ。\n聞きましたか姉様？",
                           five: "言質、取りました！\nもう引っ込められませんよ♪" } }
        render json: @lem_announces
    end

    def create
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
