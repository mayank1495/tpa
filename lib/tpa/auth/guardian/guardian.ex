defmodule Tpa.Auth.Guardian do
  use Guardian, otp_app: :tpa

  def subject_for_token(user, _claims) do
    # TODO: return {:ok, resource}.Put email as resource.
    # {:ok, user.email}
    sub = to_string(user.id)
    # IO.puts "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    # IO.inspect sub
    # IO.puts "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    # TODO: return user resource as: {:ok, user}  or {:error, :resource_not_found}.
    # Decide on porper "sub" first
    # user = %{email: claims["email"], password: claims["password"]}
    # {:ok, user}


    id = claims["sub"]
    resource = Tpa.Accounts.get_user!(id)
    # IO.puts "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    # IO.inspect resource
    # IO.puts "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

# #Callback defs for GuardianDB

#   def after_encode_and_sign(resource, claims, token, _options) do
#     with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
#       {:ok, token}
#     end
#   end

#   def on_verify(claims, token, _options) do
#     with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
#       {:ok, claims}
#     end
#   end

#   def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
#     with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
#       {:ok, {old_token, old_claims}, {new_token, new_claims}}
#     end
#   end

#   def on_revoke(claims, token, _options) do
#     with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
#       {:ok, claims}
#     end
#   end
end
