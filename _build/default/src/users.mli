(** Type representing a user with a netid, password, total_credits, and college *)
type user

(* Create a new user *)
val make_user : string -> string -> string -> user

(** Add a user to the list of users *)
val add_user : user -> user list -> user list

(** Hard-coded list of users *)
val users : user list

(** Get the list of users *)
val get_users : unit -> user list

(** Change the user's college *)
val change_college : string -> user -> user

(** Authenticate a user by netid and password *)
val authenticate : string -> string -> bool

(** Change the user's total credits *)
val set_total_credits : float -> user -> unit 

(* Get the user's netid *)
val get_netid : user -> string

(* Get the user's total credits *)
val get_total_credits : user -> float

(* Get the user's college *)
val get_college : user -> string 