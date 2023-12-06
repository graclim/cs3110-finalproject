open OUnit2
open Yojson.Basic.Util
open Course_scheduler
open Users
open Scheduler
open Courses

(* At the top of your test file, which should be named test.ml or something very
   similar so that the grader can find it, please write a (potentially lengthy)
   comment describing your approach to testing: what you tested, anything you
   omitted testing, and why you believe that your test suite demonstrates the
   correctness of your system. A detailed rubric can be found below. *)

(* =================== TESTING FOR USER AUTHENTICATION =================== *)
let test_authenticate_successful _ =
  Printf.printf
    "=== Testing authenticate (Valid user should authenticate successfully) ===\n";
  let netid = "user1" in
  let password = "pass1" in
  let result = authenticate netid password in
  Printf.printf "NetID: %s\n" netid;
  Printf.printf "Password: %s\n" password;
  Printf.printf "Result: %b\n" result;
  assert_bool "Valid user should authenticate successfully" result;
  Printf.printf "=== Test test_authenticate_successful completed ===\n"

let test_authenticate_both_invalid _ =
  Printf.printf
    "=== Testing authenticate (Invalid user should not authenticate) ===\n";
  let netid = "fake_user" in
  let password = "fake_pass" in
  let result = authenticate netid password in
  Printf.printf "NetID: %s\n" netid;
  Printf.printf "Password: %s\n" password;
  Printf.printf "Result: %b\n" result;
  assert_bool "Invalid user should not authenticate" (not result);
  Printf.printf "=== Test test_authenticate_both_invalid completed ===\n"

let test_authenticate_wrong_password _ =
  Printf.printf
    "=== Testing authenticate (User should not be authenticated with wrong \
     password) ===\n";
  let netid = "user1" in
  let password = "wrongpass" in
  let result = authenticate netid password in
  Printf.printf "NetID: %s\n" netid;
  Printf.printf "Password: %s\n" password;
  Printf.printf "Result: %b\n" result;
  assert_bool "User should not be authenticated with the wrong password"
    (not result);
  Printf.printf "=== Test test_authenticate_wrong_password completed ===\n"

let test_authenticate_wrong_netid _ =
  Printf.printf
    "=== Testing authenticate (User should not be authenticated with wrong \
     netid) ===\n";
  let netid = "wronguser" in
  let password = "pass1" in
  let result = authenticate netid password in
  Printf.printf "NetID: %s\n" netid;
  Printf.printf "Password: %s\n" password;
  Printf.printf "Result: %b\n" result;
  assert_bool "User should not be authenticated with the wrong netid"
    (not result);
  Printf.printf "=== Test test_authenticate_wrong_netid completed ===\n"

(* =================== TESTING FOR COURSE CREATION 1 =================== *)

let test_course_id_1 _ =
  Printf.printf "=== Testing get_course_id ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_id = Courses.get_course_id mock_course in
  Printf.printf "Course ID: %d\n" course_id;
  assert_equal ~msg:"Course ID should be correct" 101 course_id;
  Printf.printf "=== Test course_id_1 completed ===\n"

let test_course_name_1 _ =
  Printf.printf "=== Testing get_course_name ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_name = Courses.get_course_name mock_course in
  Printf.printf "Course Name: %s\n" course_name;
  assert_equal ~msg:"Course name should be correct" "Introduction to OCaml"
    course_name;
  Printf.printf "=== Test course_name_1 completed ===\n"

let test_course_description_1 _ =
  Printf.printf "=== Testing get_course_description ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_description = Courses.get_course_description mock_course in
  Printf.printf "Course Description: %s\n" course_description;
  assert_equal ~msg:"Course description should be correct"
    "A course about OCaml programming basics" course_description;
  Printf.printf "=== Test course_description_1 completed ===\n"

let test_course_credits_1 _ =
  Printf.printf "=== Testing get_course_credits ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_credits = Courses.get_course_credits mock_course in
  Printf.printf "Course Credits: %f\n" course_credits;
  assert_equal ~msg:"Course credits should be correct" 4.0 course_credits;
  Printf.printf "=== Test course_credits_1 completed ===\n"

let test_course_schedule_days_1 _ =
  Printf.printf "=== Testing get_schedule_days ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_schedule = Courses.get_course_schedule mock_course in
  let schedule_days = Courses.get_schedule_days course_schedule in
  Printf.printf "Schedule Days: [%s]\n" (String.concat "; " schedule_days);
  assert_equal ~msg:"Course days should be correct"
    [ "Monday"; "Wednesday"; "Friday" ]
    schedule_days;
  Printf.printf "=== Test course_schedule_days_1 completed ===\n"

let test_course_schedule_time_start_1 _ =
  Printf.printf "=== Testing get_start_time ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_schedule = Courses.get_course_schedule mock_course in
  let schedule_time = Courses.get_schedule_time course_schedule in
  let start_time = Courses.get_start_time schedule_time in
  Printf.printf "Start Time: %d\n" start_time;
  assert_equal ~msg:"Start time should be correct" 900 start_time;
  Printf.printf "=== Test course_schedule_time_start_1 completed ===\n"

let test_course_schedule_time_finish_1 _ =
  Printf.printf "=== Testing get_finish_time ===\n";
  let example_time = Courses.make_time 900 1030 in
  let example_schedule =
    Courses.make_schedule [ "Monday"; "Wednesday"; "Friday" ] example_time
  in
  let mock_course =
    Courses.make_course 101 "Introduction to OCaml"
      "A course about OCaml programming basics" 4.0 example_schedule
  in

  let course_schedule = Courses.get_course_schedule mock_course in
  let schedule_time = Courses.get_schedule_time course_schedule in
  let finish_time = Courses.get_finish_time schedule_time in
  Printf.printf "Finish Time: %d\n" finish_time;
  assert_equal ~msg:"Finish time should be correct" 1030 finish_time;
  Printf.printf "=== Test course_schedule_time_finish_1 completed ===\n"

(* =================== TESTING FOR COURSE CREATION 2 =================== *)

let test_another_course_id _ =
  Printf.printf "=== Testing get_course_id for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_id = Courses.get_course_id another_mock_course in
  Printf.printf "Course ID: %d\n" course_id;
  assert_equal ~msg:"Course ID should be correct" 102 course_id;
  Printf.printf "=== Test test_another_course_id completed ===\n"

let test_another_course_name _ =
  Printf.printf "=== Testing get_course_name for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_name = Courses.get_course_name another_mock_course in
  Printf.printf "Course Name: %s\n" course_name;
  assert_equal ~msg:"Course name should be correct" "Advanced OCaml" course_name;
  Printf.printf "=== Test test_another_course_name completed ===\n"

let test_another_course_description _ =
  Printf.printf "=== Testing get_course_description for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in
  
  let course_description = Courses.get_course_description another_mock_course in
  Printf.printf "Course Description: %s\n" course_description;
  assert_equal ~msg:"Course description should be correct"
    "An advanced course on OCaml programming" course_description;
  Printf.printf "=== Test test_another_course_description completed ===\n"

let test_another_course_credits _ =
  Printf.printf "=== Testing get_course_credits for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_credits = Courses.get_course_credits another_mock_course in
  Printf.printf "Course Credits: %f\n" course_credits;
  assert_equal ~msg:"Course credits should be correct" 3.0 course_credits;
  Printf.printf "=== Test test_another_course_credits completed ===\n"

let test_another_course_schedule_days _ =
  Printf.printf "=== Testing get_schedule_days for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_schedule = Courses.get_course_schedule another_mock_course in
  let schedule_days = Courses.get_schedule_days course_schedule in
  Printf.printf "Schedule Days: [%s]\n" (String.concat "; " schedule_days);
  assert_equal ~msg:"Course days should be correct" [ "Tuesday"; "Thursday" ]
    schedule_days;
  Printf.printf "=== Test test_another_course_schedule_days completed ===\n"

let test_another_course_schedule_time_start _ =
  Printf.printf "=== Testing get_start_time for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_schedule = Courses.get_course_schedule another_mock_course in
  let schedule_time = Courses.get_schedule_time course_schedule in
  let start_time = Courses.get_start_time schedule_time in
  Printf.printf "Start Time: %d\n" start_time;
  assert_equal ~msg:"Start time should be correct" 1400 start_time;
  Printf.printf
    "=== Test test_another_course_schedule_time_start completed ===\n"

let test_another_course_schedule_time_finish _ =
  Printf.printf "=== Testing get_finish_time for another course ===\n";
  let another_example_time = Courses.make_time 1400 1530 in
  let another_example_schedule =
    Courses.make_schedule [ "Tuesday"; "Thursday" ] another_example_time
  in
  let another_mock_course =
    Courses.make_course 102 "Advanced OCaml"
      "An advanced course on OCaml programming" 3.0 another_example_schedule
  in

  let course_schedule = Courses.get_course_schedule another_mock_course in
  let schedule_time = Courses.get_schedule_time course_schedule in
  let finish_time = Courses.get_finish_time schedule_time in
  Printf.printf "Finish Time: %d\n" finish_time;
  assert_equal ~msg:"Finish time should be correct" 1530 finish_time;
  Printf.printf
    "=== Test test_another_course_schedule_time_finish completed ===\n"

(* =================== TESTING FOR COURSE CONFLICTS =================== *)

let test_courses_1_and_2_conflict _ =
  Printf.printf "=== Testing course conflicts (Courses 1 and 2 conflict) ===\n";
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  let time2 = make_time 930 1230 in
  let schedule2 = make_schedule [ "Monday"; "Wednesday" ] time2 in
  let course2 = make_course 102 "Course2" "Description" 4.0 schedule2 in

  let conflict_result =
    is_conflict (get_course_schedule course1) (get_course_schedule course2)
  in
  Printf.printf "Courses 1 and 2 conflict: %b\n" conflict_result;
  assert_bool "Courses 1 and 2 conflict" conflict_result;
  Printf.printf "=== Test test_courses_1_and_2_conflict completed ===\n"

let test_courses_1_and_3_do_not_conflict _ =
  Printf.printf
    "=== Testing course conflicts (Courses 1 and 3 do not conflict) ===\n";
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  let time3 = make_time 1200 1400 in
  let schedule3 = make_schedule [ "Wednesday"; "Friday" ] time3 in
  let course3 = make_course 103 "Course3" "Description" 3.0 schedule3 in

  let conflict_result =
    is_conflict (get_course_schedule course1) (get_course_schedule course3)
  in
  Printf.printf "Courses 1 and 3 do not conflict: %b\n" (not conflict_result);
  assert_bool "Courses 1 and 3 do not conflict" (not conflict_result);
  Printf.printf "=== Test test_courses_1_and_3_do_not_conflict completed ===\n"

let test_courses_3_and_4_conflict _ =
  Printf.printf "=== Testing course conflicts (Courses 3 and 4 conflict) ===\n";
  let time3 = make_time 1200 1400 in
  let schedule3 = make_schedule [ "Wednesday"; "Friday" ] time3 in
  let course3 = make_course 103 "Course3" "Description" 3.0 schedule3 in

  let time4 = make_time 1300 1500 in
  let schedule4 = make_schedule [ "Friday" ] time4 in
  let course4 = make_course 104 "Course4" "Description" 2.0 schedule4 in

  let conflict_result =
    is_conflict (get_course_schedule course3) (get_course_schedule course4)
  in
  Printf.printf "Courses 3 and 4 conflict: %b\n" conflict_result;
  assert_bool "Courses 3 and 4 conflict" conflict_result;
  Printf.printf "=== Test test_courses_3_and_4_conflict completed ===\n"

let test_courses_1_and_5_conflict _ =
  Printf.printf "=== Testing course conflicts (Courses 1 and 5 conflict) ===\n";
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  let time5 = make_time 800 1000 in
  let schedule5 = make_schedule [ "Monday"; "Wednesday" ] time5 in
  let course5 = make_course 105 "Course5" "Description" 1.0 schedule5 in

  let conflict_result =
    is_conflict (get_course_schedule course1) (get_course_schedule course5)
  in
  Printf.printf "Courses 1 and 5 conflict: %b\n" conflict_result;
  assert_bool "Courses 1 and 5 conflict" conflict_result;
  Printf.printf "=== Test test_courses_1_and_5_conflict completed ===\n"

(* =================== TESTING FOR SCHEDULE CONFLICTS =================== *)

let test_course_conflicts_with_existing_courses _ =
  Printf.printf
    "=== Testing course conflicts (Course conflicts with existing courses) ===\n";
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 930 1230 in
  let schedule2 = make_schedule [ "Monday"; "Wednesday" ] time2 in
  let course2 = make_course 102 "Course2" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf "Course conflicts with existing courses: %b\n" conflict_result;
  assert_bool "Course conflicts with existing courses" conflict_result;
  Printf.printf
    "=== Test test_course_conflicts_with_existing_courses completed ===\n"

let test_course_does_not_conflict_with_existing_courses _ =
  Printf.printf
    "=== Testing course conflicts (Course does not conflict with existing \
     courses) ===\n";
  let time1 = make_time 900 1200 in
  let schedule1 = make_schedule [ "Monday"; "Wednesday" ] time1 in
  let course1 = make_course 101 "Course1" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time3 = make_time 1400 1600 in
  let schedule3 = make_schedule [ "Tuesday"; "Thursday" ] time3 in
  let course3 = make_course 103 "Course3" "Description" 3.0 schedule3 in

  let conflict_result = has_schedule_conflict course3 !my_courses in
  Printf.printf "Course does not conflict with existing courses: %b\n"
    (not conflict_result);
  assert_bool "Course does not conflict with existing courses"
    (not conflict_result);
  Printf.printf
    "=== Test test_course_does_not_conflict_with_existing_courses completed ===\n"

let test_overlapping_times_different_days _ =
  Printf.printf
    "=== Testing course conflicts (Courses on different days should not \
     conflict) ===\n";
  let time1 = make_time 900 1100 in
  let schedule1 = make_schedule [ "Monday" ] time1 in
  let course1 = make_course 201 "Course1" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 900 1100 in
  let schedule2 = make_schedule [ "Tuesday" ] time2 in
  let course2 = make_course 202 "Course2" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf "Courses on different days should not conflict: %b\n"
    (not conflict_result);
  assert_bool "Courses on different days should not conflict"
    (not conflict_result);
  Printf.printf "=== Test test_overlapping_times_different_days completed ===\n"

let test_adjacent_times_same_day _ =
  Printf.printf
    "=== Testing course conflicts (Adjacent courses on the same day should not \
     conflict) ===\n";
  let time1 = make_time 900 1000 in
  let schedule1 = make_schedule [ "Wednesday" ] time1 in
  let course1 = make_course 203 "Course3" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 1000 1100 in
  let schedule2 = make_schedule [ "Wednesday" ] time2 in
  let course2 = make_course 204 "Course4" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf "Adjacent courses on the same day should not conflict: %b\n"
    (not conflict_result);
  assert_bool "Adjacent courses on the same day should not conflict"
    (not conflict_result);
  Printf.printf "=== Test test_adjacent_times_same_day completed ===\n"

let test_complete_overlap_same_day _ =
  Printf.printf
    "=== Testing course conflicts (Courses with complete overlap on the same \
     day should conflict) ===\n";
  let time1 = make_time 1300 1500 in
  let schedule1 = make_schedule [ "Thursday" ] time1 in
  let course1 = make_course 205 "Course5" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 1300 1500 in
  let schedule2 = make_schedule [ "Thursday" ] time2 in
  let course2 = make_course 206 "Course6" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf
    "Courses with complete overlap on the same day should conflict: %b\n"
    conflict_result;
  assert_bool "Courses with complete overlap on the same day should conflict"
    conflict_result;
  Printf.printf "=== Test test_complete_overlap_same_day completed ===\n"

let test_partial_overlap_same_day _ =
  Printf.printf
    "=== Testing course conflicts (Courses with partial overlap on the same \
     day should conflict) ===\n";
  let time1 = make_time 1400 1600 in
  let schedule1 = make_schedule [ "Friday" ] time1 in
  let course1 = make_course 207 "Course7" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 1500 1700 in
  let schedule2 = make_schedule [ "Friday" ] time2 in
  let course2 = make_course 208 "Course8" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf
    "Courses with partial overlap on the same day should conflict: %b\n"
    conflict_result;
  assert_bool "Courses with partial overlap on the same day should conflict"
    conflict_result;
  Printf.printf "=== Test test_partial_overlap_same_day completed ===\n"

let test_no_overlap_same_day _ =
  Printf.printf
    "=== Testing course conflicts (Courses on the same day with no overlap \
     should not conflict) ===\n";
  let time1 = make_time 800 1000 in
  let schedule1 = make_schedule [ "Monday" ] time1 in
  let course1 = make_course 209 "Course9" "Description" 3.0 schedule1 in

  my_courses := [ course1 ];

  let time2 = make_time 1100 1300 in
  let schedule2 = make_schedule [ "Monday" ] time2 in
  let course2 = make_course 210 "Course10" "Description" 4.0 schedule2 in

  let conflict_result = has_schedule_conflict course2 !my_courses in
  Printf.printf
    "Courses on the same day with no overlap should not conflict: %b\n"
    (not conflict_result);
  assert_bool "Courses on the same day with no overlap should not conflict"
    (not conflict_result);
  Printf.printf "=== Test test_no_overlap_same_day completed ===\n"

(* =================== TESTING FOR USER DATA =================== *)

let test_set_total_credits _ =
  Printf.printf "=== Testing User functions (set_total_credits) ===\n";
  let user = make_user "user3" "pass3" "engineering" in
  set_total_credits 15.0 user;
  let credits_result = get_total_credits user in
  Printf.printf "Set total credits to 15.0: %f\n" credits_result;
  assert_equal 15.0 credits_result;

  set_total_credits 10.0 user;
  let credits_result = get_total_credits user in
  Printf.printf "Set total credits to 10.0: %f\n" credits_result;
  assert_equal 10.0 credits_result;
  Printf.printf "=== Test test_set_total_credits completed ===\n"

let test_get_netid _ =
  Printf.printf "=== Testing User functions (get_netid) ===\n";
  let user = make_user "user4" "pass4" "arts and sciences" in
  let netid_result = get_netid user in
  Printf.printf "NetID: %s\n" netid_result;
  assert_equal "user4" netid_result;
  Printf.printf "=== Test test_get_netid completed ===\n"

let test_get_total_credits _ =
  Printf.printf "=== Testing User functions (get_total_credits) ===\n";
  let user = make_user "user5" "pass5" "engineering" in
  set_total_credits 12.0 user;
  let credits_result = get_total_credits user in
  Printf.printf "Total credits: %f\n" credits_result;
  assert_equal 12.0 credits_result;

  set_total_credits 0.0 user;
  let credits_result = get_total_credits user in
  Printf.printf "Total credits: %f\n" credits_result;
  assert_equal 0.0 credits_result;
  Printf.printf "=== Test test_get_total_credits completed ===\n"

let test_get_college_engineering _ =
  Printf.printf "=== Testing User functions (get_college) ===\n";
  let user = make_user "user6" "pass6" "engineering" in
  let college_result = get_college user in
  Printf.printf "College: %s\n" college_result;
  assert_equal "engineering" college_result;
  Printf.printf "=== Test test_get_college_engineering completed ===\n"

let test_get_college_engineering_uppercase _ =
  Printf.printf "=== Testing User functions (get_college with uppercase) ===\n";
  let user = make_user "user8" "pass8" "ENGINEERING" in
  let college_result = get_college user in
  Printf.printf "College: %s\n" college_result;
  assert_equal "ENGINEERING" college_result;
  Printf.printf
    "=== Test test_get_college_engineering_uppercase completed ===\n"

let test_get_college_arts _ =
  Printf.printf "=== Testing User functions (get_college) ===\n";
  let user = make_user "user7" "pass7" "arts and sciences" in
  let college_result = get_college user in
  Printf.printf "College: %s\n" college_result;
  assert_equal "arts and sciences" college_result;
  Printf.printf "=== Test test_get_college_arts completed ===\n"

let test_get_college_arts_uppercase _ =
  Printf.printf "=== Testing User functions (get_college with uppercase) ===\n";
  let user = make_user "user" "pass" "ARTS AND SCIENCES" in
  let college_result = get_college user in
  Printf.printf "College: %s\n" college_result;
  assert_equal "ARTS AND SCIENCES" college_result;
  Printf.printf
    "=== Test test_get_college_engineering_uppercase completed ===\n"

(* =================== TESTING FOR ADDING, GETTING =================== *)
let test_add_user_1 _ =
  let initial_users = get_users () in
  let new_user = make_user "user3" "pass3" "engineering" in
  let updated_users = add_user new_user initial_users in
  assert_equal ~msg:"New user should be added to the list of users"
    (List.length updated_users)
    (List.length initial_users + 1);
  assert_equal ~msg:"New user should have the correct netid" "user3"
    (get_netid (List.hd updated_users));
  assert_equal ~msg:"New user should have the correct college" "engineering"
    (get_college (List.hd updated_users))

let test_add_user_2 _ =
  let initial_users = get_users () in
  let new_user = make_user "user3" "pass3" "arts and sciences" in
  let updated_users = add_user new_user initial_users in
  assert_equal ~msg:"New user should be added to the list of users"
    (List.length updated_users)
    (List.length initial_users + 1);
  assert_equal ~msg:"New user should have the correct netid" "user3"
    (get_netid (List.hd updated_users));
  assert_equal ~msg:"New user should have the correct college"
    "arts and sciences"
    (get_college (List.hd updated_users))

(* =================== COMBINING ALL TEST SUITES =================== *)
let suite =
  "Course Scheduler Tests"
  >::: [
         (* authenticate *)
         "test_authenticate_successful" >:: test_authenticate_successful;
         "test_authenticate_both_invalid" >:: test_authenticate_both_invalid;
         "test_authenticate_wrong_password" >:: test_authenticate_wrong_password;
         "test_authenticate_wrong_netid" >:: test_authenticate_wrong_netid;
         (* courses 1 *)
         "test_course_id_1" >:: test_course_id_1;
         "test_course_name_1" >:: test_course_name_1;
         "test_course_description_1" >:: test_course_description_1;
         "test_course_credits_1" >:: test_course_credits_1;
         "test_course_schedule_days_1" >:: test_course_schedule_days_1;
         "test_course_schedule_time_start_1"
         >:: test_course_schedule_time_start_1;
         "test_course_schedule_time_finish_1"
         >:: test_course_schedule_time_finish_1;
         (* courses 2 *)
         "test_another_course_id" >:: test_another_course_id;
         "test_another_course_name" >:: test_another_course_name;
         "test_another_course_description" >:: test_another_course_description;
         "test_another_course_credits" >:: test_another_course_credits;
         "test_another_course_schedule_days"
         >:: test_another_course_schedule_days;
         "test_another_course_schedule_time_start"
         >:: test_another_course_schedule_time_start;
         "test_another_course_schedule_time_finish"
         >:: test_another_course_schedule_time_finish;
         (* conflicts *)
         "test_courses_1_and_2_conflict" >:: test_courses_1_and_2_conflict;
         "test_courses_1_and_3_do_not_conflict"
         >:: test_courses_1_and_3_do_not_conflict;
         "test_courses_3_and_4_conflict" >:: test_courses_3_and_4_conflict;
         "test_courses_1_and_5_conflict" >:: test_courses_1_and_5_conflict;
         "test_course_conflicts_with_existing_courses"
         >:: test_course_conflicts_with_existing_courses;
         "test_course_does_not_conflict_with_existing_courses"
         >:: test_course_does_not_conflict_with_existing_courses;
         "test_overlapping_times_different_days"
         >:: test_overlapping_times_different_days;
         "test_adjacent_times_same_day" >:: test_adjacent_times_same_day;
         "test_complete_overlap_same_day" >:: test_complete_overlap_same_day;
         "test_partial_overlap_same_day" >:: test_partial_overlap_same_day;
         "test_no_overlap_same_day" >:: test_no_overlap_same_day;
         (* users *)
         "test_set_total_credits" >:: test_set_total_credits;
         "test_get_netid" >:: test_get_netid;
         "test_get_total_credits" >:: test_get_total_credits;
         "test_get_college_engineering" >:: test_get_college_engineering;
         "test_get_college_engineering_uppercase"
         >:: test_get_college_engineering_uppercase;
         "test_get_college_arts_uppercase" >:: test_get_college_arts_uppercase;
         "test_get_college_arts" >:: test_get_college_arts;
         "test_add_user_1" >:: test_add_user_1;
         "test_add_user_2" >:: test_add_user_2;
       ]

(* Run the tests *)
let () = run_test_tt_main suite
