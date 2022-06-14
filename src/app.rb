require 'bundler'
Bundler.require

require File.expand_path('../db/db.rb', __FILE__)

module My
class App < Sinatra::Base

    configure do
        set :sessions, true
        register Sinatra::ActiveRecordExtension # use activerecord
        #use Rack::PostBodyContentTypeParser # request json
    end
    helpers do
        def date
            @date ||= Date.new
        end
    end

    # TODO: move to other file
    get '/' do
        "Hello World!!\n"
    end

end
end
