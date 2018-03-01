defmodule Tasks2.Work.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.Work.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :task_description, :string
    field :task_name, :string
    belongs_to :assigned_to, Tasks2.Accounts.User
    belongs_to :assigned_by, Tasks2.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:task_name, :task_description, :completed, :assigned_to_id, :assigned_by_id])
    |> validate_required([:task_name, :task_description, :completed, :assigned_to_id, :assigned_by_id])
  end
end
