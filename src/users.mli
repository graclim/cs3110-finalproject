(** Type representing a user with a netid, password, total_credits, and college *)
type user

(** Hard-coded list of users *)
val users : user list

(** Authenticate a user by netid and password *)
val authenticate : string -> string -> bool

(**Change the user's total credits*)
val set_total_credits : float -> user -> unit 

(*Get the user's netid*)
val get_netid : user -> string

(*Get the user's total credits*)
val get_total_credits : user -> float

(*Get the user's college*)
val get_college : user -> string 

