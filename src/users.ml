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
  { netid; password; total_credits = 0.0; college; courses = []}

let add_user new_user users_list = new_user :: users_list

let rec load_courses courses_json =
  List.map (fun course_json ->
    let id = Util.to_int (Util.member "id" course_json) in
    let name = Util.to_string (Util.member "name" course_json) in
    let description = Util.to_string (Util.member "description" course_json) in
    let credits = Util.to_float (Util.member "credits" course_json) in
    let schedule_json = Util.member "schedule" course_json in
    let days = Util.member "days" schedule_json |> Util.to_list |> List.map Util.to_string in
    let time_json = Util.member "time" schedule_json in
    let start = Util.to_int (Util.member "start" time_json) in
    let finish = Util.to_int (Util.member "finish" time_json) in
    let time = make_time start finish in
    let schedule = make_schedule days time in
    make_course id name description credits schedule
  ) courses_json

let load_users_from_json =
  let json = Yojson.Basic.from_file "users.json" in
  let users_json = Util.to_list json in
  List.map (fun user_json ->
    let netid = Util.to_string (Util.member "netid" user_json) in
    let password = Util.to_string (Util.member "password" user_json) in
    let total_credits = Util.to_float (Util.member "total_credits" user_json) in
    let college = Util.to_string (Util.member "college" user_json) in
    let user_courses =
      try
        let courses_json = Util.member "courses" user_json |> Util.to_list in
        load_courses courses_json
      with
      | _ -> []
    in
    { netid; password; total_credits; college; courses = user_courses }
  ) users_json

(* let load_users_from_json = 
  let json_string = Yojson.Basic.from_file "users.json" in
  let users_json = Yojson.Basic.Util.to_list json_string in
  List.map (fun user_json ->
    let user_courses  =
      let json_courses= Yojson.Basic.Util.member "courses" user_json in 
      let courses_json = Yojson.Basic.Util.to_list json_courses in
      List.map (fun course_json ->
        let schedule_json = Yojson.Basic.Util.member "schedule" course_json in 
        let days_list = Yojson.Basic.Util.member "days" schedule_json in days_list in 
        let days = 
          match days_list with
          | `List json_days ->
              let ocaml_days =
                Yojson.Basic.Util.to_list json_days
                |> List.map Yojson.Basic.Util.to_string
              (* Now 'ocaml_days' is an OCaml list of strings *)
              (* Use 'ocaml_days' as needed *)
          | _ -> failwith "Expected a JSON list for 'days'" 
        in days
        (* let days = Yojson.Basic.Util.to_list schedule_json |> List.map Yojson.Basic.Util.to_string in days *)
        (* let time_json = Yojson.Basic.Util.member "time" schedule_json in
        let start = Yojson.Basic.Util.to_int (Yojson.Basic.Util.member "start" time_json) in
        let finish = Yojson.Basic.Util.to_int (Yojson.Basic.Util.member "finish" time_json) in
        let time = make_time start finish in
        let course_schedule : schedule = make_schedule days time in
        let id = Yojson.Basic.Util.to_int (Yojson.Basic.Util.member "id" course_json) in
        let name = Yojson.Basic.Util.to_string (Yojson.Basic.Util.member "name" course_json) in
        let description = Yojson.Basic.Util.to_string (Yojson.Basic.Util.member "description" course_json) in
        let credits = Yojson.Basic.Util.to_float (Yojson.Basic.Util.member "credits" course_json) in
        let course = make_course id name description credits course_schedule in  
        course  *)
      ) 
      courses_json
    in 
    {
      netid = Yojson.Basic.Util.to_string (Yojson.Basic.Util.member "netid" user_json);
      password = Yojson.Basic.Util.to_string (Yojson.Basic.Util.member "password" user_json);
      total_credits = Yojson.Basic.Util.to_float (Yojson.Basic.Util.member "total_credits" user_json);
      college = Yojson.Basic.Util.to_string (Yojson.Basic.Util.member "college" user_json);
      courses = []; 
    }
  ) users_json *)


let print_all_users l =  
  let print_user user=
    Printf.printf "NetID: %s\n" user.netid;
    Printf.printf "Password: %s\n" user.password;
    Printf.printf "Total Credits: %.2f\n" user.total_credits;
    Printf.printf "College: %s\n\n" user.college;
    match user.courses with 
    | first_course :: _ -> 
      Printf.printf "College: %s\n\n" (get_course_name first_course) 
    | [] -> print_endline ""; 
  in
  List.iter print_user l  

let users =
  load_users_from_json

let get_users () = users

let change_college new_college user = { user with college = new_college }

let authenticate netid password =
  List.exists (fun user -> user.netid = netid && user.password = password) users

let set_total_credits credits user = user.total_credits <- credits
let get_netid user = user.netid
let get_total_credits user = user.total_credits
let get_college user = user.college


(* Prints out total number of credits a student is planning on taking *)
let display_total_credits netid =
  try
    let user = List.find (fun u -> get_netid u = netid) users in
    Printf.printf "Total credits for %s: %.2f\n" (get_netid user)
      (get_total_credits user)
  with Not_found -> print_endline "User not found."
