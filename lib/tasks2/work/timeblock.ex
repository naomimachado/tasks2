defmodule Tasks2.Work.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks2.Work.Timeblock


  schema "timeblocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, Tasks2.Work.Task

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :task_id])
  end
end
