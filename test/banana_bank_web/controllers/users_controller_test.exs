defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias BananaBank.Users.User

  setup do
    params = %{
      "name" => "John Doe",
      "email" => "jhon@email.com",
      "password" => "123456",
      "zip_code" => "29560000"
    }

    body = %{
      "cep" => "29560-000",
      "logradouro" => "",
      "complemento" => "",
      "bairro" => "",
      "localidade" => "Iúna",
      "uf" => "ES",
      "ibge" => "3202400",
      "gia" => "",
      "ddd" => "28",
      "siafi" => "5865"
    }

    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "successfully creates an user", %{conn: conn, user_params: params, body: body} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "email" => "jhon@email.com",
                 "id" => _id,
                 "name" => "John Doe",
                 "zip_code" => "29560000"
               },
               "message" => "user created successfully"
             } = response
    end

    test "return error when invalid params are sent", %{conn: conn} do
      params = %{
        name: nil,
        email: "jh",
        password: "q",
        zip_code: "12"
      }

      expect(BananaBank.ViaCep.ClientMock, :call, fn "12" ->
        {:ok, %{"status" => :not_found}}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "email" => ["has invalid format"],
                 "name" => ["can't be blank"],
                 "password" => ["should be at least 6 character(s)"],
                 "zip_code" => ["should be 8 character(s)"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn, user_params: params, body: body} do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "email" => "jhon@email.com",
                 "id" => ^id,
                 "name" => "John Doe",
                 "zip_code" => "29560000"
               },
               "message" => "user deleted successfully"
             } = response
    end
  end
end
