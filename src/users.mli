open Yojson
open Courses

type user = {
  netid : string;
  password : string;
  mutable total_credits : float;
  college : string;
  mutable courses : course list;
}
(** Type representing a user with a netid, password, total credits, college, and
    a list of courses *)

val make_user : string -> string -> string -> user
(** Create a new user with the given netid, password, and college. Initially,
    the user has 0.0 total credits and no courses. *)

val add_user : user -> user list -> user list
(** Add a user to the list of users *)

val load_users_from_json : user list
(** Load current users from a JSON file into a list of users *)

val print_all_users : user list -> unit
(** Print all users in the provided list *)

val users : user list
(** A list of users loaded from a JSON file *)

val get_users : unit -> user list
(** Get the list of users *)

val user_to_json : user -> Yojson.Basic.t
(** Convert a single user to a Yojson.Basic.json representation *)

val update_user_courses : course list -> string -> unit
(** Update user courses and total credits based on the given netid, and write
    the updated information to a JSON file *)

val change_college : string -> user -> user
(** Change the user's college *)

val authenticate : string -> string -> bool
(** Authenticate a user by netid and password *)

val set_total_credits : float -> user -> unit
(** Set the user's total credits *)

val get_netid : user -> string
(** Get the user's netid *)

val get_total_credits : user -> float
(** Get the user's total credits *)

val get_college : user -> string
(** Get the user's college *)

val get_courses : user -> course list
(** Get the user's list of courses *)

val display_total_credits : string -> unit
(** Display the total number of credits for a student based on netid *)

val add_user_to_json_file : string -> string -> string -> unit