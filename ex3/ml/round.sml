fun parse file =
  let
	(* A function to read an integer from specified input. *)
    fun readInt input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    	(* Open input file. *)
    val inStream = TextIO.openIn file
      (* Read 2 integers and consume newline. *)
    val M = readInt inStream
    val N = readInt inStream
    val _ = TextIO.inputLine inStream
      (* A function to read M integers from the open file. *)
    fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
    	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
  in
  	(M, N, readInts N [])
  end

fun round file =
  let
    fun solve List len =
      let
        fun calc nil dest sum far = (sum, far)
          | calc (h::t) dest prevsum prevfar =
              let
                val distance = (dest - h + len) mod len
              in
                calc t dest (prevsum + distance) (Int.max(prevfar, distance))
              end

        fun search L 0 answer = answer
          | search L dest (a, b) =
            let
              val (A, B) = calc L (dest-1) 0 0
            in
              search L (dest-1) ((A::a), (B::b))
            end

        fun check (a, []) ans pos curr = (ans, pos)
          | check ([], b) ans pos curr = (ans, pos)
          | check ((S::ST), (F::FT)) prev pos current =
            let
              val rest = S - F + 1
              val circ = F - rest + 2
            in
              if F <= rest andalso (S < prev orelse prev = ~1) then check (ST, FT) S current (current+1)
              else if F > rest andalso ((S + (2 - (circ div len))*len) < prev orelse prev = ~1)
                  then check (ST, FT) (S + (2 - (circ div len))*len) current (current+1)
              else check (ST, FT) prev pos (current+1)
            end

        val (sums, far) = search List len ([],[])

      in
        check (sums, far) ~1 ~1 0
      end

    val (M, N, List) = parse file
    val (steps, pos) = solve List M
  in
  (print(Int.toString(steps) ^ " " ^ Int.toString(pos) ^ "\n"))
  end
