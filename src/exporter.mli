open Unix
open Courses
open Users

val minutes_to_hhmmss : int -> string
(** Signature for converting minutes to HHMMSS format *)

val day_to_ics_date : string -> string
(** Signature for mapping weekday strings to ICS date format *)

val current_system_date : unit -> int * int * int
(** Signature for getting the current system date *)

val weekday_number : string -> int
(** Signature for getting the numeric representation of a weekday *)

val current_weekday_string : unit -> string
(** Signature for getting the current weekday as a string *)

val add_days_to_date : int * int * int -> int -> string
(** Signature for adding days to a date *)

val course_to_ics_event : course -> string -> string
(** Signature for converting a course schedule to an ICS event *)

val export_user_schedule_to_ics : user -> unit
(** Signature for exporting a user's course schedule to an ICS file *)
