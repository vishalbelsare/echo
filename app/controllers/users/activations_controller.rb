class Users::ActivationsController < ApplicationController

  skip_before_filter :require_user
  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.find_by_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?

    respond_to do |format|
      format.html do
        render :template => 'users/activations/new', :layout => 'static'
      end
    end
  end

  def create
    @user = User.find(params[:id])

    raise Exception if @user.active?

    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      set_info I18n.t('users.activation.messages.success')
      flash_info
      redirect_to welcome_path
    else
      set_error I18n.t('users.activation.messages.failed')
      flash_error
      render :template => 'users/activations/new', :layout => 'static'
    end
  end




end
