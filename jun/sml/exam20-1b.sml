(* 2 *)
fun c ls =
  let
    fun d [] n prev = Int.max(n, prev)
      | d (42 :: t) n prev = d t (n + 1) prev
      | d (h :: t) n prev = d t 0 (Int.max(n, prev))
  in
    d ls 0 0
end

(* 4 *)
fun double_pairs L =
  let
    fun cont nil _ sum = (nil, nil, sum)
      | cont _ nil sum = (nil, nil, sum)
      | cont (h::t) (rest::tail) sum =
          if (2*h = rest) then cont t tail (sum + 1)
          else if (2*h > rest) then cont (h::t) tail sum
          else  cont t (rest::tail) sum
  in
    #3 (cont L (tl L) 0)
  end
