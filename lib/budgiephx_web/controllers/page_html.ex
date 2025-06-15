defmodule BudgiephxWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use BudgiephxWeb, :html

  embed_templates "page_html/*"

  def demo(assigns) do
    ~H"""
    Hello!
    """
  end

  def greet(assigns) do
    ~H"""
    <div>
      Hello {assigns.name} {@lname}
    </div>
    """
  end
end
