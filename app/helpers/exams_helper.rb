module ExamsHelper
  def check_state_for_span state
    case state
    when "start"
      "primary"
    when "testing"
      "warning"
    when "uncheck"
      "info"
    when "checked"
      "success"
    end
  end
end
