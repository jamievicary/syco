let () =
  Csv.Rows.load ~has_header:true "participants.csv"
  |> List.map Csv.Row.to_assoc
  |> List.sort (fun r1 r2 -> compare (List.assoc "Last name" r1 |> String.lowercase_ascii) (List.assoc "Last name" r2 |> String.lowercase_ascii))
  |> List.filter (fun row ->
      List.assoc "Do you consent to being listed as a participant on the webpage with your affiliation?" row = "Yes"
    )
  |> List.iter (fun row ->
      Printf.printf "<li>%s %s (%s)</li>\n%!"
        (List.assoc "First name" row)
        (List.assoc "Last name" row)
        (List.assoc "Affiliation" row)
    )
