open Yojson
open Users

(** Type representing time with a start and finish as integers *)
type time

(** Type representing a schedule with a list of days and a time *)
type schedule

(** Type representing a course with an id, name, description, credits, and schedule *)
type course

val get_course_id : course -> int

val get_course_name : course -> string  

val get_course_description : course -> string  

val get_course_credits : course -> float 

val get_course_schedule : course -> schedule 

val get_schedule_days : schedule -> string list 

val get_schedule_time : schedule -> time   

val get_start_time : time -> int  

val get_finish_time : time -> int 

(** Convert JSON to time type *)
val to_time : Yojson.Basic.t -> time

(** Convert JSON to schedule type *)
val to_schedule : Yojson.Basic.t -> schedule

(** List of courses loaded from JSON *)
val cs_courses : course list

(** Display a list of all available CS courses *)
val display_courses : unit -> unit

(** Calculate the total number of credits from a list of courses *)
val total_credits : course list -> float

(** Print out the total number of credits for a student based on netid *)
val display_total_credits : string -> unit

(** Get the credit limit based on the college *)
val get_credit_limit : string -> float


