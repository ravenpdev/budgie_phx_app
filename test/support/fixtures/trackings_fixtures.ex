defmodule Budgiephx.TrackingsFixtures do
  def valid_budget_attributes(attrs \\ %{}) do
    attrs
    |> add_user_if_necessary()
    |> Enum.into(%{
      name: "some budget",
      description: "budget description",
      start_date: ~D[2025-06-01],
      end_date: ~D[2025-06-30]
    })
  end

  def budget_fixture(attrs \\ %{}) do
    {:ok, budget} =
      attrs
      |> valid_budget_attributes()
      |> Budgiephx.Trackings.create_budget()

    budget
  end

  defp add_user_if_necessary(attrs) when is_map(attrs) do
    Map.put_new_lazy(attrs, :user_id, fn ->
      user = Budgiephx.AccountsFixtures.user_fixture()
      user.id
    end)
  end
end
