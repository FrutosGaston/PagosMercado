class ApplicationController < ActionController::API

  def error_json(status, title, detail)
    json = {
        "errors": [
            {
                "status": status,
                "title":  title,
                "detail": detail
            }
        ]
    }
    render json: json, status: status
  end

end
