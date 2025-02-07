class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(set_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private
  def set_params
    params.expect(user: [:username, :email])
  end

end
