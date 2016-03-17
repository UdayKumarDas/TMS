class UserMailer < ApplicationMailer

	def invitation_to_user(user,invite_user,project)
		@project= project
		@user = user
		@invite_user = invite_user
	    @url  = 'http://example.com/login'
	    mail(to: @invite_user.email, subject: "#{@user.name} invited you")
	end

end
