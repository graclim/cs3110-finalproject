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

val create_user : unit -> unit
(*prompt the user to create new user with netid, password, and college. Stores
   new users into the json database*) 

val login_or_create_user : unit -> unit
(** [login_or_create_user ()] prompts the user to enter their netid and password to login.
     User can also create new user *)