ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address					=> "smtp.sendgrid.net",
	:port						=> "587",
	:authentication				=> :plain,
	:user_name					=> "app27199106@heroku.com",
	:password					=> "dirxeu5k",
	:domain						=> "heroku.com",
	:enable_starttls_auto		=> true
}