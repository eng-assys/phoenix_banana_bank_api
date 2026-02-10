defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback call(String.t()) :: {:ok, map()} | {:error, :not_found | :bad_request | :internal_server_error}
end
