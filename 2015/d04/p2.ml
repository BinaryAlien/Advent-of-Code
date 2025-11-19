let solve ic =
  let secret_key = input_line ic in
  let rec aux n =
    let hash =
      secret_key ^ string_of_int n |> Digest.MD5.string |> Digest.MD5.to_hex
    in
    if String.starts_with ~prefix:(String.make 6 '0') hash then n
    else aux (n + 1)
  in
  aux 1
;;

stdin |> solve |> Printf.printf "%d\n"
