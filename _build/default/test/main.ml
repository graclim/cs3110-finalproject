open OUnit2
open Yojson.Basic.Util
open Course_scheduler
open Users
open Scheduler
open Courses

(* =================== TESTING FOR USER AUTHENTICATION =================== *)

let test_authenticate _ =
  assert_bool "Valid user should authenticate successfully"
    (authenticate "user1" "pass1");
  assert_bool "Invalid user should not authenticate"
    (not (authenticate "fake_user" "fake_pass"));
  assert_bool "User should not be authenticated with wrong password"
    (not (authenticate "user1" "wrongpass"));
  assert_bool "User should not be authenticated with wrong netid"
    (not (authenticate "wronguser" "pass1"))

(* =================== TESTING FOR COURSE CREATION 1 =================== *)

let test_course_creation1 _ =
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  assert_equal ~msg:"Course ID should be correct" 101
    (Courses.get_course_id mock_course);
  assert_equal ~msg:"Course name should be correct" "Introduction to OCaml"
    (Courses.get_course_name mock_course);
  assert_equal ~msg:"Course description should be correct"
    "A course about OCaml programming basics"
    (Courses.get_course_description mock_course);
  assert_equal ~msg:"Course credits should be correct" 4.0
    (Courses.get_course_credits mock_course);

  let course_schedule = Courses.get_course_schedule mock_course in
  assert_equal ~msg:"Course days should be correct"
    [ "Monday"; "Wednesday"; "Friday" ]
    (Courses.get_schedule_days course_schedule);

  let schedule_time = Courses.get_schedule_time course_schedule in
  assert_equal ~msg:"Start time should be correct" 900
    (Courses.get_start_time schedule_time);
  assert_equal ~msg:"Finish time should be correct" 1030
    (Courses.get_finish_time schedule_time)

(* =================== TESTING FOR COURSE CREATION 2 =================== *)

let test_course_creation2 _ =
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  assert_equal ~msg:"Course ID should be correct" 102
    (Courses.get_course_id another_mock_course);
  assert_equal ~msg:"Course name should be correct" "Advanced OCaml"
    (Courses.get_course_name another_mock_course);
  assert_equal ~msg:"Course description should be correct"
    "An advanced course on OCaml programming"
    (Courses.get_course_description another_mock_course);
  assert_equal ~msg:"Course credits should be correct" 3.0
    (Courses.get_course_credits another_mock_course);

  let course_schedule = Courses.get_course_schedule another_mock_course in
  assert_equal ~msg:"Course days should be correct" [ "Tuesday"; "Thursday" ]
    (Courses.get_schedule_days course_schedule);

  let schedule_time = Courses.get_schedule_time course_schedule in
  assert_equal ~msg:"Start time should be correct" 1400
    (Courses.get_start_time schedule_time);
  assert_equal ~msg:"Finish time should be correct" 1530
    (Courses.get_finish_time schedule_time)

(* =================== TESTING FOR COURSE CONFLICTS =================== *)

let test_is_conflict _ =
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  let time2 = make_time 930 1230 in
  let schedule2 = make_schedule [ "Monday"; "Wednesday" ] time2 in
  let course2 = make_course 102 "Course2" "Description" 4.0 schedule2 in

  let time3 = make_time 1200 1400 in
  let schedule3 = make_schedule [ "Wednesday"; "Friday" ] time3 in
  let course3 = make_course 103 "Course3" "Description" 3.0 schedule3 in

  let time4 = make_time 1300 1500 in
  let schedule4 = make_schedule [ "Friday" ] time4 in
  let course4 = make_course 104 "Course4" "Description" 2.0 schedule4 in

  let time5 = make_time 800 1000 in
  let schedule5 = make_schedule [ "Monday"; "Wednesday" ] time5 in
  let course5 = make_course 105 "Course5" "Description" 1.0 schedule5 in

  assert_bool "Courses 1 and 2 conflict"
    (is_conflict (get_course_schedule course1) (get_course_schedule course2));

  assert_bool "Courses 1 and 3 do not conflict"
    (not
       (is_conflict (get_course_schedule course1) (get_course_schedule course3)));

  assert_bool "Courses 3 and 4 conflict"
    (is_conflict (get_course_schedule course3) (get_course_schedule course4));

  assert_bool "Courses 1 and 5 conflict"
    (is_conflict (get_course_schedule course1) (get_course_schedule course5))

let test_has_schedule_conflict _ =
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 930 1230 in
  let schedule2 = make_schedule [ "Monday"; "Wednesday" ] time2 in
  let course2 = make_course 102 "Course2" "Description" 4.0 schedule2 in

  assert_bool "Course conflicts with existing courses"
    (has_schedule_conflict course2 !my_courses);

  let time3 = make_time 1400 1600 in
  let schedule3 = make_schedule [ "Tuesday"; "Thursday" ] time3 in
  let course3 = make_course 103 "Course3" "Description" 3.0 schedule3 in

  assert_bool "Course does not conflict with existing courses"
    (not (has_schedule_conflict course3 !my_courses))

(* =================== COMBINING ALL TEST SUITES =================== *)
let suite =
  "Course Scheduler Tests"
  >::: [
         "test_authenticate" >:: test_authenticate;
         "test_course_creation1" >:: test_course_creation1;
         "test_course_creation2" >:: test_course_creation2;
         "test_is_conflict" >:: test_is_conflict;
         "test_has_schedule_conflict" >:: test_has_schedule_conflict;
       ]

(* Run the tests *)
let () = run_test_tt_main suite
