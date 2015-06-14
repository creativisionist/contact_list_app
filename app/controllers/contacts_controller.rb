class ContactsController < ApplicationController
  def home
    @contact = Contact.first
  end

  def index
    if user_signed_in?
      @contacts = current_user.contacts
    else
      flash[:info] = "Please sign in to see your contacts."
      redirect_to "/users/sign_in"
    end
  end

  def show
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contacts = @contact.full_name
    if params[:group]
      @contacts = Group.find_by(name: params[:group]).contacts
    end
  end

  def new
  end

  def create
    Contact.create(first_name: params[:first_name], middle_name: params[:middle_name], last_name: params[:last_name], email: params[:email], phone_number: params[:phone_number], bio: params[:bio], user_id: current_user.id)
  end

  def edit
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
  end

  def update
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.update(first_name: params[:first_name], middle_name: params[:middle_name], last_name: params[:last_name], email: params[:email], phone_number: params[:phone_number], bio: params[:bio])
  end

  def destroy
    contact_id = params[:id]
    contact = Contact.find_by(id: contact_id)
    contact.destroy
  end

  def search
    search_term = params[:search]
    @contact = Contact.where("first_name LIKE ? OR middle_name LIKE ? OR last_name LIKE ? OR email LIKE ? OR phone_number LIKE ? OR phone_number LIKE ? OR bio LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
    render :index
  end
end