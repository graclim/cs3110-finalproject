open Yojson.Basic
open Courses

type user = {
  netid : string;
  password : string;
  mutable total_credits : float;
  college : string;
  mutable courses : course list;
}

let make_user netid password college =
  { netid; password; total_credits = 0.0; college; courses = [] }

let add_user new_user users_list = new_user :: users_list

let load_users_from_json : user list ref =
  let rec load_courses courses_json =
    List.map
      (fun course_json ->
        let id = Util.to_int (Util.member "id" course_json) in
        let name = Util.to_string (Util.member "name" course_json) in
        let description =
          Util.to_string (Util.member "description" course_json)
        in
        let credits = Util.to_float (Util.member "credits" course_json) in
        let schedule_json = Util.member "schedule" course_json in
        let days =
          Util.member "days" schedule_json
          |> Util.to_list |> List.map Util.to_string
        in
        let time_json = Util.member "time" schedule_json in
        let start = Util.to_int (Util.member "start" time_json) in
        let finish = Util.to_int (Util.member "finish" time_json) in
        let time = make_time start finish in
        let schedule = make_schedule days time in
        make_course id name description credits schedule)
      courses_json
  in
  let json = Yojson.Basic.from_file "users.json" in
  let users_json = Util.to_list json in
  ref
    (List.map
       (fun user_json ->
         let netid = Util.to_string (Util.member "netid" user_json) in
         let password = Util.to_string (Util.member "password" user_json) in
         let total_credits =
           Util.to_float (Util.member "total_credits" user_json)
         in
         let college = Util.to_string (Util.member "college" user_json) in
         let user_courses =
           try
             let courses_json =
               Util.member "courses" user_json |> Util.to_list
             in
             load_courses courses_json
           with _ -> []
         in
         { netid; password; total_credits; college; courses = user_courses })
       users_json)

let print_all_users l =
  let print_user user =
    Printf.printf "NetID: %s\n" user.netid;
    Printf.printf "Password: %s\n" user.password;
    Printf.printf "Total Credits: %.2f\n" user.total_credits;
    Printf.printf "College: %s\n\n" user.college;
    match user.courses with
    | first_course :: _ ->
        Printf.printf "College: %s\n\n" (get_course_name first_course)
    | [] -> print_endline ""
  in
  List.iter print_user l

let users : user list ref = load_users_from_json
let get_users () = users

(* Function to convert a single user to Yojson *)
let user_to_json user =
  `Assoc
    [
      ("netid", `String user.netid);
      ("password", `String user.password);
      ("total_credits", `Float user.total_credits);
      ("college", `String user.college);
      (* Convert courses list to Yojson representation *)
      ( "courses",
        `List
          (List.map
             (fun course ->
               (* Convert each course to Yojson *)
               (* Implement conversion logic for courses if needed *)
               `Assoc
                 [
                   ("id", `Int (get_course_id course));
                   ("name", `String (get_course_name course));
                   ("description", `String (get_course_description course));
                   ("credits", `Float (get_course_credits course));
                   ( "schedule",
                     `Assoc
                       [
                         ( "days",
                           `List
                             (List.map
                                (fun day -> `String day)
                                (get_schedule_days (get_course_schedule course)))
                         );
                         ( "time",
                           `Assoc
                             [
                               ( "start",
                                 `Int
                                   (get_start_time
                                      (get_schedule_time
                                         (get_course_schedule course))) );
                               ( "finish",
                                 `Int
                                   (get_finish_time
                                      (get_schedule_time
                                         (get_course_schedule course))) );
                             ] );
                       ] )
                   (* Add other course fields as needed *);
                 ])
             user.courses) );
    ]

(*update user courses*)
let update_user_courses courses netid =
  let rec find_user users netid =
    match users with
    | u :: t -> if u.netid = netid then u else find_user t netid
    | [] -> failwith "user not found"
  in
  let rec total_credits l =
    match l with
    | course :: t -> get_course_credits course +. total_credits t
    | [] -> 0.0
  in
  let user = find_user !users netid in
  user.courses <- courses;
  user.total_credits <- total_credits courses;
  let users_json = `List (List.map user_to_json !users) in
  let oc = open_out "users.json" in
  output_string oc (to_string users_json);
  close_out oc

let change_college new_college user = { user with college = new_college }

let authenticate netid password =
  List.exists
    (fun username -> username.netid = netid && username.password = password)
    !users

let set_total_credits credits user = user.total_credits <- credits
let get_netid user = user.netid
let get_total_credits user = user.total_credits
let get_college user = user.college
let get_courses user = user.courses

(* ANSI escape codes for colors *)
let red = "\027[31m"
let green = "\027[32m"
let yellow = "\027[33m"
let blue = "\027[34m"
let reset = "\027[0m"

let display_total_credits netid =
  try
    let user = List.find (fun u -> get_netid u = netid) !users in
    Printf.printf "%sTotal credits for %s%s: %s%.2f%s credits\n" green
      (get_netid user) reset yellow (get_total_credits user) reset
  with Not_found -> Printf.printf "%sUser not found%s\n" red reset

(* Prints out total number of credits a student is planning on taking *)
let add_user_to_json_file netid password college =
  let filename = "users.json" in

  let curr_users = load_users_from_json in
  let user_exists = List.exists (fun u -> u.netid = netid) !curr_users in
  if user_exists then failwith "Netid already in use"
  else
    let new_user = make_user netid password college in
    let all_users = new_user :: !curr_users in
    let users_json = `List (List.map user_to_json all_users) in
    let oc =
      open_out_gen [ Open_creat; Open_trunc; Open_wronly ] 0o666 filename
    in
    try
      output_string oc (Yojson.Basic.pretty_to_string users_json);
      close_out oc;
      users := all_users (* Update the in-memory users list *)
    with e ->
      close_out_noerr oc;
      raise e
