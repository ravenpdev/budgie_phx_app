defmodule BudgiephxWeb.CreateBudgetDialog do
  use BudgiephxWeb, :live_component

  alias Budgiephx.Trackings
  alias Budgiephx.Trackings.Budget

  @impl true
  def update(assigns, socket) do
    changeset = Trackings.change_budget(%Budget{})

    socket =
      socket
      |> assign(assigns)
      |> assign(form: to_form(changeset))

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"budget" => params}, socket) do
    changeset = Trackings.change_budget(%Budget{}, params) |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset))}
  end

  def handle_event("save", %{"budget" => params}, socket) do
    params = Map.put(params, "user_id", socket.assigns.current_user.id)

    with {:ok, %Budget{}} <- Trackings.create_budget(params) do
      socket =
        socket
        |> put_flash(:info, "Budget created")
        |> push_navigate(to: ~p"/budgets", replace: true)

      {:noreply, socket}
    else
      {:error, changeset} -> {:noreply, assign(socket, form: to_form(changeset))}
    end
  end
end
