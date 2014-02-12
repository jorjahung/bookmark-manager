get '/users/forgotten_password' do
	erb :"users/forgotten_password"
end

post '/users/forgotten_password' do
	email = params[:email]
	user = User.first(:email => email)
    if user
      user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
      user.password_token_timestamp = Time.now
      user.save
      flash[:notice] = "Email sent!"
    else
      flash[:notice] = "Email is not registered"
    end
	redirect to('/')
end
