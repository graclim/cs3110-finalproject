open Yojson

type time = {
  start : int;
  finish : int;
}
(** Type representing time with a start and finish as integers *)

type schedule = {
  days : string list;
  time : time;
}
(** Type representing a schedule with a list of days and a time *)

type course = {
  id : int;
  name : string;
  description : string;
  credits : float;
  schedule : schedule;
}
(** Type representing a course with an id, name, description, credits, and
    schedule *)

val make_time : int -> int -> time
(** [make_time start_time finish_time] creates a new [time] record with the
    given start and finish times. *)

val make_schedule : string list -> time -> schedule
(** [make_schedule days time] creates a new [schedule] record with the given
    list of days and [time]. *)

val make_course : int -> string -> string -> float -> schedule -> course
(** [make_course id name desc credits schedule] creates a new [course] record
    with the given id, name, description, credits, and schedule. *)

val to_time : Yojson.Basic.t -> time
(** [to_time json] converts a JSON representation to the time type. *)

val get_course_id : course -> int
(** [get_course_id c] returns the ID of the given course [c]. *)

val get_course_name : course -> string
(** [get_course_name c] returns the name of the given course [c]. *)

val get_course_description : course -> string
(** [get_course_description c] returns the description of the given course [c]. *)

val get_course_credits : course -> float
(** [get_course_credits c] returns the credits of the given course [c]. *)

val get_course_schedule : course -> schedule
(** [get_course_schedule c] returns the schedule of the given course [c]. *)

val get_schedule_days : schedule -> string list
(** [get_schedule_days s] returns the list of days in the schedule [s]. *)

val get_schedule_time : schedule -> time
(** [get_schedule_time s] returns the time in the schedule [s]. *)

val get_start_time : time -> int
(** [get_start_time t] returns the start time of the given time [t]. *)

val get_finish_time : time -> int
(** [get_finish_time t] returns the finish time of the given time [t]. *)

val to_schedule : Yojson.Basic.t -> schedule
(** [to_schedule json] converts a JSON representation to the schedule type. *)

val cs_courses : course list
(** List of computer science courses loaded from JSON *)

val get_cs_courses : unit -> course list
(** [get_cs_courses ()] returns a list of all computer science courses. *)

(* Field to courses mapping *)
val field_to_courses : (string, course list) Hashtbl.t

val get_terminal_width : unit -> int
(** Gets the current width of the terminal. Returns the terminal width as an
    integer. If it cannot determine the width, defaults to 80. *)

(* Function to recommend courses based on a given field *)
val recommend_courses : string -> course list

(* Function to get recommended courses - this is effectively an alias to
   recommend_courses *)
val get_recommended_courses : string -> course list

(* Function to display a list of recommended courses *)
val display_recommended_courses : course list -> unit

val display_courses : unit -> unit
(** [display_courses ()] prints out a list of all available computer science
    courses. *)

val total_credits : course list -> float
(** [total_credits courses] calculates the total number of credits from a list
    of courses. *)

val get_credit_limit : string -> float
(** [get_credit_limit college] returns the credit limit based on the college. *)
