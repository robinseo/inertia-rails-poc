class ContactsController < ApplicationController
  before_action :set_contact, only: %i[update destroy]

  def index
    @contacts = Contact.eager_load(:contact_numbers).all.as_json(include: :contact_numbers)
  end

  def new
    @contact_number_labels = ContactNumber.labels.keys
  end

  def edit
    @contact = Contact.eager_load(:contact_numbers).find(params[:id]).as_json(include: :contact_numbers)
    @contact_number_labels = ContactNumber.labels.keys
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: "Contact was successfully created."
    else
      redirect_to new_contact_path, inertia: { errors: @contact.errors }
    end
  end

  def update
    Contact.transaction do
      @contact.contact_numbers.delete_all
      @contact.update!(contact_params)
      redirect_to contacts_path, notice: "Contact was successfully updated."
    end

  rescue ActiveRecord::RecordInvalid
    redirect_to edit_contact_path(@contact), inertia: { errors: @contact.errors }
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "Contact was successfully destroyed."
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :company, contact_numbers_attributes: [:label, :number])
  end
end
