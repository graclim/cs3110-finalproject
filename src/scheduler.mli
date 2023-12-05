open Courses
open Users

(*load the user courses based on net id*)
val load_courses : string -> unit

val my_courses : course list ref
(** Mutable list representing the user's current courses *)

val is_conflict : schedule -> schedule -> bool
(** Check if two schedules conflict *)

val has_schedule_conflict : course -> course list -> bool
(** Check if a new course conflicts with the existing schedule *)

val add_course_ID : string -> int -> unit
(** Add a course by ID *)

val add_course_name : string -> string -> unit
(** Add a course by name *)

val drop_course_ID : string -> int -> unit
(** Drop a course by ID *)

val drop_course_name : string -> string -> unit
(** Drop a course by name *)

val display_my_courses : unit -> unit
(** Display courses that the user is currently enrolled in *)

(*update the json for the user based on his courses*)
val update_json : string -> unit
