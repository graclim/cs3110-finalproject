open Course_scheduler
open Yojson
open Users
open Courses
open Scheduler

(* Main user interface *)
let rec main netid =
  print_endline "\n1: Display all courses";
  print_endline "2: Display my courses";
  print_endline "3: Add course by ID";
  print_endline "4: Drop course by ID";
  print_endline "5: Add course by name";
  print_endline "6: Drop course by name";
  print_endline "7: Display total credits";
  print_endline "0: Exit";
  print_string "Enter your choice: ";
  match read_int () with
  | 1 ->
      print_endline "";
      display_courses ();
      main netid
  | 2 ->
      print_endline "";
      display_my_courses ();
      main netid
  | 3 ->
      print_endline "";
      print_string "Enter course ID to add: ";
      add_course_ID netid (read_int ());
      main netid
  | 4 ->
      print_endline "";
      print_string "Enter course ID to drop: ";
      (*NEED TO ADD A TRY EXCEPTION CLAUSE FOR READ_LINE*)
      drop_course_ID netid (int_of_string (read_line ()));
      main netid
  | 5 ->
      print_endline "";
      print_string "Enter course name to add: ";
      add_course_name netid (read_line ());
      main netid
  | 6 ->
      print_endline "";
      print_string "Enter course ID to drop: ";
      drop_course_name netid (read_line ());
      main netid
  | 7 ->
      print_endline "";
      display_total_credits netid;
      main netid
  | 0 ->
      print_endline "";
      print_endline "Bye!"
  | _ ->
      print_endline "";
      print_endline "Invalid option";
      main netid

(* User login interface *)
let rec login () =
  print_endline "Please enter your netid:";
  let netid : string = read_line () in
  print_endline "Please enter your password:";
  let password = read_line () in
  if authenticate netid password then (
    print_endline "Login successful.";
    print_endline "";
    main netid)
  else (
    print_endline "Invalid netid or password.";
    print_endline "";
    login ())

(* Start the application with the login process *)
let _ = print_all_users load_users_from_json
let () = login ()
