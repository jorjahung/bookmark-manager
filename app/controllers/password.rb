get '/users/reset_password' do
	erb :"users/reset_password", :layout => !request.xhr?
end

post '/users/reset_password' do
	email = params[:email]
	user = User.first(:email => email)
    if user
      user.password_token = (1..50).map{(('A'..'Z').to_a+('a'..'z').to_a+(1..9).to_a).sample}.join
      user.password_token_timestamp = Time.now
      user.save
      # send an email with link that should be "localhost:9393/users/reset_password/#{user.password_token}"
      flash[:notice] = "Email sent!"
    else
      flash[:notice] = "Email address is not registered"
    end
	redirect to('/')
end

get '/users/reset_password/:token' do |token|
	user = User.first(:password_token => token)
	if user
		expiry_time = Time.parse(user.password_token_timestamp)+(60*60)
		if Time.now <= expiry_time # is fine
			erb :"users/get_new_password"
		else
			flash[:errors] = ["Password reset token expired"]
			user.update(:password_token => nil,
									:password_token_timestamp => nil)
			redirect to('/users/reset_password')
		end
	else
		flash[:errors] = ["Failed to find password reset token"]
		redirect to('/')
	end
end

post '/users/reset_password/:token' do
 user = User.first(:password_token =>  params[:_token])
 	# The token must be a hidden field on the form and it must be checked again after submission. 
	
 	if user && user.email == params[:email]
		user.attributes = {:email => user.email,
				:password => params[:password],
				:password_confirmation => params[:password_confirmation],
				:password_token => nil, # After the new password is set, remove the token from the database, so that it couldn't be used again.
				:password_token_timestamp => nil}

			if user.save
				session[:user_id] = user.id
				redirect to('/')
			else 
				flash.now[:errors] = user.errors.full_messages
				erb :"users/get_new_password"
			end
	else
		flash[:errors] = ["Failed to find email and reset token combination"]
		erb :"users/get_new_password"
	end
end
