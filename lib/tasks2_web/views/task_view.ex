defmodule Tasks2Web.TaskView do
  use Tasks2Web, :view
  import Ecto.Query
  alias Tasks2.Repo

  def get_underlings(user_id) do
      Repo.all(from u in Tasks2.Accounts.User,
        where: u.manager_id == ^user_id)
      |> Enum.map(&({&1.name, &1.id}))
    end

end
