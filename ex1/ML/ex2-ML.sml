fun parse file =
  let
    fun readInt input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    fun next_String input =
      let
        val a = TextIO.inputAll input
      in
        explode(a)
      end

    val inStream = TextIO.openIn file
      (* Read 2 integers and consume newline. *)
    val N = readInt inStream
    val M = readInt inStream
    val _ = TextIO.inputLine inStream

    fun readRows 0 M acc = acc
    | readRows i M acc = readRows (i - 1) M (next_String inStream :: acc)
  in
  	(N, M, next_String inStream)
  end

fun check arr i j N M =
  let
    fun find arr i j N M =
      let
        val I = Array2.sub(arr, i, j) div M
        val J = Array2.sub(arr, i, j) mod M
        val a = Array2.update (arr, i, j, ~3)
        val n = check arr I J N M
        val k = Array2.update (arr, i, j, n)
      in
        n
      end
  in
    if (Array2.sub(arr, i, j) = ~1) then ~1
    else if (Array2.sub(arr, i, j) = ~2 orelse Array2.sub(arr, i, j) = ~3) then ~2
    else find arr i j N M
  end

fun ans arr i j N M counter =
  if (i = N) then counter
  else if (j = M) then ans arr (i+1) 0 N M counter
  else
    let
      val n = check arr i j N M
      val k = Array2.update(arr, i, j, n)
    in
      if (n = ~2) then ans arr i (j+1) N M (counter+ 1)
                  else ans arr i (j+1) N M counter
    end

fun conv nil = #"a"
  | conv (#"\n"::t) = conv t
  | conv (c::t) = c

fun mod_a i j N M c =
  if (c = #"U") then
    if (i = 0) then ~1 else (i-1)*M + j
  else if (c = #"D") then
    if (i = N - 1) then ~1 else (i+1)*M + j
  else if (c = #"R") then
    if (j = M - 1) then ~1 else i*M + j + 1
  else if (c = #"L") then
    if (j = 0) then ~1 else i*M + j - 1
  else ~4;

fun make nil i j N M arr = arr
  | make (x::nil) i j N M arr = arr
  | make lista i 0 N M arr = make lista (i-1) M N M arr
  | make lista 0 j N M arr = arr
  | make lista i j N M arr =
    let
      val t = Array2.update (arr, N - i, M - j, (mod_a (N - i) (M - j) N M (conv lista)))
      val h::t = lista
      val l2 =
        if ((hd t) = #"\n") then (tl t) else t
    in
      make l2 i (j-1) N M arr
    end

fun answer_print ans = (
  print (Int.toString (ans))
)

fun loop_rooms filename =
  let
    val (N, M, l) = parse filename
    val arr = Array2.array(N, M, 1)
    val arr = make l N M N M arr
    val answer = ans arr 0 0 N M 0
  in
    answer_print answer
  end
