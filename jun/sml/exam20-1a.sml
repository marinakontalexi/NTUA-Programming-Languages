(* 2 *)
fun s ls =
  let
    fun c [] a = a
      | c (x :: r) a = c r ((x::r) :: a)
  in c ls []
end

(* 4 *)
fun find [] prev max = ([], max)
  | find a prev max =
    if ((hd a) mod 2 = prev) then (a, max)
    else find (tl a) (1-prev) (max + 1);

fun loop [] max = max
  | loop a max =
    let
      val (newa, r) = find (tl a) ((hd a) mod 2) 1
    in
      if (r > max) then loop newa r
      else loop newa max
    end

fun oddeven L = loop L 0
