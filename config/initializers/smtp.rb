ActionMailer::Base.smtp_settings = {
  address: "smtp-relay.sendinblue.com",
  port: 587,
  domain: "https://blog-post-rails.herokuapp.com",
  user_name: ENV["SENDINBLUE_USERNAME"],
  password: ENV["SENDINBLUE_PASSWORD"]
}
