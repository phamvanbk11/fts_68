class Chatwork
  class << self
    def send_message exam
      room_id = Settings.room_id.to_s
      begin
        to_account_id = ChatWork::Member.get(room_id: room_id)
          .find{|member| member["name"] == exam.user.name}["account_id"]
        message_body = I18n.t "chatwork_success",
          subject_name: exam.subject.name, id: to_account_id,
          score: exam.number_of_correct,
          total_questions: exam.subject.number_of_questions
        ChatWork::Message.create room_id: room_id, body: message_body
      rescue
        to_account_id = I18n.t "undefined_user"
        message_body = I18n.t "chatwork_error",
          subject_name: exam.subject.name, score: exam.number_of_correct,
          total_questions: exam.subject.number_of_questions
        ChatWork::Message.create room_id: room_id, body: message_body
      end
    end
  end
end
