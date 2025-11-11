let rec input_dimensions ic =
  try
    let dimensions =
      Scanf.bscanf ic " %dx%dx%d" (fun length width height ->
          (length, width, height))
    in
    dimensions :: input_dimensions ic
  with End_of_file -> []

let min a b c = Stdlib.min (Stdlib.min a b) c

let compute_paper dimensions =
  let length, width, height = dimensions in
  let area = (2 * length * width) + (2 * length * height) + (2 * width * height)
  and slack = min (length * width) (length * height) (width * height) in
  area + slack

let solve ic =
  let ic = Scanf.Scanning.from_channel ic in
  let dimensions = input_dimensions ic in
  dimensions |> List.map compute_paper |> List.fold_left ( + ) 0
;;

let solution = solve stdin in
Printf.printf "%d\n" solution
