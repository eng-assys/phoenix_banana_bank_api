defmodule BananaBank.ViaCep.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def call(zip_code) do
    "#{zip_code}/json"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => "true"}}}) do
    {:error, :not_found}
  end
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end
  defp handle_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :bad_request}
  end
  defp handle_response({:error, _}) do
    {:error, :internal_server_error}
  end

end
