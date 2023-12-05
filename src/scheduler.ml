open Courses
open Users

(* A mutable list representing the user's courses *)
let my_courses = ref []

let rec find_user_courses users netid =
  match users with
  | user :: t ->
      if get_netid user = netid then get_courses user
      else find_user_courses t netid
  | [] -> failwith "User does not exist"

(*load the courses in by netid into my_courses*)
let load_courses netid =
  let users_list = load_users_from_json in
  my_courses := find_user_courses users_list netid

(* A function to check if two schedules conflict *)
let is_conflict (s1 : schedule) (s2 : schedule) : bool =
  let s1_days = get_schedule_days s1 in
  let s2_days = get_schedule_days s2 in
  let shared_days = List.filter (fun day -> List.mem day s2_days) s1_days in
  (* if there's at least one shared day and the times conflict, then there's a
     conflict. *)
  let s1_time = get_schedule_time s1 in
  let s2_time = get_schedule_time s2 in
  let s1_time_finish = get_finish_time s1_time in
  let s1_time_start = get_start_time s1_time in
  let s2_time_finish = get_finish_time s2_time in
  let s2_time_start = get_start_time s2_time in
  shared_days <> []
  && not (s1_time_finish <= s2_time_start || s2_time_finish <= s1_time_start)

(* A function to check if a new course conflicts with existing courses *)
let has_schedule_conflict new_course my_courses =
  List.exists
    (fun existing_course ->
      is_conflict
        (get_course_schedule existing_course)
        (get_course_schedule new_course))
    my_courses

(* User can add a course by ID *)
let add_course_ID netid course_id =
  try
    let course_to_add =
      List.find (fun c -> get_course_id c = course_id) cs_courses
    in
    let user = List.find (fun u -> get_netid u = netid) users in
    let current_credits = total_credits !my_courses in

    if
      current_credits +. get_course_credits course_to_add
      > get_credit_limit (get_college user)
    then print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> get_course_id c = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline
        "Cannot add course: there is a schedule conflict with a course you're \
         already enrolled in."
    else begin
      my_courses := course_to_add :: !my_courses;
      set_total_credits
        (get_total_credits user +. get_course_credits course_to_add)
        user;
      print_endline ("Added course: " ^ get_course_name course_to_add)
    end
  with Not_found -> print_endline "Course not found."

(* User can add a course by name *)
let add_course_name netid course_name =
  try
    let course_to_add =
      List.find
        (fun c ->
          String.lowercase_ascii (get_course_name c)
          = String.lowercase_ascii course_name)
        cs_courses
    in
    let user = List.find (fun u -> Users.get_netid u = netid) Users.users in
    let current_credits = total_credits !my_courses in

    if
      current_credits +. get_course_credits course_to_add
      > get_credit_limit (Users.get_college user)
    then print_endline "Cannot add course: credit limit exceeded."
    else if List.exists (fun c -> get_course_name c = course_name) !my_courses
    then print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline
        "Cannot add course: there is a schedule conflict with an existing \
         course."
    else begin
      my_courses := course_to_add :: !my_courses;
      Users.set_total_credits
        (Users.get_total_credits user +. get_course_credits course_to_add)
        user;
      print_endline ("Added course: " ^ get_course_name course_to_add)
    end
  with
  | Not_found -> print_endline "Course not found."
  | e -> print_endline ("An unexpected error occurred: " ^ Printexc.to_string e)

(* User can drop a course by ID *)
let drop_course_ID netid course_id =
  try
    let course_to_drop =
      List.find (fun c -> get_course_id c = course_id) !my_courses
    in
    my_courses :=
      List.filter (fun c -> get_course_id c <> course_id) !my_courses;
    let user = List.find (fun u -> Users.get_netid u = netid) Users.users in
    Users.set_total_credits
      (Users.get_total_credits user -. get_course_credits course_to_drop)
      user;
    print_endline ("Dropped course: " ^ get_course_name course_to_drop)
  with Not_found ->
    print_endline "You are not enrolled in this course or user not found."

(* User can drop a course by name *)
let drop_course_name netid course_name =
  try
    let course_to_drop =
      List.find
        (fun c ->
          String.lowercase_ascii (get_course_name c)
          = String.lowercase_ascii course_name)
        !my_courses
    in
    my_courses :=
      List.filter
        (fun c -> get_course_name c <> get_course_name course_to_drop)
        !my_courses;
    let user = List.find (fun u -> Users.get_netid u = netid) Users.users in
    Users.set_total_credits
      (Users.get_total_credits user -. get_course_credits course_to_drop)
      user;
    print_endline ("Dropped course: " ^ get_course_name course_to_drop)
  with Not_found ->
    print_endline "You are not enrolled in this course or user not found."

(* Displays courses the user is enrolled in *)
let display_my_courses () =
  let rec print_my_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        let id = get_course_id course in
        let name = get_course_name course in
        let description = get_course_description course in
        let credits = get_course_credits course in
        Printf.printf "ID: %d, Name: %s, Description: %s, Credits: %.1f\n" id
          name description credits;
        print_my_courses rest_of_courses
  in
  print_endline "My courses:";
  print_my_courses !my_courses

let update_json netid = update_user_courses !my_courses netid
