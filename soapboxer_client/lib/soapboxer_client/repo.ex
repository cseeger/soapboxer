defmodule SoapboxerClient.Repo do
  use Ecto.Repo,
    otp_app: :soapboxer_client,
    adapter: Ecto.Adapters.Postgres
end
