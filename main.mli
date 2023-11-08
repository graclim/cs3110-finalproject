#require "yojson"

open String
open Yojson

(** Type representing time with a start and finish as integers *)
type time

(** Type representing a schedule with a list of days and a time *)
type schedule

(** Type representing a course with an id, name, description, credits, and schedule *)
type course

(** Type representing a user with a netid, password, total_credits, and college *)
type user

(** Convert JSON to time type *)
val to_time : Yojson -> time

(** Convert JSON to schedule type *)
val to_schedule : Yojson -> schedule

(** List of courses loaded from JSON *)
val cs_courses : course list

(** Hard-coded list of users *)
val users : user list

(** Display a list of all available CS courses *)
val display_courses : unit -> unit

(** Calculate the total number of credits from a list of courses *)
val total_credits : course list -> float

(** Print out the total number of credits for a student based on netid *)
val display_total_credits : string -> unit

(** Get the credit limit based on the college *)
val get_credit_limit : string -> float

(** Mutable list representing the user's current courses *)
val my_courses : course list ref

(** Check if two schedules conflict *)
val is_conflict : schedule -> schedule -> bool

(** Check if a new course conflicts with the existing schedule *)
val has_schedule_conflict : course -> course list -> bool

(** Add a course by ID *)
val add_course_ID : string -> int -> unit

(** Add a course by name *)
val add_course_name : string -> string -> unit

(** Drop a course by ID *)
val drop_course_ID : string -> int -> unit

(** Drop a course by name *)
val drop_course_name : string -> string -> unit

(** Display courses that the user is currently enrolled in *)
val display_my_courses : unit -> unit

(** Authenticate a user by netid and password *)
val authenticate : string -> string -> bool

(** Main user interface *)
val main : string -> unit

(** User login interface *)
val login : unit -> unit