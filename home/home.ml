open Course_scheduler
open Yojson
open Users
open Courses
open Scheduler

(* Main user interface *)
let rec main netid =
  load_courses netid;
  let rec interface netid =
    print_endline "\n1: Display all courses";
    print_endline "2: Display my courses";
    print_endline "3: Add course by ID";
    print_endline "4: Drop course by ID";
    print_endline "5: Add course by name";
    print_endline "6: Drop course by name";
    print_endline "7: Display total credits";
    print_endline "0: Exit";
    print_string "Enter your choice: ";
    try
      match read_int () with
      | 1 ->
          print_endline "";
          display_courses ();
          interface netid
      | 2 ->
          print_endline "";
          display_my_courses ();
          interface netid
      | 3 ->
          print_endline "";
          print_string "Enter course ID to add: ";
          add_course_ID netid (read_int ());
          interface netid
      | 4 ->
          print_endline "";
          print_string "Enter course ID to drop: ";
          drop_course_ID netid (int_of_string (read_line ()));
          interface netid
      | 5 ->
          print_endline "";
          print_string "Enter course name to add: ";
          add_course_name netid (read_line ());
          interface netid
      | 6 ->
          print_endline "";
          print_string "Enter course ID to drop: ";
          drop_course_name netid (read_line ());
          interface netid
      | 7 ->
          print_endline "";
          display_total_credits netid;
          interface netid
      | 0 ->
          print_endline "";
          print_endline "Bye!"
      | _ ->
          print_endline "";
          print_endline "Invalid option";
          interface netid
    with Failure msg ->
      print_endline "";
      print_endline "Invalid option";
      interface netid
  in
  interface netid;
  update_json netid

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

let rec create_user () = 
    try 
        print_endline "Please enter your netid:";
        let netid :string =  read_line () in  
        print_endline "Please enter your password:";
        let password : string = read_line () in
        print_endline "Please enter your college:";
        print_endline "0: College of Engineering";
        print_endline "1: College of Arts & Sciences";
        let college_num : int = read_int () in
        let college = if college_num = 0 then "engineering" else "arts and sciences" in  
        add_user_to_json_file netid password college; 
        login () 
    with Failure msg -> print_endline "Netid already exists; try again"; create_user ()

let rec login_or_create_user () = 
    print_endline "Create User or Login";
    print_endline "0: Login";
    print_endline "1: Create User";
    try 
        match read_int () with 
        | 0 -> 
            login ()
        | 1 -> 
            create_user ()
        | _ -> 
            print_endline "Not an option; try again";
            login_or_create_user ()
    with Failure msg -> 
        print_endline "Not an option; try again";
        login_or_create_user ()  

(* let _ = print_all_users load_users_from_json *)

(* Start the application with the login process *)
let () = login_or_create_user ()