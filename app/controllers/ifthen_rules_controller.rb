class IfthenRulesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @ifthen_rule = current_user.ifthen_rules.build(ifthen_rule_params)
    if @ifthen_rule.save
      flash[:success] = "IfthenRule created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def ifthen_rule_params
      params.require(:ifthen_rule).permit(:if, :then)
    end
end
