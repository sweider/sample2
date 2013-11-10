module MessagesHelper

  def messages_count(messages)
    if messages.any?
      messages.count
    else
      "0"
    end
  end

  def cut_message(string)
    if string.length > 70
      string = string[0..70] + '...'
    end
    string
  end
end