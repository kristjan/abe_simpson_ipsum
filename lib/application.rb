require 'haml'
require 'sinatra'

require 'parser'

class AbeSimpsonIpsum < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :public_folder, File.join(root, 'public')

  set :data, File.join(File.dirname(__FILE__), '..', 'data', 'abe.html')
  set :ipsum, Proc.new { Parser.new(File.read(data)) }

  get '/favicon.ico' do
    ''
  end

  get '/?:count?' do
    @count = (params[:count] || rand(3) + 2).to_i
    haml :index
  end
end
