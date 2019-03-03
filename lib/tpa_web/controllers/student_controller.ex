defmodule TpaWeb.StudentController do
  use TpaWeb, :controller

  alias Tpa.Accounts
  alias Tpa.Accounts.Student
  alias Tpa.Auth.Guardian

  def index(conn, _params) do
    students = Accounts.list_students()
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/")
  else
    changeset = Accounts.change_student(%Student{})
    render(conn, "new.html", changeset: changeset)
  end
  end

  def create(conn, %{"student" => student_params}) do
    maybe_user = Guardian.Plug.current_resource(conn)

    case Accounts.create_student(student_params) do
      {:ok, student} ->
        claims = %{
          "role" => "student"
        }
        conn
        |> put_flash(:info, "Student created successfully.")
        |> Guardian.Plug.sign_in(student.user, claims)
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Accounts.get_student!(id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Accounts.get_student!(id)
    changeset = Accounts.change_student(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Accounts.get_student!(id)

    case Accounts.update_student(student, student_params) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Accounts.get_student!(id)
    {:ok, _student} = Accounts.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end
end
