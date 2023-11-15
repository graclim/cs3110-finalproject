open Yojson
open Users

type time = {
  start : int;
  finish : int;
}

type schedule = {
  days : string list;
  time : time;
}

type course = {
  id : int;
  name : string;
  description : string;
  credits : float;
  schedule : schedule;
}

(* A helper function to extract time information. *)
let to_time json =
  let open Yojson.Basic.Util in
  {
    start = json |> member "start" |> to_int;
    finish = json |> member "finish" |> to_int;
  }

(* A helper function to extract schedule information. *)
let to_schedule json =
  let open Yojson.Basic.Util in
  {
    days = json |> member "days" |> to_list |> List.map to_string;
    time = json |> member "time" |> to_time;
  }

let cs_courses =
  let json = Yojson.Basic.from_file "data/courses.json" in
  let open Yojson.Basic.Util in
  json |> to_list
  |> List.map (fun json ->
         let id = json |> member "id" |> to_int in
         let name = json |> member "name" |> to_string in
         let description = json |> member "description" |> to_string in
         let credits = json |> member "credits" |> to_float in
         let schedule = json |> member "schedule" |> to_schedule in

         { id; name; description; credits; schedule })


(* Displays all available CS courses *)
let display_courses () =
  let rec print_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf "ID: %d, Name: %s, Description: %s, Credits: %.1f\n"
          course.id course.name course.description course.credits;
        print_courses rest_of_courses
  in
  print_endline "Available courses:";
  print_courses cs_courses

(* Calculates total number of credits a student is planning on taking *)
let total_credits courses =
  List.fold_left (fun acc course -> acc +. course.credits) 0.0 courses

(* Prints out total number of credits a student is planning on taking *)
let display_total_credits netid =
  try
    let user = List.find (fun u -> (Users.get_netid u) = netid) Users.users in
    Printf.printf "Total credits for %s: %.2f\n" (Users.get_netid user) (Users.get_total_credits user) 
  with Not_found -> print_endline "User not found."

(* Credit limit of student based on their college *)
let get_credit_limit college =
  match college with
  | "engineering" -> 20.0
  | "arts and sciences" -> 22.0
  | _ -> failwith "Unknown college"

(* A mutable list representing the user's courses *)
let my_courses = ref []

(* A function to check if two schedules conflict *)
let is_conflict (s1 : schedule) (s2 : schedule) : bool =
  let shared_days = List.filter (fun day -> List.mem day s2.days) s1.days in
  (* if there's at least one shared day and the times conflict, then there's a
     conflict. *)
  shared_days <> []
  && not (s1.time.finish <= s2.time.start || s2.time.finish <= s1.time.start)

(* A function to check if a new course conflicts with existing courses *)
let has_schedule_conflict new_course my_courses =
  List.exists
    (fun existing_course ->
      is_conflict existing_course.schedule new_course.schedule)
    my_courses

(* User can add a course by ID *)
(* let add_course_ID netid course_id = try let course_to_add = List.find (fun c
   -> c.id = course_id) cs_courses in let user = List.find (fun u -> u.netid =
   netid) users in let current_credits = total_credits !my_courses in

   if current_credits +. course_to_add.credits > get_credit_limit user.college
   then print_endline "Cannot add course: credit limit exceeded." else if
   List.exists (fun c -> c.id = course_id) !my_courses then print_endline "You
   are already enrolled in this course." else if has_schedule_conflict
   course_to_add !my_courses then print_endline "Cannot add course: there is a
   schedule conflict with a course you're \ already enrolled in." else (
   my_courses := course_to_add :: !my_courses; print_endline ("Added course: " ^
   course_to_add.name)) with Not_found -> print_endline "Course not found." *)

let add_course_ID netid course_id =
  try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    let user = List.find (fun u -> (Users.get_netid u) = netid) Users.users in
    let current_credits = total_credits !my_courses in

    if current_credits +. course_to_add.credits > get_credit_limit (Users.get_college user)
    then print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline
        "Cannot add course: there is a schedule conflict with a course you're \
         already enrolled in."
    else 
      my_courses := course_to_add :: !my_courses;
      Users.set_total_credits ((Users.get_total_credits user) +. course_to_add.credits) user;
      print_endline ("Added course: " ^ course_to_add.name)
  with Not_found -> print_endline "Course not found."

(* User can add a course by name *)
(* let add_course_name netid course_name = try let course_to_add = List.find
   (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name)
   cs_courses in let user = List.find (fun u -> u.netid = netid) users in let
   current_credits = total_credits !my_courses in

   if current_credits +. course_to_add.credits > get_credit_limit user.college
   then print_endline "Cannot add course: credit limit exceeded." else if
   List.exists (fun c -> c.name = course_to_add.name) !my_courses then
   print_endline "You are already enrolled in this course." else if
   has_schedule_conflict course_to_add !my_courses then print_endline "Cannot
   add course: there is a schedule conflict with an existing \ course." else (
   my_courses := course_to_add :: !my_courses; print_endline ("Added course: " ^
   course_to_add.name)) with | Not_found -> print_endline "Course not found." |
   e -> print_endline ("An unexpected error occurred: " ^ Printexc.to_string
   e) *)

let add_course_name netid course_name =
  try
    let course_to_add =
      List.find
        (fun c ->
          String.lowercase_ascii c.name = String.lowercase_ascii course_name)
        cs_courses
    in
    let user = List.find (fun u -> (Users.get_netid u) = netid) Users.users in
    let current_credits = total_credits !my_courses in

    if current_credits +. course_to_add.credits > get_credit_limit (Users.get_college user)
    then print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.name = course_name) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline
        "Cannot add course: there is a schedule conflict with an existing \
         course."
    else 
      my_courses := course_to_add :: !my_courses;
      Users.set_total_credits ((Users.get_total_credits user) +. course_to_add.credits) user;
      print_endline ("Added course: " ^ course_to_add.name)
  with
  | Not_found -> print_endline "Course not found."
  | e -> print_endline ("An unexpected error occurred: " ^ Printexc.to_string e)

(* User can drop a course by ID *)
let drop_course_ID netid course_id =
  try
    let course_to_drop = List.find (fun c -> c.id = course_id) !my_courses in
    my_courses := List.filter (fun c -> c.id <> course_id) !my_courses;
    let user = List.find (fun u -> Users.get_netid u = netid) Users.users in
    Users.set_total_credits ((Users.get_total_credits user) -. course_to_drop.credits) user;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found ->
    print_endline "You are not enrolled in this course or user not found."

(* User can drop a course by name *)
let drop_course_name netid course_name =
  try
    let course_to_drop =
      List.find
        (fun c ->
          String.lowercase_ascii c.name = String.lowercase_ascii course_name)
        !my_courses
    in
    my_courses :=
      List.filter (fun c -> c.name <> course_to_drop.name) !my_courses;
    let user = List.find (fun u -> (Users.get_netid u) = netid) Users.users in
    Users.set_total_credits ((Users.get_total_credits user) -. course_to_drop.credits) user; 
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found ->
    print_endline "You are not enrolled in this course or user not found."

(* Displays courses the user is enrolled in *)
let display_my_courses () =
  let rec print_my_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf "ID: %d, Name: %s, Description: %s, Credits: %.1f\n"
          course.id course.name course.description course.credits;
        print_my_courses rest_of_courses
  in
  print_endline "My courses:";
  print_my_courses !my_courses


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
      drop_course_ID (netid) (int_of_string (read_line ())); 
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
  if Users.authenticate netid password then (
    print_endline "Login successful.";
    print_endline "";
    main netid)
  else (
    print_endline "Invalid netid or password.";
    print_endline "";
    login ())

(* Run login *)
let () = login ()