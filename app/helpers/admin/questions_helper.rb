module Admin::QuestionsHelper
  def css_class type
    case type
    when "active"
      "success"
    when "waiting"
      "warning"
    when "rejected"
      "danger"
    when "inactive"
      "default"
    end
  end

  def number_order num
    num += 1
  end

  def mapping_enum_to_i18n type, hash_array
    map_array = {}
    hash_array.each{|key, value| map_array[I18n.t "#{type}.#{key}"] = value}
    map_array
  end
end
