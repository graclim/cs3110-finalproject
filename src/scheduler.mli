open Courses
open Users

val my_courses : course list ref
(** [my_courses] is a mutable list representing the user's current courses. It's
    a reference to a list of [course] objects, allowing dynamic modification. *)

val load_courses : string -> unit
(** [load_courses netid] loads the courses for a user identified by [netid]. It
    updates the [my_courses] list with the courses associated with the user.
    @param netid is a string representing the network ID of the user. *)

val is_conflict : schedule -> schedule -> bool
(** [is_conflict schedule1 schedule2] checks if two schedules conflict with each
    other.
    @param schedule1 is the first schedule to compare.
    @param schedule2 is the second schedule to compare.
    @return [true] if there is a conflict, [false] otherwise. *)

val has_schedule_conflict : course -> course list -> bool
(** [has_schedule_conflict new_course existing_courses] checks if adding
    [new_course] to [existing_courses] would create a schedule conflict.
    @param new_course is the course to check for potential scheduling conflicts.
    @param existing_courses
      is the list of courses already in the user's schedule.
    @return [true] if there is a conflict, [false] otherwise. *)

val add_course_ID : string -> int -> unit
(** [add_course_ID netid course_id] adds a course to the user's schedule by
    course ID.
    @param netid is the network ID of the user.
    @param course_id is the ID of the course to add. *)

val add_course_name : string -> string -> unit
(** [add_course_name netid course_name] adds a course to the user's schedule by
    course name.
    @param netid is the network ID of the user.
    @param course_name is the name of the course to add. *)

val drop_course_ID : string -> int -> unit
(** [drop_course_ID netid course_id] drops a course from the user's schedule by
    course ID.
    @param netid is the network ID of the user.
    @param course_id is the ID of the course to drop. *)

val drop_course_name : string -> string -> unit
(** [drop_course_name netid course_name] drops a course from the user's schedule
    by course name.
    @param netid is the network ID of the user.
    @param course_name is the name of the course to drop. *)

val display_my_courses : unit -> unit
(** [display_my_courses ()] displays the courses that the user is currently
    enrolled in. *)

val update_json : string -> unit
(** [update_json netid] updates the JSON file representing the user's course
    data. This function is used to persist changes made to the user's schedule.
    @param netid
      is the network ID of the user whose course data is to be updated. *)
