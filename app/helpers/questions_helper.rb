module QuestionsHelper
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

  def link_to_add_fields name, f, association, type
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |form|
      render("shared/"+association.to_s.singularize + "_" + type, f: form)
    end
    link_to name, "", class: "add_fields",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def disable_select? action
    action == "edit"
  end

  def text_for_edit_state state
    state == "waiting" ? t("check") : t("edit")
  end

  def check_answer_for list_checked_answer, answer
    list_checked_answer.detect{|result| result.answer_id == answer.id}
  end

  def label_for is_correct
    if is_correct
      content_tag :span, class: "lable label-primary" do
        t "correct"
      end
    else
      content_tag :span, class: "lable label-danger" do
        t "incorrect"
      end
    end
  end

  def bg_for answer
    "bg-success" if answer.is_correct?
  end
end
