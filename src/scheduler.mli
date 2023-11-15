open Courses
open Users

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