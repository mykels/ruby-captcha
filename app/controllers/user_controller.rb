# frozen_string_literal: true

class UserController < ApplicationController
  before_action :setup_negative_captcha, only: %i[new create_negative]

  def index
    new
  end

  def new
    p 'preparing for a new user..'
    @user = User.new
  end

  def create_negative
    p 'preparing for creating user using negative captcha..'
    @user = User.new(@captcha.values[:username], @captcha.values[:password]) if @captcha.valid?
    redirect_to "/user/#{@user.username}/#{@user.password}" if @captcha.valid?
    redirect_to '/user/bot/bot' unless @captcha.valid?
  end

  def create_invisible
    p 'preparing for creating user using invisible captcha..'
    user = params[:user]
    @user = User.new(user[:username], user[:password])
    redirect_to "/user/#{@user.username}/#{@user.password}"
  end

  def show
    @user = User.new(params[:username], params[:password])
  end

  private

  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
        # A secret key entered in environment.rb. 'rake secret' will give you a good one.
        secret: '91f8046c7644c95623b57e5a0d7a82c20be5f1f060f4fc7d6df1f7da2249934a85cde97ea38ae457990ccd05dd1de8db89a78710c600fbdf5142d8b5a7d60c52',
        spinner: request.remote_ip,
        # Whatever fields are in your form
        fields: %i[username password],
        # If you wish to override the default CSS styles (position: absolute; left: -2000px;) used to position the fields off-screen
        css: 'display: none',
        params: params
    )
  end
end
