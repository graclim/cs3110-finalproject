open Yojson
open Courses

type user
(** Type representing a user with a netid, password, total_credits, and college *)

(* Create a new user *)
val make_user : string -> string -> string -> user

val add_user : user -> user list -> user list
(** Add a user to the list of users *)

val users : user list
(** Hard-coded list of users *)

(*update user courses and credits and write to json*)
val update_user_courses : course list -> string -> unit

(*Load current users into a list of users*)
val load_users_from_json : user list

(*Print users*)
val print_all_users : user list -> unit

val get_users : unit -> user list
(** Get the list of users *)

val change_college : string -> user -> user
(** Change the user's college *)

val authenticate : string -> string -> bool
(** Authenticate a user by netid and password *)

val set_total_credits : float -> user -> unit
(** Change the user's total credits *)

(* Get the user's netid *)
val get_netid : user -> string

(* Get the user's total credits *)
val get_total_credits : user -> float

(* Get the user's college *)
val get_college : user -> string

(* Get the user's courses*)
val get_courses : user -> course list

val display_total_credits : string -> unit
(** [display_total_credits netid] prints out the total number of credits for a
    student based on netid. *)
