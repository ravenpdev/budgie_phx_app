defmodule Budgiephx.TrackingsTest do
  use Budgiephx.DataCase

  alias Budgiephx.Trackings
  alias Budgiephx.Trackings.{Budget}

  describe "budgets" do
    test "get_all_budgets/0" do
    end

    test "create_budget/2 with valid data creates budget" do
      user = Budgiephx.AccountsFixtures.user_fixture()

      # valid_attrs = %{
      #   name: "some name",
      #   description: "some description",
      #   start_date: ~D[2025-06-12],
      #   end_date: ~D[2025-06-14],
      #   user_id: user.id
      # }

      valid_attrs = Budgiephx.TrackingsFixtures.valid_budget_attributes(%{user_id: user.id})

      assert {:ok, %Budget{} = budget} = Trackings.create_budget(valid_attrs)
      assert budget.name == "some budget"
      assert budget.description == "budget description"
      assert budget.start_date == ~D[2025-06-01]
      assert budget.end_date == ~D[2025-06-30]
      assert budget.user_id == user.id
    end

    test "create_budget/2 date must be valid" do
      # user = Budgiephx.AccountsFixtures.user_fixture()

      # invalid_attrs = %{
      #   name: "some budget",
      #   description: "budget description",
      #   start_date: ~D[2025-06-12],
      #   end_date: ~D[2025-06-11],
      #   user_id: user.id
      # }

      # invalid_attrs =
      #   Budgiephx.TrackingsFixtures.valid_budget_attributes()
      #   |> Map.replace_lazy(:end_date, fn _v -> ~D[2025-05-01] end)

      invalid_attrs =
        Budgiephx.TrackingsFixtures.valid_budget_attributes()
        |> Map.merge(%{
          start_date: ~D[2025-06-14],
          end_date: ~D[2025-06-01]
        })

      assert {:error, %Ecto.Changeset{} = changeset} = Trackings.create_budget(invalid_attrs)
      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:end_date]

      assert %{end_date: ["must end after start date"]} = errors_on(changeset)
    end

    test "create_budget/2 requires name" do
      # user = Budgiephx.AccountsFixtures.user_fixture()

      # attrs_without_name = %{
      #   description: "some description",
      #   start_date: ~D[2025-06-12],
      #   end_date: ~D[2025-06-13],
      #   user_id: user.id
      # }

      attrs_without_name =
        Budgiephx.TrackingsFixtures.valid_budget_attributes() |> Map.delete(:name)

      assert {:error, %Ecto.Changeset{} = changeset} = Trackings.create_budget(attrs_without_name)
      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
