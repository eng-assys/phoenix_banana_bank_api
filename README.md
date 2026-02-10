# BananaBank

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

* Update Packages `mix deps.get`

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix

## Generate Database Migration
```bash
mix ecto.gen.migration add_users_table

mix ecto.migrate
```

## Examples
```elixir
# Create a valid User changeset
iex(1)> params = %{name: "Rafael", password: "hashed_password", email: "rafael@example.com", zip_code: "12345678"}
iex(2)> changeset = BananaBank.Users.User.changeset(params)

# Insert changeset at database
iex(3)> alias BananaBank.Repo
iex(4)> BananaBank.Users.User
iex(5)> Repo.insert(changeset)

# response 
[debug] QUERY OK source="users" db=7.0ms decode=3.2ms queue=2.1ms idle=771.8ms
INSERT INTO "users" ("name","email","zip_code","password_hash","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5,$6) RETURNING "id" ["Rafael", "rafael@example.com", "12345678", "$argon2id$v=19$m=65536,t=3,p=4$zjfA8KZEgTBhY7U7xloO2Q$/yhQ30GXZBW8osZ1Yinaihz5DHBFoM3POGaIMW41lZE", ~N[2026-02-05 13:48:41], ~N[2026-02-05 13:48:41]]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:365
{:ok,
 %BananaBank.Users.User{
   __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
   id: 2,
   name: "Rafael",
   password: "hashed_password",
   password_hash: "$argon2id$v=19$m=65536,t=3,p=4$zjfA8KZEgTBhY7U7xloO2Q$/yhQ30GXZBW8osZ1Yinaihz5DHBFoM3POGaIMW41lZE",
   email: "rafael@example.com",
   zip_code: "12345678",
   inserted_at: ~N[2026-02-05 13:48:41],
   updated_at: ~N[2026-02-05 13:48:41]
 }}

iex(6) BananaBank.Repo.get(BananaBank.Users.User, 2)
[debug] QUERY OK source="users" db=2.0ms idle=1707.3ms
SELECT u0."id", u0."name", u0."password_hash", u0."email", u0."zip_code", u0."inserted_at", u0."updated_at" FROM "users" AS u0 WHERE (u0."id" = $1) [2]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:365
%BananaBank.Users.User{
  __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
  id: 2,
  name: "Rafael",
  password: nil,
  password_hash: "$argon2id$v=19$m=65536,t=3,p=4$zjfA8KZEgTBhY7U7xloO2Q$/yhQ30GXZBW8osZ1Yinaihz5DHBFoM3POGaIMW41lZE",
  email: "rafael@example.com",
  zip_code: "12345678",
  inserted_at: ~N[2026-02-05 13:48:41],
  updated_at: ~N[2026-02-05 13:48:41]
}
```