open Graphics
open Courses

(* Converts minutes to a more readable time format *)
let minutes_to_time min =
  let hours = min / 60 in
  let minutes = min mod 60 in
  Printf.sprintf "%02d:%02d" hours minutes

(* Draw a single course entry on the calendar *)
let draw_course_entry x y course =
  let course_start = minutes_to_time (get_start_time (get_schedule_time course.schedule)) in
  let course_end = minutes_to_time (get_finish_time (get_schedule_time course.schedule)) in
  moveto x y;
  draw_string (course.name ^ " " ^ course_start ^ "-" ^ course_end)

(* Function to draw the weekly calendar *)
let draw_calendar courses =
  open_graph " 800x600";
  set_window_title "Weekly Course Calendar";
  auto_synchronize false;

  let prev_dimensions = ref (size_x (), size_y ()) in

  let draw_contents () =
    clear_graph ();

    (* Recalculate dimensions and positions based on current window size *)
    let day_labels = ["Monday"; "Tuesday"; "Wednesday"; "Thursday"; "Friday"; "Saturday"; "Sunday"] in
    let day_width = size_x () / List.length day_labels in
    let hour_height = 50 in  (* This can be adjusted for different window sizes *)
    let start_hour = 8 in

    (* Draw day labels *)
    List.iteri (fun i day ->
        moveto (i * day_width) (size_y () - 20);
        draw_string day;
      ) day_labels;

    (* Draw course entries with dynamically calculated positions *)
    List.iter (fun course ->
        List.iter (fun day ->
            let day_index = match day with
              | "Monday" -> 0 | "Tuesday" -> 1 | "Wednesday" -> 2
              | "Thursday" -> 3 | "Friday" -> 4 | "Saturday" -> 5
              | "Sunday" -> 6 | _ -> failwith "Invalid day"
            in
            let x_pos = day_index * day_width in
            let course_start = get_start_time (get_schedule_time course.schedule) in
            let y_pos = (size_y ()) - (((course_start / 60) - start_hour) * hour_height) in
            draw_course_entry x_pos y_pos course
          ) (get_schedule_days course.schedule)
      ) courses;
  in

  draw_contents ();

  let rec update_and_draw () =
    let current_dimensions = (size_x (), size_y ()) in
    if !prev_dimensions <> current_dimensions then begin
      prev_dimensions := current_dimensions;
      draw_contents ();
    end;

    try
      ignore (wait_next_event [Poll]);
      update_and_draw ();
    with
    | Graphic_failure _ -> ()
  in

  update_and_draw ();
  close_graph ()