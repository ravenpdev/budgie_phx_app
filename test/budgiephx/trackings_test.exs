defmodule Budgiephx.TrackingsTest do
  use Budgiephx.DataCase

  alias Budgiephx.Trackings
  alias Budgiephx.Trackings.{Budget}

  describe "budgets" do
    test "create_budget/2 with valid data creates budget" do
      user = Budgiephx.AccountsFixtures.user_fixture()

      valid_attrs = %{
        name: "some name",
        description: "some description",
        start_date: ~D[2025-06-12],
        end_date: ~D[2025-06-14],
        user_id: user.id
      }

      assert {:ok, %Budget{} = budget} = Trackings.create_budget(valid_attrs)
      assert budget.name == "some name"
      assert budget.description == "some description"
      assert budget.start_date == ~D[2025-06-12]
      assert budget.end_date == ~D[2025-06-14]
      assert budget.user_id == user.id
    end

    test "create_budget/2 end_date must be greater than start date" do
      user = Budgiephx.AccountsFixtures.user_fixture()

      invalid_attrs = %{
        name: "something",
        description: "something description",
        start_date: ~D[2025-06-12],
        end_date: ~D[2025-06-11],
        user_id: user.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Trackings.create_budget(invalid_attrs)
      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:end_date]
    end

    test "create_budget/2 requires name" do
      user = Budgiephx.AccountsFixtures.user_fixture()

      attrs_without_name = %{
        description: "some description",
        start_date: ~D[2025-06-12],
        end_date: ~D[2025-06-13],
        user_id: user.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Trackings.create_budget(attrs_without_name)
      assert changeset.valid? == false
      assert Keyword.keys(changeset.errors) == [:name]
    end
  end
end
