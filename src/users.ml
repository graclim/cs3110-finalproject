type user = {
  netid : string;
  password : string;
  mutable total_credits : float;
  college : string;
}

let make_user netid password college =
  { netid; password; total_credits = 0.0; college }

let add_user new_user users_list = new_user :: users_list

let users =
  [
    {
      netid = "user1";
      password = "pass1";
      total_credits = 0.0;
      college = "engineering";
    };
    {
      netid = "user2";
      password = "pass2";
      total_credits = 0.0;
      college = "arts and sciences";
    };
  ]

let get_users () = users
let change_college new_college user = { user with college = new_college }

let authenticate netid password =
  List.exists (fun user -> user.netid = netid && user.password = password) users

let set_total_credits credits user = user.total_credits <- credits
let get_netid user = user.netid
let get_total_credits user = user.total_credits
let get_college user = user.college
