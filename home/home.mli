open Course_scheduler
open Yojson
open Users
open Courses
open Scheduler

(** [main netid] starts the main user interface for the given netid. *)
val main : string -> unit

val login : unit -> unit
(** [login ()] prompts the user to enter their netid and password and starts the
    application if login is successful. *)
