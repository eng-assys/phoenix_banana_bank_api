defmodule BananaBankWeb.Plugs.Auth do
  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
    {:ok, data} <- BananaBankWeb.Token.verify(token) do
      Plug.Conn.assign(conn, :user_id, data)
    else
      _error->
        conn
        |> Plug.Conn.put_status(:unauthorized)
        |> Phoenix.Controller.put_view(json: BananaBankWeb.ErrorJSON)
        |> Phoenix.Controller.render(:error, status: :unauthorized)
        |> Plug.Conn.halt()
    end
  end
end
