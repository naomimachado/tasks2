Design Choices:
- Admin is the super user.
- Admin manages all the managers who do not have a higher manager.
- A user can not be his own manager.
- Only a users manager an assign him/her tasks.
- Only the user whom the task belongs to can start and stop the time blocks
- The user can update his/her time blocks
- The time blocks must be entered in UTC format.
- The users manager can view the task in detail and delete and update time blocks

# Tasks2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
