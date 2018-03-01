defmodule Tasks2.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task_name, :string, null: false
      add :task_description, :text, null: false
      add :completed, :boolean, default: false, null: false
      add :assigned_to_id, references(:users, on_delete: :delete_all), null: false
      add :assigned_by_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:assigned_to_id])
    create index(:tasks, [:assigned_by_id])
  end
end
