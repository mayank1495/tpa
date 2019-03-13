defmodule Tpa.Auth.Guardian.AdminPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :tpa,
    error_handler: Tpa.Auth.Guardian.ErrorHandler,
    module: Tpa.Auth.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access", "role"=> "admin"})
  # If there is an authorization header, restrict it to an access token and validate it
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access", "role"=> "admin"})
  # Load the user if either of the verifications worked
  # By default, the LoadResource plug will return an error if no resource can be found.
  # We can override this behaviour using the allow_blank: true option. ??
  plug Guardian.Plug.EnsureAuthenticated
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
