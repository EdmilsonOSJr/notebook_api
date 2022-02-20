class AuthsController < ApplicationController

    def create
        puts " ++++++++++++++ #{params}"
        
        payload = {"name": params[:name]}
        hmac_secret = 'my$ecretK3y'

        token = JWT.encode payload, hmac_secret, 'HS256'
        render json: { token: token}
        

    end


end
