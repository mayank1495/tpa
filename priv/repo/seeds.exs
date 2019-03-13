# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tpa.Repo.insert!(%Tpa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Tpa.Accounts
alias Tpa.Placement

admin1 = %{
  "name" => "Admin",
  "user" => %{
    "email" => "admin@admin.com",
    "password" => "password",
    "role" => "admin"
  }
}

admin2 = %{
  "name" => "Admin 2",
  "user" => %{
    "email" => "admin2@admin.com",
    "password" => "password",
    "role" => "admin"
  }
}


c1 = %{"job_profile" => "J1", "location" => "L1", "name" => "A", "package" => "10"}
c2 = %{"job_profile" => "J2", "location" => "L2", "name" => "B", "package" => "20"}
c3 = %{"job_profile" => "J3", "location" => "L3", "name" => "C", "package" => "30"}
c4 = %{"job_profile" => "J4", "location" => "L4", "name" => "D", "package" => "40"}
c5 = %{"job_profile" => "J5", "location" => "L5", "name" => "E", "package" => "50"}
c6 = %{"job_profile" => "J6", "location" => "L6", "name" => "F", "package" => "60"}

s1 = %{
  "first_name" => "Mayank",
  "last_name" => "Agarwal",
  "reg_no" => "1",
  "user" => %{
    "email" => "mayank@mayank.com",
    "password" => "password",
    "role" => "student"
  }
}

s2 = %{
  "first_name" => "Piyush",
  "last_name" => "Kumar",
  "reg_no" => "2",
  "user" => %{
    "email" => "piyush@piyush.com",
    "password" => "password",
    "role" => "student"
  }
}

s3 = %{
  "first_name" => "Ankush",
  "last_name" => "Mandal",
  "reg_no" => "3",
  "user" => %{
    "email" => "ankush@ankush.com",
    "password" => "password",
    "role" => "student"
  }
}

s4 = %{
  "first_name" => "Rohit",
  "last_name" => "Kumar",
  "reg_no" => "4",
  "user" => %{
    "email" => "rohit@rohit.com",
    "password" => "password",
    "role" => "student"
  }
}

Accounts.create_admin(admin1)
Accounts.create_admin(admin2)

Accounts.create_student(s1)
Accounts.create_student(s2)
Accounts.create_student(s3)
Accounts.create_student(s4)

Placement.create_company(c1)
Placement.create_company(c2)
Placement.create_company(c3)
Placement.create_company(c4)
Placement.create_company(c5)
Placement.create_company(c6)
