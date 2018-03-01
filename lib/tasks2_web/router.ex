defmodule Tasks2Web.Router do
  use Tasks2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def get_current_user(conn, params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Tasks2.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tasks2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/tasks", TaskController

     post "/session", SessionController, :create
     delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
   scope "/api/v1", Tasks2Web do
     pipe_through :api
     resources "/timeblocks", TimeblockController, except: [:new, :edit]
   end
end
