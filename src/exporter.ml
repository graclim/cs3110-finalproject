open Unix
open Courses
open Users

(* Helper function to convert minutes since midnight to HHMMSS format *)
let minutes_to_hhmmss minutes =
  let hours = minutes / 60 in
  let mins = minutes mod 60 in
  Printf.sprintf "%02d%02d00" hours mins

(* Helper function to map weekday strings to ICS date format *)
let day_to_ics_date day =
  match day with
  | "Monday" -> "MO"
  | "Tuesday" -> "TU"
  | "Wednesday" -> "WE"
  | "Thursday" -> "TH"
  | "Friday" -> "FR"
  | "Saturday" -> "SA"
  | "Sunday" -> "SU"
  | _ -> failwith "Invalid day"

(* Get the current system date *)
let current_system_date () =
  let tm = Unix.localtime (Unix.time ()) in
  (tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday)

let weekday_number day =
  match day with
  | "Sunday" -> 0
  | "Monday" -> 1
  | "Tuesday" -> 2
  | "Wednesday" -> 3
  | "Thursday" -> 4
  | "Friday" -> 5
  | "Saturday" -> 6
  | _ -> failwith "Invalid weekday"

(* Get the current weekday as a string *)
let current_weekday_string () =
  let tm = Unix.localtime (Unix.time ()) in
  match tm.tm_wday with
  | 0 -> "Sunday"
  | 1 -> "Monday"
  | 2 -> "Tuesday"
  | 3 -> "Wednesday"
  | 4 -> "Thursday"
  | 5 -> "Friday"
  | 6 -> "Saturday"
  | _ -> failwith "Invalid weekday"

(* Function to add days to a date *)
let add_days_to_date (year, month, day) offset =
  (* Simple implementation: assumes all months have 30 days and doesn't handle year boundaries *)
  let total_days = day + offset in
  let new_day = total_days mod 30 in
  let new_month = month + (total_days / 30) in
  Printf.sprintf "%04d%02d%02d" year new_month new_day

(* Convert a course schedule to an ICS event, accounting for the current week *)
let course_to_ics_event course current_weekday =
  List.map (fun day ->
      let weekday_offset = (weekday_number day) - (weekday_number current_weekday) in
      let event_date = add_days_to_date (current_system_date ()) weekday_offset in
      let time = course.schedule.time in
      let start_time = minutes_to_hhmmss time.start in
      let end_time = minutes_to_hhmmss time.finish in
      Printf.sprintf
        "BEGIN:VEVENT\nDTSTART;TZID=America/New_York:%sT%s\nDTEND;TZID=America/New_York:%sT%s\nRRULE:FREQ=WEEKLY;BYDAY=%s\nSUMMARY:%s\nDESCRIPTION:%s\nEND:VEVENT\n"
        event_date start_time event_date end_time (day_to_ics_date day) course.name course.description
    ) course.schedule.days
  |> String.concat "\n"

(* Exports a user's course schedule to an ICS file *)
let export_user_schedule_to_ics user =
  let current_weekday = current_weekday_string () in
  let ics_header = "BEGIN:VCALENDAR\nVERSION:2.0\nPRODID:-//YourOrg//YourApp//EN\nCALSCALE:GREGORIAN\n" in
  let ics_footer = "END:VCALENDAR" in
  let ics_events = List.fold_left (fun acc course -> acc ^ (course_to_ics_event course current_weekday) ^ "\n") "" user.courses in
  let ics_content = ics_header ^ ics_events ^ ics_footer in
  let filename = Printf.sprintf "%s_schedule.ics" user.netid in
  let oc = open_out filename in
  Printf.printf "Exporting schedule to %s\n" filename;
  output_string oc ics_content;
  close_out oc