defmodule Tasks2.WorkTest do
  use Tasks2.DataCase

  alias Tasks2.Work

  describe "tasks" do
    alias Tasks2.Work.Task

    @valid_attrs %{completed: true, task_description: "some task_description", task_name: "some task_name"}
    @update_attrs %{completed: false, task_description: "some updated task_description", task_name: "some updated task_name"}
    @invalid_attrs %{completed: nil, task_description: nil, task_name: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Work.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Work.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Work.create_task(@valid_attrs)
      assert task.completed == true
      assert task.task_description == "some task_description"
      assert task.task_name == "some task_name"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Work.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.task_description == "some updated task_description"
      assert task.task_name == "some updated task_name"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_task(task, @invalid_attrs)
      assert task == Work.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Work.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Work.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Work.change_task(task)
    end
  end

  describe "timeblocks" do
    alias Tasks2.Work.Timeblock

    @valid_attrs %{end: "2010-04-17 14:00:00.000000Z", start: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{end: "2011-05-18 15:01:01.000000Z", start: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{end: nil, start: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Work.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Work.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Work.create_timeblock(@valid_attrs)
      assert timeblock.end == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert timeblock.start == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Work.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert timeblock.start == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Work.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Work.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Work.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Work.change_timeblock(timeblock)
    end
  end
end
