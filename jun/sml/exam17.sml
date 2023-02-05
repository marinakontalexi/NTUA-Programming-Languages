datatype 'a tree = node of 'a * 'a tree * 'a tree | empty

fun count empty = 0
  | count (node(_, a, b)) =
    (count a) + (count b) + 1;

fun countUnbalanced empty prev = prev
  | countUnbalanced (node(_, a, b)) prev =
    let
      val me = if (count a = count b) then 0
               else 1
      val A = countUnbalanced a 0
      val B = countUnbalanced b 0
    in
      A + B + prev + me
    end

fun countU T =
let
  fun better empty prev = (1, prev)
    | better (node(_, a, b)) prev =
      let
        val (A1, A2) = better a prev
        val (B1, B2) = better b A2
        val me = if (A1 = B1) then 0
                 else 1
      in
        (A1 + B1 + 1, me + B2)
      end
    val (A, B) = better T 0
  in
    B
  end
