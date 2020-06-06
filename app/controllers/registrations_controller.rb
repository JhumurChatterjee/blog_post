class RegistrationsController < Devise::RegistrationsController
  def check_email_duplicacy
    user = User.find_by(email: params[:email])

    if user
      render status: :unprocessable_entity, json: { message: "Email is already taken." }
    else
      render status: :ok, json: { message: "Email is valid." }
    end
  end
end
