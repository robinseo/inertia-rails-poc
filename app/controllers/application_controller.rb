class ApplicationController < ActionController::Base
  use_inertia_instance_props

  before_action :set_csrf_cookie

  # Rails Flash를 inertia $page global property로 전달
  inertia_share flash: -> {
    {
      success: flash.notice,
      alert: flash.alert
    }
  }

  # Rails uses HTTP_X_CSRF_TOKEN, but axios sends HTTP_X_XSRF_TOKEN (different name, X instead of C)
  # By overriding `request_authenticity_tokens` we can tell Rails to check HTTP_X_XSRF_TOKEN, too
  # Source: https://github.com/rails/rails/blob/v6.0.3.2/actionpack/lib/action_controller/metal/request_forgery_protection.rb#L305-L308
  def request_authenticity_tokens # Axios가 CSRF Token을 사용하도록 함
    super << request.headers['HTTP_X_XSRF_TOKEN']
  end

  private

  def default_render  # default renderer를 inertia로 변경
    render(inertia: true)
  end

  def set_csrf_cookie # CSRF Token을 쿠키에 저장
    cookies['XSRF-TOKEN'] = {
      value: form_authenticity_token,
      same_site: 'Strict'
    }
  end
end
