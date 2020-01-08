class StandardPagesController < ApplicationController
  before_action :logged_in_user, only: :new

  def home
    if logged_in?
      if params[:listen].present?
        @feed_items = current_user.ifthen_rules.paginate(page: params[:page], per_page: 15).listen(params[:listen])
      elsif params[:listen].blank?
        @feed_items = []
      end
    end
  end

  def about
  end

  def contact
  end

  def new
    if logged_in?
      @ifthen_rule = current_user.ifthen_rules.build
      if params[:q]
        @feed_items = IfthenRule.search_by_keyword(params[:q]).paginate(page: params[:page])
      else
        @feed_items = current_user.ifthen_rules.paginate(page: params[:page], per_page: 15)
      end
    end
  end
end
