defmodule ProgressTrackerWeb.Router do
  use ProgressTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ProgressTrackerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", ProgressTrackerWeb do
    pipe_through :browser

    get "/", AuthController, :request
    get "/callback", AuthController, :callback
  end

  scope "/", ProgressTrackerWeb do
    pipe_through :browser

    live "/", MangaLive.Index, :index
    live "/mangas/new", MangaLive.Index, :new
    live "/mangas/:id/edit", MangaLive.Index, :edit

    live "/mangas/:id", MangaLive.Show, :show
    live "/mangas/:id/show/edit", MangaLive.Show, :edit
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:progress_tracker, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ProgressTrackerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
