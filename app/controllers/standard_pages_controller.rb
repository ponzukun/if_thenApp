class StandardPagesController < ApplicationController
  def home
    if logged_in?
      @ifthen_rule = current_user.ifthen_rules.build
      @feed_items  = current_user.ifthen_rules.paginate(page: params[:page], per_page: 15)
    end
  end

  def about
  end

  def contact
  end
end
