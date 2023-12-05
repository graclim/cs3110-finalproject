open Yojson

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

(* A helper function to extract time information. *)
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

(* Displays all available CS courses *)
let display_courses () =
  let rec print_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf
          "ID: %3d | Name: %-20s | Description: %-70s | Credits: %.1f\n"
          course.id course.name course.description course.credits;
        print_courses rest_of_courses
  in
  Printf.printf "\n%-3s | %-30s | %-83s | %s\n" "ID" "Name" "Description"
    "Credits";
  Printf.printf "%s\n" (String.make 180 '-');
  print_courses cs_courses;
  Printf.printf "%s\n" (String.make 180 '-');
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

