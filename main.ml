#require "yojson"

open String
open Yojson

(* Define the structure of a course *)
type course = {id: int; name: string; description: string}
type course = {
  id : int;
  name : string;
  description : string;
  credits : float
}

let cs_courses =
  let json = Yojson.Basic.from_file "courses.json" in
  let open Yojson.Basic.Util in
  json |> to_list
  |> List.map (fun json ->
         let id = json |> member "id" |> to_int in
         let name = json |> member "name" |> to_string in
         let description = json |> member "description" |> to_string in
         let credits = json |> member "credits" |> to_float in

         { id; name; description; credits })

(* Define the structure of a user *)
type user = {netid: string; password: string; mutable total_credits: float; college: string}

(* Hard-coded list of users for demonstration purposes *)
let users = [
  {netid="user1"; password="pass1"; total_credits=0.0; college="engineering"};
  {netid="user2"; password="pass2"; total_credits=0.0; college="arts and sciences"};
]

(* Displays all available CS courses *)
let display_courses () = 
  let rec print_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf "ID: %d, Name: %s, Description: %s, Credits: %.1f\n" course.id course.name course.description course.credits;
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
    let user = List.find (fun u -> u.netid = netid) users in
    Printf.printf "Total credits for %s: %.2f\n" user.netid user.total_credits
  with Not_found -> print_endline "User not found."

(* Credit limit of student based on their college *)
let get_credit_limit college =
  match college with
  | "engineering" -> 18.0
  | "arts and sciences" -> 22.0
  | _ -> failwith "Unknown college"

(* A mutable list representing the user's courses *)
let my_courses = ref []

(* function to check if two schedules conflict *)
let is_conflict (s1: schedule) (s2: schedule) : bool =
  let shared_days = List.filter (fun day -> List.mem day s2.days) s1.days in
  (* if there's at least one shared day and the times conflict, then there's a conflict. *)
  shared_days <> [] && not (s1.time.finish <= s2.time.start || s2.time.finish <= s1.time.start)


(* function to check if a new course conflicts with existing courses *)
let has_schedule_conflict new_course my_courses =
  List.exists (fun existing_course -> is_conflict existing_course.schedule new_course.schedule) my_courses

(* User can add a course by ID *)
let add_course_ID netid course_id =
  (* try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found." *)
  try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    let user = List.find (fun u -> u.netid = netid) users in
    let current_credits = total_credits !my_courses in
    if current_credits +. course_to_add.credits > get_credit_limit user.college then
      print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found." *)
  try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    let user = List.find (fun u -> u.netid = netid) users in
    let current_credits = total_credits !my_courses in
    if current_credits +. course_to_add.credits > get_credit_limit user.college then
      print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found."

(* User can add a course by name *)
let add_course_name netid course_name =
  (* try
    let course_to_add = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) cs_courses in
    if List.exists (fun c -> c.name = course_to_add.name) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found." *)
  try
    let course_to_add = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) cs_courses in
    let user = List.find (fun u -> u.netid = netid) users in
    let current_credits = total_credits !my_courses in
    if current_credits +. course_to_add.credits > get_credit_limit user.college then
      print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.name = course_to_add.name) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found." *)
  try
    let course_to_add = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) cs_courses in
    let user = List.find (fun u -> u.netid = netid) users in
    let current_credits = total_credits !my_courses in
    if current_credits +. course_to_add.credits > get_credit_limit user.college then
      print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> c.name = course_to_add.name) !my_courses then
      print_endline "You are already enrolled in this course."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found."

(* User can drop a course by ID *)
let drop_course_ID netid course_id =
  (* try
    let course_to_drop = List.find (fun c -> c.id = course_id) !my_courses in
    my_courses := List.filter (fun c -> c.id <> course_id) !my_courses;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course." *)
  try
    let course_to_drop = List.find (fun c -> c.id = course_id) !my_courses in
    my_courses := List.filter (fun c -> c.id <> course_id) !my_courses;
    let user = List.find (fun u -> u.netid = netid) users in
    user.total_credits <- user.total_credits -. course_to_drop.credits;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course or user not found."

(* User can drop a course by name *)
let drop_course_name netid course_name =
  (* try
    let course_to_drop = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) !my_courses in
    my_courses := List.filter (fun c -> c.name <> course_to_drop.name) !my_courses;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course." *)
  try
    let course_to_drop = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) !my_courses in
    my_courses := List.filter (fun c -> c.name <> course_to_drop.name) !my_courses;
    let user = List.find (fun u -> u.netid = netid) users in
    user.total_credits <- user.total_credits -. course_to_drop.credits;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course or user not found."

(* Displays courses the user is enrolled in *)
let display_my_courses () = 
  let rec print_my_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
      Printf.printf "ID: %d, Name: %s, Description: %s, Credits: %.1f\n" course.id course.name course.description course.credits;
      print_my_courses rest_of_courses
  in
  print_endline "My courses:";
  print_my_courses !my_courses

(* Checks if user netid and password input is a valid user *)
let authenticate netid password =
  List.exists (fun user -> user.netid = netid && user.password = password) users

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
  | 1 -> print_endline ""; display_courses (); main netid
  | 2 -> print_endline ""; display_my_courses (); main netid
  | 3 -> print_endline ""; print_string "Enter course ID to add: ";
         add_course_ID netid (read_int ()); main netid
  | 4 -> print_endline ""; print_string "Enter course ID to drop: ";
         drop_course_ID netid (read_int ()); main netid
  | 5 -> print_endline ""; print_string "Enter course name to add: ";
        add_course_name netid (read_line ()); main netid
  | 6 -> print_endline ""; print_string "Enter course ID to drop: ";
         drop_course_name netid (read_line ()); main netid
  | 7 -> print_endline ""; display_total_credits netid; main netid
  | 0 -> print_endline ""; print_endline "Bye!"
  | _ -> print_endline ""; print_endline "Invalid option"; main netid

(* User login interface *)
let rec login () =
  print_endline "Please enter your netid:";
  let netid = read_line () in
  print_endline "Please enter your password:";
  let password = read_line () in
  if authenticate netid password then
    (print_endline "Login successful."; 
    print_endline "";
    main netid)
  else
    (print_endline "Invalid netid or password."; 
    print_endline "";
    login ())

(* Run login *)
let () = login ()
