module Response
  def message_response(message, status = :ok)
    json_response({ message: message }, status)
  end

  def json_response(json, status = :ok)
    render json: json, status: status
  end
end
