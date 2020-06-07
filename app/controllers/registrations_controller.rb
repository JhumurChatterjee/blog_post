class RegistrationsController < Devise::RegistrationsController
  def check_email_duplicacy
    user = User.find_by(email: params[:email])

    if user
      render status: :unprocessable_entity, json: { message: t("invalid_email") }
    else
      render status: :ok, json: { message: t("valid_email") }
    end
  end
end
