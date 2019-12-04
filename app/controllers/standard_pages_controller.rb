class StandardPagesController < ApplicationController
  def home
    @ifthen_rule = current_user.ifthen_rules.build if logged_in?
  end

  def about
  end

  def contact
  end
end
