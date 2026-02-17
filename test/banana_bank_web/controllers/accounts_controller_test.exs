defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import Mox

  alias BananaBank.Users
  alias BananaBank.Users.User

  alias BananaBank.Accounts
  alias BananaBank.Accounts.Account

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

    via_cep_body = %{
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

    {:ok, %{first_user_params: first_user_params, second_user_params: second_user_params, via_cep_body: via_cep_body}}
  end

  describe "create/2" do
    test "successfully creates an account for user", %{
      conn: conn,
      via_cep_body: via_cep_body,
      first_user_params: first_user_params
    } do
      expect(BananaBank.ViaCep.ClientMock, :call, fn "29560000" ->
        {:ok, via_cep_body}
      end)

      {:ok, %User{id: first_user_id}} = Users.create(first_user_params)

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

  describe "transaction/2" do
    test "successfully creates a transaction for accounts", %{
      conn: conn,
      via_cep_body: via_cep_body,
      first_user_params: first_user_params,
      second_user_params: second_user_params
    } do
      expect(BananaBank.ViaCep.ClientMock, :call, 2, fn "29560000" ->
        {:ok, via_cep_body}
      end)

      {:ok, %User{id: first_user_id}} = Users.create(first_user_params)

      first_user_account_params = %{
        user_id: first_user_id,
        balance: 100_000
      }

      {:ok, %Account{id: first_user_account_id}} = Accounts.create(first_user_account_params)

      {:ok, %User{id: second_user_id}} = Users.create(second_user_params)

      second_user_account_params = %{
        user_id: second_user_id,
        balance: 100_000
      }

      {:ok, %Account{id: second_user_account_id}} = Accounts.create(second_user_account_params)

      transaction_params = %{
        from_account_id: first_user_account_id,
        to_account_id: second_user_account_id,
        value: 300
      }

      response =
        conn
        |> post(~p"/api/accounts/transaction", transaction_params)
        |> json_response(:ok)

      assert %{
               "message" => "transaction success",
               "from_account" => %{
                 "id" => ^first_user_account_id,
                 "balance" => "99700",
                 "user_id" => ^first_user_id
               },
               "to_account" => %{
                 "id" => ^second_user_account_id,
                 "balance" => "100300",
                 "user_id" => ^second_user_id
               }
             } = response
    end
  end
end
