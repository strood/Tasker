module ApplicationHelper

  def auth_token
    # This creates us an auth token tage with ruby.
    # We need to embed with ruby, and clean our output so we dont get XSS
    html= '<input type="hidden" name="authenticity_token"'
    html+= "value=\"#{h(form_authenticity_token)}\"/>"

    html.html_safe
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
