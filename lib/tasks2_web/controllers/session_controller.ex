#Attribution: http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html

defmodule Tasks2Web.SessionController do
  use Tasks2Web, :controller

  def create(conn, %{"email" => email}) do
    user = Tasks2.Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back, #{user.name}")
      |> redirect(to: user_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Can't log in! Please register an account")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "You have logged out.")
    |> redirect(to: page_path(conn, :index))
  end

end
