defmodule Budgiephx.Trackings do
  import Ecto.Query, warn: false
  alias Budgiephx.Accounts.User
  alias Budgiephx.Repo
  alias Budgiephx.Trackings.Budget

  def get_all_budgets do
    Repo.all(Budget)
  end

  def create_budget(attrs \\ %{}) do
    %Budget{}
    |> Budget.changeset(attrs)
    |> Repo.insert()

    # Repo.transaction(fn ->
    #   user = Repo.get_by(User, email: "ravenparagas@gmail.com")

    #   today = Date.utc_today()

    #   # build a budget from user
    #   budget =
    #     Ecto.build_assoc(user, :budgets,
    #       name: "housing",
    #       description: "pag-ibig housing payment",
    #       start_date: today,
    #       end_date: Date.add(today, 1)
    #     )

    #   Repo.insert!(budget)
    # end)
  end
end
