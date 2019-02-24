defmodule Tpa.AccountsTest do
  use Tpa.DataCase

  alias Tpa.Accounts

  describe "students" do
    alias Tpa.Accounts.Student

    @valid_attrs %{address: "some address", cgpa: "some cgpa", dept: "some dept", first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{address: "some updated address", cgpa: "some updated cgpa", dept: "some updated dept", first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{address: nil, cgpa: nil, dept: nil, first_name: nil, last_name: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Accounts.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Accounts.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Accounts.create_student(@valid_attrs)
      assert student.address == "some address"
      assert student.cgpa == "some cgpa"
      assert student.dept == "some dept"
      assert student.first_name == "some first_name"
      assert student.last_name == "some last_name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, student} = Accounts.update_student(student, @update_attrs)
      assert %Student{} = student
      assert student.address == "some updated address"
      assert student.cgpa == "some updated cgpa"
      assert student.dept == "some updated dept"
      assert student.first_name == "some updated first_name"
      assert student.last_name == "some updated last_name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_student(student, @invalid_attrs)
      assert student == Accounts.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Accounts.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Accounts.change_student(student)
    end
  end

  describe "credentials" do
    alias Tpa.Accounts.Credential

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Accounts.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Accounts.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.email == "some email"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end
end
