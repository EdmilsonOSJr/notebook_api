class PhonesController < ApplicationController
    before_action :set_contact

    def destroy 
        phone = Phone.find(phones_params[:id])
        phone.destroy
    end


    def create 
        @contact.phones << Phone.new(phones_params)

        if @contact.save
            render json: @contact.phones, status: :created, localtion: contact_phones_url(@contact)
        else
            render json: @contact.erros, status: :unprocessable_entity 
        end
    end

    def update
        phone = Phone.find(phones_params[:id])

        if phone.update(phones_params)
            render json: @contact.phones 
        else
            render json: @contact.erros, status: :unprocessable_entity 
        end
    end

    def show
        render json: @contact.phones
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def phones_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

end
