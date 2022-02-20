class ContactsController < ApplicationController
include ErrorSerializer

  before_action :set_contact, only: %i[ show update destroy ]
  
  # GET /contacts
  def index
    page_number = params[:page].try(:[], :number)
    per_page = params[:page].try(:[], :size)

    @contacts = Contact.all.page(page_number).per(per_page)

    # cach-control -------- expires_in 30.seconds, public: true
    if stale?(etag: @contacts)
      render json: @contacts, include: [:kind, :phones, :address]
    end
  end

  # GET /contacts/1
  def show
    render json: @contact, include: [:kind, :phones, :address]#, meta: {author: "Edmilson"}#, methods: :birthdate_br 
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: ErrorSerializer.serialize(@contact.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
        
    def contact_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    #  params.require(:contact).permit(:name, :email, :birthdate, :kind_id, 
    #  phones_attributes: [:id, :number, :_destroy],
    #  address_attributes: [:id, :street, :city])
    end
end
