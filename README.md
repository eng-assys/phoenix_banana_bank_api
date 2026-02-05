# BananaBank

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

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
params = %{name: "Rafael", password: "hashed_password", email: "rafael@example.com", zip_code: "12345678"}
changeset = BananaBank.Users.User.changeset(params)

# Insert changeset at database
> alias BananaBank.Repo
> BananaBank.Users.User
> Repo.insert(changeset)

# response 
[debug] QUERY OK source="users" db=9.5ms decode=2.8ms queue=5.7ms idle=1745.1ms
INSERT INTO "users" ("name","email","password_hash","zip_code","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5,$6) RETURNING "id" ["Rafael", "rafael@example.com", "hashed_password", "12345678", ~N[2026-02-05 11:51:11], ~N[2026-02-05 11:51:11]]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:365
{:ok,
 %BananaBank.Users.User{
   __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
   id: 1,
   name: "Rafael",
   password_hash: "hashed_password",
   email: "rafael@example.com",
   zip_code: "12345678",
   inserted_at: ~N[2026-02-05 11:51:11],
   updated_at: ~N[2026-02-05 11:51:11]
 }}

 > Repo.get(User, 1)
```