module ApplicationHelper
  module Flash
    def helper_success(action)
      { success: t(action, scope: [:message]) }
    end

    def helper_errors(obj)
      full_msg = "<ul>"
      obj.errors.full_messages.each do |msg|
        full_msg << "<li>#{msg}</li>"
      end
      full_msg << "</ul>"
      { error: full_msg }
    end

    def helper_render_errors(obj)
      full_msg = "<ul>"
      obj.errors.full_messages.each do |msg|
        full_msg << "<li>#{msg}</li>"
      end
      full_msg << "</ul>"
      flash.now[:error] = full_msg
    end
  end
end
