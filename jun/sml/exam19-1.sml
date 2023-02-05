(* 2 *)
datatype 'a tree = Empty
                 | Node of 'a * 'a tree * 'a tree
datatype 'a option = NONE | SOME of 'a

fun floor Empty K prev = prev
  | floor (Node(Data, a, b)) K prev =
    if (Data < K) then floor b K (SOME Data)
    else if (Data > K) then floor a K prev
    else (SOME Data);

(* dummy *)
fun map (f, nil) = nil
  | map (f, l) = f (hd l) :: map (f, tl l);

fun subseq [] prev = prev
  | subseq a prev =
        subseq (tl a) (map (fn l => ((hd a) :: l), prev) @ prev);

fun Allsubseq L = subseq L [[]];

(* not so dummy *)

fun allsubseq L =
  let
    fun subseq nil prev = prev
      | subseq (a::t) prev =
        let
          fun make [] prev = prev
            | make (h::t) prev = make t ((a::h)::prev)
          val new = make prev prev
        in
          subseq t new
        end
  in subseq (rev L) [[]]
  end

(* by nickie *)
fun bynickie xs =
  let
    fun nonempty [] = []
      | nonempty (x::xs) =
      let
        fun walk [] acc = acc
          | walk (ys::yss) acc =
            walk yss ((x::ys)::ys::acc)
      in
        walk (nonempty xs) [[x]]
      end
    in
      [] :: nonempty xs
    end

(* rip *)
fun powerset [] = [[]]
  | powerset (h::t) =
          foldl (fn (x,acc) => x :: (h :: x) :: acc) [] (powerset t)
