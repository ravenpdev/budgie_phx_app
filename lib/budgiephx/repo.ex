defmodule Budgiephx.Repo do
  use Ecto.Repo,
    otp_app: :budgiephx,
    adapter: Ecto.Adapters.Postgres
end
