(* function to calculate the length of the longest subsequence with sum not greater than N *)
fun max_seq_N L N =
  let
    fun walk nil L _ _ m = m
      | walk _ nil _ _ m = m
      | walk (h::t) (first::rest) s current m =
      if (s + h <= N)
        then walk t (first::rest) (s + h) (current+1) (Int.max(current+1, m))
      else walk (h::t) rest (s - first) (current-1) m
      (*else walk t rest 0 0 m*)
  in
    walk L L 0 0 0
  end


(* function to calculate the maximum sum of all subsequences of a list *)
fun max_sum L =
  let
    fun walk nil current prev = Int.max(current,  prev)
      | walk (h::t) current prev =
        if (current + h <= 0) then walk t 0 prev
        else walk t (current+h) (Int.max(current+h, prev))
  in
    walk L 0 0
  end

(* function to convert a tree into a l/r list *)
datatype 'a tree = empty | n of 'a * 'a tree * 'a tree

fun political_list T =
  let
    fun sep empty L R _ = (L, R)
      | sep (n(D, L, R)) A B C =
          let
            val (L1, R1) = sep L A B true
            val (L2, R2) = sep R L1 R1 false
            val D1 =
              if C then (D::L2) else (D::R2)
            val (Ret1, Ret2) =
              if C then (D1, R2) else (L2, D1)
          in
            (Ret1, Ret2)
          end
    val (Left, Right) = sep T [] [] true
  in
    (Left, Right)
  end
