module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_404(msg)
    json_response(msg, 404)
  end
end