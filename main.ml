open String

type time = {start: int; (* in minutes, 0 meaning 12:00 AM, etc. *) 
             finish: int}

type schedule = {days: string list; (* ["Monday", "Wednesday", "Friday"] etc. *)
                 time: time}  (* time remains the same *)


type course = {id: int; 
               name: string; 
               description: string; 
               schedule: schedule}

(* CS Courses *)
let cs_courses = [
  let classes = [
  {id=1; 
   name="CS1110";
   description="Introduction to Computing: A Design and Development Perspective"; 
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=545; finish=595}}};  (* 9:05 to 9:55 *)
  {id=2;
   name="CS1112";
   description="Introduction to Computing: An Engineering and Science Perspective";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=610; finish=660}}};  (* 10:10 to 11:00 *)
  {id=3; 
   name="CS1132"; 
   description="Short Course in MATLAB";
   schedule={days=["Tuesday"; "Thursday"]; time={start=540; finish=615}}};  (* 9:00 to 10:15 *)
  {id=4; 
   name="CS1133"; 
   description="Short Course in Python";
   schedule={days=["Tuesday"; "Thursday"]; time={start=540; finish=615}}};  (* 9:00 to 10:15 *)
  {id=5; 
   name="CS1620"; 
   description="Visual Imaging in the Electronic Age";
   schedule={days=["Wednesday"]; time={start=720; finish=870}}};  (* 12:00 to 2:30 PM *)
  {id=6; 
   name="CS1710"; 
   description="Introduction to Cognitive Science";
   schedule={days=["Tuesday"]; time={start=900; finish=1050}}};  (* 3:00 to 5:30 PM *)
  {id=7; 
   name="CS2024"; 
   description="C++ Programming";
   schedule={days=["Thursday"]; time={start=900; finish=1050}}};  (* 3:00 to 5:30 PM *)
   {id=8; 
   name="CS2110"; 
   description="Object-Oriented Programming and Data Structures";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=675; finish=725}}};  (* 11:15 to 12:05 *)
  {id=9; 
   name="CS2800"; 
   description="Discrete Structures";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=545; finish=595}}};  (* 9:05 to 9:55 *)
  {id=10; 
   name="CS2850"; 
   description="Networks";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=610; finish=660}}};  (* 10:10 to 11:00 *)
  {id=11; 
   name="CS3110"; 
   description="Data Structures and Functional Programming";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=675; finish=725}}};  (* 11:15 to 12:05 *)
  {id=12; 
   name="CS3300"; 
   description="Data-Driven Web Applications";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=740; finish=790}}};  (* 12:20 to 1:10 PM *)
  {id=13; 
   name="CS3410"; 
   description="Computer System Organization and Programming";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=805; finish=855}}};  (* 1:25 to 2:15 PM *)
  {id=14; 
   name="CS4210"; 
   description="Numerical Analysis and Differential Equations";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=870; finish=920}}};  (* 2:30 to 3:20 PM *)
  {id=15; 
   name="CS4320"; 
   description="Introduction to Database Systems";
   schedule={days=["Tuesday"]; time={start=810; finish=960}}};  (* 1:30 to 4:00 PM *)
  {id=16; 
   name="CS4321"; 
   description="Practicum in Database Systems";
   schedule={days=["Monday"]; time={start=0; finish=1}}};  (* no schedule *)
  {id=17; 
   name="CS4410"; 
   description="Operating Systems";
   schedule={days=["Wednesday"]; time={start=900; finish=1050}}};  (* 3:00 to 5:30 PM *)
  {id=18; 
   name="CS4411"; 
   description="Practicum in Operating Systems";
   schedule={days=["Tuesday"]; time={start=0; finish=1}}};  (* no schedule *)
  {id=19; 
   name="CS4420"; 
   description="Computer Architecture";
   schedule={days=["Tuesday"; "Thursday"]; time={start=810; finish=885}}};  (* 1:30 to 2:45 PM *)
  {id=20; 
   name="CS4620"; 
   description="Introduction to Computer Graphics";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=800; finish=850}}};  (* 1:20 to 2:10 PM *)
  {id=21; 
   name="CS4621"; 
   description="Computer Graphics Practicum";
   schedule={days=["Monday"]; time={start=0; finish=1}}};  (* no schedule *)
  {id=22; 
   name="CS4700"; 
   description="Foundations of Artificial Intelligence";
   schedule={days=["Tuesday"; "Thursday"]; time={start=900; finish=975}}};  (* 3:00 to 4:15 PM *)
  {id=23; 
   name="CS4701"; 
   description="Practicum in Artificial Intelligence";
   schedule={days=["Wednesday"]; time={start=0; finish=1}}};  (* no schedule *)
  {id=24; 
   name="CS4740"; 
   description="Natural Language Processing";
   schedule={days=["Monday"]; time={start=780; finish=930}}};  (* 1:00 to 3:30 PM *)
  {id=25; 
   name="CS4750"; 
   description="Foundations of Robotics";
   schedule={days=["Friday"]; time={start=780; finish=930}}};  (* 1:00 to 3:30 PM *)
  {id=26; 
   name="CS4775"; 
   description="Computational Genetics and Genomics";
   schedule={days=["Tuesday"; "Thursday"]; time={start=840; finish=915}}};  (* 2:00 to 3:15 PM *)
  {id=27; 
   name="CS4780"; 
   description="Machine Learning for Intelligent Systems";
   schedule={days=["Monday"; "Wednesday"]; time={start=610; finish=685}}};  (* 10:10 to 11:25 PM *)
  {id=28; 
   name="CS4786"; 
   description="Machine Learning for Data Science";
   schedule={days=["Tuesday"; "Thursday"]; time={start=610; finish=685}}};  (* 10:10 to 11:25 PM *)
  {id=29; 
   name="CS4810"; 
   description="Introduction to Computer Vision";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=675; finish=725}}};  (* 11:15 to 12:05 *)
  {id=30; 
   name="CS4812"; 
   description="Quantum Information Processing";
   schedule={days=["Wednesday"]; time={start=965; finish=1040}}};  (* 4:05 to 5:20 PM *)
  {id=31; 
   name="CS4820"; 
   description="Introduction to Analysis of Algorithms";
   schedule={days=["Monday"; "Wednesday"; "Friday"]; time={start=545; finish=595}}};  (* 9:05 to 9:55 *)
  {id=32; 
   name="CS4860"; 
   description="Applied Logic";
   schedule={days=["Friday"]; time={start=965; finish=1040}}};  (* 4:05 to 5:20 PM *)
  ]
]

(* displays all available CS courses *)
let display_courses () = 
  let rec print_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf "ID: %d, Name: %s, Description: %s\n" course.id course.name course.description;
        print_courses rest_of_courses
  in
  print_endline "Available courses:";
  print_courses cs_courses


(* a mutable list representing the user's courses *)
let my_courses = ref []

(* function to check if two schedules conflict *)
let is_conflict (s1: schedule) (s2: schedule) : bool =
  let shared_days = List.filter (fun day -> List.mem day s2.days) s1.days in
  (* if there's at least one shared day and the times conflict, then there's a conflict. *)
  shared_days <> [] && not (s1.time.finish <= s2.time.start || s2.time.finish <= s1.time.start)


(* function to check if a new course conflicts with existing courses *)
let has_schedule_conflict new_course my_courses =
  List.exists (fun existing_course -> is_conflict existing_course.schedule new_course.schedule) my_courses

(* user can add a course by ID *)
let add_course_ID course_id =
  try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found."

(* user can add a course by name *)
let add_course_name course_name =
  try
    let course_to_add = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) cs_courses in
    if List.exists (fun c -> c.name = course_to_add.name) !my_courses then
      print_endline "You are already enrolled in this course."
    else if has_schedule_conflict course_to_add !my_courses then
      print_endline "There is a schedule conflict with your current courses."
    else
      (my_courses := course_to_add :: !my_courses;
       print_endline ("Added course: " ^ course_to_add.name))
  with Not_found -> print_endline "Course not found."

(* user can drop a course by ID *)
let drop_course_ID course_id =
  try
    let course_to_drop = List.find (fun c -> c.id = course_id) !my_courses in
    my_courses := List.filter (fun c -> c.id <> course_id) !my_courses;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course."

(* user can drop a course by name *)
let drop_course_name course_name =
  try
    let course_to_drop = List.find (fun c -> String.lowercase_ascii c.name = String.lowercase_ascii course_name) !my_courses in
    my_courses := List.filter (fun c -> c.name <> course_to_drop.name) !my_courses;
    print_endline ("Dropped course: " ^ course_to_drop.name)
  with Not_found -> print_endline "You are not enrolled in this course."

(* displays courses the user is enrolled in *)
let display_my_courses () = 
  let rec print_my_courses course_list =
    match course_list with
    | [] -> ()
    | course :: rest_of_courses ->
        Printf.printf "ID: %d, Name: %s, Description: %s\n" course.id course.name course.description;
        print_my_courses rest_of_courses
  in
  print_endline "My courses:";
  print_my_courses !my_courses

(* main user interface *)
let rec main () = 
  print_endline "\n1: Display all courses";
  print_endline "2: Display my courses";
  print_endline "3: Add course by ID";
  print_endline "4: Drop course by ID";
  print_endline "5: Add course by name";
  print_endline "6: Drop course by name";
  print_endline "0: Exit";
  print_string "Enter your choice: ";
  match read_int () with
  | 1 -> print_endline ""; display_courses (); main ()
  | 2 -> print_endline ""; display_my_courses (); main ()
  | 3 -> print_endline ""; print_string "Enter course ID to add: ";
         add_course_ID (read_int ()); main ()
  | 4 -> print_endline ""; print_string "Enter course ID to drop: ";
         drop_course_ID (read_int ()); main ()
  | 5 -> print_endline ""; print_string "Enter course name to add: ";
        add_course_name (read_line ()); main ()
  | 6 -> print_endline ""; print_string "Enter course ID to drop: ";
         drop_course_name (read_line ()); main ()
  | 0 -> print_endline ""; print_endline "Bye!"
  | _ -> print_endline ""; print_endline "Invalid option"; main ()

(* run main *)
let () = main ()