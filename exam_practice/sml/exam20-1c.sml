(* 2 *)
  fun prime 2 = true
    | prime n = n mod 2 <> 0 andalso
      check 3
  and check k =
        k * k > n orelse
        n mod k <> 0 andalso
        check (k+2)



(* 4 *)
fun reverse xs =
  let
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
    rev (xs, nil)
  end

fun find a 0 prev = (reverse prev, a)
  | find a N prev = find (tl a) (N-1) ((hd a) :: prev);

fun reconstruct [] = []
  | reconstruct L =
  let
    val h = hd L
    val (new, rest) = find (tl L) h []
  in
    (h :: new) :: (reconstruct rest)
  end
