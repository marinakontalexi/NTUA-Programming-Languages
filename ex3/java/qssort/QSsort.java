import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class QSsort {
  // The main function.
  public static void main(String args[]) {

    File inFile = new File(args[0]);
    Deque<Integer> queue = new ArrayDeque<>(),  stack = new ArrayDeque<>();
    try {
      Scanner scanner = new Scanner(inFile);
      String line = scanner.nextLine();
      while(scanner.hasNextInt()) {
        queue.add(scanner.nextInt());
      }

      Solver solver = new RBFSolver();
      State initial = new QSstate("", queue, stack);

      State result = solver.solve(initial);
      if (result.getPath() == "") {
        System.out.println("empty");
      } else {
        System.out.println(result.getPath());;
      }
    }
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }

}
