class ApplicationController < ActionController::API

  def error_json(code, title, detail)
    json = {
        "errors": [
            {
                "status": 'error',
                "code": code,
                "title":  title,
                "detail": detail
            }
        ]
    }
    render json: json, status: 'error'
  end

end
