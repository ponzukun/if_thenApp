class StandardPagesController < ApplicationController
  before_action :logged_in_user, only: :new

  def home
  end

  def about
  end

  def contact
  end

  def new
    if logged_in?
      @ifthen_rule = current_user.ifthen_rules.build
      @feed_items  = current_user.ifthen_rules.paginate(page: params[:page], per_page: 15)
    end
  end
end
