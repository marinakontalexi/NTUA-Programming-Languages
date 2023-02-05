fun pick_in_order L =
  let
    fun walk nil prev nil = (rev prev)
      | walk nil prev next = walk (rev next) (prev) []
      | walk (nil::t) prev next = walk t prev next
      | walk ((first::tail)::t) prev next = walk t (first::prev) (tail::next)
    in
    walk L [] []
    end

fun split n L =
let fun aux 0 acc L = (rev acc, L)
| aux n acc [] = (rev acc, [])
| aux n acc (h :: t) = aux (n-1) (h::acc) t
in aux n [] L
end
