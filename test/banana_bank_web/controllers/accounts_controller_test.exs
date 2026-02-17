defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias BananaBank.Users.User

  setup do
    first_user_params = %{
      "name" => "John Doe",
      "email" => "jhon@email.com",
      "password" => "123456",
      "zip_code" => "29560000"
    }

    second_user_params = %{
      "name" => "Other Doe",
      "email" => "other@email.com",
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

    expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
      {:ok, body}
    end)

    expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
      {:ok, body}
    end)

    {:ok, %User{id: first_user_id}} = Users.create(first_user_params)
    {:ok, %User{id: second_user_id}} = Users.create(second_user_params)

    {:ok, %{first_user_id: first_user_id, second_user_id: second_user_id}}
  end

  describe "create/2" do
    test "successfully creates an account for user", %{conn: conn, first_user_id: first_user_id} do
      account_params = %{
        user_id: first_user_id,
        balance: 100_000
      }

      response =
        conn
        |> post(~p"/api/accounts", account_params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "balance" => "100000",
                 "id" => _id,
                 "user_id" => ^first_user_id
               },
               "message" => "account created successfully"
             } = response
    end


  end
end
