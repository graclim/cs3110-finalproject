open Yojson
open Unix

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

let make_time start_time finish_time =
  { start = start_time; finish = finish_time }

let make_schedule days time = { days; time }

let make_course id name description credits schedule =
  { id; name; description; credits; schedule }

let to_time json =
  let open Yojson.Basic.Util in
  {
    start = json |> member "start" |> to_int;
    finish = json |> member "finish" |> to_int;
  }

let get_course_id c = c.id
let get_course_name c = c.name
let get_course_description c = c.description
let get_course_credits c = c.credits
let get_course_schedule c = c.schedule
let get_schedule_days s = s.days
let get_schedule_time s = s.time
let get_start_time t = t.start
let get_finish_time t = t.finish

(* A helper function to extract schedule information. *)
let to_schedule json =
  let open Yojson.Basic.Util in
  {
    days = json |> member "days" |> to_list |> List.map to_string;
    time = json |> member "time" |> to_time;
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
         let schedule = json |> member "schedule" |> to_schedule in

         { id; name; description; credits; schedule })

let get_cs_courses () = cs_courses

(* ANSI escape codes for colors *)
let red = "\027[31m"
let green = "\027[32m"
let yellow = "\027[33m"
let blue = "\027[34m"
let reset = "\027[0m"

(* Field to courses mapping *)
let field_to_courses : (string, course list) Hashtbl.t = Hashtbl.create 8

(* Populate the hashtable with field-to-courses associations *)
let () =
  let add_courses_to_field field course_ids =
    let courses =
      List.filter
        (fun curr_course -> List.mem curr_course.id course_ids)
        cs_courses
    in
    Hashtbl.add field_to_courses field courses
  in
  (* Machine Learning/AI *)
  add_courses_to_field "Machine Learning/AI" [ 27; 28; 22; 23; 24 ];

  (* Software Development *)
  add_courses_to_field "Software Development"
    [ 1; 2; 4; 8; 11; 12; 13; 17; 18; 20; 21; 29 ];

  (* Data Science *)
  add_courses_to_field "Data Science" [ 12; 26; 28; 30 ];

  (* Systems Programming *)
  add_courses_to_field "Systems Programming" [ 7; 13; 17; 18; 19; 20; 21 ];

  (* Web and Internet *)
  add_courses_to_field "Web and Internet" [ 10; 12; 20; 30 ];

  (* Foundations and Theory *)
  add_courses_to_field "Foundations and Theory" [ 9; 14; 31; 32 ];

  (* Robotics and AI *)
  add_courses_to_field "Robotics and AI" [ 22; 23; 24; 25 ];

  (* Others *)
  add_courses_to_field "Others" [ 3; 5; 6; 15; 16; 26 ]

(* Function to get the width of the terminal *)
let get_terminal_width () =
  try
    let in_channel = Unix.open_process_in "tput cols" in
    let width = int_of_string (input_line in_channel) in
    let _ = Unix.close_process_in in_channel in
    width
  with _ -> 80 (* Default width if tput cols fails *)

let recommend_courses user_field =
  match Hashtbl.find_opt field_to_courses user_field with
  | Some recommended_courses -> recommended_courses
  | None -> []

let get_recommended_courses user_field = recommend_courses user_field

(* Function to display a list of recommended courses *)
let display_recommended_courses courses =
  let terminal_width = get_terminal_width () in
  let divider = String.make terminal_width '-' in

  Printf.printf "\n%s%-3s%s | %s%-30s%s | %s%-40s%s | %s%s%s\n" red "ID" reset
    green "Name" reset blue "Description" reset yellow "Credits" reset;
  Printf.printf "%s\n" divider;

  List.iter
    (fun course ->
      Printf.printf
        "%sID: %3d%s | %sName: %-20s%s | %sCredits: %-7.1f%s | %sDescription: \
         %-50s%s\n"
        red course.id reset green course.name reset yellow course.credits reset
        blue course.description reset)
    courses;

  Printf.printf "%s\n" divider;
  print_endline ""

(* Displays all available CS courses with colored output *)
let display_courses () =
  let terminal_width = get_terminal_width () in
  let divider = String.make terminal_width '-' in

  let rec print_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf
          "%sID: %3d%s | %sName: %-20s%s | %sCredits: %-7.1f%s | \
           %sDescription: %-50s%s\n"
          red course.id reset green course.name reset yellow course.credits
          reset blue course.description reset;
        print_courses rest_of_courses
  in

  Printf.printf "\n%s%-3s%s | %s%-20s%s | %s%-7s%s | %s%-50s%s\n" red "ID" reset
    green "Name" reset yellow "Credits" reset blue "Description" reset;
  Printf.printf "%s\n" divider;
  print_courses cs_courses;
  Printf.printf "%s\n" divider;
  print_endline ""

(* Calculates total number of credits a student is planning on taking *)
let total_credits courses =
  List.fold_left (fun acc course -> acc +. course.credits) 0.0 courses

(* Credit limit of student based on their college *)
let get_credit_limit college =
  match college with
  | "engineering" -> 20.0
  | "arts and sciences" -> 22.0
  | _ -> failwith "Unknown college"
