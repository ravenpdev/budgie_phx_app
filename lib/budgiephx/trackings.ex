defmodule Budgiephx.Trackings do
  import Ecto.Query, warn: false
  alias Budgiephx.Repo
  alias Budgiephx.Trackings.Budget

  def list_budgets do
    Repo.all(Budget)
    |> Repo.preload(:user)
  end

  def get_budget(id) do
    Repo.get(Budget, id)
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
