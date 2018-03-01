defmodule Tasks2Web.UserView do
  use Tasks2Web, :view
  import Ecto.Query

  def replace_email_with_id do
    Enum.map(Tasks2.Accounts.list_users(), &{&1.name, &1.id})
  end
  
end
