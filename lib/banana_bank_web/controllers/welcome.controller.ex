defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: :ok, message: "Welcome to banana bank"})
  end
end
