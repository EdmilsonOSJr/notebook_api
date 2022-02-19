class AddressesController < ApplicationController

    before_action :set_contact

    def destroy 
        @contact.address.destroy
    end


    def create 
        if @contact.address = Address.new(address_params)
            render json: @contact.address, status: :created, localtion: contact_address_url(@contact)
        else
            render json: @contact.erros, status: :unprocessable_entity 
        end
    end

    def update
        if @contact.address.update(address_params)
            render json: @contact.address 
        else
            render json: @contact.erros, status: :unprocessable_entity 
        end
    end

    def show
        render json: @contact.address
    end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
        @contact = Contact.find(params[:contact_id])
    end

    def address_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

end
