defmodule BudgiephxWeb.BudgetListLive do
  use BudgiephxWeb, :live_view

  alias Budgiephx.Trackings

  def mount(_params, _session, socket) do
    budgets = Trackings.list_budgets()

    socket = assign(socket, budgets: budgets)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.table id="budgets" rows={@budgets}>
        <:col :let={budget} label="Name">{budget.name}</:col>
        <:col :let={budget} label="Description">{budget.description}</:col>
        <:col :let={budget} label="Start date">{budget.start_date}</:col>
        <:col :let={budget} label="End date">{budget.end_date}</:col>
        <:col :let={budget} label="Creator Name">{budget.user.name}</:col>
      </.table>
    </div>
    """
  end
end
