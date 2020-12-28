require 'money/bank/currencylayer_bank'

class ApplicationController < Sinatra::Base
  	configure do
    	set :views, "app/views"
    	set :public_dir, "public"
  	end

  	get '/' do
      @conversions = Conversion.all
   		erb :index
  	end

    get '/new' do
      erb :new
    end

    post '/new' do
      new_conversion = Conversion.new({
        from: params[:from],
        to: params[:to],
        amount: params[:amount],
        result: convert(params[:amount].to_f)
      })
      new_conversion.save
      redirect '/'
    end

    def convert(amount)
      mclb = Money::Bank::CurrencylayerBank.new
      mclb.access_key = 'eba5f3dbb34fa7f9b73414c275daaeb9'
      mclb.update_rates
      rate = mclb.get_rate(params[:from], params[:to])

      return (amount * rate).round(2)
    end
end
