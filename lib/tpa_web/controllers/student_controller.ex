defmodule TpaWeb.StudentController do
  use TpaWeb, :controller

  alias Tpa.Accounts
  alias Tpa.Accounts.Student
  alias Tpa.Auth.Guardian
  alias Tpa.Placement
  alias Tpa.Placement.Company

  def index(conn, _params) do
    redirect(conn, to: student_path(conn, :show_profile))
    # students = Accounts.list_students()
    # render(conn, "index.html", students: students)
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
        |> put_session(:current_user, student.id)
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

  def show_company(conn, _param) do
    # companies = Tpa.Placement.list_companies()
    redirect(conn, to: company_path(conn, :index))
  end

  def apply_for_company(conn, %{"id" => company_id}) do
    student_id = get_session(conn, :current_user)
    company = Placement.get_company!(company_id)
    student = Accounts.get_student!(student_id)
    all_company = student.company ++ [company]
    Accounts.update_student_company_relation(student, all_company)

    conn
    |> put_flash(:info, "Successfully Applied")
    |> redirect(to: company_path(conn, :index))
  end

  def show_profile(conn, param) do
    student_id = get_session(conn, :current_user)
    student = Accounts.get_student!(student_id)
    render(conn, "profile.html", student: student)
  end

  def get_company_ids(conn) do
    std_id = get_session(conn, :current_user)
    # ids =
    Tpa.Accounts.get_applied_company_ids(std_id)
  end

  def withdraw_company(conn, %{"id" => id}) do
    std_id = get_session(conn, :current_user)
    {cm_id , ""} = Integer.parse(id)
    Accounts.delete_student_company_entry(std_id, cm_id)
    conn
    |> put_flash(:danger, "Withdrawn!!!")
    |> redirect(to: company_path(conn, :index))
  end
end
