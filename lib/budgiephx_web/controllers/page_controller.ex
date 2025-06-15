defmodule BudgiephxWeb.PageController do
  use BudgiephxWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about)
  end

  def demo(conn, _params) do
    render(conn, :demo)
  end

  def greet(conn, %{"name" => name}) do
    render(conn, :greet, name: name, lname: "paragas")
  end
end
