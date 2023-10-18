open String

(* Define the structure of a course *)
type course = {id: int; name: string; description: string}

(* CS courses *)
let cs_courses = [
  {id=1; name="CS1110"; description="Introduction to Computing: A Design and Development Perspective"};
  {id=2; name="CS1112"; description="Introduction to Computing: An Engineering and Science Perspective"};
  {id=3; name="CS1132"; description="Short Course in MATLAB"};
  {id=4; name="CS1133"; description="Short Course in Python"};
  {id=5; name="CS1620"; description="Visual Imaging in the Electronic Age"};
  {id=6; name="CS1710"; description="Introduction to Cognitive Science"};
  {id=7; name="CS2024"; description="C++ Programming"};
  {id=8; name="CS2110"; description="Object-Oriented Programming and Data Structures"};
  {id=9; name="CS2800"; description="Discrete Structures"};
  {id=10; name="CS2850"; description="Networks"};
  {id=11; name="CS3110"; description="Data Structures and Functional Programming"};
  {id=12; name="CS3300"; description="Data-Driven Web Applications"};
  {id=13; name="CS3410"; description="Computer System Organization and Programming"};
  {id=14; name="CS4210"; description="Numerical Analysis and Differential Equations"};
  {id=15; name="CS4320"; description="Introduction to Database Systems"};
  {id=16; name="CS4321"; description="Practicum in Database Systems"};
  {id=17; name="CS4410"; description="Operating Systems"};
  {id=18; name="CS4411"; description="Practicum in Operating Systems"};
  {id=19; name="CS4420"; description="Computer Architecture"};
  {id=20; name="CS4620"; description="Introduction to Computer Graphics"};
  {id=21; name="CS4621"; description="Computer Graphics Practicum"};
  {id=22; name="CS4700"; description="Foundations of Artificial Intelligence"};
  {id=23; name="CS4701"; description="Practicum in Artificial Intelligence"};
  {id=24; name="CS4740"; description="Natural Language Processing"};
  {id=25; name="CS4750"; description="Foundations of Robotics"};
  {id=26; name="CS4775"; description="Computational Genetics and Genomics"};
  {id=27; name="CS4780"; description="Introduction to Machine Learning"};
  {id=28; name="CS4783"; description="Mathematical Foundations of Machine Learning"};
  {id=29; name="CS4787"; description="Principles of Large-Scale Machine Learning Systems"};
  {id=30; name="CS4812"; description="Quantum Information Processing"};
  {id=31; name="CS4820"; description="Introduction to Analysis of Algorithms"};
  {id=32; name="CS4860"; description="Applied Logic"};
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

(* user can add a course by ID *)
let add_course_ID course_id =
  try
    let course_to_add = List.find (fun c -> c.id = course_id) cs_courses in
    if List.exists (fun c -> c.id = course_id) !my_courses then
      print_endline "You are already enrolled in this course."
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