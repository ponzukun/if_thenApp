class IfthenRulesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user,   only: :destroy

  def create
    @ifthen_rule = current_user.ifthen_rules.build(ifthen_rule_params)
    if @ifthen_rule.save
      flash[:success] = "IfthenRule created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'standard_pages/home'
    end
  end

  def destroy
    @ifthen_rule.destroy
    flash[:success] = "IfthenRule deleted"
    # redirect_to request.referrer || root_url
    redirect_back(fallback_location: root_url)
  end

  private

    def ifthen_rule_params
      params.require(:ifthen_rule).permit(:if_content, :then_content, :picture)
    end

    def correct_user
      @ifthen_rule = current_user.ifthen_rules.find_by(id: params[:id])
      redirect_to root_url if @ifthen_rule.nil?
    end
end
