# frozen_string_literal: true

module BaseApi
  module Users
    def self.new_user(params)

      user.assign_attributes(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        phone: params[:phone]
      )
      begin
        user.save!
      rescue ActiveRecord::RecordInvalid => exception
        return ServiceContract.error('Error saving user.') unless user.valid?
      end


      ServiceContract.success(user)
    end

    def self.destroy_user(user_id)
      user = User.find(user_id)
      return ServiceContract.error('Error deleting user') unless user.destroy

      ServiceContract.success(payload: user)
    end

    def self.update_user(user_id, user_params)
      user = User.find(user_id)

        # update user's attributes
        user.assign_attributes(
          first_name: user_params[:first_name],
          last_name: user_params[:last_name],
          email: user_params[:email],
          phone: user_params[:phone]
          password: user_params[:password]
        )

      begin
        user.save! 
      rescue ActiveRecord::RecordInvalid => exception 
        return ServiceContract.error('Error saving user.') unless user.valid?
      end

      ServiceContract.success(user)
    end
  end
end
