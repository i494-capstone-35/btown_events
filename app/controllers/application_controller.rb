class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  before_filter :prepare_for_mobile

  private

  MOBILE_USER_AGENTS = 'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
    'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|'                    +
    'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|'                    +
    'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|'                    +
    'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|'                       +
    'mobile'

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ Regexp.new(MOBILE_USER_AGENTS, true)
    end
  end
  helper_method :mobile_device?

  #railscast 199
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format         = :mobile if mobile_device?
  end
end
