open Course_scheduler
open Yojson
open Users
open Courses
open Scheduler

(* Main user interface *)
let rec main netid =
  load_courses netid;
  let rec interface netid =
    print_endline "";
    print_endline "========== Course Scheduler Main Menu ==========";
    print_endline
      "1: Display all available courses - Explore the wide range of courses \
       offered.";
    print_endline
      "2: Display my courses - View the courses you are currently enrolled in.";
    print_endline
      "3: Add course by ID - Enroll in a new course using its unique course ID.";
    print_endline
      "4: Drop course by ID - Unenroll from a course using its course ID.";
    print_endline
      "5: Add course by name - Enroll in a new course using its name.";
    print_endline
      "6: Drop course by name - Unenroll from a course using its name.";
    print_endline
      "7: Display total credits - Check the total credits of all your courses.";
    print_endline
      "8: Get course recommendations - Get personalized course suggestions \
       based on specific fields.";
    print_endline "0: Exit - Log out of the Course Scheduler System.";
    print_endline "------------------------------------------------";
    print_string "Please enter your choice and press Enter: ";
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
          let read = read_int () in
          add_course_ID netid read;
          interface netid
      | 4 ->
          print_endline "";
          print_string "Enter course ID to drop: ";
          let read = read_line () in
          drop_course_ID netid (int_of_string read);
          interface netid
      | 5 ->
          print_endline "";
          print_string "Enter course name to add: ";
          let read = read_line () in
          add_course_name netid read;
          interface netid
      | 6 ->
          print_endline "";
          print_string "Enter course ID to drop: ";
          let read = read_line () in
          drop_course_name netid read;
          interface netid
      | 7 ->
          print_endline "";
          display_total_credits netid;
          interface netid
      | 8 ->
          print_endline "";
          print_endline "Select a field of interest for course recommendations:";
          print_endline "1: Machine Learning/AI";
          print_endline "2: Software Development";
          print_endline "3: Data Science";
          print_endline "4: Systems Programming";
          print_endline "5: Web and Internet";
          print_endline "6: Foundations and Theory";
          print_endline "7: Robotics and AI";
          print_endline "8: Others";
          print_endline "";
          print_string "Enter your choice: ";
          let field_choice = read_int () in
          let field =
            match field_choice with
            | 1 -> "Machine Learning/AI"
            | 2 -> "Software Development"
            | 3 -> "Data Science"
            | 4 -> "Systems Programming"
            | 5 -> "Web and Internet"
            | 6 -> "Foundations and Theory"
            | 7 -> "Robotics and AI"
            | _ -> "Others"
          in
          let recommended_courses = recommend_courses field in
          display_recommended_courses recommended_courses;
          (* Calling the function from courses.ml *)
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
  print_endline "";
  print_endline "=========== Course Scheduler Login ===========";
  print_endline "Please enter your netid:";
  let netid : string = read_line () in
  print_endline "";
  print_endline "Please enter your password:";
  let password = read_line () in
  if authenticate netid password then (
    print_endline "";
    print_endline "Login successful! Redirecting to the main menu...";
    main netid)
  else (
    print_endline "";
    print_endline
      "Login failed. Please check your NetID and password, and try again.";
    login ())

let rec create_user () =
  try
    print_endline "";
    print_endline "========= Create a New User Account ==========";
    print_endline "Please enter your netid:";
    let netid : string = read_line () in
    print_endline "";
    print_endline "Please enter your password:";
    let password : string = read_line () in
    print_endline "";
    print_endline "Select your college from the options below:";
    print_endline "0: College of Engineering";
    print_endline "1: College of Arts & Sciences";
    print_string "Enter the number corresponding to your college: ";
    let college_num : int = read_int () in
    let college =
      if college_num = 0 then "engineering" else "arts and sciences"
    in
    add_user_to_json_file netid password college;
    print_endline "Account created successfully! Redirecting to login...";
    login ()
  with Failure msg ->
    print_endline
      "The NetID you entered already exists. Please try again with a different \
       NetID.";
    create_user ()

let rec login_or_create_user () =
  (* Welcome message and introduction *)
  print_endline "";
  print_endline "";
  print_endline "========== Welcome to the Course Scheduler System! ==========";
  print_endline
    "===============================================================";
  print_endline
    "This system is designed to be your comprehensive academic companion,";
  print_endline "helping you make the most out of your educational journey.";
  print_endline "";
  print_endline "With the Course Scheduler System, you can:";
  print_endline "";
  print_endline "1. Browse and Explore Courses:";
  print_endline "   - Access a vast catalog of courses spanning various fields.";
  print_endline "   - Discover new subjects, electives, and core requirements.";
  print_endline "";
  print_endline "2. Enroll in Courses:";
  print_endline
    "   - Choose courses that align with your academic interests or major.";
  print_endline
    "   - Stay up-to-date with course availability and prerequisites.";
  print_endline "";
  print_endline "3. Manage Your Enrollments:";
  print_endline "   - View your currently enrolled courses at any time.";
  print_endline "   - Add or drop courses as your academic plan evolves.";
  print_endline "";
  print_endline "4. Personalized Recommendations:";
  print_endline
    "   - Receive course recommendations tailored to your interests.";
  print_endline
    "   - Explore new learning opportunities in your preferred fields.";
  print_endline "";
  print_endline "5. Track Total Credit Hours:";
  print_endline
    "   - Keep track of your total credit hours for efficient academic \
     planning.";
  print_endline
    "   - Ensure you're on the right path to meet your degree requirements.";
  print_endline "";
  print_endline
    "Our goal is to empower you in your academic journey, making course";
  print_endline
    "planning easier, more efficient, and aligned with your educational goals.";
  print_endline "";
  print_endline
    "Let's get started! Choose an option below to either create a new";
  print_endline "user account or log in to your existing account.";
  print_endline
    "===============================================================";

  (* Instructions for new or returning users *)
  print_endline "\nTo get started:";
  print_endline
    "  - If you are a new user, you can create a user account. This will allow \
     you to access all the features of the system.";
  print_endline
    "  - If you already have an account, you can log in to access your \
     personalized course dashboard.";

  (* Display options for login or user creation *)
  print_endline "";
  print_endline "0: Login (Existing users)";
  print_endline "1: Create User (New users)";
  print_endline "";
  print_string "Enter your choice (0 or 1): ";
  try
    match read_int () with
    | 0 -> login ()
    | 1 -> create_user ()
    | _ ->
        print_endline "";
        print_endline "Not an option; try again";
        login_or_create_user ()
  with Failure msg ->
    print_endline "";
    print_endline "Not an option; try again";
    login_or_create_user ()

(* let _ = print_all_users load_users_from_json *)

(* Start the application with the login process *)
let () = login_or_create_user ()
