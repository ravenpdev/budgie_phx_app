defmodule Budgiephx.Repo.Migrations.CreateBudgets do
  use Ecto.Migration

  def change do
    create table("budgets", primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :text
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :user_id, references(:users, type: :binary_id, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:budgets, [:user_id])

    create constraint(:budgets, :budget_end_after_start,
             check: "end_date > start_date",
             comment: "Budget must end after its start date"
           )
  end
end
